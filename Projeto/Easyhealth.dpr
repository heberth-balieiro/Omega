program Easyhealth;

uses
  Vcl.Forms,
  UPrincipal in '..\Win32\Form\UPrincipal.pas' {FrmPrincipal},
  UDM in '..\Win32\DM\UDM.pas' {DM: TDataModule},
  UFormCadModelo in '..\Win32\FormModelo\UFormCadModelo.pas' {Frm_ModeloPadrao},
  UAcaoForm in '..\Win32\Units\UAcaoForm.pas',
  UException in '..\Win32\Units\UException.pas',
  UTratarError in '..\Win32\Units\UTratarError.pas',
  UConfigbanco in '..\Win32\Form\UConfigbanco.pas' {Frm_Configbanco},
  UCadPessoa in '..\Win32\Form\UCadPessoa.pas' {Frm_CadPessoa},
  UCadDoacao in '..\Win32\Form\UCadDoacao.pas' {Frm_CadManutencao},
  UFormRelModelo in '..\Win32\FormModelo\UFormRelModelo.pas' {Frm_RelModeloPadrao},
  URelDoacao in '..\Win32\Form\URelDoacao.pas' {Frm_RelDoacao};

{$R *.res}

begin
  Application.Initialize;
  Application.MainFormOnTaskbar := True;
  Application.CreateForm(TDM, DM);
  Application.CreateForm(TFrmPrincipal, FrmPrincipal);
  Application.Run;
end.
