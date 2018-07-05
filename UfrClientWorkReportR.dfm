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
    TabOrder = 1
    ViewStyle = vsReport
    OnColumnClick = lvColumnClick
    OnCompare = lvCompare
    OnCustomDrawSubItem = lvCustomDrawSubItem
    ExplicitLeft = 8
    ExplicitTop = 8
    ExplicitWidth = 670
    ExplicitHeight = 225
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
end
