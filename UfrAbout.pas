unit UfrAbout;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.StdCtrls;

type
  TfrAbout = class(TForm)
    Label1: TLabel;
    Label2: TLabel;
    Button1: TButton;
    procedure Button1Click(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  frAbout: TfrAbout;

implementation

{$R *.dfm}

procedure TfrAbout.Button1Click(Sender: TObject);
begin
close;
end;

procedure TfrAbout.FormClose(Sender: TObject; var Action: TCloseAction);
begin
Action:=caFree;
end;

end.
