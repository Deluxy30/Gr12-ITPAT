unit conPropImplementDB;

interface

uses
  SysUtils, Classes, DB, ADODB;

type
  TdbmPropImpl = class(TDataModule)
    conPropImplementDB: TADOConnection;
    tblAgents: TADOTable;
    tblProperties: TADOTable;
    tblUsers: TADOTable;
    dscProperties: TDataSource;
    dscAgents: TDataSource;
    dscUsers: TDataSource;
    dscUsertransaction: TDataSource;
    dscPropDetails: TDataSource;
    tblUserTransactionRelation: TADOTable;
    tblPropDetails: TADOTable;
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  dbmPropImpl: TdbmPropImpl;

implementation

{$R *.dfm}

end.
