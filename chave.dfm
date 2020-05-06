object ufrmChaves: TufrmChaves
  Left = 0
  Top = 0
  BorderIcons = [biSystemMenu, biMinimize]
  Caption = 'Registro do Sistema'
  ClientHeight = 130
  ClientWidth = 472
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  OldCreateOrder = False
  OnShow = FormShow
  PixelsPerInch = 96
  TextHeight = 13
  object lbl_chave: TLabel
    Left = 48
    Top = 32
    Width = 289
    Height = 13
  end
  object Button1: TButton
    Left = 350
    Top = 62
    Width = 97
    Height = 25
    Caption = 'Validar'
    TabOrder = 0
    OnClick = Button1Click
  end
  object edt_chave: TEdit
    Left = 48
    Top = 64
    Width = 249
    Height = 21
    TabOrder = 1
  end
end
