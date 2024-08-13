unit Main;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, Grids, DBGrids, StdCtrls, ComCtrls, conPropDB, Login, jpeg,
  ExtCtrls, Menus, Math, FileCtrl;

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
    btnNextPage: TButton;
    btnPreviousPage: TButton;
    btnSearch: TButton;
    btnSort: TButton;
    rgpSelection: TRadioGroup;
    btnDisplay: TButton;
    Exit1: TMenuItem;
    Admin1: TMenuItem;
    ManageUsers1: TMenuItem;
    AddProperties1: TMenuItem;
    ManageAgents1: TMenuItem;
    procedure btnSearchClick(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure Button2Click(Sender: TObject);
    procedure btnSortClick(Sender: TObject);
    procedure btnExitClick(Sender: TObject);
    procedure LoadPropertyDetails;
    procedure Exit1Click(Sender: TObject);
    procedure AddProperties1Click(Sender: TObject);
    procedure btnNextPageClick(Sender: TObject);

    procedure LoadPropertiesForPage(Page: Integer);
    procedure btnPreviousPageClick(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  frmMainDB: TfrmMainDB;
  iTotalPages: Integer;
  iCurrentPage: Integer = 1;

implementation

uses
  NewProd;
{$R *.dfm}

procedure TfrmMainDB.AddProperties1Click(Sender: TObject);
begin
  frmMainDB.Close;
  frmNew.Show;
end;

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
  iStock: Integer;
begin
  iStock := 0;
  // Search for an Item
  sTarget := InputBox('Propedex Database', 'Enter an item to search for', '');
  bFound := FALSE;
  dbmPropDB.tblProperties.First;
  while (not dbmPropDB.tblProperties.Eof) AND (NOT bFound) do
  begin
    if sTarget = dbmPropDB.tblProperties['Address'] or dbmPropDB.tblProperties
      ['Area'] or dbmPropDB.tblProperties['PropertyID']
      or dbmPropDB.tblProperties['AgentID'] then
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

procedure TfrmMainDB.btnNextPageClick(Sender: TObject);
begin

  if iCurrentPage < iTotalPages then
  begin
    Inc(iCurrentPage);
    LoadPropertiesForPage(iCurrentPage);
  end;
end;

procedure TfrmMainDB.btnPreviousPageClick(Sender: TObject);
begin
  if iCurrentPage > 1 then
  begin
    Dec(iCurrentPage);
    LoadPropertiesForPage(iCurrentPage);
  end;
end;

procedure TfrmMainDB.Exit1Click(Sender: TObject);
begin
  exit;
end;

procedure TfrmMainDB.FormCreate(Sender: TObject);
begin
  iTotalPages := Ceil(dbmPropDB.qryProperties.RecordCount / 6);
  LoadPropertiesForPage(1);
end;

procedure TfrmMainDB.FormShow(Sender: TObject);
var
  sSuppID: string;
begin
  // If User is admin, activate Add and Delete button
  if bAdmin = true then
  begin
    // .Enabled := true;
  end;

  LoadPropertyDetails;
  Timer1.Enabled := FALSE;
  // While not end of database, look for all items that are low in stock and Display their Names.
end;

procedure TfrmMainDB.LoadPropertiesForPage(Page: Integer);
var
  StartRecord: Integer;
  i: Integer;
begin
  StartRecord := (Page - 1) * 6;
  dbmPropDB.qryProperties.First;
  dbmPropDB.qryProperties.MoveBy(StartRecord);

  for i := 1 to 6 do
  begin
    if not dbmPropDB.qryProperties.Eof then
    begin
      // Load the image and labels for the current property
      // Example:
      img[i].Picture.LoadFromFile(
        'D:\usb backup\OSWALD_AUMULLER_PAT2024\Properties\' +
          dbmPropDB.qryProperties.FieldByName('PropertyID').AsString + '.jpg');
      lblimg[i]Address.Caption := dbmPropDB.qryProperties.FieldByName('Address')
        .AsString;
      lblimg[i]Price.Caption := dbmPropDB.qryProperties.FieldByName('Price')
        .AsString;
      lblimg[i]Area.Caption := dbmPropDB.qryProperties.FieldByName('Area')
        .AsString;
      dbmPropDB.qryProperties.Next;
    end
    else
    begin
      img[i].Picture := nil; // Clear the image if there's no property
      lblimg[i]Address.Caption := '';
      lblimg[i]Price.Caption := '';
      lblimg[i]Area.Caption := '';
    end;
  end;

  // Enable/disable navigation buttons
  btnPreviousPage.Enabled := Page > 1;
  btnNextPage.Enabled := Page < iTotalPages;
end;

procedure TfrmMainDB.LoadPropertyDetails;
var
  ImagePath: string;
begin
  // Assuming ADOQuery1 is set up to retrieve data from tblProperties
  dbmPropDB.qryProperties.SQL.Text :=
    'SELECT PropertyID, Address, Price, Area FROM tblProperties';
  dbmPropDB.qryProperties.Open;

  // Loop through each property and assign images and labels
  dbmPropDB.qryProperties.First; // Start at the first record
  while not dbmPropDB.qryProperties.Eof do
  begin
    // Determine which image and labels to update
    case dbmPropDB.qryProperties.RecNo of
      1:
        begin
          ImagePath :=
            'D:\usb backup\OSWALD_AUMULLER_PAT2024\Properties\' +
            dbmPropDB.qryProperties.FieldByName('PropertyID')
            .AsString + '.jpg';
          if FileExists(ImagePath) then
            img1.Picture.LoadFromFile(ImagePath);
          lblImg1Address.Caption := dbmPropDB.qryProperties.FieldByName
            ('Address').AsString;
          lblImg1Price.Caption := FormatFloat('R#,##0.00',
            dbmPropDB.qryProperties.FieldByName('Price').AsFloat);
          lblImg1Area.Caption := dbmPropDB.qryProperties.FieldByName('Area')
            .AsString;
        end;
      2:
        begin
          ImagePath :=
            'D:\usb backup\OSWALD_AUMULLER_PAT2024\Properties\' +
            dbmPropDB.qryProperties.FieldByName('PropertyID')
            .AsString + '.jpg';
          if FileExists(ImagePath) then
            img2.Picture.LoadFromFile(ImagePath);
          lblImg2Address.Caption := dbmPropDB.qryProperties.FieldByName
            ('Address').AsString;
          lblImg2Price.Caption := FormatFloat('R#,##0.00',
            dbmPropDB.qryProperties.FieldByName('Price').AsFloat);
          lblImg2Area.Caption := dbmPropDB.qryProperties.FieldByName('Area')
            .AsString;

        end;
      3:
        begin
          ImagePath :=
            'D:\usb backup\OSWALD_AUMULLER_PAT2024\Properties\' +
            dbmPropDB.qryProperties.FieldByName('PropertyID')
            .AsString + '.jpg';
          if FileExists(ImagePath) then
            img3.Picture.LoadFromFile(ImagePath);
          lblImg3Address.Caption := dbmPropDB.qryProperties.FieldByName
            ('Address').AsString;
          lblImg3Price.Caption := FormatFloat('R#,##0.00',
            dbmPropDB.qryProperties.FieldByName('Price').AsFloat);
          lblImg3Area.Caption := dbmPropDB.qryProperties.FieldByName('Area')
            .AsString;
        end;
      4:
        begin
          ImagePath :=
            'D:\usb backup\OSWALD_AUMULLER_PAT2024\Properties\' +
            dbmPropDB.qryProperties.FieldByName('PropertyID')
            .AsString + '.jpg';
          if FileExists(ImagePath) then
            img4.Picture.LoadFromFile(ImagePath);
          lblImg4Address.Caption := dbmPropDB.qryProperties.FieldByName
            ('Address').AsString;
          lblImg4Price.Caption := FormatFloat('R#,##0.00',
            dbmPropDB.qryProperties.FieldByName('Price').AsFloat);
          lblImg4Area.Caption := dbmPropDB.qryProperties.FieldByName('Area')
            .AsString;
        end;
      5:
        begin
          ImagePath :=
            'D:\usb backup\OSWALD_AUMULLER_PAT2024\Properties\' +
            dbmPropDB.qryProperties.FieldByName('PropertyID')
            .AsString + '.jpg';
          if FileExists(ImagePath) then
            img5.Picture.LoadFromFile(ImagePath);
          lblImg5Address.Caption := dbmPropDB.qryProperties.FieldByName
            ('Address').AsString;
          lblImg5Price.Caption := FormatFloat('R#,##0.00',
            dbmPropDB.qryProperties.FieldByName('Price').AsFloat);
          lblImg5Area.Caption := dbmPropDB.qryProperties.FieldByName('Area')
            .AsString;
        end;
      6:
        begin
          ImagePath :=
            'D:\usb backup\OSWALD_AUMULLER_PAT2024\Properties\' +
            dbmPropDB.qryProperties.FieldByName('PropertyID')
            .AsString + '.jpg';
          if FileExists(ImagePath) then
            img6.Picture.LoadFromFile(ImagePath);
          lblImg6Address.Caption := dbmPropDB.qryProperties.FieldByName
            ('Address').AsString;
          lblImg6Price.Caption := FormatFloat('R#,##0.00',
            dbmPropDB.qryProperties.FieldByName('Price').AsFloat);
          lblImg6Area.Caption := dbmPropDB.qryProperties.FieldByName('Area')
            .AsString;
        end;

      // Repeat for img3, img4, img5, img6...
    end;

    dbmPropDB.qryProperties.Next; // Move to the next record
  end;
end;

end.
