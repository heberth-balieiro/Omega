inherited Frm_CadManutencao: TFrm_CadManutencao
  Caption = 'Manuten'#231#227'o'
  TextHeight = 17
  inherited Page: TPageControl
    ActivePage = TabDados
    inherited TabDados: TTabSheet
      inherited GroupBoxdados: TGroupBox
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
          DataField = 'DOA_QTDE'
          DataSource = ds
          TabOrder = 3
          OnKeyPress = edtqtdeKeyPress
        end
      end
    end
  end
  inherited IMG: TcxImageList
    FormatVersion = 1
  end
  inherited Sql_Cons: TSQLDataSet
    SchemaName = 'sa'
    CommandText = 'Select * form BS_DOACAO'
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
