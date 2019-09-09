object frEditUser: TfrEditUser
  Left = 0
  Top = 0
  BorderStyle = bsDialog
  Caption = #1056#1077#1076#1072#1082#1090#1080#1088#1086#1074#1072#1085#1080#1077' '#1087#1086#1083#1100#1079#1086#1074#1072#1090#1077#1083#1103
  ClientHeight = 317
  ClientWidth = 316
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -12
  Font.Name = 'Tahoma'
  Font.Style = []
  OldCreateOrder = False
  Position = poMainFormCenter
  OnClose = FormClose
  OnCreate = FormCreate
  OnShow = FormShow
  PixelsPerInch = 96
  TextHeight = 14
  object Label1: TLabel
    Left = 8
    Top = 8
    Width = 27
    Height = 14
    Caption = #1060#1048#1054
  end
  object Label2: TLabel
    Left = 8
    Top = 56
    Width = 34
    Height = 14
    Caption = #1051#1086#1075#1080#1085
  end
  object Label3: TLabel
    Left = 8
    Top = 104
    Width = 41
    Height = 14
    Caption = #1055#1072#1088#1086#1083#1100
  end
  object Label4: TLabel
    Left = 8
    Top = 152
    Width = 33
    Height = 14
    Caption = #1055#1088#1072#1074#1072
  end
  object Label5: TLabel
    Left = 8
    Top = 200
    Width = 89
    Height = 14
    Caption = #1055#1086#1076#1088#1072#1079#1076#1077#1083#1077#1085#1080#1077
  end
  object edFio: TEdit
    Left = 8
    Top = 28
    Width = 300
    Height = 22
    TabOrder = 0
  end
  object edLogin: TEdit
    Left = 8
    Top = 76
    Width = 300
    Height = 22
    TabOrder = 1
  end
  object edPass: TEdit
    Left = 8
    Top = 124
    Width = 300
    Height = 22
    TabOrder = 2
  end
  object ComboBox1: TComboBox
    Left = 8
    Top = 172
    Width = 300
    Height = 22
    Style = csDropDownList
    TabOrder = 3
  end
  object ComboBox2: TComboBox
    Left = 8
    Top = 220
    Width = 300
    Height = 22
    Style = csDropDownList
    TabOrder = 4
  end
  object Button1: TButton
    Left = 233
    Top = 288
    Width = 75
    Height = 25
    Caption = 'OK'
    Default = True
    TabOrder = 5
    OnClick = Button1Click
  end
  object Button2: TButton
    Left = 152
    Top = 288
    Width = 75
    Height = 25
    Cancel = True
    Caption = #1054#1090#1084#1077#1085#1072
    TabOrder = 6
    OnClick = Button2Click
  end
  object chFired: TCheckBox
    Left = 8
    Top = 256
    Width = 97
    Height = 17
    Caption = #1059#1074#1086#1083#1077#1085
    TabOrder = 7
  end
  object q: TMyQuery
    Connection = dm.cn
    Left = 136
    Top = 16
  end
end
