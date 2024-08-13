unit conPropDB;

interface

uses
  SysUtils, Classes, DB, ADODB;

type
  TdbmPropDB = class(TDataModule)
    conPropDB: TADOConnection;
    dscTransactions: TDataSource;
    tblPropDetails: TADOTable;
    tblTransactions: TADOTable;
    dscPropDetails: TDataSource;
    dscUsers: TDataSource;
    dscAgents: TDataSource;
    dscProperties: TDataSource;
    tblUsers: TADOTable;
    tblProperties: TADOTable;
    tblAgents: TADOTable;
    qryAgents: TADOQuery;
    qryProperties: TADOQuery;
    qryUsers: TADOQuery;
    qryPropDetails: TADOQuery;
    qryTransactions: TADOQuery;
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  dbmPropDB: TdbmPropDB;

implementation

{$R *.dfm}

end.
