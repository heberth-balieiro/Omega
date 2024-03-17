unit UDM;

interface

uses
  System.SysUtils, System.Classes, Data.DBXMSSQL, Data.DB, Data.SqlExpr,
  System.IniFiles, Data.DBXOdbc, Data.FMTBcd, Datasnap.Provider,
  Datasnap.DBClient;

type
  TDM = class(TDataModule)
    Connect: TSQLConnection;
    cds_pessoa: TClientDataSet;
    dsp_pessoa: TDataSetProvider;
    sds_pessoa: TSQLDataSet;
    cds_pessoaPES_ID: TIntegerField;
    cds_pessoaPES_NOME: TStringField;
    cds_pessoaPES_DATANASC: TSQLTimeStampField;
    cds_pessoaPES_TIPOSANG: TStringField;
    cds_pessoaPES_EMAIL: TStringField;
    cds_pessoaPES_CELULAR: TStringField;
    cds_pessoaPES_CPF: TStringField;
    cds_doacao: TClientDataSet;
    dsp_doacao: TDataSetProvider;
    sds_doacao: TSQLDataSet;
    cds_doacaoDOA_ID: TIntegerField;
    cds_doacaoDOA_DATA: TSQLTimeStampField;
    cds_doacaoDOA_QTDE: TFMTBCDField;
    cds_doacaoDOA_STATUS: TStringField;
    cds_doacaoPES_ID: TIntegerField;
    cds_listPessoa: TClientDataSet;
    IntegerField1: TIntegerField;
    StringField1: TStringField;
    SQLTimeStampField1: TSQLTimeStampField;
    StringField2: TStringField;
    StringField3: TStringField;
    StringField4: TStringField;
    StringField5: TStringField;
    dsp_listPessoa: TDataSetProvider;
    sds_listPessoa: TSQLDataSet;
    cds_doacaoVIRTUAL_DATANASCIMENTO: TDateField;
    procedure DataModuleCreate(Sender: TObject);
  private
    FDrivername: String;
    Fpass: string;
    fdatabase: String;
    Fuser: string;
    Fhostname: string;

    { Private declarations }
  public
    nDir:string;
    { Public declarations }
    function LerValorIni(const ArquivoIni, Seccao, Chave,
      ValorPadrao: string): string;
    procedure GravarValorIni(const ArquivoIni, Seccao, Chave, Valor: string);
    Procedure ConfigBanco(Connection:Tsqlconnection);

    Property Drivername :String read  FDrivername write Fdrivername;
    property Hostname   :string read  Fhostname   write Fhostname;
    property Database   :String read  fdatabase   write Fdatabase;
    property user       :string read  Fuser       write Fuser;
    property pass       :string read  Fpass       write Fpass;
    function Numerador(Tabela, Campo: String): Integer;
    function ValidarPessoa(S:string;dt:tdate): Boolean;
    function ValidarultDoacao(id: integer): Tdate;
    function AnularDoacao(i: integer): boolean;
  end;

var
  DM: TDM;

implementation

uses
  Vcl.Dialogs;

{%CLASSGROUP 'Vcl.Controls.TControl'}

{$R *.dfm}

