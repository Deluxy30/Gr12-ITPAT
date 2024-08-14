unit SubmitApp;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, ExtCtrls, StdCtrls, ComCtrls;

type
  TSubmitApplication = class(TForm)
    Label5: TLabel;
    lbl: TLabel;
    Label7: TLabel;
    Label10: TLabel;
    ProgressBar1: TProgressBar;
    Button4: TButton;
    OpenDialog1: TOpenDialog;
    Timer1: TTimer;
    Label1: TLabel;
    procedure Timer1Timer(Sender: TObject);
    procedure Button4Click(Sender: TObject);
    procedure FormShow(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  SubmitApplication: TSubmitApplication;
  ProofOfResidenceFileName, IDFileName: string;
  FilesSelected: Boolean;
  lblInReview: TLabel;

implementation

{$R *.dfm}

procedure TSubmitApplication.Button4Click(Sender: TObject);
begin
  FilesSelected := False; // Initialize the flag to false

  OpenDialog1.Filter := 'PDF files (*.pdf)|*.pdf';
  OpenDialog1.Title := 'Submit your Proof of Residence';

  // Show the Open Dialog for Proof of Residence
  if OpenDialog1.Execute then
  begin
    ProofOfResidenceFileName := OpenDialog1.FileName;
    showMessage('Proof of Residence selected: ' + ProofOfResidenceFileName);

    // Show the Open Dialog for ID
    OpenDialog1.Title := 'Submit your ID'; // Change title for ID selection
    if OpenDialog1.Execute then
    begin
      IDFileName := OpenDialog1.FileName;
      showMessage('ID selected: ' + IDFileName);

      // Both files have been selected, start the progress simulation
      FilesSelected := True;
    end;
  end;

  if FilesSelected then
  begin
  Button4.Enabled := false;
    ProgressBar1.Position := 0;
    lbl.Caption := 'Connecting to server';
    Timer1.Enabled := True;
    Timer1.Tag := 0; // Used to keep track of the simulation stage
  end
  else
  begin
    showMessage('Please select both Proof of Residence and ID files.');
  end;

end;

procedure TSubmitApplication.FormShow(Sender: TObject);
begin
  Timer1.Enabled := False; ;
end;

procedure TSubmitApplication.Timer1Timer(Sender: TObject);
begin
  // Update ProgressBar and Label text based on Timer Tag
  case Timer1.Tag of
    0:
      begin
        Sleep(5000);
        ProgressBar1.Position := 25;
        lbl.Caption := 'Encrypting Traffic';
        Timer1.Tag := 1;
      end;
    1:
      begin
        Sleep(5000);
        ProgressBar1.Position := 50;
        lbl.Caption := 'Uploading Documents';
        Timer1.Tag := 2;
      end;
    2:
      begin
        Sleep(10000);
        ProgressBar1.Position := 75;
        lbl.Caption := 'Finalizing Submission';
        Timer1.Tag := 3;
      end;
    3:
      begin
        Sleep(1500);
        ProgressBar1.Position := 100;
        lbl.Caption := 'Submitted Successfully';
        Timer1.Enabled := False; // Stop the timer
        Label5.Visible := False;
        Label7.Visible := False;
        lbl.Visible := False;
        Label10.Visible := False;
        Label1.Visible := False;
        Button4.Visible := False;
        ProgressBar1.Visible := False;
        lblInReview := TLabel.Create(SubmitApplication);
        lblInReview.Parent := SubmitApplication;
        lblInReview.Font.Size := 24;
        lblInReview.Caption := 'Review In Progress';
        lblInReview.Left := 37;
        lblInReview.Top := 76;
        lblInReview.Color := clBlack;
        lblInReview.Transparent := False;
        Sleep(15000);
        lblInReview.Caption := 'Application Approved!';
        lblInReview.Color := clLime;
        Sleep(500);
        showMessage('Moving to payment screen...');
      end;
  end;
end;

end.
