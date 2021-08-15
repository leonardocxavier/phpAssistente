unit editor;

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils, eventlog, Forms, Controls, Graphics, Dialogs, StdCtrls,
  ExtCtrls, ComCtrls, SynHighlighterHTML, SynEdit, SynCompletion,
  SynPluginSyncroEdit, SynHighlighterJScript, SynHighlighterAny,
  SynHighlighterPHP;

type

  { TForm1 }

  TForm1 = class(TForm)
    Button1: TButton;
    Button2: TButton;
    Button3: TButton;
    Button4: TButton;
    Button5: TButton;
    Button6: TButton;
    Button7: TButton;
    Edit1: TEdit;
    Edit2: TEdit;
    Edit3: TEdit;
    GroupBox1: TGroupBox;
    GroupBox2: TGroupBox;
    GroupBox3: TGroupBox;
    GroupBox4: TGroupBox;
    GroupBox5: TGroupBox;
    Image1: TImage;
    Label1: TLabel;
    Label2: TLabel;
    ListBox1: TListBox;
    Memo1: TMemo;
    Memo2: TMemo;
    Memo3: TMemo;
    PageControl1: TPageControl;
    PageControl2: TPageControl;
    Panel1: TPanel;
    Panel2: TPanel;
    Panel3: TPanel;
    Panel4: TPanel;
    ProgressBar1: TProgressBar;
    StatusBar1: TStatusBar;
    SynCompletion1: TSynCompletion;
    SynCompletion2: TSynCompletion;
    SynEdit1: TSynEdit;
    SynEdit2: TSynEdit;
    SynEdit3: TSynEdit;
    SynEdit4: TSynEdit;
    SynEdit5: TSynEdit;
    SynEdit6: TSynEdit;
    SynEdit7: TSynEdit;
    SynHTMLSyn1: TSynHTMLSyn;
    SynJScriptSyn1: TSynJScriptSyn;
    SynPHPSyn1: TSynPHPSyn;
    SynPluginSyncroEdit1: TSynPluginSyncroEdit;
    SynPluginSyncroEdit2: TSynPluginSyncroEdit;
    SynPluginSyncroEdit3: TSynPluginSyncroEdit;
    SynPluginSyncroEdit4: TSynPluginSyncroEdit;
    SynPluginSyncroEdit5: TSynPluginSyncroEdit;
    SynPluginSyncroEdit6: TSynPluginSyncroEdit;
    TabSheet1: TTabSheet;
    TabSheet10: TTabSheet;
    TabSheet11: TTabSheet;
    TabSheet12: TTabSheet;
    TabSheet13: TTabSheet;
    TabSheet14: TTabSheet;
    TabSheet15: TTabSheet;
    TabSheet2: TTabSheet;
    TabSheet3: TTabSheet;
    TabSheet4: TTabSheet;
    TabSheet5: TTabSheet;
    TabSheet6: TTabSheet;
    TabSheet7: TTabSheet;
    TabSheet8: TTabSheet;
    TabSheet9: TTabSheet;
    Timer1: TTimer;
    ToggleBox1: TToggleBox;
    ToolBar1: TToolBar;
    procedure Button1Click(Sender: TObject);
    procedure Button2Click(Sender: TObject);
    procedure Button4Click(Sender: TObject);
    procedure Button5Click(Sender: TObject);
    procedure Button6Click(Sender: TObject);
    procedure Edit1KeyPress(Sender: TObject; var Key: char);
    procedure ListBox1DblClick(Sender: TObject);
    procedure Memo2Change(Sender: TObject);
    procedure PageControl2Change(Sender: TObject);
    procedure Timer1Timer(Sender: TObject);
    procedure ToolBar1Click(Sender: TObject);
  private

  public

  end;

var
  Form1: TForm1;

implementation

{$R *.lfm}

{ TForm1 }

procedure TForm1.Button1Click(Sender: TObject);
begin
  ListBox1.AddItem(Edit1.Text,self);
  Edit1.Text:='';
end;

procedure TForm1.Button2Click(Sender: TObject);
begin
  ListBox1.DeleteSelected;

end;

