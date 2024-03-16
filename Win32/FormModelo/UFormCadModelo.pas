unit UFormCadModelo;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.ComCtrls, Data.DB, Data.FMTBcd,
  Data.SqlExpr, Datasnap.Provider, Datasnap.DBClient, Vcl.Grids, Vcl.DBGrids,
  Vcl.StdCtrls, Vcl.ToolWin, System.Actions, Vcl.ActnList, System.ImageList,
  Vcl.ImgList, cxImageList, cxGraphics,
  UAcaoForm;

type
  TFrm_ModeloPadrao = class(TForm)
    Page: TPageControl;
    IMG: TcxImageList;
    Menu: TActionList;
    A_novo: TAction;
    A_editar: TAction;
    a_excluir: TAction;
    a_consulta: TAction;
    a_cancelar: TAction;
    a_salvar: TAction;
    a_fechar: TAction;
    ToolBar1: TToolBar;
    ToolButton8: TToolButton;
    ToolButton2: TToolButton;
    ToolButton3: TToolButton;
    ToolButton4: TToolButton;
    ToolButton9: TToolButton;
    ToolButton1: TToolButton;
    ToolButton10: TToolButton;
    ToolButton5: TToolButton;
    ToolButton6: TToolButton;
    ToolButton7: TToolButton;
    TabDados: TTabSheet;
    TabConsulta: TTabSheet;
    Group_filtro: TGroupBox;
    EdtFiltro: TComboBox;
    EdtPesquisa: TEdit;
    Label1: TLabel;
    Label2: TLabel;
    DBGrid: TDBGrid;
    ds_cons: TDataSource;
    cds_cons: TClientDataSet;
    dsp_Cons: TDataSetProvider;
    Sql_Cons: TSQLDataSet;
    ds: TDataSource;
    procedure a_salvarUpdate(Sender: TObject);
    procedure A_novoUpdate(Sender: TObject);
    procedure A_editarExecute(Sender: TObject);
    procedure A_novoExecute(Sender: TObject);
    procedure a_excluirExecute(Sender: TObject);
    procedure a_consultaExecute(Sender: TObject);
    procedure a_cancelarExecute(Sender: TObject);
    procedure a_salvarExecute(Sender: TObject);
    procedure a_fecharExecute(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure FormKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
    procedure FormKeyPress(Sender: TObject; var Key: Char);
    procedure FormShow(Sender: TObject);
  private


  Protected
    FAcao         : TAcaoForm;
    FRegistro     : TBookmark;
    FComponente   : TWinControl;
  public
    Procedure Editar; Virtual;
    Procedure Novo; Virtual;
    Procedure Excluir; virtual;
    Procedure Consultar; virtual;
    Procedure Cancelar; virtual;
    Procedure Pesquisa; virtual;
    Procedure Salvar; virtual;
    Procedure Campos(Acoes:Boolean);
    { Public declarations }
  end;

var
  Frm_ModeloPadrao: TFrm_ModeloPadrao;

implementation

{$R *.dfm}


procedure TFrm_ModeloPadrao.a_cancelarExecute(Sender: TObject);
begin
  self.Cancelar();
end;

procedure TFrm_ModeloPadrao.a_consultaExecute(Sender: TObject);
begin
  self.Consultar();
end;

procedure TFrm_ModeloPadrao.A_editarExecute(Sender: TObject);
begin
  self.editar();
end;

procedure TFrm_ModeloPadrao.a_excluirExecute(Sender: TObject);
begin
 self.Excluir();
end;

procedure TFrm_ModeloPadrao.a_fecharExecute(Sender: TObject);
begin
  Close;
end;

procedure TFrm_ModeloPadrao.A_novoExecute(Sender: TObject);
begin
  self.Novo();
end;

procedure TFrm_ModeloPadrao.A_novoUpdate(Sender: TObject);
begin
  TAction(Sender).Enabled := ds.DataSet.State in [dsInactive, dsBrowse];
end;

procedure TFrm_ModeloPadrao.a_salvarExecute(Sender: TObject);
begin
  self.salvar();
end;

procedure TFrm_ModeloPadrao.a_salvarUpdate(Sender: TObject);
begin
  TAction(Sender).Enabled := ds.DataSet.State in [dsInsert, dsEdit];
end;

procedure TFrm_ModeloPadrao.Campos(Acoes: Boolean);
begin

end;

procedure TFrm_ModeloPadrao.Cancelar;
begin
  TclientDataset(ds.DataSet).CancelUpdates;
  Page.ActivePage     := TabConsulta;

  if Assigned(self.DBGrid) then
  self.DBGrid.SetFocus;

  self.EdtPesquisa.Clear();
  self.EdtPesquisa.SetFocus;

end;

procedure TFrm_ModeloPadrao.Consultar;
begin

end;

procedure TFrm_ModeloPadrao.Editar;
begin

  Self.FAcao      := UAcaoForm.AcEditar;

  Try

    Self.FRegistro  := TClientdataset(ds_cons.DataSet).GetBookmark;
    Self.Campos(True);

    if not ds_cons.DataSet.IsEmpty then
    begin

      ds.DataSet.Close;
      TClientDataset(ds.DataSet).Params[0].AsInteger  := ds_cons.DataSet.Fields[0].AsInteger;
      ds.DataSet.Open;

      if assigned(self.DBGrid) then
      self.DBGrid.SetFocus;

      page.ActivePage   := Tabdados;
      ds.DataSet.Edit;

      if Assigned(self.Fcomponente) then
      self.Fcomponente.setfocus();

    end;

  Except on e:exception do
    raise Exception.Create('Erro:'+#13+e.Message);
  End;

end;

procedure TFrm_ModeloPadrao.Excluir;
begin
  Self.FAcao    := UAcaoForm.AcExcluir;

  Try
    ds.DataSet.Close;
    TClientDataset(ds.DataSet).Params[0].AsInteger  := ds_cons.DataSet.Fields[0].AsInteger;
    ds.DataSet.Open;


  except on e:exception do
    raise Exception.Create('Erro:'+#13+e.Message);
  End;

end;

procedure TFrm_ModeloPadrao.FormClose(Sender: TObject;
  var Action: TCloseAction);
begin
  if ds.DataSet.Active then
  ds.DataSet.Close;

  frm_modeloPadrao:= nil;
end;

procedure TFrm_ModeloPadrao.FormKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  if key = VK_Escape then
  a_fechar.Execute;
end;

procedure TFrm_ModeloPadrao.FormKeyPress(Sender: TObject; var Key: Char);
begin

  if Key = #13 then
  begin
    Key := #0;
    Perform(Wm_NextDlgCtl, 0, 0);
  end;

end;

procedure TFrm_ModeloPadrao.FormShow(Sender: TObject);
begin
  page.ActivePage   := TabConsulta;
  edtpesquisa.SetFocus;

end;

procedure TFrm_ModeloPadrao.Novo;
begin

end;

procedure TFrm_ModeloPadrao.Pesquisa;
begin

end;

procedure TFrm_ModeloPadrao.Salvar;
begin

end;

end.
