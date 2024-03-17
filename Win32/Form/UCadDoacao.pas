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
    procedure A_novoExecute(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure edtqtdeKeyPress(Sender: TObject; var Key: Char);
    procedure a_salvarExecute(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  Frm_CadManutencao: TFrm_CadManutencao;

implementation

{$R *.dfm}

uses UDM;

procedure TFrm_CadManutencao.A_novoExecute(Sender: TObject);
begin
  inherited;
  dm.cds_doacaodoa_id.AsInteger := DM.Numerador('BS_DOACAO','DOA_ID');
  dm.cds_doacaodoa_data.EditMask := '##/##/####';
end;

procedure TFrm_CadManutencao.a_salvarExecute(Sender: TObject);
var
Idade:Integer;
Qtdedoada:Double;
begin
  inherited;

  idade     := YearsBetween(Date, dm.cds_doacaoVIRTUAL_DATANASCIMENTO.AsDateTime);
  Qtdedoada := Strtofloatdef(edtqtde.Text,0);

  if (idade > 60) then
  begin
    Showmessage('Idade da pessoa n�o est� dentro dos limites.');
    exit;
  end;

  if Qtdedoada > 1.0 then
  begin
    Showmessage('Quantidade informada doada n�o pode exceder a 1 litro.');
    exit;
  end;


end;

procedure TFrm_CadManutencao.edtqtdeKeyPress(Sender: TObject; var Key: Char);
begin
  inherited;
  if not (Key in ['0'..'9', #8]) then
  key  := #0;
end;

procedure TFrm_CadManutencao.FormShow(Sender: TObject);
begin
  inherited;
  dspessoa.DataSet.Close;
  dspessoa.DataSet.Open;


end;

end.