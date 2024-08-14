object AdminManagement: TAdminManagement
  Left = 0
  Top = 0
  Caption = 'AdminManagement'
  ClientHeight = 659
  ClientWidth = 972
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
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
  object Button1: TButton
    Left = 728
    Top = 183
    Width = 217
    Height = 58
    Caption = 'Main Menu'
    TabOrder = 3
    OnClick = Button1Click
  end
end
