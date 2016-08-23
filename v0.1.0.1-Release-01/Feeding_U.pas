//Developed by MarineXII
unit Feeding_U;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, ExtCtrls, DBCtrls, Grids, DBGrids, Class_Data, StdCtrls, DB,
  ADODB, Mask;

type
  TFeedingForm = class(TForm)
    dbFeeding: TDBGrid;
    dbnFeeding: TDBNavigator;
    btnFeedingLoad: TButton;
    dsFeed: TDataSource;
    adoqFeed: TADOQuery;
    dbeFeedEntry: TDBEdit;
    dbeFeedId: TDBEdit;
    dbeFeedDate: TDBEdit;
    dbeFeedAte: TDBEdit;
    Label1: TLabel;
    Label2: TLabel;
    Label3: TLabel;
    Label4: TLabel;
    btnMain: TButton;
    btnShed: TButton;
    btnFeedAdd: TButton;
    procedure btnFeedingLoadClick(Sender: TObject);
    procedure FormActivate(Sender: TObject);
    procedure btnMainClick(Sender: TObject);
    procedure btnShedClick(Sender: TObject);
    procedure btnFeedAddClick(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  FeedingForm: TFeedingForm;
  CleanFeeding : DataBaseClean;
  fsid, fDate, fAt : String;

implementation

uses MainU, Shedding_U;

{$R *.dfm}
//For future sorting
//var qryF : String;

Procedure fOpenTable;
begin
  FeedingForm.adoqFeed.Close;
  FeedingForm.adoqFeed.SQL.SetText('SELECT * FROM tblFeed');
  FeedingForm.adoqFeed.ExecSQL;
  FeedingForm.adoqFeed.Open;
end;

procedure TFeedingForm.btnFeedingLoadClick(Sender: TObject);
begin
  fOpenTable;
  CleanFeeding.FitGrid(dbFeeding);
end;

procedure TFeedingForm.FormActivate(Sender: TObject);
begin
  CleanFeeding := DataBaseClean.Create;
end;

procedure TFeedingForm.btnMainClick(Sender: TObject);
begin
  MainWindow.Show;
end;

procedure TFeedingForm.btnShedClick(Sender: TObject);
begin
  SheddingForm.Show;
end;

procedure TFeedingForm.btnFeedAddClick(Sender: TObject);
begin
  fsid := InputBox('Snake ID','ID of snake or press cancel to stop entering data','');
  if fsid <> '' then
  begin
    fDate := InputBox('Date fed','Date the snake was offered food','');
    if InputBox('Eaten','Enter "y" for eaten and "n" for not eaten','') = 'y' then
      fAt := 'Yes'
    else
      fAt := 'No';
    adoqFeed.Close;
    adoqFeed.SQL.Text := 'INSERT INTO tblFeed(SnakeID, Date_Fed, Ate) VALUES ("' +
    fsid + '","' + fDate + '","' + fAt + '")';
    adoqFeed.ExecSQL;
  end else
  begin
    ShowMessage('Returned to feeding data window');
  end;
  fOpenTable;
  CleanFeeding.FitGrid(dbFeeding);
end;

end.
