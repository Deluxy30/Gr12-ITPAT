unit Main;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, Grids, DBGrids, StdCtrls, ComCtrls, conPropDB, Login, jpeg,
  ExtCtrls, Menus, Math, FileCtrl, PropertyDetails, Generics.Collections;

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
    function IsNumeric(const Value: string): Boolean;
    procedure btnDisplayClick(Sender: TObject);
    procedure imgPropertyClick(Sender: TObject);
    procedure FormHide(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
    procedure img1Click(Sender: TObject);
    procedure img2Click(Sender: TObject);
    procedure img3Click(Sender: TObject);
    procedure img4Click(Sender: TObject);
    procedure img5Click(Sender: TObject);
    procedure img6Click(Sender: TObject);

  private
    { Private declarations }
    imgArray: array [1 .. 6] of TImage;
    lblAddressArray: array [1 .. 6] of TLabel;
    lblPriceArray: array [1 .. 6] of TLabel;
    lblAreaArray: array [1 .. 6] of TLabel;

  public
    { Public declarations }

  end;

var
  frmMainDB: TfrmMainDB;
  iTotalPages: Integer;
  iCurrentPage: Integer = 1;
  PropertyIDMap: TDictionary<Integer, String>;

implementation

uses
  NewProd, Admin;
{$R *.dfm}

procedure TfrmMainDB.AddProperties1Click(Sender: TObject);
begin
  frmMainDB.Hide;
  AdminManagement.Show;
end;

procedure TfrmMainDB.btnDisplayClick(Sender: TObject);
var
  sSelectedArea: string;
begin
  sSelectedArea := rgpSelection.Items[rgpSelection.ItemIndex];

  dbmPropDB.qryProperties.Close;

  if sSelectedArea = 'All' then
  begin
    // Display all properties
    dbmPropDB.qryProperties.SQL.Text := 'SELECT * FROM tblProperties';
  end
  else
  begin
    // Display properties for the selected area
    dbmPropDB.qryProperties.SQL.Text :=
      'SELECT * FROM tblProperties WHERE Area = :SelectedArea';
    dbmPropDB.qryProperties.Parameters.ParamByName('SelectedArea').Value :=
      sSelectedArea;
  end;

  dbmPropDB.qryProperties.Open;

  if dbmPropDB.qryProperties.IsEmpty then
    ShowMessage('No properties found in ' + sSelectedArea)
  else
    LoadPropertiesForPage(1); // Load the results starting from the first page
end;

procedure TfrmMainDB.btnExitClick(Sender: TObject);
begin
  if MessageDlg('Are you sure', mtConfirmation, mbYesNo, 0) = mrYes then
  begin
    frmMainDB.Close;
  end
  else
  begin
    ShowMessage('Log Out Cancelled');
  end;

end;

procedure TfrmMainDB.btnSearchClick(Sender: TObject);
var
  sSearchTerm: string;
  sProp, sAgent: string;
  bFound: Boolean;
begin
  sSearchTerm := InputBox('Search Property', 'Enter Property ID or Address:',
    '');
  bFound := False;
  sProp := Copy(sSearchTerm, 1, 3);
  sAgent := Copy(sSearchTerm, 1, 2);
  if sSearchTerm <> '' then
  begin
    if sProp = 'PRP' then
    begin
      // Search by PropertyID
      dbmPropDB.qryProperties.Close;
      dbmPropDB.qryProperties.SQL.Text :=
        'SELECT * FROM tblProperties WHERE PropertyID = :SearchTerm';
      dbmPropDB.qryProperties.Parameters.ParamByName('SearchTerm').Value :=
        sSearchTerm;
    end
    else if sAgent = 'AT' then
    begin
      // Search by AgentID
      dbmPropDB.qryProperties.Close;
      dbmPropDB.qryProperties.SQL.Text :=
        'SELECT * FROM tblProperties WHERE AgentID = :SearchTerm';
      dbmPropDB.qryProperties.Parameters.ParamByName('SearchTerm').Value :=
        sSearchTerm;
    end
    else
    begin
      // Search by Address or Area
      dbmPropDB.qryProperties.Close;
      dbmPropDB.qryProperties.SQL.Text :=
        'SELECT * FROM tblProperties WHERE Address LIKE :SearchTerm OR Area LIKE :SearchTerm';
      dbmPropDB.qryProperties.Parameters.ParamByName('SearchTerm')
        .Value := '%' + sSearchTerm + '%';
    end;

    dbmPropDB.qryProperties.Open;

    if not dbmPropDB.qryProperties.IsEmpty then
    begin
      bFound := True;
      LoadPropertiesForPage(1); // Load the results starting from the first page
    end;

    if not bFound then
      ShowMessage('No property found containing "' + sSearchTerm + '".');
  end
  else
  begin
    ShowMessage('Please enter a valid search term.');
  end;

end;

procedure TfrmMainDB.btnSortClick(Sender: TObject);
begin
  // Modify the SQL query to order by the Price field
  dbmPropDB.qryProperties.SQL.Text :=
    'SELECT * FROM tblProperties ORDER BY Price ASC';

  // Reopen the query to apply the new SQL command
  dbmPropDB.qryProperties.Open;

  // Reload the properties for the current page
  LoadPropertiesForPage(1);

  // Reset the page tracking
  iCurrentPage := 1;
  iTotalPages := Ceil(dbmPropDB.qryProperties.RecordCount / 6);
end;

procedure TfrmMainDB.Button2Click(Sender: TObject);
begin
  // Shows the Add Item window and closes the main window
  frmMainDB.Hide;
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
  Exit;
end;

procedure TfrmMainDB.FormCreate(Sender: TObject);
var
  i: Integer;
begin
  iTotalPages := Ceil(dbmPropDB.qryProperties.RecordCount / 6);
  LoadPropertyDetails;

  imgArray[1] := img1;
  imgArray[2] := img2;
  imgArray[3] := img3;
  imgArray[4] := img4;
  imgArray[5] := img5;
  imgArray[6] := img6;

  lblAddressArray[1] := lblImg1Address;
  lblAddressArray[2] := lblImg2Address;
  lblAddressArray[3] := lblImg3Address;
  lblAddressArray[4] := lblImg4Address;
  lblAddressArray[5] := lblImg5Address;
  lblAddressArray[6] := lblImg6Address;

  lblPriceArray[1] := lblImg1Price;
  lblPriceArray[2] := lblImg2Price;
  lblPriceArray[3] := lblImg3Price;
  lblPriceArray[4] := lblImg4Price;
  lblPriceArray[5] := lblImg5Price;
  lblPriceArray[6] := lblImg6Price;

  lblAreaArray[1] := lblImg1Area;
  lblAreaArray[2] := lblImg2Area;
  lblAreaArray[3] := lblImg3Area;
  lblAreaArray[4] := lblImg4Area;
  lblAreaArray[5] := lblImg5Area;
  lblAreaArray[6] := lblImg6Area;
end;

procedure TfrmMainDB.FormDestroy(Sender: TObject);
begin
  PropertyIDMap.Free;
end;

procedure TfrmMainDB.FormHide(Sender: TObject);
begin
  PropertyIDMap.Free;
end;

procedure TfrmMainDB.FormShow(Sender: TObject);
var
  sSuppID: string;
begin
  // If User is admin, activate Add and Delete button
  if bAdmin = True then
  begin
    MainMenu1.Items.Find('Admin').Enabled := True;
  end
  else
  begin
    MainMenu1.Items.Find('Admin').Enabled := False;
  end;
  LoadPropertyDetails;
  Timer1.Enabled := False;
  PropertyIDMap := TDictionary<Integer, String>.Create;

end;

procedure TfrmMainDB.img1Click(Sender: TObject);
begin
  img1.OnClick := imgPropertyClick;
end;

procedure TfrmMainDB.img2Click(Sender: TObject);
begin
  img2.OnClick := imgPropertyClick;
end;

procedure TfrmMainDB.img3Click(Sender: TObject);
begin
  img3.OnClick := imgPropertyClick;
end;

procedure TfrmMainDB.img4Click(Sender: TObject);
begin
  img4.OnClick := imgPropertyClick;
end;

procedure TfrmMainDB.img5Click(Sender: TObject);
begin
  img5.OnClick := imgPropertyClick;
end;

procedure TfrmMainDB.img6Click(Sender: TObject);
begin
  img6.OnClick := imgPropertyClick;
end;

procedure TfrmMainDB.imgPropertyClick(Sender: TObject);
var
  PropertyID, AgentID, AgentImagePath, AgencyName: string;
  img: TImage;
begin
  if Sender is TImage then
  begin
    img := TImage(Sender);
    if Assigned(img.Picture.Graphic) then
    begin
      // Assuming Tag stores the index of the property
      PropertyID := dbmPropDB.qryProperties.FieldByName('PropertyID').AsString;

      // Use qryProperties to get basic property information
      dbmPropDB.qryProperties.Close;
      dbmPropDB.qryProperties.SQL.Text :=
        'SELECT Address, Price, Size, AgentID FROM tblProperties WHERE PropertyID = :PropertyID';
      dbmPropDB.qryProperties.Parameters.ParamByName('PropertyID').Value :=
        PropertyID;
      dbmPropDB.qryProperties.Open;

      // Use qryPropertyDetails to get additional details
      dbmPropDB.qryPropertyDetails.Close;
      dbmPropDB.qryPropertyDetails.SQL.Text :=
        'SELECT Bedrooms, Bathrooms, Pool, PetFriendly FROM tblPropDetails WHERE PropertyID = :PropertyID';
      dbmPropDB.qryPropertyDetails.Parameters.ParamByName('PropertyID')
        .Value := PropertyID;
      dbmPropDB.qryPropertyDetails.Open;

      // Load the property details into the RichEdit
      with frmPropDetails.redPropDetails do
      begin
        // Address
        SelAttributes.Style := [fsBold];
        Lines.Add('Address:');
        SelAttributes.Style := [];
        Lines.Add(dbmPropDB.qryProperties.FieldByName('Address').AsString);
        Lines.Add('');

        // Price
        SelAttributes.Style := [fsBold];
        Lines.Add('Price:');
        SelAttributes.Style := [];
        Lines.Add(FormatCurr('0.00',
            dbmPropDB.qryProperties.FieldByName('Price').AsCurrency));
        Lines.Add('');

        // Size
        SelAttributes.Style := [fsBold];
        Lines.Add('Size:');
        SelAttributes.Style := [];
        Lines.Add(dbmPropDB.qryProperties.FieldByName('Size').AsString);
        Lines.Add('');

        // Bedrooms
        SelAttributes.Style := [fsBold];
        Lines.Add('Bedrooms:');
        SelAttributes.Style := [];
        Lines.Add(IntToStr(dbmPropDB.qryPropertyDetails.FieldByName('Bedrooms')
              .AsInteger));
        Lines.Add('');

        // Bathrooms
        SelAttributes.Style := [fsBold];
        Lines.Add('Bathrooms:');
        SelAttributes.Style := [];
        Lines.Add(IntToStr(dbmPropDB.qryPropertyDetails.FieldByName('Bathrooms')
              .AsInteger));
        Lines.Add('');

        // Pool
        SelAttributes.Style := [fsBold];
        Lines.Add('Pool:');
        SelAttributes.Style := [];
        if dbmPropDB.qryPropertyDetails.FieldByName('Pool').AsBoolean then
          Lines.Add('Yes')
        else
          Lines.Add('No');
        Lines.Add('');

        // Pet Friendly
        SelAttributes.Style := [fsBold];
        Lines.Add('Pet Friendly:');
        SelAttributes.Style := [];
        if dbmPropDB.qryPropertyDetails.FieldByName('PetFriendly')
          .AsBoolean then
          Lines.Add('Yes')
        else
          Lines.Add('No');
      end;

      // Load Agent's Image and Name
      AgentID := dbmPropDB.qryProperties.FieldByName('AgentID').AsString;
      dbmPropDB.qryProperties.Close;
      dbmPropDB.qryProperties.SQL.Text :=
        'SELECT AgencyName FROM tblAgents WHERE AgentID = :AgentID';
      dbmPropDB.qryProperties.Parameters.ParamByName('AgentID')
        .Value := AgentID;
      dbmPropDB.qryProperties.Open;
      AgencyName := dbmPropDB.qryProperties.FieldByName('AgencyName').AsString;

      AgentImagePath :=
        'D:\usb backup\OSWALD_AUMULLER_PAT2024\Agency\' + AgencyName + '\' +
        AgentID + '.jpg';
      if FileExists(AgentImagePath) then
        frmPropDetails.imgAgency.Picture.LoadFromFile(AgentImagePath)
      else
        frmPropDetails.imgAgency.Picture := nil; // Clear the image if not found

      // Display AgentID and Name
      frmPropDetails.lblAgentName.Caption := 'Agent ID: ' + AgentID + ' - ' +
        AgencyName;

      // Show the Property Details form
      frmPropDetails.Show;
    end;
  end;
end;

function TfrmMainDB.IsNumeric(const Value: string): Boolean;
var
  TestValue: Double;
begin
  Result := TryStrToFloat(Value, TestValue);
end;

procedure TfrmMainDB.LoadPropertiesForPage(Page: Integer);
var
  i, StartIndex: Integer;
  Price: Currency;
  PropertyID: string;
begin
  StartIndex := (iCurrentPage - 1) * 6;
  dbmPropDB.qryProperties.First;
  dbmPropDB.qryProperties.MoveBy(StartIndex);

  for i := 1 to 6 do
  begin
    if not dbmPropDB.qryProperties.Eof then
    begin
      PropertyID := dbmPropDB.qryProperties.FieldByName('PropertyID').AsString;
      // Load the image and labels for the current property
      imgArray[i].Picture.LoadFromFile(
        'D:\usb backup\OSWALD_AUMULLER_PAT2024\Properties\' +
          dbmPropDB.qryProperties.FieldByName('PropertyID').AsString + '.jpg');

      lblAddressArray[i].Caption := dbmPropDB.qryProperties.FieldByName
        ('Address').AsString;
      // Store the PropertyID in the global dictionary using i as the key
      PropertyIDMap.AddOrSetValue(i, PropertyID);
      imgArray[i].Tag := i;
      // Retrieve and format the price
      Price := dbmPropDB.qryProperties.FieldByName('Price').AsCurrency;
      lblPriceArray[i].Caption := FormatCurr('R ###,###,##0.00', Price);

      lblAreaArray[i].Caption := dbmPropDB.qryProperties.FieldByName('Area')
        .AsString;

      // Move to the next record
      dbmPropDB.qryProperties.Next;
    end
    else
    begin
      // Clear the image and labels if there's no property to display
      imgArray[i].Picture := nil;
      lblAddressArray[i].Caption := '';
      lblPriceArray[i].Caption := '';
      lblAreaArray[i].Caption := '';
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
    end;

    dbmPropDB.qryProperties.Next; // Move to the next record
  end;
end;

end.
