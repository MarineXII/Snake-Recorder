//Developed by MarineXII
unit Shedding_U;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, Grids, DBGrids, StdCtrls, ExtCtrls, DBCtrls, DB, ADODB, Class_Data,
  Mask;

type
  TSheddingForm = class(TForm)
    dbShed: TDBGrid;
    DBNavigator1: TDBNavigator;
    btnShedLoad: TButton;
    btnShedMain: TButton;
    Button1: TButton;
    dsShed: TDataSource;
    dbeShedEntry: TDBEdit;
    dbeShedID: TDBEdit;
    dbeShedBlues: TDBEdit;
    dbeShed: TDBEdit;
    dbeShedComplete: TDBEdit;
    Label1: TLabel;
    Label2: TLabel;
    Label3: TLabel;
    Label4: TLabel;
    Label5: TLabel;
    btnMainAAdd: TButton;
    adoqShed: TADOQuery;
    procedure btnShedMainClick(Sender: TObject);
    procedure btnShedLoadClick(Sender: TObject);
    procedure FormActivate(Sender: TObject);
    procedure Button1Click(Sender: TObject);
    procedure btnMainAAddClick(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  SheddingForm: TSheddingForm;
  ShedClean : DataBaseClean;
  sid, sComp1, sdBlue, sdShed : String;
implementation

uses MainU, Feeding_U;

{$R *.dfm}

procedure sOpenTable;
begin
  SheddingForm.adoqShed.Close;
  SheddingForm.adoqShed.SQL.SetText('SELECT * FROM tblShed');
  SheddingForm.adoqShed.ExecSQL;
  SheddingForm.adoqShed.Open;
end;

procedure TSheddingForm.btnShedMainClick(Sender: TObject);
begin
  MainWindow.Show;
end;

procedure TSheddingForm.btnShedLoadClick(Sender: TObject);
begin
  sOpenTable;
  ShedClean.FitGrid(dbShed);
end;

procedure TSheddingForm.FormActivate(Sender: TObject);
begin
  ShedClean := DataBaseClean.Create;
end;

procedure TSheddingForm.Button1Click(Sender: TObject);
begin
  FeedingForm.Show;
end;

procedure TSheddingForm.btnMainAAddClick(Sender: TObject);
begin
  sid := InputBox('Snake ID','ID of snake or press cancel to stop entering data','');
  if sid <> '' then
  begin
    sdBlue := InputBox('Enter blue date','Date snake went into blue','');
    sdShed := InputBox('Enter shed date','Date snake shed','');
    if InputBox('Complete shed', 'Enter "y" for full shed and "n" for not complete shed','') = 'n' then
      sComp1 := 'No'
    else
      sComp1 := 'Yes';
  adoqShed.Close;
  adoqShed.SQL.Text := 'INSERT INTO tblShed(SnakeID, Date_Blue, Date_Shed, Complete_Shed) VALUES ("' +
    sid + '","' + sdBlue + '","' + sdShed + '","' + sComp1 + '")';
  adoqShed.ExecSQL;
  end else
  begin
    ShowMessage('Returned to shedding data window');
  end;
  sOpenTable;
  ShedClean.FitGrid(dbShed);
end;

end.
