object frReportClientR: TfrReportClientR
  Left = 0
  Top = 0
  BorderIcons = [biSystemMenu, biMaximize]
  Caption = 'frReportClientR'
  ClientHeight = 411
  ClientWidth = 605
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  OldCreateOrder = False
  Position = poDesktopCenter
  OnShow = FormShow
  PixelsPerInch = 96
  TextHeight = 13
  object DBGridEh1: TDBGridEh
    AlignWithMargins = True
    Left = 8
    Top = 283
    Width = 589
    Height = 120
    DataSource = ds
    DynProps = <>
    TabOrder = 0
    Visible = False
    Columns = <
      item
        CellButtons = <>
        DynProps = <>
        EditButtons = <>
        FieldName = 'id'
        Footers = <>
        Visible = False
      end
      item
        CellButtons = <>
        DynProps = <>
        EditButtons = <>
        FieldName = 'client'
        Footers = <>
        Width = 150
      end
      item
        CellButtons = <>
        DynProps = <>
        EditButtons = <>
        FieldName = 'work'
        Footers = <>
        Width = 150
      end
      item
        CellButtons = <>
        DynProps = <>
        EditButtons = <>
        FieldName = 'time_work'
        Footers = <>
        Width = 55
      end
      item
        CellButtons = <>
        DynProps = <>
        EditButtons = <>
        FieldName = 'id_client'
        Footers = <>
      end
      item
        CellButtons = <>
        DynProps = <>
        EditButtons = <>
        FieldName = 'id_work'
        Footers = <>
      end
      item
        CellButtons = <>
        DynProps = <>
        EditButtons = <>
        FieldName = 'dt'
        Footers = <>
      end
      item
        CellButtons = <>
        DynProps = <>
        EditButtons = <>
        FieldName = 'user_id'
        Footers = <>
      end>
    object RowDetailData: TRowDetailPanelControlEh
    end
  end
  object lv: TListView
    AlignWithMargins = True
    Left = 3
    Top = 3
    Width = 599
    Height = 405
    Align = alClient
    Columns = <
      item
        Caption = #1050#1083#1080#1077#1085#1090
        Width = 250
      end
      item
        Caption = #1042#1088#1077#1084#1103'('#1084#1080#1085')'
        Width = 100
      end
      item
        Caption = #1042#1088#1077#1084#1103'('#1095#1072#1089')'
        Width = 100
      end
      item
        Caption = #1042#1088#1077#1084#1103'('#1092#1072#1082#1090')'
        Width = 100
      end>
    GridLines = True
    ReadOnly = True
    TabOrder = 1
    ViewStyle = vsReport
    OnColumnClick = lvColumnClick
    OnCompare = lvCompare
    OnCustomDrawItem = lvCustomDrawItem
  end
  object q: TMyQuery
    Connection = dm.cn
    SQL.Strings = (
      
        'select tasks.id, tasks.id_client, tasks.id_work, tasks.time_work' +
        ', tasks.dt, tasks.user_id,'
      'clients.`name` as `client`,'
      'works.`name` as `work`'
      'from tasks '
      'LEFT JOIN works ON (works.`id`=tasks.`id_work`)'
      'LEFT JOIN clients ON (clients.`id`=tasks.`id_client`)'
      'WHERE  (tasks.dt BETWEEN '#39'2018-06-28'#39' AND '#39'2018-06-30'#39')'
      'AND (tasks.user_id in(1, 3))'
      'GROUP BY tasks.id')
    Left = 416
    Top = 352
  end
  object ds: TMyDataSource
    DataSet = q
    Left = 456
    Top = 352
  end
end
