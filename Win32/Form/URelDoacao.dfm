inherited Frm_RelDoacao: TFrm_RelDoacao
  Caption = 'Relat'#243'rio de doa'#231#227'o'
  ClientHeight = 228
  ClientWidth = 437
  ExplicitWidth = 445
  ExplicitHeight = 255
  TextHeight = 17
  inherited ToolBar1: TToolBar
    Top = 172
    Width = 437
    ExplicitTop = 283
    ExplicitWidth = 428
  end
  inherited Panel: TPanel
    Width = 437
    Height = 172
    ExplicitLeft = 0
    ExplicitTop = 0
    ExplicitWidth = 428
    ExplicitHeight = 283
    object GroupBox1: TGroupBox
      Left = 0
      Top = 0
      Width = 437
      Height = 172
      Align = alClient
      TabOrder = 0
      ExplicitWidth = 428
      ExplicitHeight = 283
      object Label1: TLabel
        Left = 8
        Top = 62
        Width = 41
        Height = 17
        Caption = 'Pessoa'
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
        Width = 91
        Height = 17
        Caption = 'Tipo Sangu'#237'neo'
      end
      object edtPessoa: TComboBox
        Left = 8
        Top = 80
        Width = 420
        Height = 25
        Style = csDropDownList
        CharCase = ecUpperCase
        TabOrder = 3
      end
      object edtDataInicial: TEdit
        Left = 8
        Top = 31
        Width = 120
        Height = 25
        CharCase = ecUpperCase
        TabOrder = 0
      end
      object edtDataFinal: TEdit
        Left = 134
        Top = 31
        Width = 120
        Height = 25
        CharCase = ecUpperCase
        TabOrder = 1
      end
      object edtTipo: TComboBox
        Left = 260
        Top = 31
        Width = 168
        Height = 25
        Style = csDropDownList
        TabOrder = 2
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
        TabOrder = 4
        Items.Strings = (
          'Listagem agrupada por tipo sangu'#237'neo')
      end
    end
  end
  inherited IMG: TcxImageList
    FormatVersion = 1
  end
  inherited Menu: TActionList
    inherited a_imprimir: TAction
      OnExecute = nil
    end
  end
  inherited Relatorio: TfrxReport
    Datasets = <>
    Variables = <>
    Style = <>
  end
end
