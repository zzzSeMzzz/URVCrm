unit UfrAnaliticWork;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, UfrAnaliticWorkR, Data.DB, MemDS,
  DBAccess, MyAccess, Vcl.StdCtrls, Vcl.ComCtrls, UtilsUnit, DataUnit,
  Vcl.CheckLst;

type
  TfrAnaliticWork = class(TForm)
    dt4: TDateTimePicker;
    Button1: TButton;
    dt3: TDateTimePicker;
    dt2: TDateTimePicker;
    dt1: TDateTimePicker;
    Label2: TLabel;
    Label1: TLabel;
    cbClient: TComboBox;
    q: TMyQuery;
    Label5: TLabel;
    Label4: TLabel;
    lbWorks: TCheckListBox;
    Button3: TButton;
    Button4: TButton;
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure FormCreate(Sender: TObject);
    function validDate:boolean;
    procedure Button1Click(Sender: TObject);
    procedure Button4Click(Sender: TObject);
    procedure Button3Click(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  frAnaliticWork: TfrAnaliticWork;
  clients, works:TLockupValue;
  i:integer;

implementation

{$R *.dfm}

procedure TfrAnaliticWork.Button1Click(Sender: TObject);
var frRep:TfrAnaliticWorkR;
    selClients, selWorks:TLockupValue;
begin
if not validDate then exit;
{if(cbWork1.ItemIndex=cbWork2.ItemIndex)
then begin
       ShowMessage('Работы для сравнения должны быть разными');
       exit;
     end; }

selWorks:=TLockupValue.Create;
selClients:=TLockupValue.Create;

{for I := 0 to lbClient.Items.Count-1 do
     if(lbClient.Checked[i]) then selClients.addPair(clients.getPair(i));}
selClients.addPair(clients.getIdFromPosValue(cbClient.ItemIndex), cbClient.Text);
for I := 0 to lbWorks.Items.Count-1 do
     if(lbWorks.Checked[i]) then selWorks.addPair(works.getPair(i));



frRep:=TfrAnaliticWorkR.Create(Application);
frRep.dt1:=dt1.Date;
frRep.dt2:=dt2.Date;
frRep.dt3:=dt3.Date;
frRep.dt4:=dt4.Date;
frRep.idClient:=clients.getIdFromPosValue(cbClient.ItemIndex);
frRep.works.Assign(selWorks);
frRep.clients.Assign(selClients);
selWorks.Free;
selClients.Free;
frRep.ShowModal;
end;

procedure TfrAnaliticWork.Button3Click(Sender: TObject);
begin
lbWorks.CheckAll(cbChecked);
end;

procedure TfrAnaliticWork.Button4Click(Sender: TObject);
begin
lbWorks.CheckAll(cbUnChecked);
end;

procedure TfrAnaliticWork.FormClose(Sender: TObject; var Action: TCloseAction);
begin
Action:=caFree;
end;

procedure TfrAnaliticWork.FormCreate(Sender: TObject);
begin
dt1.date:=now;
dt2.date:=now;
dt3.date:=now;
dt4.date:=now;
clients:=TLockupValue.Create;
works:=TLockupValue.Create;
q.SQL.Text:='select * from clients order by name asc';
q.Open;
if(q.RecordCount=0)then
begin
  ShowMessage('Клиентов пока нет');
  exit;
  Button1.Enabled:=false;
end;

for I := 0 to q.RecordCount-1 do
  begin
    clients.addPair(q.FieldByName('id').AsInteger, q.FieldByName('name').AsString);
    q.Next;
  end;
cbClient.Items.Assign(clients.slValues);
cbClient.ItemIndex:=0;
q.Close;


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
end;

function TfrAnaliticWork.validDate: boolean;
begin
result:=true;
if dt1.Date>dt2.Date then begin
 ShowMessage('Период 1: дата начала не может быть больше даты конца');
 result:=false;
end;

if dt3.Date>dt4.Date then begin
 ShowMessage('Период 2: дата начала не может быть больше даты конца');
 result:=false;
end;

if dt3.Date<=dt2.Date then begin
 ShowMessage('Период 2 должен следовать за периодом 1');
 result:=false;
end;
end;

end.
