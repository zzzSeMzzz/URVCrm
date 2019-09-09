object frManageUsers: TfrManageUsers
  AlignWithMargins = True
  Left = 0
  Top = 0
  BorderIcons = [biSystemMenu, biMaximize]
  Caption = #1059#1087#1088#1072#1074#1083#1077#1085#1080#1077' '#1087#1086#1083#1100#1079#1086#1074#1072#1090#1077#1083#1103#1084#1080
  ClientHeight = 396
  ClientWidth = 858
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -12
  Font.Name = 'Tahoma'
  Font.Style = []
  OldCreateOrder = False
  Position = poMainFormCenter
  ShowHint = True
  OnClose = FormClose
  OnCloseQuery = FormCloseQuery
  OnShow = FormShow
  DesignSize = (
    858
    396)
  PixelsPerInch = 96
  TextHeight = 14
  object sSpeedButton1: TsSpeedButton
    Left = 8
    Top = 372
    Width = 23
    Height = 22
    Hint = #1044#1086#1073#1072#1074#1080#1090#1100
    Anchors = [akLeft, akBottom]
    OnClick = sSpeedButton1Click
    Images = frMain.AllImages
    ImageIndex = 0
    ExplicitTop = 366
  end
  object sSpeedButton2: TsSpeedButton
    Left = 66
    Top = 372
    Width = 23
    Height = 22
    Hint = #1059#1076#1072#1083#1080#1090#1100
    Anchors = [akLeft, akBottom]
    OnClick = sSpeedButton2Click
    Images = frMain.AllImages
    ImageIndex = 1
    ExplicitTop = 366
  end
  object sSpeedButton3: TsSpeedButton
    Left = 37
    Top = 372
    Width = 23
    Height = 22
    Hint = #1056#1077#1076#1072#1082#1090#1080#1088#1086#1074#1072#1090#1100
    Anchors = [akLeft, akBottom]
    OnClick = sSpeedButton3Click
    Images = frMain.AllImages
    ImageIndex = 2
    ExplicitTop = 366
  end
  object DBGridEh1: TDBGridEh
    Left = 0
    Top = 0
    Width = 858
    Height = 366
    Align = alTop
    Anchors = [akLeft, akTop, akRight, akBottom]
    DataSource = dm.usersDS
    DynProps = <>
    ReadOnly = True
    TabOrder = 0
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
        FieldName = 'id_role'
        Footers = <>
        Visible = False
      end
      item
        CellButtons = <>
        DynProps = <>
        EditButtons = <>
        FieldName = 'login'
        Footers = <>
        Title.Caption = #1051#1086#1075#1080#1085
        Width = 90
      end
      item
        CellButtons = <>
        DynProps = <>
        EditButtons = <>
        FieldName = 'pass'
        Footers = <>
        Title.Caption = #1055#1072#1088#1086#1083#1100
        Width = 90
      end
      item
        CellButtons = <>
        DynProps = <>
        EditButtons = <>
        FieldName = 'user_name'
        Footers = <>
        Title.Caption = #1060#1048#1054
        Width = 250
      end
      item
        CellButtons = <>
        DynProps = <>
        EditButtons = <>
        FieldName = 'id_dep'
        Footers = <>
        Visible = False
      end
      item
        CellButtons = <>
        DynProps = <>
        EditButtons = <>
        FieldName = 'dname'
        Footers = <>
        Title.Caption = #1055#1086#1076#1088#1072#1079#1076#1077#1083#1077#1085#1080#1077
        Width = 180
      end
      item
        CellButtons = <>
        DynProps = <>
        EditButtons = <>
        FieldName = 'role'
        Footers = <>
        Title.Caption = #1055#1088#1072#1074#1072
        Width = 120
      end
      item
        CellButtons = <>
        Checkboxes = True
        DynProps = <>
        EditButtons = <>
        FieldName = 'fired'
        Footers = <>
        KeyList.Strings = (
          '1'
          '0')
        Title.Caption = #1059#1074#1086#1083#1077#1085
        Width = 70
      end>
    object RowDetailData: TRowDetailPanelControlEh
    end
  end
  object chFired: TCheckBox
    Left = 95
    Top = 372
    Width = 162
    Height = 22
    Anchors = [akLeft, akBottom]
    Caption = #1055#1086#1082#1072#1079#1072#1090#1100' '#1091#1074#1086#1083#1077#1085#1085#1099#1093
    TabOrder = 1
    OnClick = chFiredClick
  end
  object q: TMyQuery
    Connection = dm.cn
    Left = 424
    Top = 192
  end
end
