program Easyhealth;

uses
  Vcl.Forms,
  UPrincipal in '..\Win32\Form\UPrincipal.pas' {FrmPrincipal},
  UDM in '..\Win32\DM\UDM.pas' {DM: TDataModule},
  UFormCadModelo in '..\Win32\FormModelo\UFormCadModelo.pas' {Frm_ModeloPadrao},
  UAcaoForm in '..\Win32\Units\UAcaoForm.pas';

{$R *.res}

begin
  Application.Initialize;
  Application.MainFormOnTaskbar := True;
  Application.CreateForm(TFrmPrincipal, FrmPrincipal);
  Application.CreateForm(TDM, DM);
  Application.CreateForm(TFrm_ModeloPadrao, Frm_ModeloPadrao);
  Application.Run;
end.
