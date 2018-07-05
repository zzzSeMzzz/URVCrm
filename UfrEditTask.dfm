object frEditTask: TfrEditTask
  Left = 0
  Top = 0
  BorderIcons = [biSystemMenu]
  BorderStyle = bsSingle
  Caption = #1047#1072#1076#1072#1095#1072
  ClientHeight = 390
  ClientWidth = 294
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -12
  Font.Name = 'Tahoma'
  Font.Style = []
  OldCreateOrder = False
  Position = poDesktopCenter
  OnClose = FormClose
  OnCloseQuery = FormCloseQuery
  OnCreate = FormCreate
  OnKeyDown = FormKeyDown
  OnShow = FormShow
  PixelsPerInch = 96
  TextHeight = 14
  object Label1: TLabel
    Left = 16
    Top = 8
    Width = 26
    Height = 14
    Caption = #1044#1072#1090#1072
  end
  object Label2: TLabel
    Left = 16
    Top = 56
    Width = 41
    Height = 14
    Caption = #1050#1083#1080#1077#1085#1090
  end
  object Label3: TLabel
    Left = 16
    Top = 112
    Width = 58
    Height = 14
    Caption = #1042#1080#1076' '#1088#1072#1073#1086#1090
  end
  object label23: TLabel
    Left = 16
    Top = 168
    Width = 183
    Height = 14
    Caption = #1042#1088#1077#1084#1103' '#1074#1099#1087#1086#1083#1077#1085#1077#1085#1080#1103'('#1074' '#1084#1080#1085#1091#1090#1072#1093')'
  end
  object Label4: TLabel
    Left = 16
    Top = 216
    Width = 77
    Height = 14
    Caption = #1050#1086#1084#1084#1077#1085#1090#1072#1088#1080#1081
  end
  object dtPicker: TDateTimePicker
    Left = 16
    Top = 28
    Width = 257
    Height = 22
    Date = 43280.554542488440000000
    Time = 43280.554542488440000000
    TabOrder = 0
    OnKeyDown = FormKeyDown
  end
  object cbClients: TComboBox
    Left = 16
    Top = 76
    Width = 257
    Height = 22
    Style = csDropDownList
    TabOrder = 1
    OnKeyDown = FormKeyDown
  end
  object cbWorks: TComboBox
    Left = 16
    Top = 132
    Width = 257
    Height = 22
    Style = csDropDownList
    TabOrder = 2
    OnKeyDown = FormKeyDown
  end
  object edTime: TEdit
    Left = 16
    Top = 188
    Width = 257
    Height = 22
    NumbersOnly = True
    TabOrder = 3
  end
  object edComment: TMemo
    Left = 16
    Top = 236
    Width = 257
    Height = 101
    MaxLength = 255
    ScrollBars = ssVertical
    TabOrder = 4
    OnKeyDown = FormKeyDown
  end
  object Button1: TButton
    Left = 198
    Top = 360
    Width = 75
    Height = 25
    Caption = 'OK'
    Default = True
    TabOrder = 5
    OnClick = Button1Click
  end
  object Button2: TButton
    Left = 117
    Top = 360
    Width = 75
    Height = 25
    Cancel = True
    Caption = #1054#1090#1084#1077#1085#1072
    TabOrder = 6
    OnClick = Button2Click
  end
  object q: TMyQuery
    Connection = dm.cn
    Left = 144
  end
end
