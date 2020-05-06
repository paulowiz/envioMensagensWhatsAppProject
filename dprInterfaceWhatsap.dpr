program dprInterfaceWhatsap;

uses
  Vcl.Forms,
  InterfaceWhatsapp in 'InterfaceWhatsapp.pas' {ufrmWhatsapp},
  chave in 'chave.pas' {ufrmChaves};

{$R *.res}

begin
  Application.Initialize;
  Application.MainFormOnTaskbar := True;
  //Application.CreateForm(TufrmWhatsapp, ufrmWhatsapp);
  Application.CreateForm(TufrmChaves, ufrmChaves);
  Application.Run;
end.
