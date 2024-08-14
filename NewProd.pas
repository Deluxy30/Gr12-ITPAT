unit NewProd;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, ComCtrls, ExtCtrls, conPropDB, DateUtils, Spin;

type
  TfrmNew = class(TForm)
    Confirm: TButton;
    cmbAgent: TComboBox;
    edtPrice: TEdit;
    edtAddress: TEdit;
    edtSize: TEdit;
    Back: TButton;
    Label5: TLabel;
    Label4: TLabel;
    Label3: TLabel;
    Label2: TLabel;
    rgpSelection: TRadioGroup;
    Label1: TLabel;
    Label6: TLabel;
    Label7: TLabel;
    Label8: TLabel;
    sedBathroom: TSpinEdit;
    sedBedroom: TSpinEdit;
    chkPool: TCheckBox;
    chkPet: TCheckBox;
    OpenDialog1: TOpenDialog;
    procedure ConfirmClick(Sender: TObject);
    procedure BackClick(Sender: TObject);
    procedure FillComboBox;
      procedure SaveProperty;
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  frmNew: TfrmNew;

implementation

// Used to bypass Circular Unit Reference Error
uses Main, Admin;
{$R *.dfm}

procedure TfrmNew.BackClick(Sender: TObject);
begin
  // Go Back to Main Screen
  frmNew.Hide;
  AdminManagement.Show;
end;

procedure TfrmNew.ConfirmClick(Sender: TObject);
begin
SaveProperty;
    frmMainDB.Show;
    frmNew.Hide;
end;

procedure TfrmNew.FillComboBox;
var
  SQLQuery: string;
begin
  // SQL Query to fetch agent names
  SQLQuery := 'SELECT AgentName FROM tblAgents ORDER BY AgentName';

  // Open the query
  dbmPropDB.qryProperties.Close;
  dbmPropDB.qryProperties.SQL.Clear;
  dbmPropDB.qryProperties.SQL.Add(SQLQuery);
  dbmPropDB.qryProperties.Open;

  // Clear existing items in the combo box
  cmbAgent.Items.Clear;

  // Loop through the records and add them to the combo box
  while not dbmPropDB.qryProperties.Eof do
  begin
    cmbAgent.Items.Add(dbmPropDB.qryProperties.FieldByName('AgentName')
        .AsString);
    dbmPropDB.qryProperties.Next;
  end;

  // Optionally, set the first item as selected
  if cmbAgent.Items.Count > 0 then
    cmbAgent.ItemIndex := 0;

  // Close the query
  dbmPropDB.qryProperties.Close;

end;


procedure TfrmNew.SaveProperty;
var
  PropertyID, ImageFileName, AgentID: string;
  RecordCount: Integer;
  AreaAbbreviation: string;
begin
  // Determine the area abbreviation based on the selected area
  if edtAddress.Text = 'Amanzimtoti' then
    AreaAbbreviation := 'AMZ'
  else if edtAddress.Text = 'Ballito' then
    AreaAbbreviation := 'BAL'
  else if edtAddress.Text = 'Durban North' then
    AreaAbbreviation := 'DBN'
  else if edtAddress.Text = 'Glenashley' then
    AreaAbbreviation := 'GLN'
  else if edtAddress.Text = 'Phoenix' then
    AreaAbbreviation := 'PHX'
  else if edtAddress.Text = 'Pietermaritzburg' then
    AreaAbbreviation := 'PMB'
  else if edtAddress.Text = 'Salt-Rock' then
    AreaAbbreviation := 'SRK'
  else if edtAddress.Text = 'Umdloti' then
    AreaAbbreviation := 'UMD'
  else if edtAddress.Text = 'Umhlanga' then
    AreaAbbreviation := 'UMH'
  else
    AreaAbbreviation := 'OTH'; // Default for other areas

  // Get the current record count from tblProperties
  dbmPropDB.qryProperties.SQL.Text := 'SELECT COUNT(*) AS RecordCount FROM tblProperties';
  dbmPropDB.qryProperties.Open;
  RecordCount := dbmPropDB.qryProperties.FieldByName('RecordCount').AsInteger + 1;
  dbmPropDB.qryProperties.Close;

  // Construct the Property ID
  PropertyID := 'PRP-' + AreaAbbreviation + '-' + IntToStr(RecordCount);

  // Lookup the AgentID based on the selected agent's name in cboAgent
  dbmPropDB.qryProperties.SQL.Text := 'SELECT AgentID FROM tblAgents WHERE AgentName = :AgentName';
  dbmPropDB.qryProperties.Parameters.ParamByName('AgentName').Value := cmbAgent.Text;
  dbmPropDB.qryProperties.Open;
  AgentID := dbmPropDB.qryProperties.FieldByName('AgentID').AsString;
  dbmPropDB.qryProperties.Close;

  // Save the property details to the database
  dbmPropDB.qryProperties.SQL.Text :=
    'INSERT INTO tblProperties (PropertyID, Address, Area, Price, AgentID) ' +
    'VALUES (:PropertyID, :Address, :Area, :Price, :AgentID)';

  dbmPropDB.qryProperties.Parameters.ParamByName('PropertyID').Value := PropertyID;
  dbmPropDB.qryProperties.Parameters.ParamByName('Address').Value := edtAddress.Text;
  dbmPropDB.qryProperties.Parameters.ParamByName('Area').Value := edtSize.Text;
  dbmPropDB.qryProperties.Parameters.ParamByName('Price').Value := edtPrice.Text;
  dbmPropDB.qryProperties.Parameters.ParamByName('AgentID').Value := AgentID;

  dbmPropDB.qryProperties.ExecSQL;

  // Save the image with the Property ID
 if OpenDialog1.Execute then
  begin
  OpenDialog1.Filter := 'Image Files|*.jpg;*.jpeg;*.png;*.bmp';
  // Code to handle the file selection
    ImageFileName := 'D:\usb backup\OSWALD_AUMULLER_PAT2024\Properties\' + PropertyID + ExtractFileExt(OpenDialog1.FileName);
    if FileExists(OpenDialog1.FileName) then
      CopyFile(PChar(OpenDialog1.FileName), PChar(ImageFileName), False);
  end;
  ShowMessage('Property saved successfully with ID: ' + PropertyID);
end;

end.
