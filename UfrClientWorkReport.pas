unit UfrClientWorkReport;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.StdCtrls, Data.DB, MemDS, DBAccess,
  MyAccess, Vcl.ComCtrls, DataUnit, UtilsUnit, Vcl.CheckLst, UfrClientWorkReportR;

type
  TfrClientWorkReport = class(TForm)
    dt2: TDateTimePicker;
    q: TMyQuery;
    dt1: TDateTimePicker;
    cb: TComboBox;
    Label3: TLabel;
    Label2: TLabel;
    Label1: TLabel;
    lbClient: TCheckListBox;
    lbWorks: TCheckListBox;
    Label4: TLabel;
    Label5: TLabel;
    Button1: TButton;
    Button2: TButton;
    Button3: TButton;
    Button4: TButton;
    Button5: TButton;
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure FormCreate(Sender: TObject);
    procedure Button1Click(Sender: TObject);
    procedure Button3Click(Sender: TObject);
    procedure Button2Click(Sender: TObject);
    procedure Button4Click(Sender: TObject);
    procedure Button5Click(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  frClientWorkReport: TfrClientWorkReport;
  i:integer;
  dep, clients, works:TLockupValue;

implementation

{$R *.dfm}

procedure TfrClientWorkReport.Button1Click(Sender: TObject);
begin
lbClient.CheckAll(cbChecked);
end;

procedure TfrClientWorkReport.Button2Click(Sender: TObject);
begin
lbClient.CheckAll(cbUnChecked);
end;

procedure TfrClientWorkReport.Button3Click(Sender: TObject);
begin
lbWorks.CheckAll(cbChecked);
end;

procedure TfrClientWorkReport.Button4Click(Sender: TObject);
begin
lbWorks.CheckAll(cbUnChecked);
end;

procedure TfrClientWorkReport.Button5Click(Sender: TObject);
var
  frRep:TfrClientWorkReportR;
  selClients, selWorks:TLockupValue;
begin
selClients:=TLockupValue.Create;
selWorks:=TLockupValue.Create;
  frRep:=TfrClientWorkReportR.Create(Application);
  frRep.dt1:=dt1.Date;
  frRep.dt2:=dt2.Date;
  frRep.idDep:=dep.getIdFromPosValue(cb.ItemIndex);
  frRep.nameDep:=cb.Text;
  for I := 0 to lbClient.Items.Count-1 do
     if(lbClient.Checked[i]) then selClients.addPair(clients.getPair(i));
  for I := 0 to lbWorks.Items.Count-1 do
     if(lbWorks.Checked[i]) then selWorks.addPair(works.getPair(i));

  frRep.clients.Assign(selClients);
  frRep.works.Assign(selWorks);

  frRep.ShowModal;
end;

procedure TfrClientWorkReport.FormClose(Sender: TObject;
  var Action: TCloseAction);
begin
Action:=caFree;
end;

procedure TfrClientWorkReport.FormCreate(Sender: TObject);
begin
dt1.Date:=now;
dt2.Date:=now;
dep:=TLockupValue.Create;
clients:=TLockupValue.Create;
works:=TLockupValue.Create;
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

q.SQL.Text:='select * from clients order by name asc';
q.Open;
for I := 0 to q.RecordCount-1 do
  begin
    clients.addPair(q.FieldByName('id').AsInteger, q.FieldByName('name').AsString);
    q.Next;
  end;
lbClient.Items.Assign(clients.slValues);
lbClient.CheckAll(cbChecked);
q.Close;

q.SQL.Text:='select * from works order by name asc';
q.Open;
for I := 0 to q.RecordCount-1 do
  begin
    works.addPair(q.FieldByName('id').AsInteger, q.FieldByName('name').AsString);
    q.Next;
  end;
lbWorks.Items.Assign(works.slValues);
q.Close;
lbWorks.CheckAll(cbChecked);
end;

end.
