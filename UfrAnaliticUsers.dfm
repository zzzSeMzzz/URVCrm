object frAnaliticUsers: TfrAnaliticUsers
  Left = 0
  Top = 0
  BorderStyle = bsDialog
  Caption = #1057#1088#1072#1074#1085#1080#1090#1077#1083#1100#1085#1099#1081' '#1072#1085#1072#1083#1080#1079
  ClientHeight = 290
  ClientWidth = 561
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
  object Label5: TLabel
    Left = 8
    Top = 69
    Width = 66
    Height = 14
    Caption = #1042#1080#1076#1099' '#1088#1072#1073#1086#1090
  end
  object Label1: TLabel
    Left = 8
    Top = 8
    Width = 43
    Height = 14
    Caption = #1055#1077#1088#1080#1086#1076
  end
  object Label2: TLabel
    Left = 288
    Top = 69
    Width = 79
    Height = 14
    Caption = #1055#1086#1083#1100#1079#1086#1074#1072#1090#1077#1083#1080
  end
  object lbWorks: TCheckListBox
    Left = 8
    Top = 89
    Width = 265
    Height = 129
    ItemHeight = 14
    TabOrder = 0
  end
  object Button4: TButton
    Left = 168
    Top = 224
    Width = 105
    Height = 18
    Caption = #1057#1085#1103#1090#1100' '#1074#1089#1077
    TabOrder = 1
    OnClick = Button4Click
  end
  object Button3: TButton
    Left = 57
    Top = 224
    Width = 105
    Height = 18
    Caption = #1054#1090#1084#1077#1090#1080#1090#1100' '#1074#1089#1077
    TabOrder = 2
    OnClick = Button3Click
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
  object lbUsers: TCheckListBox
    Left = 288
    Top = 89
    Width = 265
    Height = 129
    ItemHeight = 14
    TabOrder = 5
  end
  object Button1: TButton
    Left = 448
    Top = 226
    Width = 105
    Height = 18
    Caption = #1057#1085#1103#1090#1100' '#1074#1089#1077
    TabOrder = 6
    OnClick = Button1Click
  end
  object Button2: TButton
    Left = 337
    Top = 226
    Width = 105
    Height = 18
    Caption = #1054#1090#1084#1077#1090#1080#1090#1100' '#1074#1089#1077
    TabOrder = 7
    OnClick = Button2Click
  end
  object Button5: TButton
    Left = 478
    Top = 257
    Width = 75
    Height = 25
    Caption = 'OK'
    Default = True
    TabOrder = 8
    OnClick = Button5Click
  end
  object q: TMyQuery
    Connection = dm.cn
    Left = 360
    Top = 24
  end
end
