unit Main;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, Grids, DBGrids, StdCtrls, ComCtrls, conPropDB, Login, jpeg,
  ExtCtrls, Menus, FileCtrl;

type
  TfrmMainDB = class(TForm)
    btnExit: TButton;
    MainMenu1: TMainMenu;
    File1: TMenuItem;
    OpenDialog1: TOpenDialog;
    Timer1: TTimer;
    img1: TImage;
    img4: TImage;
    img2: TImage;
    img3: TImage;
    img5: TImage;
    img6: TImage;
    lblImg1Address: TLabel;
    lblImg1Area: TLabel;
    lblImg1Price: TLabel;
    lblImg2Address: TLabel;
    lblImg2Area: TLabel;
    lblImg2Price: TLabel;
    lblImg3Address: TLabel;
    lblImg3Area: TLabel;
    lblImg3Price: TLabel;
    lblImg5Address: TLabel;
    lblImg5Area: TLabel;
    lblImg5Price: TLabel;
    lblImg6Address: TLabel;
    lblImg6Area: TLabel;
    lblImg6Price: TLabel;
    lblImg4Address: TLabel;
    lblImg4Area: TLabel;
    lblImg4Price: TLabel;
    Button6: TButton;
    Button7: TButton;
    btnSearch: TButton;
    btnSort: TButton;
    rgpSelection: TRadioGroup;
    btnDisplay: TButton;
    btnAdminMgmt: TButton;
    procedure btnSearchClick(Sender: TObject);
    procedure FormShow(Sender: TObject);

    procedure Button2Click(Sender: TObject);
    procedure btnSortClick(Sender: TObject);
    procedure btnExitClick(Sender: TObject);
    procedure LoadPropertyDetails;
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  frmMainDB: TfrmMainDB;

implementation

uses
  NewProd;
{$R *.dfm}




procedure TfrmMainDB.btnExitClick(Sender: TObject);
begin
  if MessageDlg('Are you sure', mtConfirmation, mbYesNo, 0) = mrYes then
  begin
    frmMainDB.Close;
  end
  else
  begin
    showMessage('Log Out Cancelled');
  end;

end;



procedure TfrmMainDB.btnSearchClick(Sender: TObject);
var
  sTarget: String;
  bFound: Boolean;
  iStock: integer;
begin
  iStock := 0;
  // Search for an Item
  sTarget := InputBox('Propedex Database', 'Enter an item to search for', '');
  bFound := FALSE;
  dbmPropDB.tblProperties.First;
  while (not dbmPropDB.tblProperties.Eof) AND (NOT bFound) do
  begin
    if sTarget = dbmPropDB.tblProperties['Address'] or dbmPropDB.tblProperties['Area']or dbmPropDB.tblProperties['PropertyID'] or dbmPropDB.tblProperties['AgentID'] then
    begin
      iStock := dbmPropDB.tblProperties['Stock'];
      bFound := true;
    end;

    dbmPropDB.tblProperties.Next;
  end;
  // If Found it will show the stock for the item
  if bFound = true then
  begin
    showMessage('Stock: ' + IntToStr(iStock));
  end
  else
  begin
    // If it failed, a dialog box will appear
    showMessage('Product not found');
  end;

end;

procedure TfrmMainDB.btnSortClick(Sender: TObject);
begin
  // Sorts the items in ascending order
  dbmPropDB.tblProperties.Sort := 'Stock ASC';
end;


procedure TfrmMainDB.Button2Click(Sender: TObject);
begin
  // Shows the Add Item window and closes the main window
  frmMainDB.hide;
  NewProd.frmNew.Show;
end;


procedure TfrmMainDB.FormShow(Sender: TObject);
var
  sSuppID: string;
begin
  // If User is admin, activate Add and Delete button
  if bAdmin = true then
  begin
    btnAdminMgmt.Enabled := true;
  end;
  Timer1.Enabled := FALSE;
  // While not end of database, look for all items that are low in stock and Display their Names.
end;



procedure TfrmMainDB.LoadPropertyDetails;
var ImagePath: string;
begin
  // Assuming ADOQuery1 is set up to retrieve data from tblProperties
  qryproperties.SQL.Text := 'SELECT PropertyID, Address, Price, Area FROM tblProperties';
  ADOQuery1.Open;

  // Loop through each property and assign images and labels
  ADOQuery1.First; // Start at the first record
  while not ADOQuery1.Eof do
  begin
    // Determine which image and labels to update
    case ADOQuery1.RecNo of
      1: begin
           ImagePath := 'D:\usb backup\OSWALD_AUMULLER_PAT2024\Properties\' + ADOQuery1.FieldByName('PropertyID').AsString + '.jpg';
           if FileExists(ImagePath) then
             img1.Picture.LoadFromFile(ImagePath);
           lblImg1Address.Caption := ADOQuery1.FieldByName('Address').AsString;
           lblImg1Price.Caption := FormatFloat('R#,##0.00', ADOQuery1.FieldByName('Price').AsFloat);
           lblImg1Area.Caption := ADOQuery1.FieldByName('Area').AsString;
         end;
      2: begin
           ImagePath := 'D:\usb backup\OSWALD_AUMULLER_PAT2024\Properties\' + ADOQuery1.FieldByName('PropertyID').AsString + '.jpg';
           if FileExists(ImagePath) then
             img2.Picture.LoadFromFile(ImagePath);
           lblImg2Address.Caption := ADOQuery1.FieldByName('Address').AsString;
           lblImg2Price.Caption := FormatFloat('R#,##0.00', ADOQuery1.FieldByName('Price').AsFloat);
           lblImg2Area.Caption := ADOQuery1.FieldByName('Area').AsString;
         end;
      // Repeat for img3, img4, img5, img6...
    end;

    ADOQuery1.Next; // Move to the next record
  end;
end;

end.
