unit chave;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.StdCtrls,interfaceWhatsapp;

type
  TufrmChaves = class(TForm)
    lbl_chave: TLabel;
    Button1: TButton;
    edt_chave: TEdit;
    procedure FormShow(Sender: TObject);
    procedure Button1Click(Sender: TObject);
  private
    { Private declarations }
    validado :String;
  public
    { Public declarations }
  end;

var
  ufrmChaves: TufrmChaves;


implementation

{$R *.dfm}




procedure TufrmChaves.Button1Click(Sender: TObject);
var
FormWhatsap : TufrmWhatsapp;
begin
   if edt_chave.Text = 'Paulo' then
   begin
     ShowMessage('Chave Validada com Sucesso!');
     validado := 'S';
     Try
     ufrmChaves.Visible:= False;
     FormWhatsap := TufrmWhatsapp.Create(nil);
     FormWhatsap.ShowModal;

     Finally
       FormWhatsap.Release;
       FormWhatsap.Destroy;
       Close;
     End;

   end else
   begin
     ShowMessage('Chave Inválida! Favor digitar uma chave válida');
     validado := 'N';
     edt_chave.SetFocus;

   end;

end;

procedure TufrmChaves.FormShow(Sender: TObject);
begin
  lbl_chave.Caption := 'Digite a chave do sistema pra continuar: ';
  validado := 'N';
end;

end.
