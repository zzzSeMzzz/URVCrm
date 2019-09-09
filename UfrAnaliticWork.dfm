object frAnaliticWork: TfrAnaliticWork
  Left = 0
  Top = 0
  BorderStyle = bsDialog
  Caption = #1040#1085#1072#1083#1080#1090#1080#1082#1072' '#1074#1080#1076#1099' '#1088#1072#1073#1086#1090
  ClientHeight = 406
  ClientWidth = 280
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
  object Label2: TLabel
    Left = 8
    Top = 64
    Width = 54
    Height = 14
    Caption = #1055#1077#1088#1080#1086#1076' 2'
  end
  object Label1: TLabel
    Left = 8
    Top = 8
    Width = 54
    Height = 14
    Caption = #1055#1077#1088#1080#1086#1076' 1'
  end
  object Label5: TLabel
    Left = 8
    Top = 184
    Width = 66
    Height = 14
    Caption = #1042#1080#1076#1099' '#1088#1072#1073#1086#1090
  end
  object Label4: TLabel
    Left = 8
    Top = 136
    Width = 41
    Height = 14
    Caption = #1050#1083#1080#1077#1085#1090
  end
  object dt4: TDateTimePicker
    Left = 152
    Top = 84
    Width = 121
    Height = 22
    Date = 43291.414696736110000000
    Time = 43291.414696736110000000
    TabOrder = 0
  end
  object Button1: TButton
    Left = 198
    Top = 379
    Width = 75
    Height = 25
    Caption = 'OK'
    Default = True
    TabOrder = 1
    OnClick = Button1Click
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
  object dt2: TDateTimePicker
    Left = 152
    Top = 28
    Width = 121
    Height = 22
    Date = 43291.414696736110000000
    Time = 43291.414696736110000000
    TabOrder = 3
  end
  object dt1: TDateTimePicker
    Left = 8
    Top = 28
    Width = 121
    Height = 22
    Date = 43291.414696736110000000
    Time = 43291.414696736110000000
    TabOrder = 4
  end
  object cbClient: TComboBox
    Left = 8
    Top = 156
    Width = 265
    Height = 22
    Style = csDropDownList
    TabOrder = 5
  end
  object lbWorks: TCheckListBox
    Left = 8
    Top = 204
    Width = 265
    Height = 129
    ItemHeight = 14
    TabOrder = 6
  end
  object Button3: TButton
    Left = 57
    Top = 339
    Width = 105
    Height = 18
    Caption = #1054#1090#1084#1077#1090#1080#1090#1100' '#1074#1089#1077
    TabOrder = 7
    OnClick = Button3Click
  end
  object Button4: TButton
    Left = 168
    Top = 339
    Width = 105
    Height = 18
    Caption = #1057#1085#1103#1090#1100' '#1074#1089#1077
    TabOrder = 8
    OnClick = Button4Click
  end
  object q: TMyQuery
    Connection = dm.cn
    Left = 104
    Top = 104
  end
end
