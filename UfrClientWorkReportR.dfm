object frClientWorkReportR: TfrClientWorkReportR
  Left = 0
  Top = 0
  BorderIcons = [biSystemMenu, biMaximize]
  Caption = 'frClientWorkReportR'
  ClientHeight = 493
  ClientWidth = 686
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  OldCreateOrder = False
  Position = poDesktopCenter
  OnClose = FormClose
  OnCreate = FormCreate
  OnShow = FormShow
  PixelsPerInch = 96
  TextHeight = 13
  object DBGridEh1: TDBGridEh
    Left = 8
    Top = 280
    Width = 670
    Height = 192
    DataSource = ds
    DynProps = <>
    TabOrder = 0
    Visible = False
    object RowDetailData: TRowDetailPanelControlEh
    end
  end
  object lv: TListView
    AlignWithMargins = True
    Left = 3
    Top = 3
    Width = 680
    Height = 487
    Align = alClient
    Columns = <>
    GridLines = True
    ReadOnly = True
    RowSelect = True
    PopupMenu = PopupMenu1
    TabOrder = 1
    ViewStyle = vsReport
    OnColumnClick = lvColumnClick
    OnCompare = lvCompare
    OnCustomDrawItem = lvCustomDrawItem
    OnCustomDrawSubItem = lvCustomDrawSubItem
  end
  object q: TMyQuery
    Connection = dm.cn
    Left = 600
    Top = 440
  end
  object ds: TMyDataSource
    DataSet = q
    Left = 640
    Top = 440
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
