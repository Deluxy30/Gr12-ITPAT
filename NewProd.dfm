object frmNew: TfrmNew
  Left = 0
  Top = 0
  Caption = 'Property Management'
  ClientHeight = 479
  ClientWidth = 616
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  OldCreateOrder = False
  OnShow = FormShow
  PixelsPerInch = 96
  TextHeight = 13
  object Label5: TLabel
    Left = 46
    Top = 35
    Width = 33
    Height = 13
    Caption = 'Agent:'
  end
  object Label4: TLabel
    Left = 46
    Top = 360
    Width = 23
    Height = 13
    Caption = 'Size:'
  end
  object Label3: TLabel
    Left = 46
    Top = 91
    Width = 88
    Height = 13
    Caption = 'Property Address:'
  end
  object Label2: TLabel
    Left = 46
    Top = 147
    Width = 30
    Height = 13
    Caption = ' Price:'
  end
  object Label1: TLabel
    Left = 390
    Top = 35
    Width = 55
    Height = 13
    Caption = 'Bathrooms:'
  end
  object Label6: TLabel
    Left = 390
    Top = 96
    Width = 51
    Height = 13
    Caption = 'Bedrooms:'
  end
  object Label7: TLabel
    Left = 417
    Top = 147
    Width = 24
    Height = 13
    Caption = 'Pool:'
  end
  object Label8: TLabel
    Left = 388
    Top = 203
    Width = 57
    Height = 13
    Caption = 'Pet Friendly'
  end
  object Confirm: TButton
    Left = 498
    Top = 400
    Width = 75
    Height = 25
    Caption = 'Confirm'
    TabOrder = 0
    OnClick = ConfirmClick
  end
  object cmbAgent: TComboBox
    Left = 160
    Top = 32
    Width = 145
    Height = 21
    TabOrder = 1
  end
  object edtPrice: TEdit
    Left = 160
    Top = 144
    Width = 121
    Height = 21
    TabOrder = 2
  end
  object edtAddress: TEdit
    Left = 160
    Top = 88
    Width = 121
    Height = 21
    TabOrder = 3
  end
  object edtSize: TEdit
    Left = 160
    Top = 357
    Width = 121
    Height = 21
    TabOrder = 4
  end
  object Back: TButton
    Left = 8
    Top = 400
    Width = 75
    Height = 25
    Caption = 'Back'
    TabOrder = 5
    OnClick = BackClick
  end
  object rgpSelection: TRadioGroup
    Left = 46
    Top = 188
    Width = 190
    Height = 145
    Caption = 'Properties'
    Items.Strings = (
      'Durban-North'
      'Glenashley'
      'Umhlanga'
      'Phoenix'
      'Salt-Rock'
      'Pietermaritzburg'
      'Umdloti')
    TabOrder = 6
  end
  object sedBathroom: TSpinEdit
    Left = 476
    Top = 32
    Width = 121
    Height = 22
    MaxValue = 0
    MinValue = 0
    TabOrder = 7
    Value = 0
  end
  object sedBedroom: TSpinEdit
    Left = 476
    Top = 93
    Width = 121
    Height = 22
    MaxValue = 0
    MinValue = 0
    TabOrder = 8
    Value = 0
  end
  object chkPool: TCheckBox
    Left = 476
    Top = 146
    Width = 97
    Height = 17
    TabOrder = 9
  end
  object chkPet: TCheckBox
    Left = 476
    Top = 202
    Width = 21
    Height = 17
    TabOrder = 10
  end
  object OpenDialog1: TOpenDialog
    Left = 400
    Top = 376
  end
end
