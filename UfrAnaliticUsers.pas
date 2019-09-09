unit UfrAnaliticUsers;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, UtilsUnit, Vcl.ComCtrls, Vcl.StdCtrls,
  Vcl.CheckLst, dataunit, Data.DB, MemDS, DBAccess, MyAccess, UfrAnaliticUsersR;

type
  TfrAnaliticUsers = class(TForm)
    lbWorks: TCheckListBox;
    Button4: TButton;
    Button3: TButton;
    Label5: TLabel;
    Label1: TLabel;
    dt2: TDateTimePicker;
    dt1: TDateTimePicker;
    lbUsers: TCheckListBox;
    Label2: TLabel;
    Button1: TButton;
    Button2: TButton;
    Button5: TButton;
    q: TMyQuery;
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure FormCreate(Sender: TObject);
    procedure Button4Click(Sender: TObject);
    procedure Button1Click(Sender: TObject);
    procedure Button2Click(Sender: TObject);
    procedure Button3Click(Sender: TObject);
    procedure Button5Click(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
    users, works:TLockupValue;
  end;

var
  frAnaliticUsers: TfrAnaliticUsers;
  i:integer;

implementation

{$R *.dfm}

procedure TfrAnaliticUsers.Button1Click(Sender: TObject);
begin
lbUsers.CheckAll(cbUnChecked);
end;

procedure TfrAnaliticUsers.Button2Click(Sender: TObject);
begin
lbUsers.CheckAll(cbChecked);
end;

procedure TfrAnaliticUsers.Button3Click(Sender: TObject);
begin
lbWorks.CheckAll(cbChecked);
end;

procedure TfrAnaliticUsers.Button4Click(Sender: TObject);
begin
lbWorks.CheckAll(cbUnChecked);
end;

procedure TfrAnaliticUsers.Button5Click(Sender: TObject);
var frRep:TfrAnaliticUsersR;
    selClients, selWorks:TLockupValue;
begin
selWorks:=TLockupValue.Create;
selClients:=TLockupValue.Create;

for I := 0 to lbUsers.Items.Count-1 do
     if(lbUsers.Checked[i]) then selClients.addPair(users.getPair(i));

for I := 0 to lbWorks.Items.Count-1 do
     if(lbWorks.Checked[i]) then selWorks.addPair(works.getPair(i));

frRep:=TfrAnaliticUsersR.Create(Application);
frRep.dt1:=dt1.Date;
frRep.dt2:=dt2.Date;

frRep.works.Assign(selWorks);
frRep.users.Assign(selClients);
selWorks.Free;
selClients.Free;
frRep.ShowModal;
end;

procedure TfrAnaliticUsers.FormClose(Sender: TObject; var Action: TCloseAction);
begin
Action:=caFree;
end;

procedure TfrAnaliticUsers.FormCreate(Sender: TObject);
begin
works:=TLockupValue.Create;
users:=TLockupValue.Create;

dt1.date:=now;
dt2.date:=now;

q.SQL.Text:='select * from works order by name asc';
q.Open;
if(q.RecordCount=0)then
begin
  ShowMessage('Работ пока нет');
  exit;
  Button1.Enabled:=false;
end;

for I := 0 to q.RecordCount-1 do
  begin
    works.addPair(q.FieldByName('id').AsInteger, q.FieldByName('name').AsString);
    q.Next;
  end;
lbWorks.Items.Assign(works.slValues);
lbWorks.CheckAll(cbChecked);
q.Close;


q.SQL.Text:='select id, user_name from users order by user_name asc';
q.Open;

for I := 0 to q.RecordCount-1 do
  begin
    users.addPair(q.FieldByName('id').AsInteger, q.FieldByName('user_name').AsString);
    q.Next;
  end;
lbUsers.Items.Assign(users.slValues);
lbUsers.CheckAll(cbChecked);

q.Close
end;

end.
