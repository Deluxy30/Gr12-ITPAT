object SubmitApplication: TSubmitApplication
  Left = 0
  Top = 0
  Caption = 'Submit'
  ClientHeight = 200
  ClientWidth = 548
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
    Left = 37
    Top = 57
    Width = 82
    Height = 13
    Caption = '-An ID Document'
  end
  object lbl: TLabel
    Left = 40
    Top = 179
    Width = 78
    Height = 13
    Caption = 'Ready to submit'
  end
  object Label7: TLabel
    Left = 24
    Top = 22
    Width = 95
    Height = 13
    Caption = 'What you will need:'
  end
  object Label10: TLabel
    Left = 37
    Top = 103
    Width = 309
    Height = 13
    Caption = '(Please ensure document is in PDF before submitting application)'
  end
  object Label1: TLabel
    Left = 37
    Top = 76
    Width = 212
    Height = 13
    Caption = '-A Proof of Payment no older than 3 months'
  end
  object ProgressBar1: TProgressBar
    Left = 40
    Top = 158
    Width = 465
    Height = 17
    TabOrder = 0
  end
  object Button4: TButton
    Left = 384
    Top = 18
    Width = 146
    Height = 94
    Caption = 'Submit'
    TabOrder = 1
    OnClick = Button4Click
  end
  object OpenDialog1: TOpenDialog
    Left = 184
    Top = 576
  end
  object Timer1: TTimer
    OnTimer = Timer1Timer
    Left = 232
    Top = 576
  end
end
