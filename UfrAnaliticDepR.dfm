object frAnaliticDepR: TfrAnaliticDepR
  Left = 0
  Top = 0
  BorderIcons = [biSystemMenu, biMaximize]
  Caption = #1044#1086#1083#1103' '#1088#1072#1073#1086#1090#1099' '#1087#1086#1076#1088#1072#1079#1076#1077#1083#1077#1085#1080#1081
  ClientHeight = 464
  ClientWidth = 739
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -12
  Font.Name = 'Tahoma'
  Font.Style = []
  OldCreateOrder = False
  Position = poDesktopCenter
  OnClose = FormClose
  OnShow = FormShow
  PixelsPerInch = 96
  TextHeight = 14
  object lv: TListView
    AlignWithMargins = True
    Left = 3
    Top = 3
    Width = 733
    Height = 458
    Align = alClient
    Columns = <
      item
        Caption = #1050#1083#1080#1077#1085#1090
        Width = 200
      end
      item
        Caption = #1048#1090#1086#1075#1086' '#1087#1086' '#1082#1083#1080#1077#1085#1090#1091
        Width = 121
      end
      item
        Caption = #1057#1091#1084#1084#1072' '#1074#1088#1077#1084#1077#1085#1080' '#1087#1086#1076#1088#1072#1079#1076#1077#1083#1077#1085#1080#1103' '#1041#1091#1093#1075#1072#1083#1090#1077#1088
        Width = 300
      end
      item
        Caption = #1057#1091#1084#1084#1072' '#1074#1088#1077#1084#1077#1085#1080' '#1087#1086#1076#1088#1072#1079#1076#1072#1083#1077#1085#1080#1103' '#1052#1083#1072#1076#1096#1080#1081' '#1087#1077#1088#1089#1086#1085#1072#1083
        Width = 360
      end
      item
        Caption = #1044#1086#1083#1103' '#1084#1083#1072#1076#1096#1077#1075#1086' '#1087#1077#1088#1089#1086#1085#1072#1083#1072' '#1074' '#1088#1072#1073#1086#1090#1077' '#1089' '#1050#1083#1080#1077#1085#1090#1086#1074',%'
        Width = 360
      end
      item
        Caption = #1044#1086#1083#1103' '#1073#1091#1093#1075#1072#1083#1090#1077#1088#1086#1074' '#1074' '#1088#1072#1073#1086#1090#1077' '#1089' '#1050#1083#1080#1077#1085#1090#1086#1074',%'
        Width = 290
      end>
    GridLines = True
    ReadOnly = True
    RowSelect = True
    PopupMenu = PopupMenu1
    TabOrder = 0
    ViewStyle = vsReport
    OnColumnClick = lvColumnClick
    OnCompare = lvCompare
    OnCustomDrawItem = lvCustomDrawItem
  end
  object q: TMyQuery
    Connection = dm.cn
    Left = 664
    Top = 408
  end
  object PopupMenu1: TPopupMenu
    Left = 120
    Top = 88
    object N1: TMenuItem
      Caption = #1069#1082#1089#1087#1086#1088#1090' '#1074' '#1101#1082#1089#1077#1083#1100
      OnClick = N1Click
    end
  end
  object SaveDialog1: TSaveDialog
    DefaultExt = 'xls'
    Filter = #1069#1082#1089#1077#1083#1100' '#1092#1072#1081#1083'|*.xls'
    Left = 200
    Top = 104
  end
end