function tiraacento ( str: String ): String;
const
AccentedChars :array[0..25] of string = ('á','à','ã','â','ä','é','è','ê','ë','í','ì','ï','î','ó','ò','õ','ô','ö','ú','ù','ü','û','ç','ñ','ý','ÿ');

NormalChars :array[0..25] of string = ('a','a','a','a','a','e','e','e','e','i','i','i','i','o','o','o','o','o','u','u','u','u','c','n','y','y');

var
i: Integer;
begin
Result := str;
for i := 0 to 25 do
Result := StringReplace(Result, AccentedChars[i], NormalChars[i], [rfReplaceAll]);
end;

procedure TForm1.Button4Click(Sender: TObject);
var
  x,a: integer;
  campo,campo_id:string;
begin
  //pega o numero de itens que o usuario incluiu no list box
  x := ListBox1.Count;
  //coloca o listbox na posição 0
  ListBox1.ItemIndex:=0;
  a:=0;

  SynEdit1.Lines.Add('<div class="sm:grid grid-cols-3 gap-2">');

  //verifica os campos do formulario que usuario precisa

  while a <= x-1 do begin
       campo :='';
       campo:= ListBox1.Items[a];
       campo_id:='';
       campo_id:=StringReplace(campo,' ','_',[rfReplaceAll, rfIgnoreCase]);
       campo_id:= tiraacento(campo_id);
       SynEdit1.lines.add('<div>');
       SynEdit1.lines.add('<label for="regular-form-1" class="form-label">'+campo+'</label> ');
       SynEdit1.lines.add('<input type="text" class="form-control" autocomplete="off" id="'+campo_id+'" placeholder="'+campo+'">');
       SynEdit1.lines.add('</div>');
       ListBox1.ItemIndex:=a;
       a := a + 1
  end;
  SynEdit1.lines.add('</div>');
  //html criado
  //criando agora os ajax do formulario
  SynEdit2.lines.Add('function gravaform(){ ');
  SynEdit2.lines.Add('    $.ajax({  ');
  SynEdit2.lines.Add('        url:"",');
  SynEdit2.lines.Add('        success:function(data){   ');
  SynEdit2.lines.Add('            $("#apresenta").html(data);');
  SynEdit2.lines.Add('        } ');
  SynEdit2.lines.Add('     });');
  SynEdit2.lines.Add('}); ');
   SynEdit2.Lines.Add('/* ===========================================*/');



end;

procedure TForm1.Button5Click(Sender: TObject);
var
  i: Integer;
begin
  If ListBox1.ItemIndex > -1 Then begin
      i := ListBox1.ItemIndex;
      if i > 0 then begin
        ListBox1.Items.Exchange(i, i - 1);
        ListBox1.Selected[i-1]:= True;
      end;
    end;
end;

procedure TForm1.Button6Click(Sender: TObject);
var
  i, Max: Integer;
begin
  If ListBox1.ItemIndex > -1 Then begin
        Max := ListBox1.Items.Count;
        if Max > 0 then begin
           Dec(Max);
           i := ListBox1.ItemIndex;
           if i < Max then begin
              ListBox1.Items.Exchange(i, i + 1);
              ListBox1.Selected[i+1]:= True;
              end;
           end;
      end;
end;

procedure TForm1.Edit1KeyPress(Sender: TObject; var Key: char);
begin
  if(Key=#13) then begin
       ListBox1.AddItem(Edit1.Text,self);
       Edit1.Text:='';
  end;
end;

procedure TForm1.ListBox1DblClick(Sender: TObject);
begin
  Edit1.Text:=ListBox1.GetSelectedText;
  ListBox1.DeleteSelected;
end;

procedure TForm1.Memo2Change(Sender: TObject);
begin

end;

procedure TForm1.PageControl2Change(Sender: TObject);
begin

end;

procedure TForm1.Timer1Timer(Sender: TObject);
var
  a : integer;
begin
  for a:=0 to 100 do begin
     ProgressBar1.Position:=a;
     sleep(100);
  end;

end;

procedure TForm1.ToolBar1Click(Sender: TObject);
begin

end;

end.

