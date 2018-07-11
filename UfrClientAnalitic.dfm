object frClientAnalitic: TfrClientAnalitic
  Left = 0
  Top = 0
  BorderStyle = bsDialog
  Caption = 'frClientAnalitic'
  ClientHeight = 163
  ClientWidth = 286
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -12
  Font.Name = 'Tahoma'
  Font.Style = []
  OldCreateOrder = False
  Position = poDesktopCenter
  OnClose = FormClose
  OnCreate = FormCreate
  PixelsPerInch = 96
  TextHeight = 14
  object Label1: TLabel
    Left = 8
    Top = 8
    Width = 54
    Height = 14
    Caption = #1055#1077#1088#1080#1086#1076' 1'
  end
  object Label2: TLabel
    Left = 8
    Top = 64
    Width = 54
    Height = 14
    Caption = #1055#1077#1088#1080#1086#1076' 2'
  end
  object dt1: TDateTimePicker
    Left = 8
    Top = 28
    Width = 121
    Height = 22
    Date = 43291.414696736110000000
    Time = 43291.414696736110000000
    TabOrder = 0
  end
  object dt2: TDateTimePicker
    Left = 152
    Top = 28
    Width = 121
    Height = 22
    Date = 43291.414696736110000000
    Time = 43291.414696736110000000
    TabOrder = 1
  end
  object dt3: TDateTimePicker
    Left = 8
    Top = 84
    Width = 121
    Height = 22
    Date = 43291.414696736110000000
    Time = 43291.414696736110000000
    TabOrder = 2
  end
  object dt4: TDateTimePicker
    Left = 152
    Top = 84
    Width = 121
    Height = 22
    Date = 43291.414696736110000000
    Time = 43291.414696736110000000
    TabOrder = 3
  end
  object Button1: TButton
    Left = 203
    Top = 130
    Width = 75
    Height = 25
    Caption = 'OK'
    Default = True
    TabOrder = 4
    OnClick = Button1Click
  end
end
