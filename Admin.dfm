object AdminManagement: TAdminManagement
  Left = 0
  Top = 0
  Caption = 'AdminManagement'
  ClientHeight = 688
  ClientWidth = 968
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  Menu = MainMenu1
  OldCreateOrder = False
  OnCreate = FormCreate
  PixelsPerInch = 96
  TextHeight = 13
  object btnDelete: TButton
    Left = 728
    Top = 32
    Width = 217
    Height = 58
    Caption = 'Delete Property'
    TabOrder = 0
    OnClick = btnDeleteClick
  end
  object dbgProperties: TDBGrid
    Left = 32
    Top = 32
    Width = 673
    Height = 209
    ReadOnly = True
    TabOrder = 1
    TitleFont.Charset = DEFAULT_CHARSET
    TitleFont.Color = clWindowText
    TitleFont.Height = -11
    TitleFont.Name = 'Tahoma'
    TitleFont.Style = []
  end
  object btnAddProp: TButton
    Left = 728
    Top = 112
    Width = 217
    Height = 57
    Caption = 'Add Property'
    TabOrder = 2
    OnClick = btnAddPropClick
  end
  object dbgUsers: TDBGrid
    Left = 32
    Top = 256
    Width = 673
    Height = 193
    ReadOnly = True
    TabOrder = 3
    TitleFont.Charset = DEFAULT_CHARSET
    TitleFont.Color = clWindowText
    TitleFont.Height = -11
    TitleFont.Name = 'Tahoma'
    TitleFont.Style = []
  end
  object btnUser: TButton
    Left = 728
    Top = 256
    Width = 217
    Height = 57
    Caption = 'Delete User'
    TabOrder = 4
  end
  object dbgAgents: TDBGrid
    Left = 32
    Top = 480
    Width = 673
    Height = 184
    ReadOnly = True
    TabOrder = 5
    TitleFont.Charset = DEFAULT_CHARSET
    TitleFont.Color = clWindowText
    TitleFont.Height = -11
    TitleFont.Name = 'Tahoma'
    TitleFont.Style = []
  end
  object btnAddAgent: TButton
    Left = 728
    Top = 480
    Width = 217
    Height = 57
    Caption = 'Add Agent'
    CommandLinkHint = 'Add Agent'
    TabOrder = 6
  end
  object MainMenu1: TMainMenu
    Top = 64
    object GobacktoMain1: TMenuItem
      Caption = 'Go back to Main'
      OnClick = GobacktoMain1Click
    end
  end
end
