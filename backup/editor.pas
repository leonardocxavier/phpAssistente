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
    Edit1: TEdit;
    GroupBox1: TGroupBox;
    Image1: TImage;
    Label1: TLabel;
    Label2: TLabel;
    ListBox1: TListBox;
    Memo1: TMemo;
    PageControl1: TPageControl;
    Panel1: TPanel;
    Panel2: TPanel;
    ProgressBar1: TProgressBar;
    SynCompletion1: TSynCompletion;
    SynCompletion2: TSynCompletion;
    SynEdit1: TSynEdit;
    SynEdit2: TSynEdit;
    SynEdit3: TSynEdit;
    SynEdit4: TSynEdit;
    SynEdit5: TSynEdit;
    SynEdit6: TSynEdit;
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
    TabSheet2: TTabSheet;
    TabSheet3: TTabSheet;
    TabSheet4: TTabSheet;
    TabSheet5: TTabSheet;
    TabSheet6: TTabSheet;
    TabSheet7: TTabSheet;
    TabSheet8: TTabSheet;
    ToggleBox1: TToggleBox;
    ToolBar1: TToolBar;
    procedure Button1Click(Sender: TObject);
    procedure Button2Click(Sender: TObject);
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

procedure TForm1.ToolBar1Click(Sender: TObject);
begin

end;

end.

