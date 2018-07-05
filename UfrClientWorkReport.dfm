object frClientWorkReport: TfrClientWorkReport
  Left = 0
  Top = 0
  BorderStyle = bsDialog
  Caption = #1054#1090#1095#1077#1090' '#1087#1086' '#1082#1083#1080#1077#1085#1090#1072#1084'-'#1074#1080#1076#1072#1084' '#1088#1072#1073#1086#1090
  ClientHeight = 358
  ClientWidth = 527
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
  object Label3: TLabel
    Left = 169
    Top = 32
    Width = 15
    Height = 14
    Caption = #1055#1086
  end
  object Label2: TLabel
    Left = 8
    Top = 8
    Width = 43
    Height = 14
    Caption = #1055#1077#1088#1080#1086#1076
  end
  object Label1: TLabel
    Left = 8
    Top = 64
    Width = 89
    Height = 14
    Caption = #1055#1086#1076#1088#1072#1079#1076#1077#1083#1077#1085#1080#1077
  end
  object Label4: TLabel
    Left = 8
    Top = 104
    Width = 49
    Height = 14
    Caption = #1050#1083#1080#1077#1085#1090#1099
  end
  object Label5: TLabel
    Left = 272
    Top = 104
    Width = 66
    Height = 14
    Caption = #1042#1080#1076#1099' '#1088#1072#1073#1086#1090
  end
  object dt2: TDateTimePicker
    Left = 200
    Top = 28
    Width = 155
    Height = 22
    Date = 43286.332057719900000000
    Time = 43286.332057719900000000
    TabOrder = 0
  end
  object dt1: TDateTimePicker
    Left = 8
    Top = 28
    Width = 155
    Height = 22
    Date = 43286.331979479170000000
    Time = 43286.331979479170000000
    TabOrder = 1
  end
  object cb: TComboBox
    Left = 8
    Top = 80
    Width = 347
    Height = 22
    Style = csDropDownList
    TabOrder = 2
  end
  object lbClient: TCheckListBox
    Left = 8
    Top = 124
    Width = 258
    Height = 157
    ItemHeight = 14
    TabOrder = 3
  end
  object lbWorks: TCheckListBox
    Left = 272
    Top = 124
    Width = 247
    Height = 157
    ItemHeight = 14
    TabOrder = 4
  end
  object Button1: TButton
    Left = 8
    Top = 287
    Width = 105
    Height = 18
    Caption = #1054#1090#1084#1077#1090#1080#1090#1100' '#1074#1089#1077
    TabOrder = 5
    OnClick = Button1Click
  end
  object Button2: TButton
    Left = 119
    Top = 287
    Width = 105
    Height = 18
    Caption = #1057#1085#1103#1090#1100' '#1074#1089#1077
    TabOrder = 6
    OnClick = Button2Click
  end
  object Button3: TButton
    Left = 272
    Top = 287
    Width = 105
    Height = 18
    Caption = #1054#1090#1084#1077#1090#1080#1090#1100' '#1074#1089#1077
    TabOrder = 7
    OnClick = Button3Click
  end
  object Button4: TButton
    Left = 383
    Top = 287
    Width = 105
    Height = 18
    Caption = #1057#1085#1103#1090#1100' '#1074#1089#1077
    TabOrder = 8
    OnClick = Button4Click
  end
  object Button5: TButton
    Left = 444
    Top = 325
    Width = 75
    Height = 25
    Caption = 'OK'
    Default = True
    TabOrder = 9
    OnClick = Button5Click
  end
  object q: TMyQuery
    Connection = dm.cn
    Left = 424
    Top = 24
  end
end
