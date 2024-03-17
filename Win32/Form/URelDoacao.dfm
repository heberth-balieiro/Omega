inherited Frm_RelDoacao: TFrm_RelDoacao
  Caption = 'Relat'#243'rio de doa'#231#227'o'
  ClientHeight = 228
  ClientWidth = 437
  OnCreate = FormCreate
  OnShow = FormShow
  ExplicitWidth = 445
  ExplicitHeight = 255
  TextHeight = 17
  inherited ToolBar1: TToolBar
    Top = 172
    Width = 437
    ExplicitTop = 160
    ExplicitWidth = 429
    inherited ToolButton6: TToolButton
      ExplicitWidth = 85
    end
    inherited ToolButton7: TToolButton
      ExplicitWidth = 80
    end
  end
  inherited Panel: TPanel
    Width = 437
    Height = 172
    ExplicitWidth = 429
    ExplicitHeight = 160
    object GroupBox1: TGroupBox
      Left = 0
      Top = 0
      Width = 437
      Height = 172
      Align = alClient
      TabOrder = 0
      ExplicitWidth = 429
      ExplicitHeight = 160
      object Label1: TLabel
        Left = 8
        Top = 62
        Width = 73
        Height = 17
        Caption = 'Pessoa |DEL|'
      end
      object Label2: TLabel
        Left = 8
        Top = 111
        Width = 53
        Height = 17
        Caption = 'Relat'#243'rio'
      end
      object Label5: TLabel
        Left = 8
        Top = 8
        Width = 63
        Height = 17
        Caption = 'Data '#205'nicial'
      end
      object Label6: TLabel
        Left = 134
        Top = 8
        Width = 57
        Height = 17
        Caption = 'Data Final'
      end
      object Label7: TLabel
        Left = 260
        Top = 8
        Width = 127
        Height = 17
        Caption = 'Tipo Sangu'#237'neo |DEL| '
      end
      object edtPessoa: TComboBox
        Left = 8
        Top = 80
        Width = 420
        Height = 25
        Style = csDropDownList
        CharCase = ecUpperCase
        TabOrder = 1
        OnKeyDown = edtPessoaKeyDown
      end
      object edtTipo: TComboBox
        Left = 260
        Top = 31
        Width = 168
        Height = 25
        Style = csDropDownList
        TabOrder = 0
        OnKeyDown = edtTipoKeyDown
        Items.Strings = (
          'A+'
          'A-'
          'B+'
          'B-'
          'O+'
          'O-')
      end
      object edtRelatorio: TComboBox
        Left = 8
        Top = 134
        Width = 420
        Height = 25
        Style = csDropDownList
        ItemIndex = 0
        TabOrder = 2
        Text = 'Listagem agrupada por tipo sangu'#237'neo'
        Items.Strings = (
          'Listagem agrupada por tipo sangu'#237'neo')
      end
      object edtdatainicial: TDateTimePicker
        Left = 8
        Top = 31
        Width = 120
        Height = 25
        Date = 45368.000000000000000000
        Time = 0.450336157409765300
        TabOrder = 3
      end
      object edtdatafinal: TDateTimePicker
        Left = 134
        Top = 31
        Width = 120
        Height = 25
        Date = 45368.000000000000000000
        Time = 0.450336157409765300
        TabOrder = 4
      end
      object edtPeriodo: TCheckBox
        Left = 112
        Top = 8
        Width = 16
        Height = 17
        TabOrder = 5
        OnClick = edtPeriodoClick
      end
    end
  end
  inherited IMG: TcxImageList
    FormatVersion = 1
  end
  inherited Menu: TActionList
    inherited a_imprimir: TAction
      OnExecute = a_imprimirExecute
    end
  end
  inherited frxRelatorio: TfrxDBDataset
    FieldAliases.Strings = (
      'quantidade=quantidade'
      'PES_TIPOSANG=PES_TIPOSANG')
  end
  inherited ds: TDataSource
    DataSet = DM.cds_RelDoacao
  end
  object Report: TfrxReport
    Version = '2022.1.3'
    DotMatrixReport = False
    IniFile = '\Software\Fast Reports'
    PreviewOptions.Buttons = [pbPrint, pbLoad, pbSave, pbExport, pbZoom, pbFind, pbOutline, pbPageSetup, pbTools, pbEdit, pbNavigator, pbExportQuick, pbCopy, pbSelection]
    PreviewOptions.Zoom = 1.000000000000000000
    PrintOptions.Printer = 'Padr'#227'o'
    PrintOptions.PrintOnSheet = 0
    ReportOptions.CreateDate = 45368.478943171300000000
    ReportOptions.LastChange = 45368.478943171300000000
    ScriptLanguage = 'PascalScript'
    ScriptText.Strings = (
      'begin'
      ''
      'end.')
    Left = 320
    Top = 180
    Datasets = <>
    Variables = <>
    Style = <>
  end
  object dspessoa: TDataSource
    DataSet = DM.cds_listPessoa
    Left = 320
    Top = 144
  end
end
