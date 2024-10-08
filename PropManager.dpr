program PropManager;

uses
  Forms,
  Login in 'Login.pas' { frmPAT2024 } ,
  SignUp in 'SignUp.pas' { frmSignUp } ,
  Main in 'Main.pas' { frmMainDB } ,
  NewProd in 'NewProd.pas' { frmNew } ,
  conPropDB in 'conPropDB.pas' { dbmPropDB: TDataModule } ,
  conPropImplementDB in 'conPropImplementDB.pas' { dbmPropImpl: TDataModule } ,
  Validation_U in 'Validation_U.pas',
  SubmitApp in 'SubmitApp.pas' { SubmitApplication } ,
  Admin in 'Admin.pas' { AdminManagement } ,
  PropertyDetails in 'PropertyDetails.pas' { frmPropDetails } ;
{$R *.res}

begin
  Application.Initialize;
  Application.MainFormOnTaskbar := True;
  Application.CreateForm(TSubmitApplication, SubmitApplication);
  Application.CreateForm(TfrmPAT2024, frmPAT2024);
  Application.CreateForm(TAdminManagement, AdminManagement);
  Application.CreateForm(TfrmNew, frmNew);
  Application.CreateForm(TfrmMainDB, frmMainDB);
  Application.CreateForm(TfrmSignUp, frmSignUp);
  Application.CreateForm(TdbmPropDB, dbmPropDB);
  Application.CreateForm(TdbmPropImpl, dbmPropImpl);
  Application.CreateForm(TfrmPropDetails, frmPropDetails);
  Application.Run;

end.
