unit UfrClientAnalitic;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.StdCtrls, Vcl.ComCtrls, UfrClientAnaliticR;

type
  TfrClientAnalitic = class(TForm)
    dt1: TDateTimePicker;
    dt2: TDateTimePicker;
    Label1: TLabel;
    dt3: TDateTimePicker;
    dt4: TDateTimePicker;
    Label2: TLabel;
    Button1: TButton;
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure FormCreate(Sender: TObject);
    procedure Button1Click(Sender: TObject);
  private
    { Private declarations }
    function validDate:boolean;
  public
    { Public declarations }
  end;

var
  frClientAnalitic: TfrClientAnalitic;

implementation

{$R *.dfm}

procedure TfrClientAnalitic.Button1Click(Sender: TObject);
var frRep:TfrClientAnaliticR;
begin
if not validDate then exit;
frRep:=TfrClientAnaliticR.Create(Application);
frRep.dt1:=dt1.Date;
frRep.dt2:=dt2.Date;
frRep.dt3:=dt3.Date;
frRep.dt4:=dt4.Date;
frRep.ShowModal;
end;

procedure TfrClientAnalitic.FormClose(Sender: TObject;
  var Action: TCloseAction);
begin
Action:=caFree;
end;

procedure TfrClientAnalitic.FormCreate(Sender: TObject);
begin
dt1.Date:=now;
dt2.Date:=now;
dt3.Date:=now;
dt4.Date:=now;
Caption:='��������� �������';
end;

function TfrClientAnalitic.validDate: boolean;
begin
result:=true;
if dt1.Date>dt2.Date then begin
 ShowMessage('������ 1: ���� ������ �� ����� ���� ������ ���� �����');
 result:=false;
end;

if dt3.Date>dt4.Date then begin
 ShowMessage('������ 2: ���� ������ �� ����� ���� ������ ���� �����');
 result:=false;
end;

if dt3.Date<=dt2.Date then begin
 ShowMessage('������ 2 ������ ��������� �� �������� 1');
 result:=false;
end;

end;

end.
