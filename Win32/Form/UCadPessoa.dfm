inherited Frm_CadPessoa: TFrm_CadPessoa
  Caption = 'Cadastro de Pessoa'
  ClientHeight = 462
  ClientWidth = 688
  ExplicitWidth = 700
  ExplicitHeight = 500
  TextHeight = 17
  inherited Page: TPageControl
    Width = 688
    Height = 406
    ExplicitWidth = 684
    ExplicitHeight = 405
    inherited TabDados: TTabSheet
      ExplicitWidth = 680
      ExplicitHeight = 396
      inherited GroupBoxdados: TGroupBox
        Width = 680
        Height = 396
        ExplicitWidth = 680
        ExplicitHeight = 396
        object Label3: TLabel
          Left = 16
          Top = 16
          Width = 43
          Height = 17
          Caption = 'C'#243'digo'
        end
        object Label4: TLabel
          Left = 111
          Top = 16
          Width = 36
          Height = 17
          Caption = 'Nome'
        end
        object Label5: TLabel
          Left = 148
          Top = 70
          Width = 100
          Height = 17
          Caption = 'Data Nascimento'
        end
        object Label6: TLabel
          Left = 271
          Top = 70
          Width = 91
          Height = 17
          Caption = 'Tipo Sanguineo'
        end
        object Label7: TLabel
          Left = 422
          Top = 75
          Width = 31
          Height = 17
          Caption = 'Email'
        end
        object Label8: TLabel
          Left = 16
          Top = 70
          Width = 21
          Height = 17
          Caption = 'CPF'
        end
        object Label9: TLabel
          Left = 16
          Top = 124
          Width = 40
          Height = 17
          Caption = 'Celular'
        end
        object edtCodigo: TDBEdit
          Left = 16
          Top = 39
          Width = 89
          Height = 25
          DataField = 'PES_ID'
          DataSource = ds
          ReadOnly = True
          TabOrder = 0
        end
        object edtNome: TDBEdit
          Left = 111
          Top = 39
          Width = 552
          Height = 25
          DataField = 'PES_NOME'
          DataSource = ds
          TabOrder = 1
        end
        object edtTipo: TDBComboBox
          Left = 271
          Top = 93
          Width = 145
          Height = 25
          Style = csDropDownList
          DataField = 'PES_TIPOSANG'
          DataSource = ds
          Items.Strings = (
            'A+'
            'A-'
            'B+'
            'B-'
            'O+'
            'O-')
          TabOrder = 4
        end
        object edtEmail: TDBEdit
          Left = 422
          Top = 93
          Width = 241
          Height = 25
          DataField = 'PES_EMAIL'
          DataSource = ds
          TabOrder = 5
          OnKeyPress = edtEmailKeyPress
        end
        object edtCelular: TDBEdit
          Left = 16
          Top = 147
          Width = 126
          Height = 25
          DataField = 'PES_CELULAR'
          DataSource = ds
          TabOrder = 6
        end
        object edtCPF: TDBEdit
          Left = 16
          Top = 93
          Width = 126
          Height = 25
          DataField = 'PES_CPF'
          DataSource = ds
          TabOrder = 2
        end
        object edtNascimento: TDBEdit
          Left = 148
          Top = 93
          Width = 117
          Height = 25
          DataField = 'PES_DATANASC'
          DataSource = ds
          TabOrder = 3
        end
      end
    end
    inherited TabConsulta: TTabSheet
      ExplicitWidth = 680
      ExplicitHeight = 396
      inherited Group_filtro: TGroupBox
        Width = 680
        ExplicitWidth = 676
        inherited EdtFiltro: TComboBox
          BevelInner = bvNone
          Style = csDropDownList
          ItemIndex = 4
          Text = 'Nome'
          Items.Strings = (
            'C'#243'digo'
            'CPF'
            'Celular'
            'Data Nascimento'
            'Nome')
        end
        inherited EdtPesquisa: TEdit
          Width = 511
          OnChange = EdtPesquisaChange
          ExplicitWidth = 511
        end
      end
      inherited DBGrid: TDBGrid
        Width = 680
        Height = 323
        DataSource = ds_cons
        Columns = <
          item
            Expanded = False
            FieldName = 'PES_ID'
            Title.Caption = 'C'#243'digo'
            Visible = True
          end
          item
            Expanded = False
            FieldName = 'PES_NOME'
            Title.Caption = 'Nome'
            Width = 263
            Visible = True
          end
          item
            Expanded = False
            FieldName = 'PES_DATANASC'
            Title.Caption = 'Nascimento'
            Width = 78
            Visible = True
          end
          item
            Expanded = False
            FieldName = 'PES_CPF'
            Title.Caption = 'CPF'
            Width = 116
            Visible = True
          end
          item
            Expanded = False
            FieldName = 'PES_CELULAR'
            Title.Caption = 'Celular'
            Width = 104
            Visible = True
          end>
      end
    end
  end
  inherited ToolBar1: TToolBar
    Top = 406
    Width = 688
    ExplicitTop = 405
    ExplicitWidth = 684
    inherited ToolButton11: TToolButton
      ImageIndex = 8
      Visible = False
    end
  end
  inherited IMG: TcxImageList
    FormatVersion = 1
  end
  inherited cds_cons: TClientDataSet
    ProviderName = 'dsp_Cons'
    Top = 356
    object cds_consPES_ID: TIntegerField
      FieldName = 'PES_ID'
      Required = True
    end
    object cds_consPES_NOME: TStringField
      FieldName = 'PES_NOME'
      Size = 100
    end
    object cds_consPES_DATANASC: TSQLTimeStampField
      FieldName = 'PES_DATANASC'
    end
    object cds_consPES_TIPOSANG: TStringField
      FieldName = 'PES_TIPOSANG'
      FixedChar = True
      Size = 2
    end
    object cds_consPES_EMAIL: TStringField
      FieldName = 'PES_EMAIL'
      Size = 100
    end
    object cds_consPES_CELULAR: TStringField
      FieldName = 'PES_CELULAR'
      Size = 100
    end
    object cds_consPES_CPF: TStringField
      FieldName = 'PES_CPF'
      Size = 100
    end
  end
  inherited Sql_Cons: TSQLDataSet
    SchemaName = 'sa'
    CommandText = 'Select * from bs_pessoa'
  end
  inherited ds: TDataSource
    DataSet = DM.cds_pessoa
    Top = 316
  end
end
