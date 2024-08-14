object SubmitApplication: TSubmitApplication
  Left = 0
  Top = 0
  Caption = 'Submit'
  ClientHeight = 484
  ClientWidth = 901
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  OldCreateOrder = False
  PixelsPerInch = 96
  TextHeight = 13
  object Label5: TLabel
    Left = -25
    Top = 16
    Width = 660
    Height = 13
    Caption = 
      'Here User will submit a "fake doc" provided in the files to subm' +
      'it and will display a progress bar as if the app is "submitting ' +
      'an application" .'
  end
  object lbl: TLabel
    Left = 355
    Top = 286
    Width = 280
    Height = 13
    Caption = 'Every 5 seconds the bar will progress and label will change'
  end
  object Label7: TLabel
    Left = 3
    Top = 56
    Width = 95
    Height = 13
    Caption = 'What you will need:'
  end
  object Label10: TLabel
    Left = 40
    Top = 35
    Width = 201
    Height = 13
    Caption = 'Still learning about file submission in delphi'
  end
  object ProgressBar1: TProgressBar
    Left = 200
    Top = 353
    Width = 150
    Height = 17
    TabOrder = 0
  end
  object Button4: TButton
    Left = 200
    Top = 322
    Width = 75
    Height = 25
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
