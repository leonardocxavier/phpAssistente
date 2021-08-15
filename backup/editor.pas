unit editor;

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils, eventlog, process, Forms, Controls, Graphics, Dialogs,
  StdCtrls, ExtCtrls, ComCtrls, SynHighlighterHTML, SynEdit, SynCompletion,
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
    ID_divconteudo: TEdit;
    GroupBox6: TGroupBox;
    NomeMenu: TEdit;
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
    SynPluginSyncroEdit7: TSynPluginSyncroEdit;
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
  campo,campo_id,nomedomenu,idconteudo:string;
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
       //criando HTML das variaveis do list box
       SynEdit1.lines.add('    <div>');
       SynEdit1.lines.add('         <label for="regular-form-1" class="form-label">'+campo+'</label> ');
       SynEdit1.lines.add('         <input type="text" class="form-control" autocomplete="off" id="'+campo_id+'" placeholder="'+campo+'">');
       SynEdit1.lines.add('    </div>');
       ListBox1.ItemIndex:=a;
       a := a + 1
  end;
  SynEdit1.lines.add('</div>');
  //html criado
   sleep(200);
   ProgressBar1.Position:=ProgressBar1.Position+5;
   Application.ProcessMessages;
  //inicio do ajax dos formuláros

  //limpando acentos e espaços nos nomes de menu e formulario para o Ajax
  nomedomenu:= tiraacento(NomeMenu.Text);
  nomedomenu := StringReplace(nomedomenu,' ','_',[rfReplaceAll, rfIgnoreCase]);

  idconteudo:=tiraacento(ID_divconteudo.Text);
  idconteudo:=StringReplace(idconteudo,' ','_',[rfReplaceAll, rfIgnoreCase]); ;
  //criando agora os ajax do formulario
  SynEdit2.Lines.Add('');
  SynEdit2.Lines.Add('/* === Início do Formulário '+NomeMenu.Text+' ===*/');
  SynEdit2.lines.Add('function '+nomedomenu+'(){ ');
  SynEdit2.lines.Add('    $.ajax({  ');
  SynEdit2.lines.Add('        url:"'+nomedomenu+'.php",');
  SynEdit2.lines.Add('        success:function(data){   ');
  SynEdit2.lines.Add('            $("#'+ID_divconteudo.Text+'").html(data);');
  SynEdit2.lines.Add('        } ');
  SynEdit2.lines.Add('     });');
  SynEdit2.lines.Add('}); ');
  SynEdit2.Lines.Add('/* ===========================================*/');
  SynEdit2.Lines.Add('');

  sleep(200);
   ProgressBar1.Position:=ProgressBar1.Position+5;
   Application.ProcessMessages;

  //criando agora os ajax do formulario
  SynEdit2.Lines.Add('');
  SynEdit2.Lines.Add('/* === listar os dados do Formulário '+NomeMenu.Text+' ===*/');
  SynEdit2.lines.Add('function listar'+nomedomenu+'(var){ ');
  SynEdit2.lines.Add('    if(!var){ ');
  SynEdit2.lines.Add('        $.ajax({  ');
  SynEdit2.lines.Add('            url:"listar'+nomedomenu+'.php",');
  SynEdit2.lines.Add('            success:function(data){   ');
  SynEdit2.lines.Add('                $("#listagem_'+nomedomenu+'").html(data);');
  SynEdit2.lines.Add('            } ');
  SynEdit2.lines.Add('        });');
  SynEdit2.lines.Add('    }else{');
  SynEdit2.lines.Add('        $.ajax({  ');
  SynEdit2.lines.Add('            url:"listar'+nomedomenu+'.php",');
  SynEdit2.lines.Add('            data:{');
  SynEdit2.lines.Add('                achar : var
  SynEdit2.lines.Add('            },');
  SynEdit2.lines.Add('            success:function(data){   ');
  SynEdit2.lines.Add('                $("#listagem_'+nomedomenu+'").html(data);');
  SynEdit2.lines.Add('            } ');
  SynEdit2.lines.Add('        });');
  SynEdit2.lines.Add('    }');
  SynEdit2.lines.Add('}); ');

  SynEdit2.Lines.Add('/* ===========================================*/');
  SynEdit2.Lines.Add('');

   //finaliza listagem dos dados do formulário
   sleep(200);
   ProgressBar1.Position:=ProgressBar1.Position+5;
   Application.ProcessMessages;


  //criando agora os ajax do formulario
  SynEdit2.Lines.Add('');
  SynEdit2.Lines.Add('/* === Gravação do Formulário===*/');
  SynEdit2.lines.Add('function gravar'+nomedomenu+'(){ ');
  SynEdit2.lines.Add('    $.ajax({  ');
  SynEdit2.lines.Add('        url:"gravar'+nomedomenu+'.php",');
  SynEdit2.Lines.Add('        data:{                    ');
      //coloca o listbox na posição 0
      ListBox1.ItemIndex:=0;
      a:=0;
      while a <= x-1 do begin
           campo :='';
           campo:= ListBox1.Items[a];
           campo_id:='';
           campo_id:=StringReplace(campo,' ','_',[rfReplaceAll, rfIgnoreCase]);
           campo_id:= tiraacento(campo_id);
           if(a=x-1) then begin
                 SynEdit2.Lines.Add('        '+campo_id+' : $("#'+campo_id+'").val()');
              end else begin
                 SynEdit2.Lines.Add('        '+campo_id+' : $("#'+campo_id+'").val(),');
           end;
           ListBox1.ItemIndex:=a;
           a:=a+1;
       end;
  SynEdit2.lines.Add('        },');
  SynEdit2.lines.Add('        success:function(data){   ');
  SynEdit2.lines.Add('            $("#msg_'+nomedomenu+'").html(data);');
  SynEdit2.Lines.Add('            lista'+nomedomenu+'(); ');
  SynEdit2.lines.Add('        } ');
  SynEdit2.lines.Add('     });');
  SynEdit2.lines.Add('}); ');
  SynEdit2.Lines.Add('/* ===========================================*/');
  SynEdit2.Lines.Add('');

  //finaliza criação dos dados a incluir

   sleep(200);
   ProgressBar1.Position:=ProgressBar1.Position+5;
   Application.ProcessMessages;

  //começa o ajax para edição dos dados

  SynEdit2.Lines.Add('');
  SynEdit2.Lines.Add('/* === Edição do Formulário===*/');
  SynEdit2.lines.Add('function editar'+nomedomenu+'(var){    ');
  SynEdit2.lines.Add('    $.ajax({  ');
  SynEdit2.lines.Add('        url:"editar'+nomedomenu+'.php",');
  SynEdit2.Lines.Add('        data:{                         ');
   SynEdit2.Lines.Add('               id : var,              ');
      //coloca o listbox na posição 0
      ListBox1.ItemIndex:=0;
      a:=0;
      while a <= x-1 do begin
           campo :='';
           campo:= ListBox1.Items[a];
           campo_id:='';
           campo_id:=StringReplace(campo,' ','_',[rfReplaceAll, rfIgnoreCase]);
           campo_id:= tiraacento(campo_id);
           if(a=x-1) then begin
                 SynEdit2.Lines.Add('               '+campo_id+' : $("#'+campo_id+'").val()');
              end else begin
                 SynEdit2.Lines.Add('               '+campo_id+' : $("#'+campo_id+'").val(),');
           end;
           ListBox1.ItemIndex:=a;
           a:=a+1;
       end;
  SynEdit2.lines.Add('        },');
  SynEdit2.lines.Add('        success:function(data){   ');
  SynEdit2.lines.Add('            $("#msg_'+nomedomenu+'").html(data);');
  SynEdit2.lines.Add('        } ');
  SynEdit2.lines.Add('     });');
  SynEdit2.lines.Add('}); ');
  SynEdit2.Lines.Add('/* ===========================================*/');
  SynEdit2.Lines.Add('');

  //temina edição dos dados

   sleep(200);
   ProgressBar1.Position:=ProgressBar1.Position+5;
   Application.ProcessMessages;

  //começa o ajax pra deletar os dados
  SynEdit2.Lines.Add('');
  SynEdit2.Lines.Add('/* === Edição do Formulário===*/');
  SynEdit2.lines.Add('function excluir'+nomedomenu+'(var){ ');
  SynEdit2.lines.Add('    $.ajax({  ');
  SynEdit2.lines.Add('        url:"excluir'+nomedomenu+'.php",');
  SynEdit2.Lines.Add('        data:{                    ');
  SynEdit2.Lines.Add('               id : var');
  SynEdit2.lines.Add('        },');
  SynEdit2.lines.Add('        success:function(data){   ');
  SynEdit2.lines.Add('            $("#msg_'+ID_divconteudo.Text+'").html(data);');
  SynEdit2.Lines.Add('            lista'+nomedomenu+'(); ');
  SynEdit2.lines.Add('        } ');
  SynEdit2.lines.Add('     });');
  SynEdit2.lines.Add('}); ');
  SynEdit2.Lines.Add('/* ===========================================*/');
  SynEdit2.Lines.Add('');

   //finaliza javascript das funções do formulário
   sleep(200);
   ProgressBar1.Position:=ProgressBar1.Position+5;
   Application.ProcessMessages;

  //constroi o html inicial da tela e funções

  //controi a estrutura HTML inicial do formulário
  SynEdit7.Lines.Add('<div id="msg_'+nomedomenu+'"></div>');
  SynEdit7.Lines.Add('<div class="intro-y grid grid-cols-3 sm:gap-6 gap-y-6 box px-5 py-8 mt-5">');
  SynEdit7.lines.Add('      <a class="btn btn-primary shadow-md mr-2" data-toggle="modal" data-target="#modalmembros" title="Adicionar Membro" onclick="novomembro();">Novo Membro</a> ');
  SynEdit7.lines.Add('          <div class="dropdown">  ');
  SynEdit7.lines.Add('              <button class="dropdown-toggle btn px-2 box text-gray-700 dark:text-gray-300" aria-expanded="false">   ');
  SynEdit7.lines.Add('                  <span class="w-5 h-5 flex items-center justify-center" title="Mais Opções"> <svg xmlns="http://www.w3.org/2000/svg" width="24" height="24" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="1.5" stroke-linecap="round" stroke-linejoin="round" class="feather feather-plus w-4 h-4"><line x1="12" y1="5" x2="12" y2="19"></line><line x1="5" y1="12" x2="19" y2="12"></line></svg> </span>');
  SynEdit7.lines.Add('              </button>  ');
  SynEdit7.lines.Add('              <div class="dropdown-menu w-40">    ');
  SynEdit7.lines.Add('                  <div class="dropdown-menu__content box dark:bg-dark-1 p-2">  ');
  SynEdit7.lines.Add('                      <a href="javascript:;" class="flex items-center block p-2 transition duration-300 ease-in-out bg-white dark:bg-dark-1 hover:bg-gray-200 dark:hover:bg-dark-2 rounded-md"> <svg xmlns="http://www.w3.org/2000/svg" width="24" height="24" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="1.5" stroke-linecap="round" stroke-linejoin="round" class="feather feather-printer w-4 h-4 mr-2"><polyline points="6 9 6 2 18 2 18 9"></polyline><path d="M6 18H4a2 2 0 0 1-2-2v-5a2 2 0 0 1 2-2h16a2 2 0 0 1 2 2v5a2 2 0 0 1-2 2h-2"></path><rect x="6" y="14" width="12" height="8"></rect></svg> Imprimir </a> ');
  SynEdit7.lines.Add('                      <a href="javascript:;" class="flex items-center block p-2 transition duration-300 ease-in-out bg-white dark:bg-dark-1 hover:bg-gray-200 dark:hover:bg-dark-2 rounded-md"> <svg xmlns="http://www.w3.org/2000/svg" width="24" height="24" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="1.5" stroke-linecap="round" stroke-linejoin="round" class="feather feather-file-text w-4 h-4 mr-2"><path d="M14 2H6a2 2 0 0 0-2 2v16a2 2 0 0 0 2 2h12a2 2 0 0 0 2-2V8z"></path><polyline points="14 2 14 8 20 8"></polyline><line x1="16" y1="13" x2="8" y2="13"></line><line x1="16" y1="17" x2="8" y2="17"></line><polyline points="10 9 9 9 8 9"></polyline></svg> Exportar Em Excel </a> ');
  SynEdit7.lines.Add('                      <a href="javascript:;" class="flex items-center block p-2 transition duration-300 ease-in-out bg-white dark:bg-dark-1 hover:bg-gray-200 dark:hover:bg-dark-2 rounded-md"> <svg xmlns="http://www.w3.org/2000/svg" width="24" height="24" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="1.5" stroke-linecap="round" stroke-linejoin="round" class="feather feather-file-text w-4 h-4 mr-2"><path d="M14 2H6a2 2 0 0 0-2 2v16a2 2 0 0 0 2 2h12a2 2 0 0 0 2-2V8z"></path><polyline points="14 2 14 8 20 8"></polyline><line x1="16" y1="13" x2="8" y2="13"></line><line x1="16" y1="17" x2="8" y2="17"></line><polyline points="10 9 9 9 8 9"></polyline></svg> Exportar Em PDF </a>');
  SynEdit7.lines.Add('                  </div>   ');
  SynEdit7.lines.Add('              </div>    ');
  SynEdit7.lines.Add('           </div>    ');
  SynEdit7.lines.Add('           <div class="hidden md:block mx-auto text-gray-600"></div>  ');
  SynEdit7.lines.Add('               <div class="w-full sm:w-auto mt-3 sm:mt-0 sm:ml-auto md:ml-0">   ');
  SynEdit7.lines.Add('                   <div class="w-56 relative text-gray-700 dark:text-gray-300"> ');
  SynEdit7.lines.Add('                        <input type="text" onclick="localisauser();" class="form-control w-56 box pr-10 placeholder-theme-13" placeholder="Search..."> ');
  SynEdit7.lines.Add('                        <svg xmlns="http://www.w3.org/2000/svg" width="24" height="24" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="1.5" stroke-linecap="round" stroke-linejoin="round" class="feather feather-search w-4 h-4 absolute my-auto inset-y-0 mr-3 right-0"><circle cx="11" cy="11" r="8"></circle><line x1="21" y1="21" x2="16.65" y2="16.65"></line></svg>  ');
  SynEdit7.lines.Add('                   </div> ');
  SynEdit7.lines.Add('               </div>  ');
  SynEdit7.lines.Add('           </div>');
  SynEdit7.Lines.Add('');
  SynEdit7.Lines.Add('<div class="intro-y col-span-12 overflow-auto lg:overflow-visible" style="overflow: auto;"> ');
  SynEdit7.Lines.Add('      <table class="table table-report mt-2" style="font-size: 12px;">  ');
  SynEdit7.Lines.Add('          <thead>   ');
  SynEdit7.Lines.Add('              <tr>  ');
  ListBox1.ItemIndex:=0;
      a:=0;
      while a <= x-1 do begin
           campo :='';
           campo:= ListBox1.Items[a];
           campo_id:='';
           campo_id:=StringReplace(campo,' ','_',[rfReplaceAll, rfIgnoreCase]);
           campo_id:= tiraacento(campo_id);
           SynEdit7.Lines.Add('                 <th>'+campo+'</th>');
           ListBox1.ItemIndex:=a;
           a:=a+1;
       end;
  SynEdit7.Lines.Add('              </tr> ');
  SynEdit7.Lines.Add('          </thead> ');
  SynEdit7.Lines.Add('          <tbody id="listagem'+nomedomenu+'"> ');
  SynEdit7.Lines.Add('              <tr></tr> ');
  SynEdit7.Lines.Add('          </tbody>');
  SynEdit7.Lines.Add('      </table>');
  SynEdit7.Lines.Add('  </div>');
  SynEdit7.Lines.Add('');
  SynEdit7.Lines.Add('<script>listar'+nomedomenu+'()</script>');
  SynEdit7.Lines.Add('');

  //temina HTML inicial do formulario
   sleep(200);
   ProgressBar1.Position:=ProgressBar1.Position+5;
   Application.ProcessMessages;

  //começa o php da tabela HTML para mostrar os dados gravados



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

