unit UfrClientAnaliticR;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Data.DB, MemDS, DBAccess, MyAccess, DataUnit,
  UtilsUnit, Vcl.ComCtrls, Vcl.Menus;

type
  TfrClientAnaliticR = class(TForm)
    q: TMyQuery;
    lv: TListView;
    PopupMenu1: TPopupMenu;
    N1: TMenuItem;
    SaveDialog1: TSaveDialog;
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure FormShow(Sender: TObject);
    procedure lvCompare(Sender: TObject; Item1, Item2: TListItem; Data: Integer;
      var Compare: Integer);
    procedure lvColumnClick(Sender: TObject; Column: TListColumn);
    procedure lvCustomDrawItem(Sender: TCustomListView; Item: TListItem;
      State: TCustomDrawState; var DefaultDraw: Boolean);
    procedure N1Click(Sender: TObject);
  private
    { Private declarations }
    procedure createSqlReport;
  public
    { Public declarations }
    dt1, dt2, dt3, dt4:Tdate;
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
  frClientAnaliticR: TfrClientAnaliticR;
  ColumnToSort:integer;
  sort:TSortState=ssNone;

implementation

{$R *.dfm}

procedure TfrClientAnaliticR.createSqlReport;
var i:integer;
    tm, currWork, nextWork, allTime:integer;
    tm2, allTime2:integer;
    client:string;

function addItem(name:string; tm, tm2:integer):TListItem;
var item:TListItem;
    r:integer;
begin
  item:=lv.Items.Add;
  item.Caption:=name;
  item.SubItems.Add(inttostr(tm));
  item.SubItems.Add(inttostr(tm2));
  r:= tm2-tm;
  item.SubItems.Add(inttostr(r));
  item.SubItems.Add(FormatFloat('#0.##', r/60));
  if(tm<>0) then
    item.SubItems.Add(FormatFloat('#0.##', (tm2/tm -1)*100 ))
    else item.SubItems.Add('----');
  Result:=item;
end;

function getNumInterval:integer;
begin
  if(q.FieldByName('dt').AsDateTime<=dt2)and(q.FieldByName('dt').AsDateTime>=dt1)
  then result:=1 else
  if(q.FieldByName('dt').AsDateTime>=dt3)and(q.FieldByName('dt').AsDateTime<=dt4)
  then Result:=2 else Result:=-1;
end;

procedure getTotalSum;
var t1, t2, i:integer;
begin
t1:=0;
t2:=0;
  for I := 0  to lv.Items.Count-1 do
  begin
    t1:=t1+strtoint(lv.Items.Item[i].SubItems[0]);
    t2:=t2+strtoint(lv.Items.Item[i].SubItems[1]);
  end;
  addItem('Итого', t1, t2);
end;

begin
q.SQL.Text:=sqlReport+sqlGroup+sqlOrder;
q.ParamByName('dt1').Value:=toMySqlDate(dt1);
q.ParamByName('dt2').Value:=toMySqlDate(dt4);

q.Open;
if(q.RecordCount=0) then exit;

tm:=0;
tm2:=0;
allTime:=0;
allTime2:=0;
currWork:=q.FieldByName('id_client').AsInteger;
//currWork2:=q.FieldByName('id_client').AsInteger;
client:=q.FieldByName('client').AsString;
//client2:=q.FieldByName('client').AsString;

for I := 0 to q.RecordCount-1 do
begin
nextWork:= q.FieldByName('id_client').AsInteger;
//ShowMessage(IntToStr(getNumInterval));
if(getNumInterval=-1) then begin
 q.next;
 Continue;//елси не попали ни в один интервал
end;

  if(currWork=nextWork) then
  begin

    if(getNumInterval=1) then tm:=tm+q.FieldByName('time_work').AsInteger
    else tm2:=tm2+q.FieldByName('time_work').AsInteger;

    if(i=q.RecordCount-1) then addItem(client, tm, tm2);
  end else
  begin

    addItem(client, tm, tm2);

    if(getNumInterval=1) then begin
      tm:=q.FieldByName('time_work').AsInteger;
      tm2:=0;
    end else
    begin
      tm2:=q.FieldByName('time_work').AsInteger;
      tm:=0;
    end;

    currWork:=q.FieldByName('id_client').AsInteger;
    client:=q.FieldByName('client').AsString;

    if(i=q.RecordCount-1) then addItem(client, tm, tm2);
  end;

q.Next;
end;

q.Close;

getTotalSum;
end;

procedure TfrClientAnaliticR.FormClose(Sender: TObject;
  var Action: TCloseAction);
begin
Action:=caFree;
end;

procedure TfrClientAnaliticR.FormShow(Sender: TObject);
begin
lv.Columns.Items[1].Caption:=datetostr(dt1)+'-'+datetostr(dt2);
lv.Columns.Items[2].Caption:=datetostr(dt3)+'-'+datetostr(dt4);
createSqlReport;
end;

procedure TfrClientAnaliticR.lvColumnClick(Sender: TObject;
  Column: TListColumn);
begin
ColumnToSort := Column.Index;
//if(ColumnToSort>0) then
if(sort=ssNone) then sort:=ssUp
else if(sort=ssUp) then sort:=ssDown
else if(sort=ssDown) then sort:=ssUp;

(Sender as TCustomListView).AlphaSort;
end;

procedure TfrClientAnaliticR.lvCompare(Sender: TObject; Item1, Item2: TListItem;
  Data: Integer; var Compare: Integer);
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

procedure TfrClientAnaliticR.lvCustomDrawItem(Sender: TCustomListView;
  Item: TListItem; State: TCustomDrawState; var DefaultDraw: Boolean);
begin
if(Item.Caption='Итого') then
begin
    Sender.Canvas.Font.Style:= Sender.Canvas.Font.Style + [fsBold];
    Sender.Canvas.Brush.Color:=cl3dLight;
end else
if item.Index mod 2=0 then  Sender.Canvas.Brush.Color:=$00EFEFEF;
end;

procedure TfrClientAnaliticR.N1Click(Sender: TObject);
begin
if not SaveDialog1.Execute(handle) then  exit;

UtilsUnit.saveListViewToExel(lv, saveDialog1.FileName);
end;

end.
