object frmPropDetails: TfrmPropDetails
  Left = 0
  Top = 0
  Caption = 'Property Details'
  ClientHeight = 342
  ClientWidth = 632
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  OldCreateOrder = False
  PixelsPerInch = 96
  TextHeight = 13
  object imgAgency: TImage
    Left = 464
    Top = 8
    Width = 137
    Height = 145
    Stretch = True
  end
  object lblAgentName: TLabel
    Left = 328
    Top = 24
    Width = 66
    Height = 13
    Caption = 'lblAgentName'
  end
  object redPropDetails: TRichEdit
    Left = 8
    Top = 8
    Width = 289
    Height = 297
    Font.Charset = ANSI_CHARSET
    Font.Color = clWindowText
    Font.Height = -11
    Font.Name = 'Tahoma'
    Font.Style = []
    ParentFont = False
    TabOrder = 0
  end
  object btnBookShowing: TButton
    Left = 352
    Top = 256
    Width = 121
    Height = 49
    Caption = 'Book Showing'
    TabOrder = 1
  end
  object btnStartApplication: TButton
    Left = 479
    Top = 256
    Width = 122
    Height = 49
    Caption = 'Start Application'
    TabOrder = 2
  end
end
