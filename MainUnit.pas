unit MainUnit;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, UserModel, Vcl.ComCtrls, Vcl.ToolWin,
  System.ImageList, Vcl.ImgList, acAlphaImageList, Vcl.Menus, UfrHandbook,
  DBGridEhGrouping, ToolCtrlsEh, DBGridEhToolCtrls, DynVarsEh, EhLibVCL,
  GridsEh, DBAxisGridsEh, DBGridEh, DataUnit, UfrEditTask, TaskUnit, Data.DB,
  MemDS, DBAccess, MyAccess, StrUtils, DbUtilsEh, UfrReportClient, UfrClientWorkReport,
  UfrClientAnalitic, UfrAnaliticDep;

type
  TfrMain = class(TForm)
    ToolBar1: TToolBar;
    btnAdmin: TToolButton;
    toolImages: TsAlphaImageList;
    ToolButton2: TToolButton;
    btnBooks: TToolButton;
    ToolButton4: TToolButton;
    btnAdd: TToolButton;
    handBookMenu: TPopupMenu;
    G1: TMenuItem;
    AllImages: TsAlphaImageList;
    R1: TMenuItem;
    N1: TMenuItem;
    DBGridEh1: TDBGridEh;
    ToolButton1: TToolButton;
    ToolButton3: TToolButton;
    ToolButton5: TToolButton;
    ToolButton6: TToolButton;
    ToolButton7: TToolButton;
    q: TMyQuery;
    btnReport: TToolButton;
    reportMenu: TPopupMenu;
    J1: TMenuItem;
    N2: TMenuItem;
    N3: TMenuItem;
    N4: TMenuItem;
    N5: TMenuItem;
    F1: TMenuItem;
    N6: TMenuItem;
    N7: TMenuItem;

    procedure CreateParams(var Params: TCreateParams); override;
    procedure btnAdminClick(Sender: TObject);
    procedure G1Click(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure btnAddClick(Sender: TObject);
    procedure ToolButton1Click(Sender: TObject);
    procedure ToolButton6Click(Sender: TObject);
    procedure DBGridEh1DblClick(Sender: TObject);
    procedure ToolButton3Click(Sender: TObject);
    procedure DBGridEh1TitleClick(Column: TColumnEh);
    procedure DBGridEh1ApplyFilter(Sender: TObject);
    procedure DBGridEh1KeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure FormCreate(Sender: TObject);
    procedure DBGridEh1DrawColumnCell(Sender: TObject; const Rect: TRect;
      DataCol: Integer; Column: TColumnEh; State: TGridDrawState);
    procedure J1Click(Sender: TObject);
    procedure N2Click(Sender: TObject);
    procedure F1Click(Sender: TObject);
    procedure N7Click(Sender: TObject);
  private
    { Private declarations }
    function getTaskSql:string;
    function getTaskSqlSorted(ack:boolean; column:string):string;
  public
    { Public declarations }
    CurrentUser:TUser;
  end;

const
  settFolder:string='clientscrm';
  FOddRowColor:TColor= $00EFEFEF;

var
  frMain: TfrMain;

implementation

{$R *.dfm}

uses UfrManageUsers;

function TfrMain.getTaskSql:string;
begin
if(CurrentUser.Role<>urAdmin) then
begin
  Result:=dataUnit.taskSql
  +' WHERE tasks.`user_id`='+inttostr(CurrentUser.id)
  +' '+DataUnit.taskSqlGrop;
  //ShowMessage(dm.taskQ.SQL.Text);
end else Result:=dataUnit.taskSql+' '+DataUnit.taskSqlGrop;
end;

function TfrMain.getTaskSqlSorted(ack:boolean; column:string):string;
begin
if(CurrentUser.Role<>urAdmin) then
begin
  Result:=dataUnit.taskSql
  +' WHERE tasks.`user_id`='+inttostr(CurrentUser.id)
  +' '+DataUnit.taskSqlGrop
  +' '+IfThen(ack, 'order by '+column+' asc', 'order by '+column+' desc');
  //ShowMessage(dm.taskQ.SQL.Text);
end else Result:=dataUnit.taskSql+' '+DataUnit.taskSqlGrop
          +' '+IfThen(ack, 'order by '+column+' asc', 'order by '+column+' desc');
end;


procedure TfrMain.J1Click(Sender: TObject);
var frReport:TfrReportClient;
begin
frReport:=TfrReportClient.Create(Application);
frReport.ShowModal;
end;

procedure TfrMain.N2Click(Sender: TObject);
var frReport:TfrClientWorkReport;
begin
frReport:=TfrClientWorkReport.Create(Application);
frReport.ShowModal;
end;

procedure TfrMain.N7Click(Sender: TObject);
var frRep:TfrAnaliticDep;
begin
frRep:=TfrAnaliticDep.Create(Application);
frRep.ShowModal;
end;

procedure TfrMain.CreateParams(var Params: TCreateParams);
begin
  inherited;
  Params.ExStyle := Params.ExStyle or WS_EX_APPWINDOW;
end;

procedure TfrMain.DBGridEh1ApplyFilter(Sender: TObject);
var s : string;
cond:string;
begin
cond:='';
s:='';
s:=GetExpressionAsFilterString(TDBGridEh(Sender), GetOneExpressionAsLocalFilterString, nil);
//showmessage(s);
dm.taskQ.Filter:=s;
dm.taskQ.Filtered:=dm.taskQ.Filter<>'';
//gfilter[1]:=s;
end;

procedure TfrMain.DBGridEh1DblClick(Sender: TObject);
var frTask:TfrEditTask;
    task:TTask;
begin
if(dm.taskQ.RecordCount=0)then exit;

frTask:=TfrEditTask.Create(Application);
frTask.idTask:=dm.taskQ.FieldByName('id').AsInteger;
with dm.taskQ do
 task:=TTask.Create(
    FieldByName('id').AsInteger, FieldByName('dt').AsDateTime,
    FieldByName('id_client').AsInteger, FieldByName('id_work').AsInteger,
    FieldByName('work').AsString, FieldByName('client').AsString,
    FieldByName('comment').AsString,
    FieldByName('time_work').AsInteger, FieldByName('user_id').AsInteger
    );

frTask.task:=task;
frTask.Show;
end;

procedure TfrMain.DBGridEh1DrawColumnCell(Sender: TObject; const Rect: TRect;
  DataCol: Integer; Column: TColumnEh; State: TGridDrawState);
begin
{IsOdd := Odd((Sender as TDBGridEh).DataSource.Dataset.RecNo);
if IsOdd then
begin
(Sender as TDBGridEh).Canvas.Brush.Color := FOddRowColor;
end;

if gdSelected in State Then
  	TDBGridEh(Sender).Canvas.Brush.Color:= clDefault;
TDBGridEh(Sender).DefaultDrawColumnCell(Rect,DataCol,Column,State);}
end;

procedure TfrMain.DBGridEh1KeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
if(Key=VK_INSERT) then btnAdd.Click;
if(Key=VK_DELETE) then ToolButton3.Click;
end;

procedure TfrMain.DBGridEh1TitleClick(Column: TColumnEh);
begin
//DBGridEh1.SortLocal:=true;
//DBGridEh1.OptionsEh:=DBGridEh1.OptionsEh + [dghAutoSortMarking];
//DBGridEh1.FieldColumns[Column.FieldName].Title.SortMarker := smDownEh;
// or like this
DBGridEh1.FieldColumns[Column.FieldName].Title.SetNextSortMarkerValue(True);
case Column.Title.SortMarker of
    smDownEh: begin
                dm.taskQ.SQL.Text:=getTaskSqlSorted(true, Column.FieldName);
                //showmessage(dm.taskQ.SQL.Text);
                dm.taskQ.open;
              end;
    smUpEh: begin
                dm.taskQ.SQL.Text:=getTaskSqlSorted(false, Column.FieldName);
                //showmessage(dm.taskQ.SQL.Text);
                dm.taskQ.open;
              end;
    smNoneEh: begin
                //showmessage(dm.taskQ.SQL.Text);
                dm.taskQ.SQL.Text:=getTaskSql;
                dm.taskQ.open;
            end;
end;
//2. Apply sorting
  //DBGridEh1.DefaultApplySorting;
end;

procedure TfrMain.F1Click(Sender: TObject);
var frRep:TfrClientAnalitic;
begin
frRep:=TfrClientAnalitic.Create(Application);
frRep.ShowModal;
end;

procedure TfrMain.FormClose(Sender: TObject; var Action: TCloseAction);
begin
DBGridEh1.SaveColumnsLayoutIni(getmys+settFolder+'\'+'gridMain.ini', 'main',false);
end;

procedure TfrMain.FormCreate(Sender: TObject);
var
  RestoreParams:TDBGridEhRestoreParams;
begin
RestoreParams:=[grpColWidthsEh];
DBGridEh1.RestoreGridLayoutIni(getmys+settFolder+'\'+'gridMain.ini','main', RestoreParams);
n3.Visible:=False;
n4.Visible:=false;
end;

procedure TfrMain.FormShow(Sender: TObject);
begin
btnAdmin.Enabled:=CurrentUser.Role=urAdmin;
n1.Enabled:=CurrentUser.Role=urAdmin;
g1.Enabled:=CurrentUser.Role=urAdmin;

if(CurrentUser.Role<>urAdmin) then
begin
  dm.taskQ.SQL.Text:=dataUnit.taskSql
  +' WHERE tasks.`user_id`='+inttostr(CurrentUser.id)
  +' '+DataUnit.taskSqlGrop;
  //ShowMessage(dm.taskQ.SQL.Text);
end;
dm.tasksFilter.SQL.Text:=getTaskSql;
dm.taskQ.Open;
dm.tasksFilter.Open;
end;

procedure TfrMain.G1Click(Sender: TObject);
var currItem:TmenuItem;
    table:string;
    frHandBook:TfrHandBook;
begin
  currItem:=TMenuItem(sender);
  case currItem.Tag of
    0:table:='department';
    1:table:='clients';
    2:table:='works';
  end;
 frHandBook:=TfrHandbook.Create(Application);
 frHandBook.tableName:=table;
 frHandBook.tableId:=currItem.Tag;
 frHandBook.ShowModal;
end;

procedure TfrMain.ToolButton1Click(Sender: TObject);
var frTask:TfrEditTask;
    task:TTask;
begin
if(dm.taskQ.RecordCount=0)then exit;

frTask:=TfrEditTask.Create(Application);
frTask.idTask:=dm.taskQ.FieldByName('id').AsInteger;
with dm.taskQ do
 task:=TTask.Create(
    FieldByName('id').AsInteger, FieldByName('dt').AsDateTime,
    FieldByName('id_client').AsInteger, FieldByName('id_work').AsInteger,
    FieldByName('work').AsString, FieldByName('client').AsString,
    FieldByName('comment').AsString,
    FieldByName('time_work').AsInteger, FieldByName('user_id').AsInteger
    );

frTask.task:=task;
frTask.ShowModal;
end;

procedure TfrMain.ToolButton3Click(Sender: TObject);
begin
if(dm.taskQ.RecordCount=0) then exit;

if(MessageDlg('Действительно удалить?',mtconfirmation, [mbyes, mbno],0)=mrYes) then
begin
 q.SQL.Text:='delete from tasks where id='+dm.taskQ.FieldByName('id').AsString;
 q.Execute;
 dm.taskQ.Refresh;
end;
end;

procedure TfrMain.ToolButton6Click(Sender: TObject);
begin
if(dm.taskQ.Active)then dm.taskQ.Refresh;
end;

procedure TfrMain.btnAddClick(Sender: TObject);
var frTask:TfrEditTask;
begin
  frTask:=TfrEditTask.Create(Application);
  frTask.idTask:=-1;
  frTask.task:=TTask.Create;
  frTask.task.idUser:=CurrentUser.id;
  frTask.ShowModal;
end;

procedure TfrMain.btnAdminClick(Sender: TObject);
var frManageU:TfrManageUsers;
begin
frManageU:=TfrManageUsers.Create(Application);
frManageU.ShowModal;
end;

end.
