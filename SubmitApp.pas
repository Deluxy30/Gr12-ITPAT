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
    procedure Timer1Timer(Sender: TObject);
    procedure Button4Click(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  SubmitApplication: TSubmitApplication;

implementation

{$R *.dfm}

procedure TSubmitApplication.Button4Click(Sender: TObject);
var
  I: integer;
begin

  OpenDialog1.Filter := 'PDF files (*.pdf)|*.pdf';
  // Filter to only show PDF files
  OpenDialog1.Title := 'Submit your Proof of Residence'; // Set the dialog title

  // Show the Open Dialog for Proof of Residence
  if OpenDialog1.Execute then
  begin
    // Handle the selected Proof of Residence file
    showMessage('Proof of Residence selected: ' + OpenDialog1.FileName);

    // Show the Open Dialog for ID
    if OpenDialog1.Execute then
    begin
      // Handle the selected ID file
      showMessage('ID selected: ' + OpenDialog1.FileName);
    end;
    ProgressBar1.Position := 0;
    lbl.Caption := 'Connecting to server';
    Timer1.Enabled := true;
    Timer1.Tag := 0; // Used to keep track of the simulation stage
end;
end;

procedure TSubmitApplication.Timer1Timer(Sender: TObject);
begin
 // Update ProgressBar and Label text based on Timer Tag
  case Timer1.Tag of
    0:
      begin
        ProgressBar1.Position := 25;
        lbl.Caption := 'Encrypting Traffic';
        Timer1.Tag := 1;
      end;
    1:
      begin
        ProgressBar1.Position := 50;
        lbl.Caption := 'Uploading Documents';
        Timer1.Tag := 2;
      end;
    2:
      begin
        ProgressBar1.Position := 75;
        lbl.Caption := 'Finalizing Submission';
        Timer1.Tag := 3;
      end;
    3:
      begin
        ProgressBar1.Position := 100;
        lbl.Caption := 'Submitted Successfully';
        Timer1.Enabled := FALSE; // Stop the timer
      end;
  end;
end;

end.
