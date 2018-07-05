program ClientsCrm;

uses
  Vcl.Forms,
  UfrLogin in 'UfrLogin.pas' {frLogin},
  DataUnit in 'DataUnit.pas' {dm: TDataModule},
  EncryptUnit in 'EncryptUnit.pas',
  UfrSett in 'UfrSett.pas' {frSett},
  MainUnit in 'MainUnit.pas' {frMain},
  UserModel in 'UserModel.pas',
  UfrManageUsers in 'UfrManageUsers.pas' {frManageUsers},
  UfrEditUser in 'UfrEditUser.pas' {frEditUser},
  UfrHandbook in 'UfrHandbook.pas' {frHandbook},
  UtilsUnit in 'UtilsUnit.pas',
  UfrEditTask in 'UfrEditTask.pas' {frEditTask},
  TaskUnit in 'TaskUnit.pas',
  UfrReportClient in 'UfrReportClient.pas' {frReportClient},
  UfrReportClientR in 'UfrReportClientR.pas' {frReportClientR},
  UfrClientWorkReport in 'UfrClientWorkReport.pas' {frClientWorkReport},
  UfrClientWorkReportR in 'UfrClientWorkReportR.pas' {frClientWorkReportR};

{$R *.res}

begin
  Application.Initialize;
  Application.MainFormOnTaskbar := True;
  Application.CreateForm(Tdm, dm);
  Application.CreateForm(TfrLogin, frLogin);
  //Application.CreateForm(TfrClientWorkReportR, frClientWorkReportR);
  //Application.CreateForm(TfrClientWorkReport, frClientWorkReport);
  //Application.CreateForm(TfrReportClientR, frReportClientR);
  //Application.CreateForm(TfrReportClient, frReportClient);
  //Application.CreateForm(TfrEditTask, frEditTask);
  //Application.CreateForm(TfrHandbook, frHandbook);
  //Application.CreateForm(TfrEditUser, frEditUser);
  //Application.CreateForm(TfrManageUsers, frManageUsers);
  //Application.CreateForm(TfrSett, frSett);
  //Application.CreateForm(TForm1, Form1);
  Application.Run;
end.
