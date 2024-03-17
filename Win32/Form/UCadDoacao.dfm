inherited Frm_CadManutencao: TFrm_CadManutencao
  Caption = 'Manuten'#231#227'o'
  TextHeight = 17
  inherited Page: TPageControl
    ActivePage = TabDados
    inherited TabDados: TTabSheet
      inherited GroupBoxdados: TGroupBox
        Width = 712
        Height = 469
        object Label3: TLabel
          Left = 16
          Top = 16
          Width = 43
          Height = 17
          Caption = 'C'#243'digo'
        end
        object Label4: TLabel
          Left = 572
          Top = 16
          Width = 27
          Height = 17
          Caption = 'Data'
        end
        object Label5: TLabel
          Left = 111
          Top = 16
          Width = 41
          Height = 17
          Caption = 'Pessoa'
        end
        object Label6: TLabel
          Left = 16
          Top = 70
          Width = 72
          Height = 17
          Caption = 'Qtde Doada'
        end
        object edtCodigo: TDBEdit
          Left = 16
          Top = 39
          Width = 89
          Height = 25
          CharCase = ecUpperCase
          DataField = 'DOA_ID'
          DataSource = ds
          ReadOnly = True
          TabOrder = 0
        end
        object edtdata: TDBEdit
          Left = 572
          Top = 39
          Width = 117
          Height = 25
          CharCase = ecUpperCase
          DataField = 'DOA_DATA'
          DataSource = ds
          TabOrder = 2
        end
        object edtpessoa: TDBLookupComboBox
          Left = 111
          Top = 39
          Width = 455
          Height = 25
          DataField = 'PES_ID'
          DataSource = ds
          KeyField = 'PES_ID'
          ListField = 'PES_NOME'
          ListSource = dsPessoa
          NullValueKey = 16452
          TabOrder = 1
        end
        object edtqtde: TDBEdit
          Left = 16
          Top = 93
          Width = 89
          Height = 25
          CharCase = ecUpperCase
          DataField = 'DOA_QTDE'
          DataSource = ds
          TabOrder = 3
          OnKeyPress = edtqtdeKeyPress
        end
      end
    end
    inherited TabConsulta: TTabSheet
      inherited Group_filtro: TGroupBox
        inherited EdtFiltro: TComboBox
          ItemIndex = 1
          Text = 'Pessoa'
          Items.Strings = (
            'C'#243'digo'
            'Pessoa'
            'CPF')
        end
        inherited EdtPesquisa: TEdit
          Width = 451
          OnChange = EdtPesquisaChange
          ExplicitWidth = 451
        end
        object edtanulada: TCheckBox
          Left = 616
          Top = 41
          Width = 81
          Height = 17
          Caption = 'Anuladas'
          TabOrder = 2
          OnClick = edtanuladaClick
        end
      end
      inherited DBGrid: TDBGrid
        DataSource = ds_cons
        Columns = <
          item
            Expanded = False
            FieldName = 'DOA_ID'
            Title.Caption = 'C'#243'digo'
            Width = 53
            Visible = True
          end
          item
            Expanded = False
            FieldName = 'DOA_DATA'
            Title.Caption = 'Data'
            Width = 88
            Visible = True
          end
          item
            Expanded = False
            FieldName = 'nnome'
            Title.Caption = 'Pessoa'
            Width = 360
            Visible = True
          end
          item
            Expanded = False
            FieldName = 'DOA_QTDE'
            Title.Caption = 'Qtde. Doada'
            Width = 84
            Visible = True
          end
          item
            Expanded = False
            FieldName = 'nstatus'
            Title.Caption = 'Status'
            Width = 82
            Visible = True
          end>
      end
    end
  end
  inherited IMG: TcxImageList
    FormatVersion = 1
  end
  inherited Menu: TActionList
    inherited A_anular: TAction
      OnExecute = A_anularExecute
    end
  end
  inherited cds_cons: TClientDataSet
    ProviderName = 'dsp_Cons'
    object cds_consDOA_ID: TIntegerField
      FieldName = 'DOA_ID'
      Required = True
    end
    object cds_consDOA_DATA: TSQLTimeStampField
      FieldName = 'DOA_DATA'
      Required = True
    end
    object cds_consDOA_QTDE: TFMTBCDField
      FieldName = 'DOA_QTDE'
      Required = True
      DisplayFormat = '#0.00'
      Precision = 18
      Size = 2
    end
    object cds_consDOA_STATUS: TStringField
      FieldName = 'DOA_STATUS'
      Required = True
      FixedChar = True
      Size = 1
    end
    object cds_consPES_ID: TIntegerField
      FieldName = 'PES_ID'
      Required = True
    end
    object cds_consnnome: TStringField
      FieldName = 'nnome'
      Required = True
      Size = 100
    end
    object cds_consnstatus: TStringField
      FieldName = 'nstatus'
      Required = True
      Size = 9
    end
  end
  inherited Sql_Cons: TSQLDataSet
    SchemaName = 'sa'
    CommandText = 
      'Select bs.*, '#13#10' Case when bs.doa_status = '#39'C'#39' then'#13#10' '#39'Conclu'#237'do'#39 +
      #13#10' else'#13#10' '#39'Anulado'#39' end nstatus, bp.pes_nome as nnome from BS_DO' +
      'ACAO BS'#13#10' join BS_PESSOA BP'#13#10' on bs.pes_id = bp.pes_id'
  end
  inherited ds: TDataSource
    DataSet = DM.cds_doacao
  end
  object dsPessoa: TDataSource
    DataSet = DM.cds_listPessoa
    Left = 300
    Top = 278
  end
end
