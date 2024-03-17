unit UCadDoacao;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, UFormCadModelo, Data.DB, Data.FMTBcd,
  Data.SqlExpr, Datasnap.Provider, Datasnap.DBClient, System.Actions,
  Vcl.ActnList, System.ImageList, Vcl.ImgList, cxImageList, cxGraphics,
  Vcl.ComCtrls, Vcl.ToolWin, Vcl.Grids, Vcl.DBGrids, Vcl.StdCtrls, Vcl.Mask,
  Vcl.ExtCtrls, Vcl.DBCtrls,DateUtils;

type
  TFrm_CadManutencao = class(TFrm_ModeloPadrao)
    Label3: TLabel;
    edtCodigo: TDBEdit;
    Label4: TLabel;
    edtdata: TDBEdit;
    edtpessoa: TDBLookupComboBox;
    Label5: TLabel;
    edtqtde: TDBEdit;
    Label6: TLabel;
    dsPessoa: TDataSource;
    cds_consDOA_ID: TIntegerField;
    cds_consDOA_DATA: TSQLTimeStampField;
    cds_consDOA_QTDE: TFMTBCDField;
    cds_consDOA_STATUS: TStringField;
    cds_consPES_ID: TIntegerField;
    cds_consnnome: TStringField;
    cds_consnstatus: TStringField;
    edtanulada: TCheckBox;
    procedure A_novoExecute(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure edtqtdeKeyPress(Sender: TObject; var Key: Char);
    procedure a_salvarExecute(Sender: TObject);
    procedure EdtPesquisaChange(Sender: TObject);
    procedure a_excluirExecute(Sender: TObject);
    procedure A_editarExecute(Sender: TObject);
    procedure edtanuladaClick(Sender: TObject);
    procedure A_anularExecute(Sender: TObject);
  private
    procedure Pesquisa;
    { Private declarations }
  public
    { Public declarations }
  end;

var
  Frm_CadManutencao: TFrm_CadManutencao;

implementation

{$R *.dfm}

uses UDM;

procedure TFrm_CadManutencao.A_anularExecute(Sender: TObject);
begin
  inherited;
  if cds_consdoa_status.AsString='A' then
  begin
    showmessage('Processo de doação já anulada.');
    exit;
  end;

  if cds_consdoa_status.AsString = 'C' then
  begin
    if Dm.AnularDoacao(cds_consdoa_id.AsInteger) then
    pesquisa;
  end;
end;

procedure TFrm_CadManutencao.A_editarExecute(Sender: TObject);
begin
  inherited;

  if cds_consdoa_status.AsString <>'C' then
  begin
    Showmessage('Registro não pode ser editado.');
    exit;
  end;

  editar();
  Pesquisa;
end;

procedure TFrm_CadManutencao.a_excluirExecute(Sender: TObject);
begin
  inherited;
  if not (cds_cons.RecordCount >0) then
  begin
    Showmessage('Selecione um registro para excluir.');
    exit;
  end;

  if cds_consdoa_status.AsString<>'C' then
  begin
    Showmessage('Registro selecionado não pode ser excluido.');
    exit;
  end;


  Excluir;
  Pesquisa;
end;

procedure TFrm_CadManutencao.A_novoExecute(Sender: TObject);
begin
  inherited;
  dm.cds_doacaodoa_status.AsString  := 'C';
  dm.cds_doacaodoa_id.AsInteger     := DM.Numerador('BS_DOACAO','DOA_ID');
  dm.cds_doacaodoa_data.EditMask    := '##/##/####';
  dm.cds_doacaodoa_qtde.AsFloat     := 0.00;
end;

procedure TFrm_CadManutencao.a_salvarExecute(Sender: TObject);
var
Idade:Integer;
Qtdedoada:Double;
DtultDoacao:Tdate;
begin
  inherited;

  idade     := YearsBetween(Date, dm.cds_doacaoVIRTUAL_DATANASCIMENTO.AsDateTime);
  Qtdedoada := Strtofloatdef(edtqtde.Text,0);

  if (idade > 60) then
  begin
    Showmessage('Idade da pessoa não está dentro dos limites.');
    edtpessoa.SetFocus;
    exit;
  end;

  if Qtdedoada > 1.0 then
  begin
    Showmessage('Quantidade informada doada não pode exceder a 1 litro.');
    edtqtde.SetFocus;
    exit;
  end;

  if dm.cds_doacao.State in [dsInsert] then
  begin

    DtUltDoacao   := Dm.ValidarultDoacao(dm.cds_doacaopes_id.AsInteger);

    if DaysBetween(DtUltDoacao, Now) < 15 then
    begin
      Showmessage('Já exite uma doação recentemente.');
      exit;
    end;

    if dm.cds_doacaodoa_data.AsDateTime > Date then
    begin
      Showmessage('A data da doação não pode ser data futura.');
      edtdata.SetFocus;
      exit;
    end;

  end;
  salvar();
  Pesquisa;
end;

procedure TFrm_CadManutencao.edtanuladaClick(Sender: TObject);
begin
  inherited;
  Pesquisa;
end;

procedure TFrm_CadManutencao.EdtPesquisaChange(Sender: TObject);
begin
  inherited;
  Pesquisa;
end;

procedure TFrm_CadManutencao.edtqtdeKeyPress(Sender: TObject; var Key: Char);
begin
  inherited;
  if not (Key in ['0'..'9',',', #8]) then
  key  := #0;
end;

procedure TFrm_CadManutencao.FormShow(Sender: TObject);
begin
  inherited;
  dspessoa.DataSet.Close;
  dspessoa.DataSet.Open;


end;

Procedure TFrm_CadManutencao.Pesquisa;
var
Filtro, Ordem, parte:String;
begin
  Filtro  := '';
  ordem   := '';
  parte   := '';

  parte   := '%';
  ordem   := ' Order by doa_data';
  cds_cons.CommandText  := 'Select bs.*,  Case when bs.doa_status = ''C'' then '+
                          '''Concluído'''+
                          'else'+
                          '''Anulado'' end nstatus,  bp.pes_nome as nnome from BS_DOACAO BS '+
                            ' join BS_PESSOA BP                                '+
                            ' on bs.pes_id = bp.pes_id /*where*/';

  if Trim(edtpesquisa.Text) <> '' then
  case edtfiltro.ItemIndex of
    0: Filtro := ' where doa_id='+edtpesquisa.Text;
    1: Filtro := ' where pes_nome like ' + quotedstr(parte+edtpesquisa.Text +'%');
    2: Filtro := ' where pes_cpf like ' + quotedstr(parte+edtpesquisa.Text +'%');
  end;

  if edtanulada.Checked = True then
    Filtro    := Filtro + ' and doa_status=''A''';

  cds_cons.Close;
  cds_cons.CommandText  := StringReplace(cds_cons.CommandText, '/*where*/', Filtro + ordem,[rfreplaceAll]);
  cds_cons.Open;


end;

end.
