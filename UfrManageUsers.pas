unit UfrManageUsers;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, DBGridEhGrouping, ToolCtrlsEh,
  DBGridEhToolCtrls, DynVarsEh, EhLibVCL, GridsEh, DBAxisGridsEh, DBGridEh, DataUnit,
  MainUnit, Vcl.Buttons, sSpeedButton, UfrEditUser, Data.DB, MemDS, DBAccess,
  MyAccess, Vcl.StdCtrls;

type
  TfrManageUsers = class(TForm)
    DBGridEh1: TDBGridEh;
    sSpeedButton1: TsSpeedButton;
    sSpeedButton2: TsSpeedButton;
    sSpeedButton3: TsSpeedButton;
    q: TMyQuery;
    chFired: TCheckBox;
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure FormShow(Sender: TObject);
    procedure FormCloseQuery(Sender: TObject; var CanClose: Boolean);
    procedure sSpeedButton1Click(Sender: TObject);
    procedure sSpeedButton3Click(Sender: TObject);
    procedure sSpeedButton2Click(Sender: TObject);
    procedure chFiredClick(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  frManageUsers: TfrManageUsers;

implementation

{$R *.dfm}

procedure TfrManageUsers.chFiredClick(Sender: TObject);
begin
DataUnit.dm.usersq.close;
if(chFired.Checked)then
DataUnit.dm.usersQ.SQL.Text:=DataUnit.userWithFiredSql  else
DataUnit.dm.usersQ.SQL.Text:=DataUnit.userWithoutFiredSql;
DataUnit.dm.usersq.open;
end;

procedure TfrManageUsers.FormClose(Sender: TObject; var Action: TCloseAction);
begin
Action:=caFree;
end;

procedure TfrManageUsers.FormCloseQuery(Sender: TObject; var CanClose: Boolean);
begin
DataUnit.dm.usersQ.Close;
end;

procedure TfrManageUsers.FormShow(Sender: TObject);
begin
if(chFired.Checked)then
DataUnit.dm.usersQ.SQL.Text:=DataUnit.userWithFiredSql  else
DataUnit.dm.usersQ.SQL.Text:=DataUnit.userWithoutFiredSql;
DataUnit.dm.usersq.open;
end;

procedure TfrManageUsers.sSpeedButton1Click(Sender: TObject);
var frEdit:TfrEditUser;
begin
 frEdit:=TfrEditUser.Create(Application);
 frEdit.idUser:=-1;
 frEdit.ShowModal;
end;

procedure TfrManageUsers.sSpeedButton2Click(Sender: TObject);
begin
if(dm.usersQ.RecordCount=0)then exit;
if(MessageDlg('Действительно удалить?',mtconfirmation, [mbyes, mbno],0)=mrYes) then
begin
 q.SQL.Text:='delete from users where id='+dm.usersQ.FieldByName('id').AsString;
 q.Execute;
 dm.usersQ.Refresh;
end;
end;

procedure TfrManageUsers.sSpeedButton3Click(Sender: TObject);
var frEdit:TfrEditUser;
begin
if(dm.usersQ.RecordCount=0) then exit;
 frEdit:=TfrEditUser.Create(Application);
 //Caption:=dm.usersQ.FieldByName('id').AsString;
 frEdit.idUser:=dm.usersQ.FieldByName('id').AsInteger;
 frEdit.ShowModal;
end;

end.
