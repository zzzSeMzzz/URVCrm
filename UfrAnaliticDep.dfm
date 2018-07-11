object frAnaliticDep: TfrAnaliticDep
  Left = 0
  Top = 0
  BorderStyle = bsDialog
  Caption = #1044#1086#1083#1103' '#1088#1072#1073#1086#1090#1099' '#1087#1086#1076#1088#1072#1079#1076#1077#1083#1077#1085#1080#1081
  ClientHeight = 97
  ClientWidth = 281
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -12
  Font.Name = 'Tahoma'
  Font.Style = []
  OldCreateOrder = False
  Position = poDesktopCenter
  OnCreate = FormCreate
  PixelsPerInch = 96
  TextHeight = 14
  object Label1: TLabel
    Left = 8
    Top = 8
    Width = 43
    Height = 14
    Caption = #1055#1077#1088#1080#1086#1076
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
  object Button1: TButton
    Left = 198
    Top = 64
    Width = 75
    Height = 25
    Caption = 'OK'
    Default = True
    TabOrder = 2
    OnClick = Button1Click
  end
end
