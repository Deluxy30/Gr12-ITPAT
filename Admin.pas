unit Admin;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, conPropDB, Grids, DBGrids, Menus;

type
  TAdminManagement = class(TForm)
    btnDelete: TButton;
    dbgProperties: TDBGrid;
    btnAddProp: TButton;
    dbgUsers: TDBGrid;
    btnUser: TButton;
    dbgAgents: TDBGrid;
    btnAddAgent: TButton;
    MainMenu1: TMainMenu;
    GobacktoMain1: TMenuItem;
    procedure FormCreate(Sender: TObject);
    procedure btnAddPropClick(Sender: TObject);
    procedure btnDeleteClick(Sender: TObject);
    procedure GobacktoMain1Click(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  AdminManagement: TAdminManagement;

implementation

uses Main, NewProd;
{$R *.dfm}

procedure TAdminManagement.btnAddPropClick(Sender: TObject);
begin
  frmNew.show;
  AdminManagement.Hide;

end;

procedure TAdminManagement.btnDeleteClick(Sender: TObject);
var
  PropertyID: string;
begin
  // Check if a record is selected
  if not dbmPropDB.tblProperties.IsEmpty then
  begin
    PropertyID := dbmPropDB.tblProperties.FieldByName('PropertyID').AsString;

    // Confirm deletion
    if MessageDlg(
      'Are you sure you want to delete this property and its details?',
      mtConfirmation, [mbYes, mbNo], 0) = mrYes then
    begin
      // Start a transaction if you are using a database that supports transactions
      try
        // Delete related details first
        dbmPropDB.tblPropDetails.DisableControls; // Temporarily disable controls for performance
        dbmPropDB.tblPropDetails.First;
        while not dbmPropDB.tblPropDetails.Eof do
        begin
          if dbmPropDB.tblPropDetails.FieldByName('PropertyID')
            .AsString = PropertyID then
            dbmPropDB.tblPropDetails.Delete;
          dbmPropDB.tblPropDetails.Next;
        end;
        dbmPropDB.tblPropDetails.EnableControls; // Re-enable controls

        // Delete the property
        dbmPropDB.tblProperties.Delete;

        // Commit the transaction if using transactions
        // YourDatabaseConnection.Commit;

        ShowMessage('Property and its details have been deleted successfully.');

      except
        on E: Exception do
        begin
          // Rollback transaction if using transactions
          // YourDatabaseConnection.Rollback;

          ShowMessage('Error deleting property: ' + E.Message);
        end;
      end;
    end
    else
      ShowMessage('Deletion cancelled.');
  end
  else
    ShowMessage('No property selected.');
end;

procedure TAdminManagement.FormCreate(Sender: TObject);
var
  i: integer;
begin
  { dbgProperties.DataSource := dbmPropDB.dscProperties;
    dbgUsers.DataSource := dbmPropDB.dscUsers;
    dbgAgents.DataSource := dbmPropDB.dscAgents;
    // Adjust column widths to fit the content
    for i := 0 to dbgProperties.Columns.Count - 1 do
    begin
    dbgProperties.Columns[i].Width := dbgProperties.Canvas.TextWidth
    (dbgProperties.Columns[i].Field.DisplayLabel) + 30;
    end;
    for i := 0 to dbgUsers.Columns.Count - 1 do
    begin
    dbgUsers.Columns[i].Width := dbgUsers.Canvas.TextWidth
    (dbgUsers.Columns[i].Field.DisplayLabel) + 30;
    end;
    for i := 0 to dbgAgents.Columns.Count - 1 do
    begin
    dbgAgents.Columns[i].Width := dbgAgents.Canvas.TextWidth
    (dbgAgents.Columns[i].Field.DisplayLabel) + 30;
    end; }
end;

procedure TAdminManagement.GobacktoMain1Click(Sender: TObject);
begin
  AdminManagement.Hide;
  frmMainDB.show;

end;

end.
