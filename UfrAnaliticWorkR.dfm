object frAnaliticWorkR: TfrAnaliticWorkR
  Left = 0
  Top = 0
  BorderIcons = [biSystemMenu, biMaximize]
  Caption = #1040#1085#1072#1083#1080#1090#1080#1082#1072' '#1074#1080#1076#1099' '#1088#1072#1073#1086#1090
  ClientHeight = 503
  ClientWidth = 790
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
  OnShow = FormShow
  PixelsPerInch = 96
  TextHeight = 14
  object lv: TListView
    AlignWithMargins = True
    Left = 3
    Top = 3
    Width = 784
    Height = 497
    Align = alClient
    Columns = <>
    GridLines = True
    ReadOnly = True
    RowSelect = True
    PopupMenu = PopupMenu1
    TabOrder = 0
    ViewStyle = vsReport
    OnCustomDrawItem = lvCustomDrawItem
    ExplicitLeft = 8
    ExplicitTop = -2
  end
  object q: TMyQuery
    Connection = dm.cn
    Left = 448
    Top = 296
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
