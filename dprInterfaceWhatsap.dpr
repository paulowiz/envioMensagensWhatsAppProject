program dprInterfaceWhatsap;

uses
  Vcl.Forms,
  InterfaceWhatsapp in 'InterfaceWhatsapp.pas' {ufrmWhatsapp};

{$R *.res}

begin
  Application.Initialize;
  Application.MainFormOnTaskbar := True;
  Application.CreateForm(TufrmWhatsapp, ufrmWhatsapp);
  Application.Run;
end.
