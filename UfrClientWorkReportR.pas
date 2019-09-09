unit UfrClientWorkReportR;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, DataUnit, DBGridEhGrouping, ToolCtrlsEh,
  DBGridEhToolCtrls, DynVarsEh, Vcl.ComCtrls, EhLibVCL, GridsEh, DBAxisGridsEh,
  DBGridEh, Data.DB, DBAccess, MyAccess, MemDS, UtilsUnit, Vcl.Menus;

type
  TfrClientWorkReportR = class(TForm)
    q: TMyQuery;
    ds: TMyDataSource;
    DBGridEh1: TDBGridEh;
    lv: TListView;
    PopupMenu1: TPopupMenu;
    N1: TMenuItem;
    SaveDialog1: TSaveDialog;
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure FormShow(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure lvColumnClick(Sender: TObject; Column: TListColumn);
    procedure lvCompare(Sender: TObject; Item1, Item2: TListItem; Data: Integer;
      var Compare: Integer);
    procedure lvCustomDrawSubItem(Sender: TCustomListView; Item: TListItem;
      SubItem: Integer; State: TCustomDrawState; var DefaultDraw: Boolean);
    procedure lvCustomDrawItem(Sender: TCustomListView; Item: TListItem;
      State: TCustomDrawState; var DefaultDraw: Boolean);
    procedure N1Click(Sender: TObject);
  private
    { Private declarations }
    procedure createSqlReport;
    procedure fillReport;
    procedure getTotalSum;
    function getReportItemByPair(pair:TLockupPair):TListItem;

  public
    { Public declarations }
    idDep, nameDep:string;
    dt1, dt2:TDate;
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
    sqlOrder:string=' ORDER BY clients.name ASC';

var
  frClientWorkReportR: TfrClientWorkReportR;
  i:integer;
  sort:TSortState=ssNone;
  ColumnToSort:integer;

implementation

{$R *.dfm}

procedure TfrClientWorkReportR.createSqlReport;
var slUserIds:TStringList;
begin
if(idDep='-1') then
begin
  q.SQL.Text:=sqlReport+sqlGroup+sqlOrder;
  q.ParamByName('dt1').Value:=toMySqlDate(dt1);
  q.ParamByName('dt2').Value:=toMySqlDate(dt2);
end else
    begin
     slUserIds:=TStringList.Create;
     q.SQL.Text:='select users.id, users.id_dep from users where users.id_dep='+idDep;
     q.Open;
     if(q.RecordCount=0) then
     begin
       ShowMessage('Не найдено ни одного пользователя в этом подразделении');
       q.Close;
       slUserIds.Free;
       exit;
     end;

     for I := 0 to q.RecordCount-1 do
       begin
         slUserIds.Add(q.FieldByName('id').AsString);
         q.Next;
       end;
     q.Close;
     slUserIds.Delimiter:=',';
     //showmessage(slUserIds.DelimitedText);
     q.SQL.Text:=sqlReport+chr(13)+
        'AND (tasks.user_id in('+slUserIds.DelimitedText+'))'
        +sqlGroup+sqlOrder;
     q.ParamByName('dt1').Value:=toMySqlDate(dt1);
     q.ParamByName('dt2').Value:=toMySqlDate(dt2);
     slUserIds.Free;
    end;

end;

procedure TfrClientWorkReportR.fillReport;
var i:integer;

function addColumn(caption:string; const width:integer=150):TListColumn;
begin
  result:=lv.Columns.Add;
  Result.Caption:=caption;
  Result.Width:=width;
end;

begin
addColumn('Клиенты', 200);
for I := 0 to works.slValues.Count-1 do addColumn(works.slValues.Strings[i]);
addColumn('Итого');

for I := 0 to clients.count-1 do
  getReportItemByPair(clients.getPair(i));

q.Close;
end;

procedure TfrClientWorkReportR.FormClose(Sender: TObject;
  var Action: TCloseAction);
begin
Action:=caFree;
clients.Free;
works.Free;
end;

procedure TfrClientWorkReportR.FormCreate(Sender: TObject);
begin
clients:=TLockupValue.Create;
works:=TLockupValue.Create;
end;

procedure TfrClientWorkReportR.FormShow(Sender: TObject);
begin
Caption:='Отчет по клиентам-видам работ';

//ShowMessage('selected clients count='+inttostr(clients.count)+' works count='+IntToStr(works.count));
createSqlReport;
//ShowMessage(q.SQL.Text);
q.Open;
fillReport;
getTotalSum;
end;


function TfrClientWorkReportR.getReportItemByPair(pair: TLockupPair): TListItem;
var item:TListItem;
  i, posWork, tm, sumTm:integer;
begin
item:=lv.Items.Add;
item.Caption:=pair.value;
sumTm:=0;

for I := 0 to works.count-1 do
  item.SubItems.Add('0');

item.SubItems.Add('0');

//ShowMessage('works text='+works.slIds.Text);

q.First;
 for I := 0 to q.RecordCount-1 do
   begin
    if(pair.id=q.FieldByName('id_client').AsInteger) then
    begin
      //showmessage(q.FieldByName('id_work').AsString);
      posWork:=works.getPositionFromId(q.FieldByName('id_work').AsInteger);
      //ShowMessage(inttostr(posWork));
      if(posWork=-1) then
      begin
        q.Next;
        Continue;
      end;

      tm:=strtoint(item.SubItems.Strings[posWork]);
      tm:=tm+q.FieldByName('time_work').AsInteger;
      sumTm:=sumTm+q.FieldByName('time_work').AsInteger;
      item.SubItems.Strings[posWork]:=inttostr(tm);

    end;
    q.Next;
   end;

item.SubItems[item.SubItems.Count-1]:=inttostr(sumTm);
Result:=item;
end;

procedure TfrClientWorkReportR.getTotalSum;
var i, j, sum:integer;
    item:TListItem;
begin
item:=lv.Items.Add;
item.Caption:='Итого';
//showmessage(inttostr(works.count));
//showmessage(inttostr(lv.Items.Count));
 for I := 0 to works.count do begin
    sum:=0;
    for j := 0 to lv.Items.Count-2 do begin
      //ShowMessage(lv.Items[j].Caption);
      sum:=sum+strtoint(lv.Items[j].SubItems[i]);
    end;
    item.SubItems.Add(inttostr(sum));
 end;

end;

procedure TfrClientWorkReportR.lvColumnClick(Sender: TObject;
  Column: TListColumn);
begin
ColumnToSort := Column.Index;
//if(ColumnToSort>0) then
if(sort=ssNone) then sort:=ssUp
else if(sort=ssUp) then sort:=ssDown
else if(sort=ssDown) then sort:=ssUp;

(Sender as TCustomListView).AlphaSort;
end;

procedure TfrClientWorkReportR.lvCompare(Sender: TObject; Item1,
  Item2: TListItem; Data: Integer; var Compare: Integer);
var
  ix: Integer;
  f1, f2:real;
begin
if(ColumnToSort=0) then
begin
  if(sort=ssUp) then
    Compare := CompareText(Item1.Caption, Item2.Caption)
  else  Compare := CompareText(Item2.Caption, Item1.Caption);
end else
begin
  ix := ColumnToSort - 1;
  f1:=strtofloat(Item1.SubItems[ix]);
  f2:=strtofloat(Item2.SubItems[ix]);
  if(sort=ssUp) then
      Compare:=CompareDoubleInc(f1, f2)
    else  Compare:=CompareDoubleInc(f2, f1);
end;

end;

procedure TfrClientWorkReportR.lvCustomDrawItem(Sender: TCustomListView;
  Item: TListItem; State: TCustomDrawState; var DefaultDraw: Boolean);
begin
if(Item.Caption='Итого') then
begin
    Sender.Canvas.Font.Style:= Sender.Canvas.Font.Style + [fsBold];
    Sender.Canvas.Brush.Color:=cl3dLight;
end else
if item.Index mod 2=0 then  Sender.Canvas.Brush.Color:=$00EFEFEF;
end;

procedure TfrClientWorkReportR.lvCustomDrawSubItem(Sender: TCustomListView;
  Item: TListItem; SubItem: Integer; State: TCustomDrawState;
  var DefaultDraw: Boolean);
begin
if(SubItem=Item.SubItems.Count) then
begin
    Sender.Canvas.Font.Style:= Sender.Canvas.Font.Style + [fsBold];
    Sender.Canvas.Brush.Color:=cl3dLight;
end;
end;

procedure TfrClientWorkReportR.N1Click(Sender: TObject);
begin
if not SaveDialog1.Execute(handle) then  exit;

UtilsUnit.saveListViewToExel(lv, saveDialog1.FileName);
end;

end.
