unit UfrReportClient;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Data.DB, MemDS, DBAccess, MyAccess,
  Vcl.StdCtrls, UtilsUnit, DataUnit, Vcl.ComCtrls, UfrReportClientR;

type
  TfrReportClient = class(TForm)
    Button1: TButton;
    cb: TComboBox;
    q: TMyQuery;
    Label2: TLabel;
    dt1: TDateTimePicker;
    dt2: TDateTimePicker;
    Label3: TLabel;
    rbDep: TRadioButton;
    RadioButton1: TRadioButton;
    cbUser: TComboBox;
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure FormCreate(Sender: TObject);
    procedure Button1Click(Sender: TObject);
    procedure RadioButton1Click(Sender: TObject);
    procedure rbDepClick(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  frReportClient: TfrReportClient;
  i:integer;
  dep, usr:TLockupValue;

implementation

{$R *.dfm}

procedure TfrReportClient.Button1Click(Sender: TObject);
var frRep:TfrReportClientR;
begin
frRep:=TfrReportClientR.Create(Application);
if(rbDep.Checked) then begin
  frRep.idDep:=dep.getIdFromPosValue(cb.ItemIndex);
  frRep.nameDep:=cb.Text;
end else begin
  frRep.idDep:='-2';
  frRep.userId:=usr.getIdFromPosValue(cbUser.ItemIndex);
  frRep.nameDep:=cbUser.Text;
end;
frRep.dt1:=dt1.Date;
frRep.dt2:=dt2.Date;

frRep.ShowModal;
end;

procedure TfrReportClient.FormClose(Sender: TObject; var Action: TCloseAction);
begin
dep.Free;
Action:=caFree;
end;

procedure TfrReportClient.FormCreate(Sender: TObject);
begin
dt1.Date:=now;
dt2.Date:=now;
dep:=TLockupValue.Create;
usr:=TLockupValue.Create;
q.SQL.Text:='select * from department order by name asc';
q.Open;
//if q.RecordCount=0 then exit;
dep.addPair(-1, 'По всем');
for I := 0 to q.RecordCount-1 do
  begin
    dep.addPair(q.FieldByName('id').AsInteger, q.FieldByName('name').AsString);
    q.Next;
  end;
q.Close;
cb.Items.Assign(dep.slValues);
cb.ItemIndex:=0;

q.SQL.Text:='select id, user_name from users';
q.Open;
for I := 0 to q.RecordCount-1 do
  begin
    usr.addPair(q.FieldByName('id').AsInteger, q.FieldByName('user_name').AsString);
    q.Next;
  end;
q.Close;
cbuser.Items.Assign(usr.slValues);
cbuser.ItemIndex:=0;
end;

procedure TfrReportClient.RadioButton1Click(Sender: TObject);
begin
cb.Enabled:=false;
cbUser.Enabled:=true;
end;

procedure TfrReportClient.rbDepClick(Sender: TObject);
begin
cb.Enabled:=true;
cbUser.Enabled:=false;
end;

end.
