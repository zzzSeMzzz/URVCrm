object frClientAnaliticR: TfrClientAnaliticR
  Left = 0
  Top = 0
  BorderIcons = [biSystemMenu, biMaximize]
  Caption = #1040#1085#1072#1083#1080#1090#1080#1082#1072' '#1082#1083#1080#1077#1085#1090#1099
  ClientHeight = 550
  ClientWidth = 719
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  OldCreateOrder = False
  Position = poDesktopCenter
  OnClose = FormClose
  OnShow = FormShow
  PixelsPerInch = 96
  TextHeight = 13
  object lv: TListView
    AlignWithMargins = True
    Left = 3
    Top = 3
    Width = 713
    Height = 544
    Align = alClient
    Columns = <
      item
        Caption = #1050#1083#1080#1077#1085#1090
        Width = 200
      end
      item
        Width = 150
      end
      item
        Width = 150
      end
      item
        Caption = #1056#1072#1089#1093#1086#1078#1076#1077#1085#1080#1077', '#1084#1080#1085
        Width = 120
      end
      item
        Caption = #1056#1072#1089#1093#1086#1078#1076#1077#1085#1080#1077', '#1095#1072#1089
        Width = 120
      end
      item
        Caption = #1042' % '#1086#1090#1085#1086#1096#1077#1085#1080#1080' '#1091#1074#1077#1083#1080#1095#1077#1085#1080'/'#1059#1084#1077#1085#1100#1096#1077#1085#1080#1077',%'
        Width = 90
      end>
    GridLines = True
    ReadOnly = True
    RowSelect = True
    TabOrder = 0
    ViewStyle = vsReport
    OnColumnClick = lvColumnClick
    OnCompare = lvCompare
  end
  object q: TMyQuery
    Connection = dm.cn
    Left = 592
    Top = 376
  end
end
