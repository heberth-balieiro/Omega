unit UPrincipal;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, System.Actions, Vcl.ActnList,
  Vcl.ExtCtrls, Vcl.Menus, Vcl.Imaging.pngimage, Vcl.ComCtrls;

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
    Acao: TActionList;
    ActSair: TAction;
    ActPessoa: TAction;
    ActDoacao: TAction;
    ActRelDoacao: TAction;
    IMG: TImage;
    BarSistema: TStatusBar;
    procedure ActSairExecute(Sender: TObject);
    procedure ActPessoaExecute(Sender: TObject);
    procedure ActDoacaoExecute(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure ActRelDoacaoExecute(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  FrmPrincipal: TFrmPrincipal;

implementation

{$R *.dfm}

uses UCadPessoa, UCadDoacao, URelDoacao;

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

procedure TFrmPrincipal.ActRelDoacaoExecute(Sender: TObject);
begin
  Application.CreateForm(TFrm_RelDoacao, Frm_RelDoacao);
  Try
    Frm_RelDoacao.showmodal;
  Finally
    Frm_RelDoacao.release;
  End;
end;

procedure TFrmPrincipal.ActSairExecute(Sender: TObject);
begin
  if Application.MessageBox(PChar('Deseja sair do Sistema?'), 'Confirmação',
    MB_YESNO + MB_DEFBUTTON2 + MB_ICONQUESTION) = mrYes then
  begin
    Application.Terminate;
  end
  else
  Abort;
end;

procedure TFrmPrincipal.FormShow(Sender: TObject);
begin
  barsistema.Panels[0].Text   := 'Versão: 1.0.0.0';
  barsistema.Panels[1].Text   := 'Banco de Sangue';

end;

end.
