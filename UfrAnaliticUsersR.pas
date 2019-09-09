unit UfrAnaliticUsersR;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, UtilsUnit, DataUnit, Data.DB, MemDS,
  DBAccess, MyAccess, Vcl.ComCtrls, DBGridEhGrouping, ToolCtrlsEh,
  DBGridEhToolCtrls, DynVarsEh, EhLibVCL, GridsEh, DBAxisGridsEh, DBGridEh,
  Vcl.Menus;

type
  TfrAnaliticUsersR = class(TForm)
    lv: TListView;
    q: TMyQuery;
    MyDataSource1: TMyDataSource;
    DBGridEh1: TDBGridEh;
    PopupMenu1: TPopupMenu;
    N1: TMenuItem;
    SaveDialog1: TSaveDialog;
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure FormCreate(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure lvCustomDrawItem(Sender: TCustomListView; Item: TListItem;
      State: TCustomDrawState; var DefaultDraw: Boolean);
    procedure lvCustomDrawSubItem(Sender: TCustomListView; Item: TListItem;
      SubItem: Integer; State: TCustomDrawState; var DefaultDraw: Boolean);
    procedure N1Click(Sender: TObject);
  private
    { Private declarations }
    procedure createReportSql;
    procedure createReport;
  public
    { Public declarations }
    users, works:TLockupValue;
    dt1, dt2:TDate;
  end;

const
    sqlReport:string=
      'select tasks.id, tasks.id_client, tasks.id_work, tasks.time_work, tasks.dt, tasks.user_id,'+chr(13)+
      'works.`name` as `work`'+chr(13)+
      'from tasks'+chr(13)+
      'LEFT JOIN works ON (works.`id`=tasks.`id_work`)'+chr(13)+
      'WHERE  (tasks.dt BETWEEN :dt1 AND :dt2)';
    sqlGroup:string=' GROUP BY tasks.id';
    sqlOrder:string=' ORDER BY tasks.`user_id` ASC, tasks.id_work ASC';

var
  frAnaliticUsersR: TfrAnaliticUsersR;

implementation

{$R *.dfm}

procedure TfrAnaliticUsersR.createReport;
var i:integer;
    tm, currWork, nextWork, cntWorks, currUser, nextUser:integer;
    user, work:string;

function addItem(name, work:string; tm, countWorks:integer):TListItem;
var item:TListItem;
begin
  item:=lv.Items.Add;
  item.Caption:=name;
  item.SubItems.Add(work);
  item.SubItems.Add(inttostr(tm));
  item.SubItems.Add(FormatFloat('#0.##', tm/countWorks));
  {r:= tm2-tm;
  item.SubItems.Add(inttostr(r));
  item.SubItems.Add(FormatFloat('#0.##', r/60));
  if(tm<>0) then
    item.SubItems.Add(FormatFloat('#0.##', (tm2/tm -1)*100 ))
    else item.SubItems.Add('----');  }
  Result:=item;
end;


begin
q.Open;
if(q.RecordCount=0) then exit;

currWork:=q.FieldByName('id_work').AsInteger;
currUser:=q.FieldByName('user_id').AsInteger;
//currWork2:=q.FieldByName('id_client').AsInteger;
user:=users.getValueFromId(q.FieldByName('user_id').AsInteger);
work:=q.FieldByName('work').AsString;
tm:=0;
cntWorks:=0;

//q.SQL.SaveToFile('d:\sql.txt');
//ShowMessage(q.sql.Text);
//ShowMessage('cnt ='+inttostr(q.RecordCount));

for I := 0 to q.RecordCount-1 do
  begin
    nextWork:= q.FieldByName('id_work').AsInteger;
    nextUser:=q.FieldByName('user_id').AsInteger;

    if(currWork=nextWork)and(currUser=nextUser) then
    begin
      tm:=tm+q.FieldByName('time_work').AsInteger;
      inc(cntWorks);
      //Showmessage('#'+inttostr(q.RecNo));
      //showmessage(inttostr(tm));

      if(i=q.RecordCount-1) then addItem(user, work, tm, cntWorks);
    end else
    begin
      addItem(user, work, tm, cntWorks);

      tm:=q.FieldByName('time_work').AsInteger;
      cntWorks:=1;
      user:=users.getValueFromId(q.FieldByName('user_id').AsInteger);
      work:=q.FieldByName('work').AsString;
      currWork:=q.FieldByName('id_work').AsInteger;
      currUser:=q.FieldByName('user_id').AsInteger;

      if(i=q.RecordCount-1) then addItem(user, work, tm, cntWorks);
    end;

    q.Next;
  end;

q.Close;
end;

procedure TfrAnaliticUsersR.createReportSql;
begin
q.SQL.Text:=sqlReport+chr(13)+
        'AND (tasks.user_id in('+users.getIds(',')+'))'+chr(13)+
        'AND (tasks.id_work in('+works.getIds(',')+'))'
        +sqlGroup+sqlOrder;
q.ParamByName('dt1').Value:=toMySqlDate(dt1);
q.ParamByName('dt2').Value:=toMySqlDate(dt2);
createReport;
end;

procedure TfrAnaliticUsersR.FormClose(Sender: TObject;
  var Action: TCloseAction);
begin
Action:=caFree;
end;

procedure TfrAnaliticUsersR.FormCreate(Sender: TObject);
begin
works:=TLockupValue.Create;
users:=TLockupValue.Create;
end;

procedure TfrAnaliticUsersR.FormShow(Sender: TObject);
begin
createReportSql;
end;

procedure TfrAnaliticUsersR.lvCustomDrawItem(Sender: TCustomListView;
  Item: TListItem; State: TCustomDrawState; var DefaultDraw: Boolean);
begin
{if(Item.Caption='Итого') then
begin
    Sender.Canvas.Font.Style:= Sender.Canvas.Font.Style + [fsBold];
    Sender.Canvas.Brush.Color:=cl3dLight;
end else }if item.Index mod 2=0 then  Sender.Canvas.Brush.Color:=$00EFEFEF;
end;

procedure TfrAnaliticUsersR.lvCustomDrawSubItem(Sender: TCustomListView;
  Item: TListItem; SubItem: Integer; State: TCustomDrawState;
  var DefaultDraw: Boolean);
begin
{if(SubItem=Item.SubItems.Count) then
begin
    Sender.Canvas.Font.Style:= Sender.Canvas.Font.Style + [fsBold];
    Sender.Canvas.Brush.Color:=cl3dLight;
end;}
end;

procedure TfrAnaliticUsersR.N1Click(Sender: TObject);
begin
if not SaveDialog1.Execute(handle) then  exit;

UtilsUnit.saveListViewToExel(lv, saveDialog1.FileName);
end;

end.
