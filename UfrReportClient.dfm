object frReportClient: TfrReportClient
  Left = 0
  Top = 0
  BorderStyle = bsDialog
  Caption = #1055#1072#1088#1072#1084#1077#1090#1088#1099' '#1086#1090#1095#1077#1090#1072
  ClientHeight = 190
  ClientWidth = 363
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
    Top = 8
    Width = 43
    Height = 14
    Caption = #1055#1077#1088#1080#1086#1076
  end
  object Label3: TLabel
    Left = 169
    Top = 32
    Width = 15
    Height = 14
    Caption = #1055#1086
  end
  object Button1: TButton
    Left = 280
    Top = 159
    Width = 75
    Height = 25
    Caption = 'OK'
    Default = True
    TabOrder = 0
    OnClick = Button1Click
  end
  object cb: TComboBox
    Left = 8
    Top = 80
    Width = 347
    Height = 22
    Style = csDropDownList
    TabOrder = 1
  end
  object dt1: TDateTimePicker
    Left = 8
    Top = 28
    Width = 155
    Height = 22
    Date = 43286.331979479170000000
    Time = 43286.331979479170000000
    TabOrder = 2
  end
  object dt2: TDateTimePicker
    Left = 200
    Top = 28
    Width = 155
    Height = 22
    Date = 43286.332057719900000000
    Time = 43286.332057719900000000
    TabOrder = 3
  end
  object rbDep: TRadioButton
    Left = 8
    Top = 56
    Width = 113
    Height = 17
    Caption = #1055#1086#1076#1088#1072#1079#1076#1077#1083#1077#1085#1080#1077
    Checked = True
    TabOrder = 4
    TabStop = True
    OnClick = rbDepClick
  end
  object RadioButton1: TRadioButton
    Left = 8
    Top = 108
    Width = 201
    Height = 17
    Caption = #1055#1086' '#1086#1090#1076#1077#1083#1100#1085#1099#1084' '#1089#1086#1090#1088#1091#1076#1085#1080#1082#1072#1084
    TabOrder = 5
    OnClick = RadioButton1Click
  end
  object cbUser: TComboBox
    Left = 8
    Top = 131
    Width = 347
    Height = 22
    Style = csDropDownList
    Enabled = False
    TabOrder = 6
  end
  object q: TMyQuery
    Connection = dm.cn
    Left = 264
  end
end
