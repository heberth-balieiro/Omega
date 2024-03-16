unit UDM;

interface

uses
  System.SysUtils, System.Classes, Data.DBXMSSQL, Data.DB, Data.SqlExpr;

type
  TDM = class(TDataModule)
    Connect: TSQLConnection;
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  DM: TDM;

implementation

{%CLASSGROUP 'Vcl.Controls.TControl'}

{$R *.dfm}

end.
