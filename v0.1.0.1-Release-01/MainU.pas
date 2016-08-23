//Developed by MarineXII
unit MainU;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, ExtCtrls, DBCtrls, DB, ADODB, Grids, DBGrids, Mask, Class_Data;

type
  TMainWindow = class(TForm)
    dbMain: TDBGrid;
    dsMain: TDataSource;
    adoqMain: TADOQuery;
    dbnMain: TDBNavigator;
    btnLoad: TButton;
    dbeMainID: TDBEdit;
    dbeMainGenus: TDBEdit;
    dbeMainSpecie: TDBEdit;
    dbeMainCommon: TDBEdit;
    dbeMainSize: TDBEdit;
    Label1: TLabel;
    Label2: TLabel;
    Label3: TLabel;
    Label4: TLabel;
    Label5: TLabel;
    Button1: TButton;
    btnShed: TButton;
    btnHelp: TButton;
    btnMainAdd: TButton;
    procedure btnLoadClick(Sender: TObject);
    procedure Button1Click(Sender: TObject);
    procedure FormActivate(Sender: TObject);
    procedure btnShedClick(Sender: TObject);
    procedure btnHelpClick(Sender: TObject);
    procedure btnMainAddClick(Sender: TObject);

  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  MainWindow: TMainWindow;
  clean : DataBaseClean;
  mid, mgen, msp, mcn : string;
  msize : integer;
  bButton : Boolean;
implementation

uses Feeding_U, Shedding_U;


{$R *.dfm}
//For future sorting
//var qryM : String;

Procedure ShowTable;
begin
  MainWindow.adoqMain.Close;
  MainWindow.adoqMain.SQL.SetText('SELECT * FROM tblBasicInfo');
  MainWindow.adoqMain.ExecSQL;
  MainWindow.adoqMain.Open;
end;

procedure TMainWindow.btnLoadClick(Sender: TObject);
begin
  ShowTable;
  clean.FitGrid(dbMain);
end;

procedure TMainWindow.Button1Click(Sender: TObject);
begin
  FeedingForm.Show;
end;

procedure TMainWindow.FormActivate(Sender: TObject);
begin
  clean := DataBaseClean.Create;
  mid := '';
  mgen := '';
  msp := '';
  mcn := '';
  msize := 0;
end;

procedure TMainWindow.btnShedClick(Sender: TObject);
begin
  SheddingForm.Show;
end;

procedure TMainWindow.btnHelpClick(Sender: TObject);
  var text, ln : string;
      txtF : TextFile;
begin
  text := '';
  AssignFile(txtF, 'Help.txt');
  if FileExists('Help.txt') = true then
  begin
  Reset(txtF);
    While NOT EOF(txtF)do
    begin
      Readln(txtF, ln);
      text := text + #13 + ln;
    end;
  ShowMessage(text);
  CloseFile(txtF);
  end
  else if FileExists('Help.txt') = false then
  begin
    Rewrite(txtF);
    Writeln(txtF,
    'Help');
    Writeln(txtF,
    '____');
    Writeln(txtF,
    '1) How to enter data:' + #13
    + #9 + 'If you would like to enter new data to the database, simply click on the "Add" button on the navigation tab below the database table');
    CloseFile(txtF);
  end;
end;

procedure TMainWindow.btnMainAddClick(Sender: TObject);
  //Add window to add new data
begin
  bButton := InputQuery('ID','Enter snake ID or press cancel to stop entering data', mid);
  if bButton = true then
  begin
    mgen := InputBox('Genus','Genus of snake','');
    msp := InputBox('Specie','Specie of snake','');
    mcn := InputBox('Common Name','Common Name of snake','');
    msize := StrToInt(InputBox('Snake size','Snake size in cm',''));
    adoqMain.Close;
    adoqMain.SQL.Text := 'INSERT INTO tblBasicInfo(SnakeID, Genus, Specie, Common_Name, SizeCm) VALUES ("' +
    mid + '","' + mgen + '","' + msp + '","' + mcn + '","' + IntToStr(msize) + '")';
    adoqMain.ExecSQL;
  end else
  begin
    ShowMessage('Returned to main window');
  end;
  ShowTable;
  clean.FitGrid(dbMain);
end;

end.
