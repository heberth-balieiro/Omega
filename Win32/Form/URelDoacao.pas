unit URelDoacao;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, UFormRelModelo, frxExportCSV,
  frxExportDOCX, frxClass, frxExportBaseDialog, frxExportPDF, Data.DB, frxDBSet,
  System.Actions, Vcl.ActnList, System.ImageList, Vcl.ImgList, cxImageList,
  cxGraphics, Vcl.ExtCtrls, Vcl.ComCtrls, Vcl.ToolWin, Vcl.StdCtrls, Vcl.Mask,
  Vcl.DBCtrls;

type
  TFrm_RelDoacao = class(TFrm_RelModeloPadrao)
    GroupBox1: TGroupBox;
    Label1: TLabel;
    Label2: TLabel;
    edtPessoa: TComboBox;
    Label5: TLabel;
    Label6: TLabel;
    edtDataInicial: TEdit;
    edtDataFinal: TEdit;
    edtTipo: TComboBox;
    Label7: TLabel;
    edtRelatorio: TComboBox;
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  Frm_RelDoacao: TFrm_RelDoacao;

implementation

{$R *.dfm}

uses UDM;

end.
