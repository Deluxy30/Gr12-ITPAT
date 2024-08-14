unit Login;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, jpeg, ExtCtrls, StdCtrls, conPropImplementDB, conPropDB, ShellAPI,
  pngimage;

type
  TfrmPAT2024 = class(TForm)
    edtPassword: TEdit;
    edtUserName: TEdit;
    btnLogin: TButton;
    lblCreatAcc: TLabel;
    Label2: TLabel;
    Label1: TLabel;
    Image1: TImage;
    chkShow: TCheckBox;
    Label3: TLabel;
    Label4: TLabel;
    Shape1: TShape;
    Image2: TImage;
    Image3: TImage;
    Image4: TImage;
    chkRemember: TCheckBox;
    lblUsername: TLabel;
    lblPassword: TLabel;
    procedure btnLoginClick(Sender: TObject);
    procedure lblCreatAccClick(Sender: TObject);
    procedure chkShowClick(Sender: TObject);
    procedure btnQuitClick(Sender: TObject);
    procedure Label3Click(Sender: TObject);
    procedure Image4Click(Sender: TObject);
    procedure FormActivate(Sender: TObject);
    procedure lblForgorClick(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  frmPAT2024: TfrmPAT2024;
  bAdmin: boolean;
  lblForgotPassword: TLabel;

implementation

uses Main, SignUp;
{$R *.dfm}

procedure TfrmPAT2024.btnLoginClick(Sender: TObject);
var
  sPassword, sUserName, sLine, sDate, sTime: string;
  bFlag: boolean;
  tLogin: textfile;
  outF: textfile;
begin

  bFlag := False;
  bAdmin := False;
  sDate := DateToStr(Date);
  sTime := TimeToStr(Time);
  sPassword := edtPassword.Text;
  sUserName := edtUserName.Text;
  // Verification for Username And Password
  with dbmPropDB do
  begin
    tblUsers.First;
    while not tblUsers.eof do
    begin
      if (tblUsers['Password'] = sPassword) AND
        (tblUsers['Username'] = sUserName) then
      begin
        bFlag := True;
      end;
      tblUsers.Next;
    end;
    if (sUserName = '') then
    begin
      showmessage('Username cannot be empty');
      edtUserName.SetFocus;
      exit;
    end // if (sUsername='') then
    else
    begin
      if (sPassword = '') then
      begin
        showmessage('Password cannot be empty');
        edtPassword.SetFocus;
        exit;
      end; // if (sUsername='') then
    end; // else
    if bFlag = False then
    begin
      showmessage('User or Password Incorrect' + #13 +
          'Otherwise create new account');

      lblForgotPassword := TLabel.Create(frmPAT2024);
      lblForgotPassword.Parent := frmPAT2024;
      lblForgotPassword.Caption := 'Forgot Password?';
      lblForgotPassword.Left := 478;
      lblForgotPassword.Top := 74;
      lblForgotPassword.Color := clLime;
      lblForgotPassword.Transparent := False;
      lblForgotPassword.Enabled := True;
      lblForgotPassword.OnClick := lblForgorClick;
    end;

    if dbmPropDB.tblUsers['UserType'] = 'Admin' then
    begin
      bAdmin := True;
    end;
    // Login History Text File
    if bFlag = True then
    begin
      showmessage('Welcome ' + sUserName);
      frmPAT2024.Hide;
      frmMainDB.Show;
      if FileExists('Login History.txt') then
      begin
        AssignFile(tLogin, 'Login History.txt');
      end
      else
      begin
        showmessage('File not found');
      end;
      // Write Date,Time and Username to File
      Append(tLogin);
      sLine := sUserName + ' at ' + sTime + ' on ' + sDate;
      Writeln(tLogin, sLine);
      CloseFile(tLogin)

    end;
  end;
  // Check if the "Remember Me" checkbox is checked
  if chkRemember.Checked then
  begin
    AssignFile(outF, 'LastLogin.txt'); // Assign the file
    Rewrite(outF); // Create or overwrite the file
    Writeln(outF, edtUserName.Text + '#' + edtPassword.Text);
    // Write the username and password to the file
    CloseFile(outF); // Close the file
  end
  else
  begin
    Rewrite(outF);
  end;
end;

procedure TfrmPAT2024.btnQuitClick(Sender: TObject);
begin
  frmPAT2024.Close;
end;

procedure TfrmPAT2024.chkShowClick(Sender: TObject);
begin
  // Hide Password On/Off
  if chkShow.Checked then
    edtPassword.PasswordChar := #0;
  if chkShow.Checked = False then
    edtPassword.PasswordChar := '*';

end;

procedure TfrmPAT2024.FormActivate(Sender: TObject);
var
  inF: textfile;
  sLine: string;
  iHash: integer;
begin
  // lblForgor.Visible := False;
  AssignFile(inF, 'LastLogin.txt');
  if FileExists('LastLogin.txt') then
  begin
    Reset(inF);
    Readln(inF, sLine);
    iHash := Pos('#', sLine);
    edtUserName.Text := Copy(sLine, 1, iHash - 1);
    edtPassword.Text := Copy(sLine, iHash + 1);
  end;
  CloseFile(inF);

end;

procedure TfrmPAT2024.Image4Click(Sender: TObject);
begin
  frmPAT2024.Close;
end;

procedure TfrmPAT2024.Label3Click(Sender: TObject);
begin
  // Using Shell API, to open a textfile within a specified App using the path
  // Credit to http://www.delphigroups.info/2/28/165398.html :D
  ShellExecute(HInstance, NIL, PCHAR('C:\Windows\Notepad.exe'),
    PCHAR('Login History.txt'), NIL, 1);
end;

procedure TfrmPAT2024.lblCreatAccClick(Sender: TObject);
begin
  // Opens Create Account window
  frmSignUp.Show;
  frmPAT2024.Hide;
end;

procedure TfrmPAT2024.lblForgorClick(Sender: TObject);
var
  UserID, PhoneNumber, FirstName: string;
begin
  // Prompt for ID
  if not InputQuery('Forgot Password', 'Enter your ID:', UserID) then
    exit;

  // Prompt for Phone Number
  if not InputQuery('Forgot Password', 'Enter your First Name:', FirstName) then
    exit;

  try // Your TADOConnection component
    dbmPropDB.qryProperties.SQL.Text :=
      'SELECT Username, Password FROM tblUsers WHERE ID = :UserID AND FirstName = :FirstName';
    dbmPropDB.qryProperties.Parameters.ParamByName('UserID').Value := UserID;
    dbmPropDB.qryProperties.Parameters.ParamByName('FirstName')
      .Value := FirstName;
    dbmPropDB.qryProperties.Open;

    // Check if a record was found
    if not dbmPropDB.qryProperties.IsEmpty then
    begin
      lblUsername.Caption := 'Username: ' + dbmPropDB.qryProperties.FieldByName
        ('Username').AsString;
      lblPassword.Caption := 'Password: ' + dbmPropDB.qryProperties.FieldByName
        ('Password').AsString;
      lblUsername.Visible := True;
      lblPassword.Visible := True;
    end
    else
    begin
      showmessage(
        'No matching user found. Please check your details and try again.');
    end;
  finally
    dbmPropDB.qryProperties.Free;
  end;
end;

end.
