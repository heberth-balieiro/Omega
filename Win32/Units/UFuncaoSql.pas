unit UFuncaoSql;

interface

uses
  windows, Forms, Controls, SysUtils, SqlExpr, DBGrids, Grids, Graphics, ComCtrls, Classes;

type
  TFuncaoSql = class
    public
      class procedure CorGrid(Sender: TObject; const Rect: TRect; DataCol: Integer; Column: TColumn;
      State: TGridDrawState; Color: TColor);
    class function MontarSql(objeto: TObject) : String; overload;
  end;

implementation

{ TFuncaoSql }

class procedure TFuncaoSql.CorGrid(Sender: TObject; const Rect: TRect;
  DataCol: Integer; Column: TColumn; State: TGridDrawState; Color: TColor);
begin

end;

class function TFuncaoSql.MontarSql(objeto: TObject): String;
var
	VPoFinal  : Integer;
	VCorpoSQL      : String;
	VSqlComponents : String;
begin
	VSqlComponents := TSQLDataSet(objeto).CommandText;
	VPoFinal        := POS(' WHERE', UpperCase(VSqlComponents)) - 1;
	if (VPoFinal <= 0) then
		VPoFinal := length(VSqlComponents);
	VCorpoSQL := Copy(VSqlComponents, 1, VPoFinal ) + ' ' ;
	Result := VCorpoSQL;
end;

end.
