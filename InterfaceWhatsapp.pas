unit InterfaceWhatsapp;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.StdCtrls, Vcl.ExtCtrls,
  Vcl.Imaging.pngimage, Vcl.Imaging.jpeg, Vcl.Grids,ComObj, Vcl.CategoryButtons,
  System.ImageList, Vcl.ImgList,ShellApi,DateUtils;


type
  TufrmWhatsapp = class(TForm)
    pnl_header: TPanel;
    pnl_bottom: TPanel;
    pnl_body: TPanel;
    lbl_data: TLabel;
    lbl_title: TLabel;
    GroupBox1: TGroupBox;
    OpenDialog1: TOpenDialog;
    lbl_grid: TLabel;
    grp_mensagem: TGroupBox;
    memo: TMemo;
    Timer1: TTimer;
    Panel1: TPanel;
    lbl_numeros: TLabel;
    img_file: TImage;
    grp_path: TGroupBox;
    lista_grid: TStringGrid;
    grp_msg: TGroupBox;
    memo_mensagem: TMemo;
    btn_enviar: TButton;
    grp_logs: TGroupBox;
    memo_logs: TMemo;
    lbl_developer: TLabel;
    edit_path: TEdit;
    img_linkedin: TImage;
    GroupBox2: TGroupBox;
    edt_coutry_code: TEdit;
    procedure Image1Click(Sender: TObject);
    procedure Timer1Timer(Sender: TObject);
    procedure btn_enviarClick(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure geraTxt;
    procedure img_linkedinClick(Sender: TObject);
    procedure img_linkedinMouseMove(Sender: TObject; Shift: TShiftState; X,
      Y: Integer);
    procedure btn_enviarMouseMove(Sender: TObject; Shift: TShiftState; X,
      Y: Integer);
    procedure img_fileMouseMove(Sender: TObject; Shift: TShiftState; X,
      Y: Integer);
  private
    { Private declarations }
    codigo :Integer;
    function EhNumero(S: string): Boolean;
    function RemoveCaracter(str: string):string;
    Function XlsToStringGrid(xStringGrid: TStringGrid; xFileXLS: string): Boolean;
  public
    { Public declarations }
  end;

var
  ufrmWhatsapp: TufrmWhatsapp;

implementation

{$R *.dfm}

function TufrmWhatsapp.RemoveCaracter(str: string):string;
var
   x: integer;
   st: string;
begin
st:='';
for x:=1 to length(str) do
    begin
    if (str[x] <> '-') and
       (str[x] <> '.') and
       (str[x] <> ',') and
       (str[x] <> '-') and
       (str[x] <> '(') and
       (str[x] <> ')') and
       (str[x] <> '_') and
       (str[x] <> '/') and
       (str[x] <> '#') and
       (str[x] <> '*') and
       (str[x] <> ' ') then
    st:=st + str[x];
    end;

st := stringReplace(st, #$A, '', [rfReplaceAll]);
Result:=st;
end;

procedure TufrmWhatsapp.btn_enviarMouseMove(Sender: TObject; Shift: TShiftState;
  X, Y: Integer);
begin
    btn_enviar.Cursor := crHandPoint;
end;

function TufrmWhatsapp.EhNumero(S: string): Boolean;
var
  I: Integer;
begin
  Result := True;
  for I := 1 to Length(S) do begin
    if not (S[I] in ['0'..'9']) then begin
      Result := False;
      Break;
    end;
  end;
end;
Function TufrmWhatsapp.XlsToStringGrid(xStringGrid: TStringGrid; xFileXLS: string): Boolean;
const
   xlCellTypeLastCell = $0000000B;
var
   XLSAplicacao, AbaXLS: OLEVariant;
   RangeMatrix: Variant;
   x, y, k, r: Integer;
begin
   Result := False;
   // Cria Excel- OLE Object
   XLSAplicacao := CreateOleObject('Excel.Application');
   try
     Screen.Cursor := crSQLWait;
   // Esconde Excel
      XLSAplicacao.Visible := False;
      // Abre o Workbook
      XLSAplicacao.Workbooks.Open(xFileXLS);

      {Selecione aqui a aba que você deseja abrir primeiro - 1,2,3,4....}
      XLSAplicacao.WorkSheets[1].Activate;
      {Selecione aqui a aba que você deseja ativar - começando sempre no 1 (1,2,3,4) }
      AbaXLS := XLSAplicacao.Workbooks[ExtractFileName(xFileXLS)].WorkSheets[1];

      AbaXLS.Cells.SpecialCells(xlCellTypeLastCell, EmptyParam).Activate;
      // Pegar o número da última linha
      x := XLSAplicacao.ActiveCell.Row;
      // Pegar o número da última coluna
      y := XLSAplicacao.ActiveCell.Column;
      // Seta xStringGrid linha e coluna
      XStringGrid.RowCount := x;
      XStringGrid.ColCount := y;
      // Associaca a variant WorkSheet com a variant do Delphi
      RangeMatrix := XLSAplicacao.Range['A1', XLSAplicacao.Cells.Item[x, y]].Value;
      // Cria o loop para listar os registros no TStringGrid
      k := 1;
      repeat
         for r := 1 to y do
            XStringGrid.Cells[(r - 1), (k - 1)] := RangeMatrix[k, r];
         Inc(k, 1);
      until k > x;
      RangeMatrix := Unassigned;
      finally
            // Fecha o Microsoft Excel
            Screen.Cursor := crDefault;
            if not VarIsEmpty(XLSAplicacao) then
            begin
                  XLSAplicacao.Quit;
                  XLSAplicacao := Unassigned;
                  AbaXLS := Unassigned;
                  Result := True;
            end;
      end;
end;

procedure TufrmWhatsapp.btn_enviarClick(Sender: TObject);
begin

  if memo_mensagem.Text = EmptyStr then
  begin
    ShowMessage('O campo mensagem deve ser preenchido! [ Message field should be fill! ]');
    memo_mensagem.SetFocus;
    Abort;
  end;

  if (edt_coutry_code.Text = EmptyStr) then
  begin
    ShowMessage('O Código DDI do país deve ser preenchido.[ Country Code Field should be fill! ]');
    edt_coutry_code.SetFocus;
    Abort;
  end;

  geraTxt;

  with TFileStream.Create('contatos.txt', fmOpenRead or fmShareDenyNone) do
  begin
    if Size <= 0 then
    begin
       ShowMessage('Nenhum número válido para envio de menssagens! [ No valid numbers to send messages! ]');
       Abort;
    end;
   Free;
  end;

  WinExec('main.exe',SW_HIDE); // roda escondido

  codigo := codigo+1;
  memo_logs.Lines.Add('');
  memo_logs.Lines.Add('Send Code: '+IntToStr(codigo));
  memo_logs.Lines.Add('Status: Números formatados e prontos para envio de mensagens.Esperando execução automática do Whatsapp Web.......');
  memo_logs.Lines.Add('Date/Time: '+DateTimeToStr(Now));
  memo_logs.Lines.Add('File: '+OpenDialog1.FileName);
  memo_logs.Lines.Add('Message:');
  memo_logs.Lines.Add('['+memo_mensagem.Text+']');
  memo_logs.Lines.Add('');



end;

procedure TufrmWhatsapp.FormShow(Sender: TObject);
begin
    memo_logs.Text := EmptyStr;
    memo_mensagem.Text := EmptyStr;
    lbl_developer.Caption := ' Developed by Paulo Mota ';
    lbl_title.Caption :=  ' WhatsApp Sender ';
    lista_grid.DefaultColWidth:=100;
    lista_grid.ColWidths[2]:=200;
    lista_grid.ColWidths[1]:=180;
    lista_grid.Cells[0,0]:= 'Name';
    lista_grid.Cells[1,0]:= 'Numbers (Area Code + Number)';
    lista_grid.Cells[2,0]:= 'Status';
end;

procedure TufrmWhatsapp.geraTxt;
var  arq,arq_msg: TextFile;
     nLinha: integer;
     msg : String;
begin
  try

    AssignFile(arq, 'contatos.txt');
    AssignFile(arq_msg, 'mensagem.txt');
    Rewrite(arq);
    Rewrite(arq_msg);

     lista_grid.Cells[2,0]:= 'Status';
     For nLinha := 1 to lista_grid.RowCount- 1 do
     begin
      if not ((lista_grid.Cells[0,nLinha] = EmptyStr)and
             (lista_grid.Cells[1,nLinha] = EmptyStr)) then
      begin
         msg :='';
         lista_grid.Cells[1,nLinha] := Trim(RemoveCaracter(lista_grid.Cells[1,nLinha]));
         if not EhNumero(lista_grid.Cells[1,nLinha]) then
         begin
           msg := 'Invalid Number';
         end;


        if not  (msg = EmptyStr) then
        begin
           lista_grid.Cells[2,nLinha]:= msg;
        end else
        begin
           Writeln(arq,lista_grid.Cells[0,nLinha]+';'+'+'+edt_coutry_code.Text+lista_grid.Cells[1,nLinha]);
           lista_grid.Cells[2,nLinha]:= 'OK';
        end;
     end;
   end;
  finally
    Writeln(arq_msg, memo_mensagem.Text);
    CloseFile(arq);
    CloseFile(arq_msg);
  end;

end;

procedure TufrmWhatsapp.Image1Click(Sender: TObject);
begin

  if OpenDialog1.Execute then
  begin
      edit_path.Text := OpenDialog1.FileName;
      try
        XlsToStringGrid(lista_grid,OpenDialog1.FileName)
      Except
      on E: Exception do
      begin
        ShowMessage('Error: ' + E.Message );
        Close;
      end;
      end;
  end;

end;



procedure TufrmWhatsapp.img_fileMouseMove(Sender: TObject; Shift: TShiftState;
  X, Y: Integer);
begin
   img_file.Cursor := crHandPoint;
end;

procedure TufrmWhatsapp.img_linkedinClick(Sender: TObject);
var
buffer: String;
begin
        buffer := 'https://www.linkedin.com/in/paulo-mota-955218a2/' ;

       ShellExecute(Application.Handle, nil, PChar(buffer), nil, nil, SW_SHOWNORMAL);
       //shellapi
end;

procedure TufrmWhatsapp.img_linkedinMouseMove(Sender: TObject; Shift: TShiftState; X,
  Y: Integer);
begin
     img_linkedin.Cursor := crHandPoint;
end;

procedure TufrmWhatsapp.Timer1Timer(Sender: TObject);
begin
  lbl_data.Caption := DateTimeToStr(Now);
end;

end.

