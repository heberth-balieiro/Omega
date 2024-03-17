unit URelDoacao;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, UFormRelModelo, frxExportCSV,
  frxExportDOCX, frxClass, frxExportBaseDialog, frxExportPDF, Data.DB, frxDBSet,
  System.Actions, Vcl.ActnList, System.ImageList, Vcl.ImgList, cxImageList,
  cxGraphics, Vcl.ExtCtrls, Vcl.ComCtrls, Vcl.ToolWin, Vcl.StdCtrls, Vcl.Mask,
  Vcl.DBCtrls,System.DateUtils;

type
  TFrm_RelDoacao = class(TFrm_RelModeloPadrao)
    GroupBox1: TGroupBox;
    Label1: TLabel;
    Label2: TLabel;
    edtPessoa: TComboBox;
    Label5: TLabel;
    Label6: TLabel;
    edtTipo: TComboBox;
    Label7: TLabel;
    edtRelatorio: TComboBox;
    edtdatainicial: TDateTimePicker;
    edtdatafinal: TDateTimePicker;
    edtPeriodo: TCheckBox;
    Report: TfrxReport;
    dspessoa: TDataSource;
    procedure FormShow(Sender: TObject);
    procedure a_imprimirExecute(Sender: TObject);
    procedure edtPeriodoClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure edtTipoKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure edtPessoaKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
  private
    { Private declarations }
    Procedure GerarRelatorio;
    Procedure ValidarFiltroData;
    Procedure CarregarComboPessoa;
  public
    { Public declarations }
  end;

var
  Frm_RelDoacao: TFrm_RelDoacao;

implementation

{$R *.dfm}

uses UDM;

procedure TFrm_RelDoacao.a_imprimirExecute(Sender: TObject);
begin
  inherited;
  if edtRelatorio.ItemIndex =-1 then
  begin
    showmessage('Selecione um modelo de relatório.');
    edtRelatorio.SetFocus;
    exit;
  end;


  GerarRelatorio;
end;

procedure TFrm_RelDoacao.CarregarComboPessoa;
var StringList  : TStringList;
begin
  StringList  := TStringList.Create;

  Try
    edtPessoa.Clear;

    dm.cds_listPessoa.Close;
    dm.cds_listPessoa.Open;
    dm.cds_listPessoa.First;

    while not dm.cds_listPessoa.Eof do
    begin
      stringList.AddObject(dspessoa.DataSet.FieldByName('pes_nome').AsString, Tobject(dspessoa.DataSet.FieldByName('pes_id').AsInteger));
      dm.cds_listPessoa.Next;
    end;

    edtPessoa.Items   := Stringlist;

  Finally
    Stringlist.free;
  End;

end;

procedure TFrm_RelDoacao.edtPeriodoClick(Sender: TObject);
begin
  inherited;
  ValidarFiltroData
end;

procedure TFrm_RelDoacao.edtPessoaKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  inherited;
  if Key = Vk_delete then
  edtpessoa.ItemIndex := -1;
end;

procedure TFrm_RelDoacao.edtTipoKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  inherited;
  if Key = Vk_delete then
  edttipo.ItemIndex := -1;
end;

procedure TFrm_RelDoacao.FormCreate(Sender: TObject);
begin
  inherited;
  CarregarComboPessoa;
end;

procedure TFrm_RelDoacao.FormShow(Sender: TObject);
begin
  inherited;
  ValidarFiltroData;
  edtdatainicial.Date   := StartOfTheMonth(Date);
  edtdatafinal.date     := date;
end;

procedure TFrm_RelDoacao.GerarRelatorio;
var
Filtro, Filtro1:String;
DTIni, DTFim: TDate;
idpessoa:integer;
begin
  Filtro      := '';
  Filtro1     := '';


  dm.cds_RelDoacao.commandText  := 'Select                  '+
                          ' SUM(bd.DOA_QTDE) as quantidade, '+
                          ' BP.PES_TIPOSANG                 '+
                          ' from                            '+
                          ' BS_DOACAO BD                    '+
                          ' join                            '+
                          ' BS_PESSOA BP                    '+
                          ' on bd.PES_ID = BP.PES_ID        '+
                          ' and bd.doa_status=''C''       '+
                          ' /*where*/'                       +
                          ' Group by                        '+
                          ' bp.PES_TIPOSANG                 '+
                          ' order by                        '+
                          ' SUM(BD.doa_qtde) DESC'          ;

  Try
    if edtperiodo.Checked then
    Filtro1 := ' and bd.doa_data between '+QuotedStr(formatdatetime('mm/dd/yyyy', edtdatainicial.date)) +
               ' and '+QuotedStr(formatdatetime('mm/dd/yyyy',edtdatafinal.Date));

    if edtTipo.ItemIndex <> -1 then
    Filtro  := ' and bp.pes_tiposang='+quotedstr(edttipo.Text);

    if edtPessoa.ItemIndex <> -1 then
    begin
      idpessoa      := Integer(edtpessoa.Items.Objects[edtpessoa.ItemIndex]);
      Filtro  := Filtro + ' and bd.pes_id='+inttostr(idpessoa);
    end;

    dm.cds_reldoacao.close;

    if edtperiodo.Checked then
    begin
      DTIni := edtdatainicial.Date;
      DTFim := edtdatafinal.Date;
    end;

    dm.cds_RelDoacao.commandText  := StringReplace(dm.cds_RelDoacao.commandText,
     '/*where*/', Filtro + filtro1, [rfreplaceAll]);

    dm.cds_reldoacao.open;

    if not dm.cds_reldoacao.IsEmpty then
    begin
      Report.LoadFromFile(dm.nDir +'\Relatorio\RelListagemDoacao.fr3');
      Report.ShowReport;
    end
    else
    Showmessage('Nenhum registro encontrado.');

  Except on e:exception do
    raise Exception.Create('Erro:'+#13+e.Message);
  End;

end;

procedure TFrm_RelDoacao.ValidarFiltroData;
begin
  if edtperiodo.Checked then
  begin
    edtdatainicial.Enabled  := True;
    edtdatafinal.Enabled    := True;
  end
  else
  begin
    edtdatainicial.Enabled  := False;
    edtdatafinal.Enabled    := False;
  end;
end;

end.
