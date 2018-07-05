object frHandbook: TfrHandbook
  Left = 0
  Top = 0
  BorderIcons = [biSystemMenu, biMaximize]
  Caption = #1057#1087#1088#1072#1074#1086#1095#1085#1080#1082
  ClientHeight = 381
  ClientWidth = 540
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -12
  Font.Name = 'Tahoma'
  Font.Style = []
  OldCreateOrder = False
  Position = poMainFormCenter
  OnClose = FormClose
  OnCloseQuery = FormCloseQuery
  OnShow = FormShow
  DesignSize = (
    540
    381)
  PixelsPerInch = 96
  TextHeight = 14
  object DBGridEh1: TDBGridEh
    AlignWithMargins = True
    Left = 3
    Top = 3
    Width = 534
    Height = 339
    Align = alTop
    Anchors = [akLeft, akTop, akRight, akBottom]
    DataSource = dm.handbookDS
    DynProps = <>
    TabOrder = 0
    Columns = <
      item
        CellButtons = <>
        DynProps = <>
        EditButtons = <>
        FieldName = 'name'
        Footers = <>
        Title.Caption = #1053#1072#1079#1074#1072#1085#1080#1077
        Width = 500
      end>
    object RowDetailData: TRowDetailPanelControlEh
    end
  end
  object DBNavigator1: TDBNavigator
    Left = 3
    Top = 348
    Width = 225
    Height = 25
    DataSource = dm.handbookDS
    VisibleButtons = [nbInsert, nbDelete, nbEdit, nbPost, nbRefresh]
    Anchors = [akLeft, akBottom]
    TabOrder = 1
    ExplicitTop = 388
  end
end
