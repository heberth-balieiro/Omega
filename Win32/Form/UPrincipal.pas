unit UPrincipal;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, System.Actions, Vcl.ActnList,
  Vcl.ExtCtrls, Vcl.Menus;

type
  TFrmPrincipal = class(TForm)
    Menu: TMainMenu;
    mnSistema: TMenuItem;
    mnsair: TMenuItem;
    mnArquivo: TMenuItem;
    mnPessoa: TMenuItem;
    mnProcesso: TMenuItem;
    mnDoacao: TMenuItem;
    mnRelatorio: TMenuItem;
    mnRelDoacao: TMenuItem;
    Panel1: TPanel;
    Acao: TActionList;
    ActSair: TAction;
    ActPessoa: TAction;
    ActDoacao: TAction;
    ActRelDoacao: TAction;
    procedure ActSairExecute(Sender: TObject);
    procedure ActPessoaExecute(Sender: TObject);
    procedure ActDoacaoExecute(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  FrmPrincipal: TFrmPrincipal;

implementation

{$R *.dfm}

uses UCadPessoa, UCadDoacao;

procedure TFrmPrincipal.ActDoacaoExecute(Sender: TObject);
begin
  Application.CreateForm(TFrm_CadManutencao, Frm_CadManutencao);
  Try
    Frm_CadManutencao.showmodal;
  Finally
    Frm_CadManutencao.release;
  End;
end;

procedure TFrmPrincipal.ActPessoaExecute(Sender: TObject);
begin
  Application.CreateForm(TFrm_CadPessoa, Frm_CadPessoa);
  Try
    Frm_CadPessoa.showmodal;
  Finally
    Frm_CadPessoa.release;
  End;
end;

procedure TFrmPrincipal.ActSairExecute(Sender: TObject);
begin
  Close;
end;

end.
