unit UFormRelModelo;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.ComCtrls, Vcl.ToolWin,
  System.Actions, Vcl.ActnList, System.ImageList, Vcl.ImgList, cxImageList,
  cxGraphics, Vcl.ExtCtrls, frxExportCSV, frxExportDOCX, frxClass,
  frxExportBaseDialog, frxExportPDF, Data.DB, frxDBSet;

type
  TFrm_RelModeloPadrao = class(TForm)
    IMG: TcxImageList;
    Menu: TActionList;
    a_imprimir: TAction;
    a_fechar: TAction;
    ToolBar1: TToolBar;
    ToolButton8: TToolButton;
    ToolButton6: TToolButton;
    ToolButton7: TToolButton;
    Panel: TPanel;
    Relatorio: TfrxReport;
    frxRelatorio: TfrxDBDataset;
    ds: TDataSource;
    frxPDF: TfrxPDFExport;
    frxDOC: TfrxDOCXExport;
    frxCSV: TfrxCSVExport;
    procedure a_fecharExecute(Sender: TObject);
    procedure FormKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
    procedure FormKeyPress(Sender: TObject; var Key: Char);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  Frm_RelModeloPadrao: TFrm_RelModeloPadrao;

implementation

{$R *.dfm}

procedure TFrm_RelModeloPadrao.a_fecharExecute(Sender: TObject);
begin
  Close;
end;

procedure TFrm_RelModeloPadrao.FormClose(Sender: TObject;
  var Action: TCloseAction);
begin
  ds.DataSet.Close;
end;

procedure TFrm_RelModeloPadrao.FormKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  if key = VK_Escape then
  a_fechar.Execute;
end;

procedure TFrm_RelModeloPadrao.FormKeyPress(Sender: TObject; var Key: Char);
begin
  if Key = #13 then
  begin
    Key := #0;
    Perform(Wm_NextDlgCtl, 0, 0);
  end;
end;

end.
