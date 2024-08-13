unit NewProd;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, ComCtrls, ExtCtrls, conPropDB, DateUtils, Spin;

type
  TfrmNew = class(TForm)
    Confirm: TButton;
    DateTimePicker1: TDateTimePicker;
    cmbSupplier: TComboBox;
    edtSuppPrice: TEdit;
    edtItem: TEdit;
    edtMarkUp: TEdit;
    Back: TButton;
    Label7: TLabel;
    Label5: TLabel;
    Label4: TLabel;
    Label3: TLabel;
    Label2: TLabel;
    Label1: TLabel;
    rgpSpecial: TRadioGroup;
    senStock: TSpinEdit;
    Label6: TLabel;
    procedure ConfirmClick(Sender: TObject);
    procedure BackClick(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  frmNew: TfrmNew;

implementation

// Used to bypass Circular Unit Reference Error
uses Main;
{$R *.dfm}

procedure TfrmNew.BackClick(Sender: TObject);
begin
  // Go Back to Main Screen
  frmNew.Hide;
  frmMainDB.Show;
end;

procedure TfrmNew.ConfirmClick(Sender: TObject);
var
  sItem, sSupplier, sTemp, sFSupp, sDate: string;
  rPrice, rMarkup, rTot: real;
  bOnSpecial: boolean;
  iCheck, iStock, I, iPos: integer;
  sProdID: string;
begin
  iCheck := 0;
  sItem := edtItem.Text;
  sSupplier := cmbSupplier.Text;
  sDate := DateToStr(DateTimePicker1.Date);
  rPrice := StrToFloat(edtSuppPrice.Text);
  rMarkup := StrToFloat(edtMarkUp.Text);
  rTot := rPrice + rMarkup;
  iStock := senStock.Value;
  // Presensce Validation
  if (rPrice = 0) OR (rMarkup = 0) then
  begin
    ShowMessage('Prices may not be empty');
  end
  else
  begin
    Inc(iCheck);
  end;
  // Check if Radiogroup items have been selected
  if rgpSpecial.ItemIndex = 0 then
  begin
    bOnSpecial := true;
    Inc(iCheck);
  end;
  if rgpSpecial.ItemIndex = 1 then
  begin
    bOnSpecial := false;
    Inc(iCheck);
  end;
  if rgpSpecial.ItemIndex = -1 then
  begin
    ShowMessage('On Special cannot be not selected');
  end;
  // Adds new item with new ProdID
  sProdID := IntToStr(dbmPropDB.tblProperties.RecordCount + 2);
  // If everything is checked, add item prodcedure will proceed and add to the table.
  if iCheck = 2 then
  begin

    dbmPropDB.tblProperties.Append;
    dbmPropDB.tblProperties.Edit;
    dbmPropDB.tblProperties['Descrip'] := sItem;
    dbmPropDB.tblProperties['ExpDate'] := DateOf(DateTimePicker1.Date);
    dbmPropDB.tblProperties['OnSpecial'] := bOnSpecial;
    dbmPropDB.tblProperties['SuppPrice'] := rPrice;
    dbmPropDB.tblProperties['Markup'] := rMarkup;
    dbmPropDB.tblProperties['SellPrice'] := rTot;
    dbmPropDB.tblProperties['Stock'] := iStock;

    dbmPropDB.tblProperties.First;
    // Checks for Supplier from combo box and stores in variable
    iPos := Pos(' ', sSupplier);
    sTemp := Copy(sSupplier, 1, iPos - 1);
    if sSupplier = dbmPropDB.tblProperties['SuppID'] then
    begin
      ShowMessage('Supplier Found! Proceeding...');
    end;
    dbmPropDB.tblProperties.Next;
    dbmPropDB.tblProperties['SuppID'] := sTemp;
    dbmPropDB.tblProperties['ProdID'] := sProdID;
    dbmPropDB.tblProperties.Post;
    ShowMessage('Item created! Going back to Main screen');
    frmMainDB.Show;
    frmNew.Hide;
  end;
end;

end.
