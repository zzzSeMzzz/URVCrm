object frAnaliticUsersR: TfrAnaliticUsersR
  AlignWithMargins = True
  Left = 0
  Top = 0
  BorderIcons = [biSystemMenu, biMaximize]
  Caption = #1040#1085#1072#1083#1080#1079' '#1089#1088#1072#1074#1085#1080#1090#1077#1083#1100#1085#1099#1081
  ClientHeight = 498
  ClientWidth = 709
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
    Left = 0
    Top = 0
    Width = 709
    Height = 498
    Align = alClient
    Columns = <
      item
        Caption = #1057#1086#1090#1088#1091#1076#1085#1080#1082
        Width = 200
      end
      item
        Caption = #1042#1080#1076' '#1088#1072#1073#1086#1090
        Width = 250
      end
      item
        Caption = #1042#1088#1077#1084#1103
        Width = 60
      end
      item
        Caption = #1057#1088#1077#1076#1085#1077#1077
        Width = 90
      end>
    GridLines = True
    ReadOnly = True
    RowSelect = True
    PopupMenu = PopupMenu1
    TabOrder = 0
    ViewStyle = vsReport
    OnCustomDrawItem = lvCustomDrawItem
    OnCustomDrawSubItem = lvCustomDrawSubItem
  end
  object DBGridEh1: TDBGridEh
    Left = 24
    Top = 272
    Width = 677
    Height = 209
    DataSource = MyDataSource1
    DynProps = <>
    TabOrder = 1
    Visible = False
    object RowDetailData: TRowDetailPanelControlEh
    end
  end
  object q: TMyQuery
    Connection = dm.cn
    Left = 304
    Top = 120
  end
  object MyDataSource1: TMyDataSource
    DataSet = q
    Left = 504
    Top = 168
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
