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
    Label1: TLabel;
    q: TMyQuery;
    Label2: TLabel;
    dt1: TDateTimePicker;
    dt2: TDateTimePicker;
    Label3: TLabel;
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure FormCreate(Sender: TObject);
    procedure Button1Click(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  frReportClient: TfrReportClient;
  i:integer;
  dep:TLockupValue;

implementation

{$R *.dfm}

procedure TfrReportClient.Button1Click(Sender: TObject);
var frRep:TfrReportClientR;
begin
frRep:=TfrReportClientR.Create(Application);
frRep.idDep:=dep.getIdFromPosValue(cb.ItemIndex);
frRep.dt1:=dt1.Date;
frRep.dt2:=dt2.Date;
frRep.nameDep:=cb.Text;
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
end;

end.
