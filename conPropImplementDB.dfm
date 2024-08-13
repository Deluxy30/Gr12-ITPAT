object dbmPropImpl: TdbmPropImpl
  OldCreateOrder = False
  Height = 416
  Width = 603
  object conPropImplementDB: TADOConnection
    Connected = True
    ConnectionString = 
      'Provider=Microsoft.Jet.OLEDB.4.0;User ID=Admin;Data Source=D:\us' +
      'b backup\OSWALD_AUMULLER_PAT2024\PropManager New DB(Implement).m' +
      'db;Mode=Share Deny None;Persist Security Info=False;Jet OLEDB:Sy' +
      'stem database="";Jet OLEDB:Registry Path="";Jet OLEDB:Database P' +
      'assword="";Jet OLEDB:Engine Type=5;Jet OLEDB:Database Locking Mo' +
      'de=1;Jet OLEDB:Global Partial Bulk Ops=2;Jet OLEDB:Global Bulk T' +
      'ransactions=1;Jet OLEDB:New Database Password="";Jet OLEDB:Creat' +
      'e System Database=False;Jet OLEDB:Encrypt Database=False;Jet OLE' +
      'DB:Don'#39't Copy Locale on Compact=False;Jet OLEDB:Compact Without ' +
      'Replica Repair=False;Jet OLEDB:SFP=False'
    LoginPrompt = False
    Mode = cmShareDenyNone
    Provider = 'Microsoft.Jet.OLEDB.4.0'
    Left = 280
    Top = 24
  end
  object tblAgents: TADOTable
    Active = True
    Connection = conPropImplementDB
    CursorType = ctStatic
    TableName = 'tblAgents'
    Left = 96
    Top = 104
  end
  object tblProperties: TADOTable
    Active = True
    Connection = conPropImplementDB
    CursorType = ctStatic
    TableName = 'tblProperties'
    Left = 200
    Top = 104
  end
  object tblUsers: TADOTable
    Active = True
    Connection = conPropImplementDB
    CursorType = ctStatic
    TableName = 'tblUsers'
    Left = 296
    Top = 104
  end
  object dscProperties: TDataSource
    DataSet = tblProperties
    Left = 200
    Top = 176
  end
  object dscAgents: TDataSource
    DataSet = tblAgents
    Left = 96
    Top = 176
  end
  object dscUsers: TDataSource
    DataSet = tblUsers
    Left = 296
    Top = 176
  end
  object dscUsertransaction: TDataSource
    DataSet = tblUserTransactionRelation
    Left = 488
    Top = 184
  end
  object dscPropDetails: TDataSource
    DataSet = tblPropDetails
    Left = 384
    Top = 176
  end
  object tblUserTransactionRelation: TADOTable
    Active = True
    Connection = conPropImplementDB
    CursorType = ctStatic
    TableName = 'tblUserTransactionRelation'
    Left = 488
    Top = 104
  end
  object tblPropDetails: TADOTable
    Active = True
    Connection = conPropImplementDB
    CursorType = ctStatic
    TableName = 'tblPropDetails'
    Left = 376
    Top = 104
  end
end
