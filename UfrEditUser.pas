unit UfrEditUser;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.StdCtrls, Data.DB, MemDS,
  DBAccess, MyAccess,
  DataUnit;

type
  TfrEditUser = class(TForm)
    Label1: TLabel;
    edFio: TEdit;
    Label2: TLabel;
    edLogin: TEdit;
    Label3: TLabel;
    edPass: TEdit;
    Label4: TLabel;
    ComboBox1: TComboBox;
    Label5: TLabel;
    ComboBox2: TComboBox;
    Button1: TButton;
    Button2: TButton;
    q: TMyQuery;
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure FormCreate(Sender: TObject);
    procedure Button2Click(Sender: TObject);
    procedure Button1Click(Sender: TObject);
    procedure FormShow(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
    idUser:integer;
  end;

var
  frEditUser: TfrEditUser;
  roles, departments: TStringList;
  i:integer;

implementation

{$R *.dfm}

uses UfrManageUsers;

function qs(s:string):string;
begin
  Result:=chr(39)+s+chr(39);
end;

procedure TfrEditUser.Button1Click(Sender: TObject);
var idRole, idDep:string;
begin
if(edFio.Text='')or(edPass.Text='')or(edLogin.Text='') then
begin
  ShowMessage('Заполните все поля');
  exit;
end;

idRole:=roles[ComboBox1.ItemIndex];
if(ComboBox2.ItemIndex=-1) then idDep:='-1'
else idDep:=departments[ComboBox2.ItemIndex];

if(idUser=-1) then begin
q.SQL.Text:='insert into `users` '+
  '(`id_role`, `login`, `pass`, `user_name`, `id_dep`) '+
  'values('
  +qs(idRole)
  +', '+qs(edLogin.Text)
  +', '+qs(edPass.Text)
  +', '+qs(edFio.Text)
  +', '+qs(idDep)
  +')';
q.Execute;
end else
begin
   q.SQL.Text:='UPDATE `users` SET '+
    '`user_name`='+qs(edfio.Text)+', '+
    '`login`='+qs(edLogin.Text)+', '+
    '`pass`='+qs(edPass.Text)+', '+
    '`id_role`='+qs(idRole)+', '+
    '`id_dep`='+qs(idDep)+
    ' WHERE `id`='+inttostr(iduser);
   q.Execute
end;

dm.usersQ.Refresh;
close;
end;

procedure TfrEditUser.Button2Click(Sender: TObject);
begin
Close;
end;

procedure TfrEditUser.FormClose(Sender: TObject; var Action: TCloseAction);
begin
Action:=caFree;
end;

procedure TfrEditUser.FormCreate(Sender: TObject);
begin
roles:=TStringList.Create();
departments:=TStringList.Create();

q.SQL.Text:='select * from user_roles';
q.Open;
for I := 0 to q.RecordCount-1 do
  begin
    roles.add(q.FieldByName('id').AsString);
    ComboBox1.Items.Add(q.FieldByName('name').AsString);
    q.Next;
  end;
ComboBox1.ItemIndex:=0;
q.Close;

q.SQL.Text:='select * from department';
q.Open;
for I := 0 to q.RecordCount-1 do
  begin
    departments.add(q.FieldByName('id').AsString);
    ComboBox2.Items.Add(q.FieldByName('name').AsString);
    q.Next;
  end;
q.Close;


end;

procedure TfrEditUser.FormShow(Sender: TObject);
begin
if(idUser<>-1) then
  begin
    q.SQL.Text:='select * from users where id='+inttostr(idUser);
    q.Open;
    if(q.RecordCount=0) then exit;

    edFio.Text:=q.FieldByName('user_name').AsString;
    edLogin.Text:=q.FieldByName('login').AsString;
    edPass.Text:=q.FieldByName('pass').AsString;
    ComboBox1.ItemIndex:=roles.IndexOf(q.FieldByName('id_role').AsString);
    ComboBox2.ItemIndex:=departments.IndexOf(q.FieldByName('id_dep').AsString);
    q.Close;
  end;
end;

end.
