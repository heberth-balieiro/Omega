unit UDM;

interface

uses
  System.SysUtils, System.Classes, Data.DBXMSSQL, Data.DB, Data.SqlExpr,
  System.IniFiles, Data.DBXOdbc, Data.FMTBcd, Datasnap.Provider,
  Datasnap.DBClient, Forms;

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
    cds_RelDoacao: TClientDataSet;
    dsp_RelDoacao: TDataSetProvider;
    sds_RelDoacao: TSQLDataSet;
    cds_RelDoacaoquantidade: TFMTBCDField;
    cds_RelDoacaoPES_TIPOSANG: TStringField;
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
    Function ConfigBanco(Connection:Tsqlconnection):Boolean;
    procedure CarregarConexao;
    Property Drivername :String read  FDrivername write Fdrivername;
    property Hostname   :string read  Fhostname   write Fhostname;
    property Database   :String read  fdatabase   write Fdatabase;
    property user       :string read  Fuser       write Fuser;
    property pass       :string read  Fpass       write Fpass;
    function Numerador(Tabela, Campo: String): Integer;
    function ValidarPessoa(S:string;dt:tdate): Boolean;
    function ValidarultDoacao(id: integer): Tdate;
    function AnularDoacao(i: integer): boolean;
    function Crypt(Action, Src: String): String;
  end;

var
  DM: TDM;

implementation

uses
  Vcl.Dialogs, UConfigbanco;

{%CLASSGROUP 'Vcl.Controls.TControl'}

{$R *.dfm}

function TDM.Crypt(Action, Src: String): String;
Label Fim;
var
  KeyLen: Integer;
  KeyPos: Integer;
  OffSet: Integer;
  Dest, Key, KeyNew: String;
  SrcPos: Integer;
  SrcAsc: Integer;
  TmpSrcAsc: Integer;
  Range: Integer;
begin
  if (Src = '') Then
  begin
    Result := '';
    Goto Fim;
  end;
  Key := 'XNGREXCPAJHKQWERYTUIOP98756LKJHASFGMNBVCAXZ13450';
  KeyNew := 'PRODOXCPAJHKQWERYTUIOP98765LKJHASFGMNBVCAXZ01234';
  Dest := '';
  KeyLen := Length(Key);
  KeyPos := 0;
  SrcPos := 0;
  SrcAsc := 0;
  Range := 128;
  if (Action = UpperCase('C')) then
  begin

    OffSet := Range;
    Dest := Format('%1.2x', [OffSet]);
    for SrcPos := 1 to Length(Src) do
    begin
      Application.ProcessMessages;
      SrcAsc := (Ord(Src[SrcPos]) + OffSet) Mod 255;
      if KeyPos < KeyLen then
        KeyPos := KeyPos + 1
      else
        KeyPos := 1;
      SrcAsc := SrcAsc Xor Ord(Key[KeyPos]);
      Dest := Dest + Format('%1.2x', [SrcAsc]);
      OffSet := SrcAsc;
    end;
  end
  Else if (Action = UpperCase('D')) then
  begin
    OffSet := StrToInt('$' + copy(Src, 1, 2));
    // <--------------- adiciona o $ entra as aspas simples
    SrcPos := 3;
    repeat
      SrcAsc := StrToInt('$' + copy(Src, SrcPos, 2));
      // <--------------- adiciona o $ entra as aspas simples
      if (KeyPos < KeyLen) Then
        KeyPos := KeyPos + 1
      else
        KeyPos := 1;
      TmpSrcAsc := SrcAsc Xor Ord(Key[KeyPos]);
      if TmpSrcAsc <= OffSet then
        TmpSrcAsc := 255 + TmpSrcAsc - OffSet
      else
        TmpSrcAsc := TmpSrcAsc - OffSet;
      Dest := Dest + Chr(TmpSrcAsc);
      OffSet := SrcAsc;
      SrcPos := SrcPos + 2;
    until (SrcPos >= Length(Src));
  end;
  Result := Dest;
Fim:
end;

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

Function TDM.ConfigBanco(Connection: Tsqlconnection):Boolean;
begin
  Result  := False;
  Try

    Connect.DriverName                  := 'MSSQL';
    Connect.Params.Values['HostName']   := Trim(hostname);
    Connect.Params.Values['Database']   := Trim(database);
    Connect.Params.Values['User_Name']  := Trim(user);
    Connect.Params.Values['Password']   := crypt('D', Pass);
    Connect.Connected := True;
    Result  := True;
  Except on e:Exception do
    begin
      showmessage('Error de conexão com o banco de dados:'+#13+e.Message);

      Frm_Configbanco := TFrm_Configbanco.Create(Application);
      Try
        Frm_Configbanco.showmodal;
      Finally
        Frm_Configbanco.release;
      End;
    end;
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

Procedure TDm.CarregarConexao;
begin
    nDir              := ExtractFilePath(ParamStr(0));

    Drivername      := LerValorIni(nDir+'\Banco.ini', 'Conexao', 'DriverName', '');
    Hostname        := LerValorIni(nDir+'\Banco.ini', 'Conexao', 'HostName', '');
    Database        := LerValorIni(nDir+'\Banco.ini', 'Conexao', 'DataBase', '');
    user            := LerValorIni(nDir+'\Banco.ini', 'Conexao', 'User', '');
    pass            := LerValorIni(nDir+'\Banco.ini', 'Conexao', 'Password', '');
end;

procedure TDM.DataModuleCreate(Sender: TObject);
begin

    CarregarConexao;
    Try
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
