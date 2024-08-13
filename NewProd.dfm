object frmNew: TfrmNew
  Left = 0
  Top = 0
  Caption = 'New Product'
  ClientHeight = 479
  ClientWidth = 993
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  OldCreateOrder = False
  PixelsPerInch = 96
  TextHeight = 13
  object Label7: TLabel
    Left = 746
    Top = 247
    Width = 34
    Height = 13
    Caption = 'Expiry:'
  end
  object Label5: TLabel
    Left = 46
    Top = 35
    Width = 33
    Height = 13
    Caption = 'Agent:'
  end
  object Label4: TLabel
    Left = 110
    Top = 363
    Width = 39
    Height = 13
    Caption = 'Markup:'
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
    Left = 746
    Top = 13
    Width = 54
    Height = 13
    Caption = 'On Special:'
  end
  object Label6: TLabel
    Left = 746
    Top = 169
    Width = 30
    Height = 13
    Caption = 'Stock:'
  end
  object Confirm: TButton
    Left = 746
    Top = 306
    Width = 75
    Height = 25
    Caption = 'Confirm'
    TabOrder = 0
    OnClick = ConfirmClick
  end
  object DateTimePicker1: TDateTimePicker
    Left = 738
    Top = 266
    Width = 186
    Height = 21
    Date = 45221.821135879640000000
    Time = 45221.821135879640000000
    TabOrder = 1
  end
  object cmbSupplier: TComboBox
    Left = 106
    Top = 32
    Width = 145
    Height = 21
    TabOrder = 2
  end
  object edtSuppPrice: TEdit
    Left = 112
    Top = 144
    Width = 121
    Height = 21
    TabOrder = 3
  end
  object edtItem: TEdit
    Left = 160
    Top = 88
    Width = 121
    Height = 21
    TabOrder = 4
  end
  object edtMarkUp: TEdit
    Left = 176
    Top = 360
    Width = 121
    Height = 21
    TabOrder = 5
  end
  object Back: TButton
    Left = 8
    Top = 400
    Width = 75
    Height = 25
    Caption = 'Back'
    TabOrder = 6
    OnClick = BackClick
  end
  object rgpSpecial: TRadioGroup
    Left = 46
    Top = 182
    Width = 185
    Height = 105
    Caption = 'Area'
    Items.Strings = (
      'Yes'
      'No')
    TabOrder = 7
  end
  object senStock: TSpinEdit
    Left = 746
    Top = 188
    Width = 121
    Height = 22
    MaxValue = 0
    MinValue = 0
    TabOrder = 8
    Value = 0
  end
end
