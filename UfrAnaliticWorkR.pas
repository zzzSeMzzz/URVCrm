unit UfrAnaliticWorkR;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, DataUnit, Vcl.ComCtrls, Data.DB, MemDS,
  DBAccess, MyAccess, UtilsUnit, DBGridEhGrouping, ToolCtrlsEh,
  DBGridEhToolCtrls, DynVarsEh, EhLibVCL, GridsEh, DBAxisGridsEh, DBGridEh,
  Vcl.Menus;

type
  TfrAnaliticWorkR = class(TForm)
    lv: TListView;
    q: TMyQuery;
    PopupMenu1: TPopupMenu;
    N1: TMenuItem;
    SaveDialog1: TSaveDialog;
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure FormShow(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure lvCustomDrawItem(Sender: TCustomListView; Item: TListItem;
      State: TCustomDrawState; var DefaultDraw: Boolean);
    procedure N1Click(Sender: TObject);
  private
    { Private declarations }
    procedure createSqlReport;
    procedure createReport;
    procedure getReportItemByPair(pair:TLockupPair);
  public
    { Public declarations }
    dt1, dt2, dt3, dt4:TDate;
    idClient:string;
    clients, works:TLockupValue;
  end;

const
    sqlReport:string=
      'select tasks.id, tasks.id_client, tasks.id_work, tasks.time_work, tasks.dt, tasks.user_id,'+chr(13)+
      'clients.`name` as `client`,'+chr(13)+
      'works.`name` as `work`'+chr(13)+
      'from tasks'+chr(13)+
      'LEFT JOIN works ON (works.`id`=tasks.`id_work`)'+chr(13)+
      'LEFT JOIN clients ON (clients.`id`=tasks.`id_client`)'+chr(13)+
      'WHERE  (tasks.dt BETWEEN :dt1 AND :dt2)';
    sqlGroup:string=' GROUP BY tasks.id';
    sqlOrder:string=' ORDER BY tasks.`id_client` ASC';

var
  frAnaliticWorkR: TfrAnaliticWorkR;

implementation

{$R *.dfm}

procedure TfrAnaliticWorkR.createReport;
var i:integer;

function addColumn(caption:string; const width:integer=150):TListColumn;
begin
  result:=lv.Columns.Add;
  Result.Caption:=caption;
  Result.Width:=width;
end;

begin

addColumn(clients.getPair(0).value, 220);
for I := 0 to works.slValues.Count-1 do begin
  addColumn(works.slValues.Strings[i], 150);
  addColumn('Расхождение, мин');
  addColumn('Расхождение, ч');
  addColumn('В % отношении увел/умен,%', 200);
end;

q.Open;
if(q.RecordCount=0) then begin
 q.Close;
 exit;
end;

for I := 0 to clients.count-1 do
  getReportItemByPair(clients.getPair(i));

q.Close;
end;

procedure TfrAnaliticWorkR.createSqlReport;
begin
q.SQL.Text:=sqlReport+chr(13)+
        'AND (clients.id in('+idClient+'))'
        +sqlGroup+sqlOrder;
q.ParamByName('dt1').Value:=toMySqlDate(dt1);
q.ParamByName('dt2').Value:=toMySqlDate(dt4);

createReport;
end;

procedure TfrAnaliticWorkR.FormClose(Sender: TObject; var Action: TCloseAction);
begin
Action:=caFree;
end;

procedure TfrAnaliticWorkR.FormCreate(Sender: TObject);
begin
works:=TLockupValue.Create;
clients:=TLockupValue.Create;
end;

procedure TfrAnaliticWorkR.FormShow(Sender: TObject);
begin
createSqlReport;
end;

procedure TfrAnaliticWorkR.getReportItemByPair(pair: TLockupPair);
var items: array[0..1] of TListItem;
    i, j, n, posWork, tm1, tm2:integer;

function getNumInterval:integer;
begin
  if(q.FieldByName('dt').AsDateTime<=dt2)and(q.FieldByName('dt').AsDateTime>=dt1)
  then result:=1 else
  if(q.FieldByName('dt').AsDateTime>=dt3)and(q.FieldByName('dt').AsDateTime<=dt4)
  then Result:=2 else Result:=-1;
end;

procedure addSubItems();
var b5, b4, c5, c4:integer;//названия и эксель
begin
b5:=strtoint(items[1].SubItems[posWork]);
b4:=strtoint(items[0].SubItems[posWork]);

c5:=b5-b4;
c4:= b4-b5;

items[0].SubItems[posWork+1]:=inttostr(c4);
items[1].SubItems[posWork+1]:=inttostr(c5);

items[0].SubItems[posWork+2]:=FormatFloat('#0.##', c4/60);
items[1].SubItems[posWork+2]:=FormatFloat('#0.##', c5/60);

if(b5<>0) then items[0].SubItems[posWork+3]:=FormatFloat('#0.##', (b4/b5 -1)*100)
  else items[0].SubItems[posWork+3]:='---';
if(b4<>0) then items[1].SubItems[posWork+3]:=FormatFloat('#0.##', (b5/b4 -1)*100)
  else  items[1].SubItems[posWork+3]:='---'
end;

begin
tm1:=0;
tm2:=0;
items[0]:=lv.Items.Add;
items[1]:=lv.Items.Add;
items[0].Caption:=DateToStr(dt1)+'-'+DateToStr(dt2);
items[1].Caption:=DateToStr(dt3)+'-'+DateToStr(dt4);

for I := 0 to length(items)-1 do  //т.к. 2 периода сравниваем
  for j := 0 to works.count-1 do begin //+3 т.к. будут 3 пол расчета по формулам
    items[i].SubItems.Add('0');
    items[i].SubItems.Add('0');
    items[i].SubItems.Add('0');
    items[i].SubItems.Add('0');
  end;

//теперь для каждой работы нужно посчитать часы и аналитику
for n := 0 to works.count-1 do begin
//go go go
tm1:=0;
tm2:=0;
q.First;
//ShowMessage(IntToStr(q.RecordCount));
for I := 0 to q.RecordCount-1 do
begin
//ShowMessage(q.FieldByName('id_client').AsString);
  if(pair.id=q.FieldByName('id_client').AsInteger) then
  begin
    {posWork:=works.getPositionFromId(q.FieldByName('id_work').AsInteger);
    //ShowMessage('pos work '+inttostr(posWork));
    //если мы не находим у этого клиента такую работу, то идем дальше
    if(posWork=-1) then
    begin
      q.Next;
      Continue;
    end;  }
    //если работа не та
    if(q.FieldByName('id_work').AsInteger<>works.getPair(n).id)then
    begin
      q.Next;
      Continue;
    end;
    //ShowMessage('interval '+inttostr(getNumInterval));
    //если работа не влезла ни в один из периодов
    if(getNumInterval=-1) then
    begin
      q.Next;
      Continue;
    end;

    //ShowMessage('interval '+inttostr(getNumInterval));
    //ShowMessage('interval '+inttostr(getNumInterval));
    posWork:=n*4;
    //ShowMessage(q.FieldByName('time_work').AsString);
    if(getNumInterval=1) then
    begin
      tm1:=strtoint(items[0].SubItems.Strings[posWork]);
      tm1:=tm1+q.FieldByName('time_work').AsInteger;
      items[0].SubItems.Strings[posWork]:=inttostr(tm1);
    end else
    begin
      tm2:=strtoint(items[1].SubItems.Strings[posWork]);
      tm2:=tm2+q.FieldByName('time_work').AsInteger;
      items[1].SubItems.Strings[posWork]:=inttostr(tm2);
    end;

  end;//тут стоит добавить else continue
  q.Next;
end;

//FormatFloat('#0.##', r/60)
addSubItems; //а вот тут считаем аналитику
end;//end woprks analitic
end;

procedure TfrAnaliticWorkR.lvCustomDrawItem(Sender: TCustomListView;
  Item: TListItem; State: TCustomDrawState; var DefaultDraw: Boolean);
begin
if item.Index mod 2=0 then  Sender.Canvas.Brush.Color:=$00EFEFEF;
end;

procedure TfrAnaliticWorkR.N1Click(Sender: TObject);
begin
if not SaveDialog1.Execute(handle) then  exit;

UtilsUnit.saveListViewToExel(lv, saveDialog1.FileName);
end;

end.
