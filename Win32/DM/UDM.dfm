object DM: TDM
  OnCreate = DataModuleCreate
  Height = 167
  Width = 686
  object Connect: TSQLConnection
    DriverName = 'MSSQL'
    LoginPrompt = False
    Params.Strings = (
      'SchemaOverride=%.dbo'
      'DriverUnit=Data.DBXMSSQL'
      
        'DriverPackageLoader=TDBXDynalinkDriverLoader,DBXCommonDriver280.' +
        'bpl'
      
        'DriverAssemblyLoader=Borland.Data.TDBXDynalinkDriverLoader,Borla' +
        'nd.Data.DbxCommonDriver,Version=24.0.0.0,Culture=neutral,PublicK' +
        'eyToken=91d62ebb5b0d1b1b'
      
        'MetaDataPackageLoader=TDBXMsSqlMetaDataCommandFactory,DbxMSSQLDr' +
        'iver280.bpl'
      
        'MetaDataAssemblyLoader=Borland.Data.TDBXMsSqlMetaDataCommandFact' +
        'ory,Borland.Data.DbxMSSQLDriver,Version=24.0.0.0,Culture=neutral' +
        ',PublicKeyToken=91d62ebb5b0d1b1b'
      'GetDriverFunc=getSQLDriverMSSQL'
      'LibraryName=dbxmss.dll'
      'VendorLib=sqlncli10.dll'
      'VendorLibWin64=sqlncli10.dll'
      'HostName=localhost\sqlexpress'
      'DataBase=dados'
      'MaxBlobSize=-1'
      'LocaleCode=0000'
      'IsolationLevel=ReadCommitted'
      'OSAuthentication=False'
      'PrepareSQL=True'
      'User_Name=sa'
      'Password=hd860412'
      'BlobSize=-1'
      'ErrorResourceFile='
      'OS Authentication=False'
      'Prepare SQL=False')
    Connected = True
    Left = 24
    Top = 48
  end
  object cds_pessoa: TClientDataSet
    Active = True
    Aggregates = <>
    Params = <
      item
        DataType = ftWideString
        Name = 'id'
        ParamType = ptInput
        Value = '-1'
      end>
    ProviderName = 'dsp_pessoa'
    Left = 280
    object cds_pessoaPES_ID: TIntegerField
      FieldName = 'PES_ID'
      ProviderFlags = [pfInUpdate, pfInWhere, pfInKey]
      Required = True
    end
    object cds_pessoaPES_NOME: TStringField
      FieldName = 'PES_NOME'
      Required = True
      Size = 100
    end
    object cds_pessoaPES_DATANASC: TSQLTimeStampField
      FieldName = 'PES_DATANASC'
      Required = True
    end
    object cds_pessoaPES_TIPOSANG: TStringField
      FieldName = 'PES_TIPOSANG'
      Required = True
      FixedChar = True
      Size = 2
    end
    object cds_pessoaPES_EMAIL: TStringField
      FieldName = 'PES_EMAIL'
      Required = True
      Size = 100
    end
    object cds_pessoaPES_CELULAR: TStringField
      FieldName = 'PES_CELULAR'
      Required = True
      Size = 100
    end
    object cds_pessoaPES_CPF: TStringField
      FieldName = 'PES_CPF'
      Required = True
      Size = 100
    end
  end
  object dsp_pessoa: TDataSetProvider
    DataSet = sds_pessoa
    Options = [poAllowCommandText, poUseQuoteChar]
    Left = 216
  end
  object sds_pessoa: TSQLDataSet
    SchemaName = 'sa'
    CommandText = 'Select * from bs_pessoa  where pes_id= :id'
    MaxBlobSize = -1
    Params = <
      item
        DataType = ftWideString
        Name = 'id'
        ParamType = ptInput
        Value = '-1'
      end>
    SQLConnection = Connect
    Left = 152
  end
  object cds_doacao: TClientDataSet
    Aggregates = <>
    Params = <
      item
        DataType = ftWideString
        Name = 'id'
        ParamType = ptInput
        Value = '-1'
      end>
    ProviderName = 'dsp_doacao'
    Left = 288
    Top = 72
    object cds_doacaoDOA_ID: TIntegerField
      FieldName = 'DOA_ID'
      Required = True
    end
    object cds_doacaoDOA_DATA: TSQLTimeStampField
      FieldName = 'DOA_DATA'
      Required = True
    end
    object cds_doacaoDOA_QTDE: TFMTBCDField
      FieldName = 'DOA_QTDE'
      Required = True
      Precision = 18
      Size = 2
    end
    object cds_doacaoDOA_STATUS: TStringField
      FieldName = 'DOA_STATUS'
      Required = True
      FixedChar = True
      Size = 1
    end
    object cds_doacaoPES_ID: TIntegerField
      FieldName = 'PES_ID'
      Required = True
    end
    object cds_doacaoVIRTUAL_DATANASCIMENTO: TDateField
      FieldKind = fkLookup
      FieldName = 'VIRTUAL_DATANASCIMENTO'
      LookupDataSet = cds_listPessoa
      LookupKeyFields = 'PES_ID'
      LookupResultField = 'PES_DATANASC'
      KeyFields = 'PES_ID'
      Lookup = True
    end
  end
  object dsp_doacao: TDataSetProvider
    DataSet = sds_doacao
    Left = 216
    Top = 72
  end
  object sds_doacao: TSQLDataSet
    SchemaName = 'sa'
    CommandText = 'Select * from bs_doacao where doa_id= :id'
    MaxBlobSize = -1
    Params = <
      item
        DataType = ftUnknown
        Name = 'id'
        ParamType = ptInput
      end>
    SQLConnection = Connect
    Left = 152
    Top = 72
  end
  object cds_listPessoa: TClientDataSet
    Aggregates = <>
    Params = <>
    ProviderName = 'dsp_listPessoa'
    Left = 560
    object IntegerField1: TIntegerField
      FieldName = 'PES_ID'
      ProviderFlags = [pfInUpdate, pfInWhere, pfInKey]
      Required = True
    end
    object StringField1: TStringField
      FieldName = 'PES_NOME'
      Required = True
      Size = 100
    end
    object SQLTimeStampField1: TSQLTimeStampField
      FieldName = 'PES_DATANASC'
      Required = True
    end
    object StringField2: TStringField
      FieldName = 'PES_TIPOSANG'
      Required = True
      FixedChar = True
      Size = 2
    end
    object StringField3: TStringField
      FieldName = 'PES_EMAIL'
      Required = True
      Size = 100
    end
    object StringField4: TStringField
      FieldName = 'PES_CELULAR'
      Required = True
      Size = 100
    end
    object StringField5: TStringField
      FieldName = 'PES_CPF'
      Required = True
      Size = 100
    end
  end
  object dsp_listPessoa: TDataSetProvider
    DataSet = sds_listPessoa
    Options = [poAllowCommandText, poUseQuoteChar]
    Left = 496
  end
  object sds_listPessoa: TSQLDataSet
    SchemaName = 'sa'
    CommandText = 'Select * from bs_pessoa order by pes_nome ASC'
    MaxBlobSize = -1
    Params = <>
    SQLConnection = Connect
    Left = 432
  end
end