Function TDM.Numerador(Tabela, Campo: String): Integer;
var
Qry :TSqlquery;
begin
  Result := 0;

  try
    Qry               := TSqlquery.Create(nil);
    Qry.SQLConnection :=Connect;

    with Qry do
    begin
      Close;
      sql.Clear;
      Sql.Add('Select Max('+Campo+')maior from '+tabela);
      Try
        Open;
        Result := Fields[0].AsInteger + 1;
      Except on e:exception do
        raise Exception.Create('Erro:'+#13+e.Message)
      End;
      Close;
    end;

  finally
    Qry.Free;
  end;

end;

procedure TDM.ConfigBanco(Connection: Tsqlconnection);
begin
  Try

    Connect.DriverName                  := 'MSSQL';
    Connect.Params.Values['HostName']   := Trim(hostname);
    Connect.Params.Values['Database']   := Trim(database);
    Connect.Params.Values['User_Name']  := Trim(user);
    Connect.Params.Values['Password']   := Trim(pass);
    Connect.Connected := True;

  Except on e:Exception do
    raise Exception.Create('Error de conexão:'+#13+e.Message);
  End;

end;

Function TDM.LerValorIni(const ArquivoIni, Seccao, Chave,
  ValorPadrao: string): string;
var
  IniFile: TIniFile;
begin
  IniFile := TIniFile.Create(ArquivoIni);
  try
    Result := IniFile.ReadString(Seccao, Chave, ValorPadrao);
  finally
    IniFile.Free;
  end;
end;

Procedure TDM.GravarValorIni(const ArquivoIni, Seccao, Chave, Valor: string);
var
  IniFile: TIniFile;
begin
  IniFile := TIniFile.Create(ArquivoIni);
  try
    IniFile.WriteString(Seccao, Chave, Valor);
  finally
    IniFile.Free;
  end;
end;

procedure TDM.DataModuleCreate(Sender: TObject);
begin
  nDir              := ExtractFilePath(ParamStr(0));
  Try
    Drivername      := LerValorIni(nDir+'\Banco.ini', 'Conexao', 'DriverName', '');
    Hostname        := LerValorIni(nDir+'\Banco.ini', 'Conexao', 'HostName', '');
    Database        := LerValorIni(nDir+'\Banco.ini', 'Conexao', 'DataBase', '');
    user            := LerValorIni(nDir+'\Banco.ini', 'Conexao', 'User', '');
    pass            := LerValorIni(nDir+'\Banco.ini', 'Conexao', 'Password', '');

    ConfigBanco(Connect);

  except on e:exception do
    raise Exception.Create('Error:'+#13+e.Message);
  End;

end;

Function TDm.ValidarPessoa(S:string;dt:TDate):Boolean;
var
Qry :TsqlQuery;
begin
  Result  := False;
  try
    Qry               := TSqlquery.Create(nil);
    Qry.SQLConnection :=Connect;

    with Qry do
    begin
      Close;
      sql.Clear;
      Sql.Add('Select Pes_nome from bs_pessoa where pes_nome= :nome and pes_datanasc= :dt');
      Params.ParamByName('nome').AsString   := S;
      Params.ParamByName('dt').AsDate       := Dt;

      Try
        Open;
        if not isempty then
        begin
          Result := True;
        end;

      Except on e:exception do
        raise Exception.Create('Erro:'+#13+e.Message)
      End;
      close;
    end;
  finally
    Qry.Free;
  end;
end;

Function TDm.ValidarultDoacao(id:integer):Tdate;
var
Qry :TsqlQuery;
begin

  try
    Qry               := TSqlquery.Create(nil);
    Qry.SQLConnection :=Connect;

    with Qry do
    begin
      Close;
      sql.Clear;
      Sql.Add('Select max(doa_data)as dt from bs_doacao where pes_id= :id');
      Params.ParamByName('id').AsInteger   := id;

      Try
        Open;
        if not isempty then
        begin
          Result := Fields[0].AsDateTime
        end
        else
          Result  := date -15;

      Except on e:exception do
        raise Exception.Create('Erro:'+#13+e.Message)
      End;
      close;
    end;
  finally
    Qry.Free;
  end;
end;

Function TDm.AnularDoacao(i:integer):boolean;
var
Qry :TsqlQuery;
begin
  Result  := False;
  try
    Qry               := TSqlquery.Create(nil);
    Qry.SQLConnection :=Connect;

    with Qry do
    begin
      Close;
      sql.Clear;
      Sql.Add('Update bs_doacao set doa_status=''A'' where doa_id= :id');
      Params.ParamByName('id').AsInteger   := i;

      Try
        ExecSql;
        Result  := True;

      Except on e:exception do
        raise Exception.Create('Erro:'+#13+e.Message)
      End;
      close;
    end;
  finally
    Qry.Free;
  end;
end;

end.
