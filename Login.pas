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
    procedure btnLoginClick(Sender: TObject);
    procedure lblCreatAccClick(Sender: TObject);
    procedure chkShowClick(Sender: TObject);
    procedure btnQuitClick(Sender: TObject);
    procedure Label3Click(Sender: TObject);
    procedure Image4Click(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  frmPAT2024: TfrmPAT2024;
  bAdmin: boolean;

implementation

uses Main, SignUp;
{$R *.dfm}

procedure TfrmPAT2024.btnLoginClick(Sender: TObject);
var
  sPassword, sUserName, sLine, sDate, sTime: string;
  bFlag: boolean;
  tLogin: textfile;
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
      showmessage('User or Password Incorrect' + #13 +
          'Otherwise create new account');
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

end.
