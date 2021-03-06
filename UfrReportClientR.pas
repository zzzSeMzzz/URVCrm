unit UfrReportClientR;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, DBGridEhGrouping, ToolCtrlsEh,
  DBGridEhToolCtrls, DynVarsEh, EhLibVCL, GridsEh, DBAxisGridsEh, DBGridEh, DataUnit,
  Data.DB, DBAccess, MyAccess, MemDS, UtilsUnit, Vcl.ComCtrls, Vcl.Menus;

type
  TfrReportClientR = class(TForm)
    DBGridEh1: TDBGridEh;
    q: TMyQuery;
    ds: TMyDataSource;
    lv: TListView;
    PopupMenu1: TPopupMenu;
    N1: TMenuItem;
    SaveDialog1: TSaveDialog;
    procedure FormShow(Sender: TObject);
    procedure lvCustomDrawItem(Sender: TCustomListView; Item: TListItem;
      State: TCustomDrawState; var DefaultDraw: Boolean);
    procedure lvCompare(Sender: TObject; Item1, Item2: TListItem; Data: Integer;
      var Compare: Integer);
    procedure lvColumnClick(Sender: TObject; Column: TListColumn);
    procedure N1Click(Sender: TObject);
  private
    { Private declarations }
    procedure createSqlReport;
  public
    { Public declarations }
    idDep, nameDep:string;
    dt1, dt2:TDate;
    userId:string;
  end;

const
    sqlReport:string=
      'select tasks.id, tasks.id_client, tasks.id_work, tasks.time_work, tasks.dt, tasks.user_id,'+chr(13)+
      'clients.`name` as `client`,'+chr(13)+
      'works.`name` as `work`'+chr(13)+
      'from tasks'+chr(13)+
      'LEFT JOIN works ON (works.`id`=tasks.`id_work`)'+chr(13)+
      'LEFT JOIN clients ON (clients.`id`=tasks.`id_client`)'+chr(13)+
     // 'WHERE  (tasks.dt BETWEEN ' + qs(':dt1') + ' AND ' + qs(':dt2') + ')';
      'WHERE  (tasks.dt BETWEEN :dt1 AND :dt2)';
    sqlGroup:string=' GROUP BY tasks.id';
    sqlOrder:string=' ORDER BY clients.name ASC';

var
  frReportClientR: TfrReportClientR;
  i:integer;
  ColumnToSort: Integer;
  sort:TSortState=ssNone;

implementation

{$R *.dfm}

procedure TfrReportClientR.createSqlReport;
var slUserIds:TStringList;
begin
if(idDep='-2') then
begin
 q.SQL.Text:=sqlReport+chr(13)+
        'AND (tasks.user_id in('+userId+'))'
        +sqlGroup+sqlOrder;
     q.ParamByName('dt1').Value:=toMySqlDate(dt1);
     q.ParamByName('dt2').Value:=toMySqlDate(dt2);
end else
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
       ShowMessage('�� ������� �� ������ ������������ � ���� �������������');
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

procedure TfrReportClientR.FormShow(Sender: TObject);
var tm, currWork, nextWork, allTime:integer;
    client:string;


function addItem(name:string; tm:integer):TListItem;
var item:TListItem;
begin
  item:=lv.Items.Add;
  item.Caption:=name;
  item.SubItems.Add(inttostr(tm));
  item.SubItems.Add(FormatFloat('#0.##', tm/60));
  item.SubItems.Add(minToHour(tm));
  Result:=item;
end;

begin
Caption:='����� '+nameDep;

createSqlReport;
//ShowMessage(q.SQL.Text);
q.Open;
if(q.RecordCount=0) then exit;

tm:=0;
allTime:=0;
currWork:=q.FieldByName('id_client').AsInteger;
client:=q.FieldByName('client').AsString;
for I := 0 to q.RecordCount-1 do
begin
  nextWork:= q.FieldByName('id_client').AsInteger;

  if(currWork=nextWork) then
  begin
    tm:=tm+q.FieldByName('time_work').AsInteger;
    if(i=q.RecordCount-1) then addItem(client, tm);
  end else
  begin
    addItem(client, tm);

    tm:=q.FieldByName('time_work').AsInteger;
    currWork:=q.FieldByName('id_client').AsInteger;
    client:=q.FieldByName('client').AsString;

    if(i=q.RecordCount-1) then addItem(client, tm);
  end;

allTime:=allTime+q.FieldByName('time_work').AsInteger;
if(i=q.RecordCount-1) then addItem('�����:', allTime);
q.Next;
end;

q.Close;
end;



procedure TfrReportClientR.lvColumnClick(Sender: TObject; Column: TListColumn);
begin
ColumnToSort := Column.Index;
//if(ColumnToSort>0) then
if(sort=ssNone) then sort:=ssUp
else if(sort=ssUp) then sort:=ssDown
else if(sort=ssDown) then sort:=ssUp;

(Sender as TCustomListView).AlphaSort;
end;


procedure TfrReportClientR.lvCompare(Sender: TObject; Item1, Item2: TListItem;
  Data: Integer; var Compare: Integer);
var
  ix: Integer;
  f1, f2:real;
begin
case ColumnToSort of
  0:begin
  if(sort=ssUp) then
    Compare := CompareText(Item1.Caption, Item2.Caption)
  else  Compare := CompareText(Item2.Caption, Item1.Caption);
    //showmessage(inttostr(Compare));
  end;
  1,2:begin
    ix := ColumnToSort - 1;
    f1:=strtofloat(Item1.SubItems[ix]);
    f2:=strtofloat(Item2.SubItems[ix]);
    if(sort=ssUp) then
      Compare:=CompareDoubleInc(f1, f2)
    else  Compare:=CompareDoubleInc(f2, f1);
  end;
  3:begin
    ix := ColumnToSort - 2;
    f1:=strtofloat(Item1.SubItems[ix]);
    f2:=strtofloat(Item2.SubItems[ix]);
    if(sort=ssUp) then
      Compare:=CompareDoubleInc(f1, f2)
    else  Compare:=CompareDoubleInc(f2, f1);
  end;
end;
end;

procedure TfrReportClientR.lvCustomDrawItem(Sender: TCustomListView;
  Item: TListItem; State: TCustomDrawState; var DefaultDraw: Boolean);
begin
if(Item.Caption='�����:') then
begin
    Sender.Canvas.Font.Style:= Sender.Canvas.Font.Style + [fsBold];
    Sender.Canvas.Brush.Color:=cl3dLight;
end else if item.Index mod 2=0 then  Sender.Canvas.Brush.Color:=$00EFEFEF;
end;

procedure TfrReportClientR.N1Click(Sender: TObject);
begin
if not SaveDialog1.Execute(handle) then  exit;

UtilsUnit.saveListViewToExel(lv, saveDialog1.FileName);
end;

end.
