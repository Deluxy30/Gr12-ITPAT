object frmMainDB: TfrmMainDB
  Left = 0
  Top = 0
  Caption = 'Propedex V1.0'
  ClientHeight = 632
  ClientWidth = 1128
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  Menu = MainMenu1
  OldCreateOrder = False
  OnShow = FormShow
  PixelsPerInch = 96
  TextHeight = 13
  object img1: TImage
    Left = 36
    Top = 32
    Width = 169
    Height = 169
  end
  object img4: TImage
    Left = 36
    Top = 288
    Width = 169
    Height = 169
  end
  object img2: TImage
    Left = 396
    Top = 32
    Width = 169
    Height = 169
  end
  object img3: TImage
    Left = 736
    Top = 32
    Width = 169
    Height = 169
  end
  object img5: TImage
    Left = 396
    Top = 288
    Width = 169
    Height = 169
  end
  object img6: TImage
    Left = 736
    Top = 288
    Width = 169
    Height = 169
  end
  object lblImg1Address: TLabel
    Left = 224
    Top = 64
    Width = 73
    Height = 13
    Caption = 'lblImg1Address'
  end
  object lblImg1Area: TLabel
    Left = 224
    Top = 104
    Width = 31
    Height = 13
    Caption = 'Label8'
  end
  object lblImg1Price: TLabel
    Left = 224
    Top = 144
    Width = 31
    Height = 13
    Caption = 'Label8'
  end
  object lblImg2Address: TLabel
    Left = 592
    Top = 64
    Width = 73
    Height = 13
    Caption = 'lblImg2Address'
  end
  object lblImg2Area: TLabel
    Left = 592
    Top = 104
    Width = 31
    Height = 13
    Caption = 'Label8'
  end
  object lblImg2Price: TLabel
    Left = 592
    Top = 144
    Width = 31
    Height = 13
    Caption = 'Label8'
  end
  object lblImg3Address: TLabel
    Left = 944
    Top = 64
    Width = 73
    Height = 13
    Caption = 'lblImg3Address'
  end
  object lblImg3Area: TLabel
    Left = 944
    Top = 104
    Width = 31
    Height = 13
    Caption = 'Label8'
  end
  object lblImg3Price: TLabel
    Left = 944
    Top = 144
    Width = 31
    Height = 13
    Caption = 'Label8'
  end
  object lblImg5Address: TLabel
    Left = 592
    Top = 312
    Width = 31
    Height = 13
    Caption = 'Label8'
  end
  object lblImg5Area: TLabel
    Left = 592
    Top = 352
    Width = 31
    Height = 13
    Caption = 'Label8'
  end
  object lblImg5Price: TLabel
    Left = 592
    Top = 392
    Width = 31
    Height = 13
    Caption = 'Label8'
  end
  object lblImg6Address: TLabel
    Left = 944
    Top = 312
    Width = 31
    Height = 13
    Caption = 'Label8'
  end
  object lblImg6Area: TLabel
    Left = 944
    Top = 352
    Width = 31
    Height = 13
    Caption = 'Label8'
  end
  object lblImg6Price: TLabel
    Left = 944
    Top = 392
    Width = 31
    Height = 13
    Caption = 'Label8'
  end
  object lblImg4Address: TLabel
    Left = 224
    Top = 312
    Width = 31
    Height = 13
    Caption = 'Label8'
  end
  object lblImg4Area: TLabel
    Left = 224
    Top = 352
    Width = 31
    Height = 13
    Caption = 'Label8'
  end
  object lblImg4Price: TLabel
    Left = 224
    Top = 392
    Width = 31
    Height = 13
    Caption = 'Label8'
  end
  object btnExit: TButton
    Left = 36
    Top = 577
    Width = 118
    Height = 34
    Caption = 'Exit'
    TabOrder = 0
    OnClick = btnExitClick
  end
  object Button6: TButton
    Left = 980
    Top = 528
    Width = 75
    Height = 25
    Caption = 'Next Page'
    TabOrder = 1
  end
  object Button7: TButton
    Left = 899
    Top = 528
    Width = 75
    Height = 25
    Caption = 'Previous Page'
    TabOrder = 2
  end
  object btnSearch: TButton
    Left = 821
    Top = 481
    Width = 234
    Height = 41
    Caption = 'Search for Item'
    Font.Charset = ANSI_CHARSET
    Font.Color = clBlack
    Font.Height = -15
    Font.Name = 'Arial'
    Font.Style = [fsBold]
    ParentFont = False
    TabOrder = 3
    OnClick = btnSearchClick
  end
  object btnSort: TButton
    Left = 444
    Top = 475
    Width = 155
    Height = 34
    Caption = 'Sort Items by Price'
    TabOrder = 4
    OnClick = btnSortClick
  end
  object rgpSelection: TRadioGroup
    Left = 605
    Top = 479
    Width = 190
    Height = 145
    Caption = 'Properties Displayed'
    ItemIndex = 0
    Items.Strings = (
      'All'
      'Durban-North'
      'Glenashley'
      'Umhlanga'
      'Phoenix'
      'Salt-Rock'
      'Pietermaritzburg'
      'Umdloti')
    TabOrder = 5
  end
  object btnDisplay: TButton
    Left = 720
    Top = 479
    Width = 75
    Height = 25
    Caption = 'Display'
    TabOrder = 6
  end
  object btnAdminMgmt: TButton
    Left = 1013
    Top = 599
    Width = 107
    Height = 25
    Caption = 'Admin Management'
    Enabled = False
    TabOrder = 7
  end
  object MainMenu1: TMainMenu
    Left = 1088
    Top = 8
    object File1: TMenuItem
      Caption = 'File'
    end
  end
  object OpenDialog1: TOpenDialog
    Left = 184
    Top = 576
  end
  object Timer1: TTimer
    Left = 232
    Top = 576
  end
end
