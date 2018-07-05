unit UfrEditTask;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.ComCtrls, Vcl.StdCtrls, UtilsUnit,
  DataUnit, Data.DB, MemDS, DBAccess, MyAccess, TaskUnit;

type
  TfrEditTask = class(TForm)
    Label1: TLabel;
    dtPicker: TDateTimePicker;
    Label2: TLabel;
    cbClients: TComboBox;
    Label3: TLabel;
    cbWorks: TComboBox;
    label23: TLabel;
    edTime: TEdit;
    Label4: TLabel;
    edComment: TMemo;
    Button1: TButton;
    Button2: TButton;
    q: TMyQuery;
    procedure CreateParams(var Params: TCreateParams); override;
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure Button2Click(Sender: TObject);
    procedure FormCloseQuery(Sender: TObject; var CanClose: Boolean);
    procedure FormCreate(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure Button1Click(Sender: TObject);
    procedure FormKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
  private
    { Private declarations }
  public
    { Public declarations }
    idTask:integer;
    task:TTask;
  end;

var
  frEditTask: TfrEditTask;
  works, clients:TLockupValue;
  i:integer;

implementation

{$R *.dfm}


procedure TfrEditTask.Button1Click(Sender: TObject);
begin
if(cbClients.ItemIndex=-1)or(cbWorks.ItemIndex=-1)or(edTime.Text='')
then begin
       messagedlg('Заполните поля клиент, вид работы, время', mtwarning, [mbok], 0);
       exit;
     end;
 //if(dtPicker.=nil)then dtPicker.Date:=now;

 if(idTask=-1) then
 begin
 //ShowMessage(toMySqlDate(dtPicker.Date));
   q.SQL.Text:='insert into `tasks` '+
  '(`dt`, `id_client`, `id_work`, `time_work`, `comment`, `user_id`) '+
  'values('
  + qs(toMySqlDate(dtPicker.Date))
  +', '+qs(clients.getIdFromPosValue(cbClients.ItemIndex))
  +', '+qs(works.getIdFromPosValue(cbWorks.ItemIndex))
  +', '+qs(edTime.Text)
  +', '+qs(edComment.Text)
  +', '+qs(inttostr(task.idUser))
  +')';
  q.Execute;
 end else
 begin
   q.SQL.Text:='UPDATE `tasks` SET '+
    '`dt`='+qs(toMySqlDate(dtPicker.Date))+', '+
    '`id_client`='+qs(clients.getIdFromPosValue(cbClients.ItemIndex))+', '+
    '`id_work`='+qs(works.getIdFromPosValue(cbWorks.ItemIndex))+', '+
    '`time_work`='+qs(edTime.Text)+', '+
    '`comment`='+qs(edComment.Text)+', '+
    '`user_id`='+qs(inttostr(task.idUser))+
    ' WHERE `id`='+inttostr(idTask);
   q.Execute
 end;

 dm.taskQ.Refresh;
 close;
end;

procedure TfrEditTask.Button2Click(Sender: TObject);
begin
Close;
end;

procedure TfrEditTask.CreateParams(var Params: TCreateParams);
begin
  inherited;
  Params.ExStyle := Params.ExStyle or WS_EX_APPWINDOW;
end;

procedure TfrEditTask.FormClose(Sender: TObject; var Action: TCloseAction);
begin
Action:=caFree;
end;

procedure TfrEditTask.FormCloseQuery(Sender: TObject; var CanClose: Boolean);
begin
works.Free;
clients.Free;
end;

procedure TfrEditTask.FormCreate(Sender: TObject);
begin
dtPicker.Date:=now;
works:=TLockupValue.Create;
clients:=TLockupValue.Create;

q.sql.Text:='select * from clients';
q.Open;
for I := 0 to q.RecordCount-1 do
begin
  clients.addPair(q.FieldByName('id').AsInteger, q.FieldByName('name').AsString);
  q.Next;
end;
q.Close;
cbClients.Items.Assign(clients.slValues);

q.sql.Text:='select * from works';
q.Open;
for I := 0 to q.RecordCount-1 do
begin
  works.addPair(q.FieldByName('id').AsInteger, q.FieldByName('name').AsString);
  q.Next;
end;
q.Close;
cbWorks.Items.Assign(works.slValues);

end;

procedure TfrEditTask.FormKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
if ([ssCtrl] = Shift) and (Key = VK_RETURN) then begin
    //Нажата комбинация Ctrl+Enter.
    //...
    //...
    Button1.Click;
  end;
end;

procedure TfrEditTask.FormShow(Sender: TObject);
begin
if(idTask<>-1) then
begin
  dtPicker.Date:=task.date;
  edComment.Text:=task.comment;
  cbClients.ItemIndex:=clients.getPositionFromId(task.idClient);
  cbWorks.ItemIndex:=works.getPositionFromId(task.idWork);
  edTime.Text:=inttostr(task.time);
end;
end;

end.
