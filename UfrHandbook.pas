unit UfrHandbook;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, DataUnit, DBGridEhGrouping, ToolCtrlsEh,
  DBGridEhToolCtrls, DynVarsEh, Vcl.ExtCtrls, Vcl.DBCtrls, EhLibVCL, GridsEh,
  DBAxisGridsEh, DBGridEh;

type
  TfrHandbook = class(TForm)
    DBGridEh1: TDBGridEh;
    DBNavigator1: TDBNavigator;
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure FormShow(Sender: TObject);
    procedure FormCloseQuery(Sender: TObject; var CanClose: Boolean);
  private
    { Private declarations }
  public
    { Public declarations }
    tableName:string;
    tableId:integer;//id таблицы=tag menuItem
  end;

var
  frHandbook: TfrHandbook;

implementation

{$R *.dfm}

procedure TfrHandbook.FormClose(Sender: TObject; var Action: TCloseAction);
begin
action:=caFree;
end;

procedure TfrHandbook.FormCloseQuery(Sender: TObject; var CanClose: Boolean);
begin
case tableId of
  0:begin
    dm.departmentsQ.Close;
  end;
  1:begin
    dm.clientsQ.Close;
  end;
  2:begin
    dm.worksQ.Close;
  end;
end;
end;

procedure TfrHandbook.FormShow(Sender: TObject);
begin
case tableId of
  0:begin
    dm.handbookDS.DataSet:=dm.departmentsQ;
    dm.departmentsQ.Open;
    Caption:='Подразделения';
  end;
  1:begin
    dm.handbookDS.DataSet:=dm.clientsQ;
    dm.clientsQ.Open;
    Caption:='Клиенты';
  end;
  2:begin
    dm.handbookDS.DataSet:=dm.worksQ;
    dm.worksQ.Open;
    Caption:='Виды работ';
  end;
end;
end;

end.
