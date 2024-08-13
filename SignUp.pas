unit SignUp;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, jpeg, ExtCtrls, StdCtrls, Main, Login, conPropDB, Validation_U;

type
  TfrmSignUp = class(TForm)
    btnSignUp: TButton;
    btnReturn: TButton;
    edtPassword: TEdit;
    edtUsername: TEdit;
    edtFirstName: TEdit;
    lblUserRew2: TLabel;
    lblUerReq: TLabel;
    lblPassReq2: TLabel;
    lbl7Char: TLabel;
    lblUserNameSu: TLabel;
    lblName: TLabel;
    lblPasswordSu: TLabel;
    Image1: TImage;
    Label2: TLabel;
    Edit1: TEdit;
    Label3: TLabel;
    RadioGroup1: TRadioGroup;
    Label1: TLabel;
    chkShow: TCheckBox;
    Shape1: TShape;
    procedure btnReturnClick(Sender: TObject);
    procedure btnSignUpClick(Sender: TObject);
    procedure chkShowClick(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  frmSignUp: TfrmSignUp;
  sFirstName, sSurname: string;
  objVal : DataValidation;

implementation

{$R *.dfm}

procedure TfrmSignUp.btnReturnClick(Sender: TObject);
begin
  frmPAT2024.Show;
  frmSignUp.Hide;
end;

procedure TfrmSignUp.btnSignUpClick(Sender: TObject);
var
  sUsername, sPassword, sGender: string;
  I, J, K: integer;
begin
objVal := DataValidation.create;
  sUsername := edtUsername.Text;
  sPassword := edtPassword.Text;
  sFirstName := edtFirstName.Text;
  sGender := RadioGroup1.items[RadioGroup1.ItemIndex];
  btnSignUp.Enabled := False;
  if objVal.isValidPassword(sPassword) = False then
  begin
    if length(sPassword) < 8 then // Length validation 
    begin
      showmessage('Password must be more than 8 characters');
      edtPassword.SetFocus;
      exit;
    end; // if length(sPassword)<8 then 

  end;

  if (sFirstName = '') then
  begin
    showmessage('First Name cannot be empty');
    edtFirstName.SetFocus;
    exit;
  end // if (sFirstName='') then 
  else
  begin
    if (sUsername = '') then
    begin
      showmessage('Username cannot be empty');
      edtUsername.SetFocus;
    end;
  end;

  for I := 1 to length(sFirstName) do // Data type validation 
  begin
    if NOT CharInSet(sFirstName[I], ['a' .. 'z', 'A' .. 'Z']) then
    begin
      showmessage('Please enter only alphabetic characters for First Name');
      edtFirstName.SetFocus;
      exit;
    end; // if NOT CharInSet (sFirstName[I],['a'..'z','A'..'Z']) then 
  end; // for I := 0 to length(sFirstName) do 

  btnSignUp.Enabled := True;

  if MessageDlg('Please confirm the username and password', mtConfirmation,
    [mbYes, mbNo], 0) = mrYes then
  begin
    dbmPropDB.tblUsers.Append;
    dbmPropDB.tblUsers['UserID'] := 'US-' + IntToStr
      (dbmPropDB.tblUsers.RecordCount);
    dbmPropDB.tblUsers['Username'] := sUsername;
    dbmPropDB.tblUsers['FirstName'] := sFirstName;
    dbmPropDB.tblUsers['Password'] := sPassword;
    dbmPropDB.tblUsers['Gender'] := sGender;
    dbmPropDB.tblUsers.Post;

    showmessage('New user registration successful.');

  end // if MessageDlg('Have you confirmed the username and password??' , mtConfirmation, mbYesNo, 0) = mrYes then 
  else
    exit;

end;

procedure TfrmSignUp.chkShowClick(Sender: TObject);
begin
 if chkShow.Checked then
    edtPassword.PasswordChar := #0;
  if chkShow.Checked = False then
    edtPassword.PasswordChar := '*';

end;

end.
