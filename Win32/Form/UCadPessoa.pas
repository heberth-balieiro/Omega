unit UCadPessoa;

interface

uses
  Winapi.Windows, Winapi.Messages, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, UFormCadModelo, Data.DB, Data.FMTBcd,
  Data.SqlExpr, Datasnap.Provider, Datasnap.DBClient, System.Actions,
  Vcl.ActnList, System.ImageList, Vcl.ImgList, cxImageList, cxGraphics,
  Vcl.ComCtrls, Vcl.ToolWin, Vcl.Grids, Vcl.DBGrids, Vcl.StdCtrls, Vcl.DBCtrls,
  Vcl.Mask, Vcl.ExtCtrls,DateUtils;

type
  TFrm_CadPessoa = class(TFrm_ModeloPadrao)
    Label3: TLabel;
    edtCodigo: TDBEdit;
    Label4: TLabel;
    edtNome: TDBEdit;
    Label5: TLabel;
    edtTipo: TDBComboBox;
    Label6: TLabel;
    edtEmail: TDBEdit;
    edtCelular: TDBEdit;
    Label7: TLabel;
    edtCPF: TDBEdit;
    Label8: TLabel;
    edtNascimento: TDBEdit;
    Label9: TLabel;
    cds_consPES_ID: TIntegerField;
    cds_consPES_NOME: TStringField;
    cds_consPES_DATANASC: TSQLTimeStampField;
    cds_consPES_TIPOSANG: TStringField;
    cds_consPES_EMAIL: TStringField;
    cds_consPES_CELULAR: TStringField;
    cds_consPES_CPF: TStringField;
    procedure A_novoExecute(Sender: TObject);
    procedure edtEmailKeyPress(Sender: TObject; var Key: Char);
    procedure EdtPesquisaChange(Sender: TObject);
    procedure a_salvarExecute(Sender: TObject);
    procedure a_excluirExecute(Sender: TObject);
    procedure A_editarExecute(Sender: TObject);
    procedure FormShow(Sender: TObject);
  private
    procedure Pesquisa;
    { Private declarations }
  public
    { Public declarations }
  end;

var
  Frm_CadPessoa: TFrm_CadPessoa;

implementation

{$R *.dfm}

uses UDM, System.SysUtils;

procedure TFrm_CadPessoa.A_editarExecute(Sender: TObject);
begin
  inherited;

  Editar();

end;

procedure TFrm_CadPessoa.a_excluirExecute(Sender: TObject);
begin
  inherited;
  excluir();
  Pesquisa;
end;

procedure TFrm_CadPessoa.A_novoExecute(Sender: TObject);
begin
  inherited;
  ds_cons.DataSet.Close;
  page.ActivePage     := tabdados;
  dm.cds_pessoapes_id.AsInteger := DM.Numerador('BS_PESSOA','PES_ID');
  dm.cds_pessoapes_cpf.EditMask := '###.###.###-##';
  dm.cds_pessoapes_celular.EditMask := '(##)#####-####';
  dm.cds_pessoapes_datanasc.EditMask := '##/##/####';
end;

procedure TFrm_CadPessoa.a_salvarExecute(Sender: TObject);
var
Nome:string;
nasc:TDateTime;
Idade:integer;
begin
  inherited;

      nome    := Trim(edtnome.Text);


      if Length(nome) <=5 then
      begin
        Showmessage('O Campo nome deve conter mais de 5 caracteres.');
        edtNome.SetFocus;
        exit;
      end;

      if dm.cds_pessoa.State in [dsInsert] then
      begin
        nasc    := dm.cds_pessoapes_datanasc.AsDateTime;
        if dm.ValidarPessoa(nome,
                            nasc
                            ) then
        begin
          showmessage('Pessoa j� cadastrado no sistema.');
          exit;
        end;


        idade := YearsBetween(Date, nasc);

        if (idade < 18) or (idade > 60) then
        begin
          Showmessage('Idade da pessoa n�o est� dentro dos limites.');
          exit;
        end;

      end;
      salvar();
      Pesquisa;
end;

procedure TFrm_CadPessoa.edtEmailKeyPress(Sender: TObject; var Key: Char);
begin
  inherited;
  if not (Key in ['A'..'Z', 'a'..'z','0'..'9','_','-','@','.', ')', #8]) then
  key  := #0;
end;

procedure TFrm_CadPessoa.EdtPesquisaChange(Sender: TObject);
begin
  inherited;
  Pesquisa;
end;

procedure TFrm_CadPessoa.FormShow(Sender: TObject);
begin
  inherited;
  ToolButton11.Visible  := False;
  ToolButton9.Visible := False;
  pesquisa;
end;

Procedure TFrm_CadPessoa.Pesquisa;
var
Filtro, Ordem, parte:String;
begin
  Filtro  := '';
  ordem   := '';
  parte   := '';

  parte   := '%';
  ordem   := ' Order by pes_nome';
  cds_cons.CommandText  := 'Select * from bs_pessoa /*where*/';

  if Trim(edtpesquisa.Text) <> '' then
  case edtfiltro.ItemIndex of
    0: Filtro := ' where pes_id='+edtpesquisa.Text;
    1: Filtro := ' where pes_cpf like ' + quotedstr(parte+edtpesquisa.Text +'%');
    2: Filtro := ' where pes_celular like ' + quotedstr(parte+edtpesquisa.Text +'%');
    3: Filtro := ' where pes_datanasc='+edtpesquisa.Text;
    4: Filtro := ' where pes_nome like ' + quotedstr(parte+edtpesquisa.Text +'%');
  end;


  cds_cons.Close;
  cds_cons.CommandText  := StringReplace(cds_cons.CommandText, '/*where*/', Filtro + ordem,[rfreplaceAll]);
  cds_cons.Open;


end;

end.
