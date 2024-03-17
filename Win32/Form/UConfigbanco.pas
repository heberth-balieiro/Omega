unit UConfigbanco;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, System.Actions, Vcl.ActnList,
  System.ImageList, Vcl.ImgList, cxImageList, cxGraphics, Vcl.StdCtrls,
  Vcl.ExtCtrls, Vcl.ComCtrls, Vcl.ToolWin, Vcl.Mask, Vcl.Buttons;

type
  TFrm_Configbanco = class(TForm)
    IMG: TcxImageList;
    Menu: TActionList;
    a_salvar: TAction;
    a_fechar: TAction;
    ToolBar1: TToolBar;
    ToolButton8: TToolButton;
    ToolButton6: TToolButton;
    ToolButton7: TToolButton;
    Panel1: TPanel;
    GroupBox1: TGroupBox;
    Label1: TLabel;
    edtServer: TEdit;
    Label2: TLabel;
    edtBase: TEdit;
    Label3: TLabel;
    edtUsuario: TEdit;
    Label4: TLabel;
    edtSenha: TMaskEdit;
    procedure FormShow(Sender: TObject);
    procedure a_fecharExecute(Sender: TObject);
    procedure a_salvarExecute(Sender: TObject);
    procedure FormKeyPress(Sender: TObject; var Key: Char);
  private
    { Private declarations }
    Procedure CarregarArquivo;
  public
    { Public declarations }
  end;

var
  Frm_Configbanco: TFrm_Configbanco;

implementation

{$R *.dfm}

Uses UDm;

{ TFrm_Configbanco }

procedure TFrm_Configbanco.a_fecharExecute(Sender: TObject);
begin
  close;
end;

procedure TFrm_Configbanco.a_salvarExecute(Sender: TObject);
begin
  try

    if edtserver.Text = '' then
    begin
      showmessage('Campo server obrigat�rio.');
      edtserver.SetFocus;
      exit;
    end;

    if edtbase.Text='' then
    begin
      showmessage('Campo Database obrigat�rio.');
      edtbase.SetFocus;
      exit;
    end;

    if edtusuario.Text = '' then
    begin
      showmessage('Campo usu�rio obrigat�rio.');
      edtusuario.SetFocus;
      exit;
    end;

    if edtsenha.Text = '' then
    begin
      showmessage('Campo senha obrigat�rio.');
      edtsenha.SetFocus;
      exit;
    end;

    dm.GravarValorIni(dm.nDir+'\Banco.ini','Conexao', 'HostName', Trim(edtserver.Text));
    dm.GravarValorIni(dm.nDir+'\Banco.ini','Conexao', 'DataBase', Trim(edtbase.Text));
    dm.GravarValorIni(dm.nDir+'\Banco.ini','Conexao', 'User', Trim(edtusuario.Text));
    dm.GravarValorIni(dm.nDir+'\Banco.ini','Conexao', 'Password', dm.crypt('C', edtsenha.Text));
    dm.CarregarConexao;
    dm.ConfigBanco(dm.Connect);
    Close;

  Except on e:exception do
    raise Exception.Create('Error:'+#13+e.Message);
  end;
end;

procedure TFrm_Configbanco.CarregarArquivo;
begin
  Try
    edtserver.Text      := dm.LerValorIni(dm.nDir+'\Banco.ini','Conexao','HostName','');
    edtBase.Text        := dm.LerValorIni(dm.nDir+'\Banco.ini','Conexao','DataBase','');
    edtusuario.Text     := dm.LerValorIni(dm.nDir+'\Banco.ini','Conexao','User','');
    edtSenha.Text       := dm.crypt('D', dm.LerValorIni(dm.nDir+'\Banco.ini','Conexao','Password',''));
  Except on e:exception do
    raise Exception.Create('Error:'+#13+e.Message);
  End;
end;

procedure TFrm_Configbanco.FormKeyPress(Sender: TObject; var Key: Char);
begin
  if Key = #13 then
  begin
    Key := #0;
    Perform(Wm_NextDlgCtl, 0, 0);
  end;
end;

procedure TFrm_Configbanco.FormShow(Sender: TObject);
begin
  CarregarArquivo;
end;

end.
