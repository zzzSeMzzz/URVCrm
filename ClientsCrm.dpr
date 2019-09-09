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
  UfrClientWorkReportR in 'UfrClientWorkReportR.pas' {frClientWorkReportR},
  UfrClientAnalitic in 'UfrClientAnalitic.pas' {frClientAnalitic},
  UfrClientAnaliticR in 'UfrClientAnaliticR.pas' {frClientAnaliticR},
  UfrAnaliticDep in 'UfrAnaliticDep.pas' {frAnaliticDep},
  UfrAnaliticDepR in 'UfrAnaliticDepR.pas' {frAnaliticDepR},
  UfrAnaliticWork in 'UfrAnaliticWork.pas' {frAnaliticWork},
  UfrAnaliticWorkR in 'UfrAnaliticWorkR.pas' {frAnaliticWorkR},
  UfrAnaliticUsers in 'UfrAnaliticUsers.pas' {frAnaliticUsers},
  UfrAnaliticUsersR in 'UfrAnaliticUsersR.pas' {frAnaliticUsersR},
  UfrAbout in 'UfrAbout.pas' {frAbout};

{$R *.res}

begin
  Application.Initialize;
  Application.MainFormOnTaskbar := True;
  Application.CreateForm(Tdm, dm);
  Application.CreateForm(TfrLogin, frLogin);
  //Application.CreateForm(TfrAbout, frAbout);
  //Application.CreateForm(TfrAnaliticUsersR, frAnaliticUsersR);
  //Application.CreateForm(TfrAnaliticUsers, frAnaliticUsers);
  //Application.CreateForm(TfrAnaliticWorkR, frAnaliticWorkR);
  //Application.CreateForm(TfrAnaliticWork, frAnaliticWork);
  //Application.CreateForm(TfrAnaliticDepR, frAnaliticDepR);
  //Application.CreateForm(TfrAnaliticDep, frAnaliticDep);
  //Application.CreateForm(TfrClientAnaliticR, frClientAnaliticR);
  //Application.CreateForm(TfrClientAnaliic, frClientAnaliic);
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
