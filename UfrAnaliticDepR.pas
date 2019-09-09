unit UfrAnaliticDepR;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Data.DB, MemDS, DBAccess, MyAccess, DataUnit,
  Vcl.ComCtrls, UtilsUnit, Vcl.Menus;

type
  TfrAnaliticDepR = class(TForm)
    q: TMyQuery;
    lv: TListView;
    PopupMenu1: TPopupMenu;
    N1: TMenuItem;
    SaveDialog1: TSaveDialog;
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure FormShow(Sender: TObject);
    procedure lvColumnClick(Sender: TObject; Column: TListColumn);
    procedure lvCompare(Sender: TObject; Item1, Item2: TListItem; Data: Integer;
      var Compare: Integer);
    procedure lvCustomDrawItem(Sender: TCustomListView; Item: TListItem;
      State: TCustomDrawState; var DefaultDraw: Boolean);
    procedure N1Click(Sender: TObject);
  private
    { Private declarations }
    procedure createSqlReport;
    procedure createReport;
  public
    { Public declarations }
    dt1, dt2:TDate;
  end;

const
    sqlReport:string=
      'select tasks.id, tasks.id_client, tasks.id_work, tasks.time_work, tasks.dt, tasks.user_id,'+chr(13)+
      'clients.`name` as `client`,'+chr(13)+
      'works.`name` as `work`,'+chr(13)+
      'users.`id_dep` as `id_dep`'+chr(13)+
      'from tasks'+chr(13)+
      'LEFT JOIN works ON (works.`id`=tasks.`id_work`)'+chr(13)+
      'LEFT JOIN clients ON (clients.`id`=tasks.`id_client`)'+chr(13)+
      'LEFT JOIN users ON (users.`id`=tasks.`user_id`)'+chr(13)+
      'WHERE  (tasks.dt BETWEEN :dt1 AND :dt2)';
    sqlGroup:string=' GROUP BY tasks.id';
    sqlOrder:string=' ORDER BY clients.name ASC';

var
  frAnaliticDepR: TfrAnaliticDepR;
  idDep1, idDep2:integer;
  ColumnToSort: Integer;
  sort:TSortState=ssNone;

implementation

{$R *.dfm}

procedure TfrAnaliticDepR.createReport;
var i, j:integer;
    tm1, currWork, nextWork:integer;
    tm2:integer;
    tmClnt:integer;
    client:string;
    allTimes:array[0..2] of integer;

    function getNumDep:integer;
    begin
      if(q.FieldByName('id_dep').AsInteger=idDep1)then Result:=1
      else Result:=2;
    end;

function addItem(name:string; tm0, tm1, tm2:integer):TListItem;
var item:TListItem;
begin
  item:=lv.Items.Add;
  item.Caption:=name;
  item.SubItems.Add(inttostr(tm0));
  item.SubItems.Add(inttostr(tm1));
  item.SubItems.Add(inttostr(tm2));
  if(tm1<>0) then item.SubItems.Add(FormatFloat('#0.##', tm2/tm1))
  else item.SubItems.Add('0');
  if(tm0<>0) then item.SubItems.Add(FormatFloat('#0.##', tm1/tm0))
  else item.SubItems.Add('0');
  Result:=item;
end;

begin
q.Open;
if(q.RecordCount=0) then exit;

tm1:=0;
tm2:=0;
tmClnt:=0;
currWork:=q.FieldByName('id_client').AsInteger;
client:=q.FieldByName('client').AsString;

for I := 0 to q.RecordCount-1 do
begin
  nextWork:= q.FieldByName('id_client').AsInteger;
  if(currWork=nextWork) then
  begin
    if(getNumDep=1)then tm1:=tm1+q.FieldByName('time_work').AsInteger
    else tm2:=tm2+q.FieldByName('time_work').AsInteger;

    tmClnt:=tmClnt+tm1+q.FieldByName('time_work').AsInteger;

    if(i=q.RecordCount-1) then addItem(client, tmClnt, tm1, tm2);
  end else
  begin
    addItem(client, tmClnt, tm1, tm2);

    if(getNumDep=1)then
    begin
       tm1:=q.FieldByName('time_work').AsInteger;
       tm2:=0;
    end else
    begin
      tm2:=q.FieldByName('time_work').AsInteger;
      tm1:=0;
    end;
    tmClnt:=q.FieldByName('time_work').AsInteger;

    currWork:=q.FieldByName('id_client').AsInteger;
    client:=q.FieldByName('client').AsString;

    if(i=q.RecordCount-1) then addItem(client, tmClnt, tm1, tm2);
  end;
q.Next;
end;

q.Close;

for I := 0 to lv.Items.Count-1 do
  for j := 0 to 2 do //первые 3 поля только считаем, остальное вычислим по формуле
  begin
    allTimes[j]:=allTimes[j]+strtoint(lv.Items[i].SubItems[j]);
  end;

addItem('Итоги', allTimes[0], allTimes[1], allTimes[2]);
end;

procedure TfrAnaliticDepR.createSqlReport;
var slUserIds:TStringList;
    i:integer;
begin
q.SQL.Text:='select * from department';
//по условию, должно быть всего 2 подразделения
q.Open;
if(q.RecordCount=0)or(q.RecordCount<2) then exit;
idDep1:=q.FieldByName('id').AsInteger;
q.Next;
idDep2:=q.FieldByName('id').AsInteger;
q.Close;


q.SQL.Text:=sqlReport+'AND (users.id_dep in('+inttostr(idDep1)+','+inttostr(idDep2)+'))'
      +sqlGroup+sqlOrder;
q.ParamByName('dt1').Value:=toMySqlDate(dt1);
q.ParamByName('dt2').Value:=toMySqlDate(dt2);

createReport;
end;


procedure TfrAnaliticDepR.FormClose(Sender: TObject; var Action: TCloseAction);
begin
Action:=caFree;
end;

procedure TfrAnaliticDepR.FormShow(Sender: TObject);
begin
createSqlReport;
end;

procedure TfrAnaliticDepR.lvColumnClick(Sender: TObject; Column: TListColumn);
begin
ColumnToSort := Column.Index;
//if(ColumnToSort>0) then
if(sort=ssNone) then sort:=ssUp
else if(sort=ssUp) then sort:=ssDown
else if(sort=ssDown) then sort:=ssUp;

(Sender as TCustomListView).AlphaSort;
end;

procedure TfrAnaliticDepR.lvCompare(Sender: TObject; Item1, Item2: TListItem;
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

procedure TfrAnaliticDepR.lvCustomDrawItem(Sender: TCustomListView;
  Item: TListItem; State: TCustomDrawState; var DefaultDraw: Boolean);
begin
if(Item.Caption='Итоги') then
begin
    Sender.Canvas.Font.Style:= Sender.Canvas.Font.Style + [fsBold];
    Sender.Canvas.Brush.Color:=cl3dLight;
end else if item.Index mod 2=0 then  Sender.Canvas.Brush.Color:=$00EFEFEF;

end;

procedure TfrAnaliticDepR.N1Click(Sender: TObject);
begin
if not SaveDialog1.Execute(handle) then  exit;

UtilsUnit.saveListViewToExel(lv, saveDialog1.FileName);
end;

end.
