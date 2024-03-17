object FrmPrincipal: TFrmPrincipal
  Left = 0
  Top = 0
  Caption = 'EasyHealth - Banco de Sangue'
  ClientHeight = 612
  ClientWidth = 901
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -12
  Font.Name = 'Segoe UI'
  Font.Style = []
  Menu = Menu
  WindowState = wsMaximized
  TextHeight = 15
  object Panel1: TPanel
    Left = 0
    Top = 0
    Width = 901
    Height = 70
    Align = alTop
    BevelOuter = bvNone
    TabOrder = 0
    ExplicitWidth = 897
  end
  object Menu: TMainMenu
    Left = 16
    Top = 104
    object mnSistema: TMenuItem
      Caption = 'Sistema'
      object mnsair: TMenuItem
        Action = ActSair
      end
    end
    object mnArquivo: TMenuItem
      Caption = 'Arquivo'
      object mnPessoa: TMenuItem
        Action = ActPessoa
      end
    end
    object mnProcesso: TMenuItem
      Caption = 'Processo'
      object mnDoacao: TMenuItem
        Action = ActDoacao
      end
    end
    object mnRelatorio: TMenuItem
      Caption = 'Relat'#243'rio'
      object mnRelDoacao: TMenuItem
        Action = ActRelDoacao
      end
    end
  end
  object Acao: TActionList
    Left = 64
    Top = 104
    object ActSair: TAction
      Category = 'Sistema'
      Caption = 'Sair'
      OnExecute = ActSairExecute
    end
    object ActPessoa: TAction
      Category = 'Arquivo'
      Caption = 'Pessoa'
      OnExecute = ActPessoaExecute
    end
    object ActDoacao: TAction
      Category = 'Processo'
      Caption = 'Doa'#231#227'o'
      OnExecute = ActDoacaoExecute
    end
    object ActRelDoacao: TAction
      Category = 'Relat'#243'rio'
      Caption = 'Doa'#231#227'o'
    end
  end
end
