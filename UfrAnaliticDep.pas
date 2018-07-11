unit UfrAnaliticDep;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.StdCtrls, Vcl.ComCtrls, UfrAnaliticDepR;

type
  TfrAnaliticDep = class(TForm)
    dt1: TDateTimePicker;
    dt2: TDateTimePicker;
    Label1: TLabel;
    Button1: TButton;
    procedure FormCreate(Sender: TObject);
    procedure Button1Click(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  frAnaliticDep: TfrAnaliticDep;

implementation

{$R *.dfm}

procedure TfrAnaliticDep.Button1Click(Sender: TObject);
var frRep:TfrAnaliticDepR;
begin
if(dt1.Date>dt2.Date) then
begin
  ShowMessage('ƒата начала не может быть больше даты конца');
  exit;
end;
frRep:=TfrAnaliticDepR.Create(Application);
frRep.dt1:=dt1.Date;
frRep.dt2:=dt2.Date;
frRep.ShowModal;
end;

procedure TfrAnaliticDep.FormCreate(Sender: TObject);
begin
dt1.Date:=now;
dt2.Date:=now;
end;

end.
