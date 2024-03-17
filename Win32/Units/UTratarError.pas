unit UTratarError;

interface

Uses
  DbClient, Sysutils;


Type
  TTratarError  =  Class
    Private
      class var FMensagemErroApplyupdate:string;
    public
      class procedure Handlereconcileerror(mensage:string; var Acao  :Treconcileaction);
      class function execute(mensage:string):string;
      class function getMensagemerroaplyupdate:string;
  End;

  var
  Tratarerror:TTratarError;

implementation

{ TTratarError }

class function TTratarError.execute(mensage: string): string;
var
  VAction: TReconcileAction;
begin
  Self.HandleReconcileError(Mensage, VAction);
  Result := Self.getMensagemerroaplyupdate();
end;

class function TTratarError.getMensagemerroaplyupdate: string;
begin
  Result := Self.FMensagemErroApplyUpdate;
end;

class procedure TTratarError.Handlereconcileerror(mensage: string;
  var Acao: Treconcileaction);
var
  PInicial: Integer;
  PFinal: Integer;
begin
  Acao := raAbort;
  FMensagemErroApplyUpdate := Mensage;
  if Pos('PRIMARY OR UNIQUE KEY', UpperCase(Mensage)) > 0 then
  begin
    PInicial := Pos('PK_', UpperCase(Mensage));
    if (PInicial = 0) then
    begin
      PInicial := Pos('UNQ_', UpperCase(Mensage));
    end;
    PFinal := Pos('ON TABLE', UpperCase(Mensage)) - 2;
    FMensagemErroApplyUpdate := 'Violação de chave primária. ' +
      Copy(Mensage, PInicial, (PFinal - PInicial));
  end
  else
  if Pos('FOREIGN KEY', UpperCase(Mensage)) > 0 then
  begin
    PInicial := Pos('FK_', UpperCase(Mensage));
    PFinal := Pos('ON TABLE', UpperCase(Mensage)) - 2;
    FMensagemErroApplyUpdate := 'Violação de chave estrangeira. ' +
      Copy(Mensage, PInicial, (PFinal - PInicial));
  end;
end;

end.
