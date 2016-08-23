//Developed by MarineXII
program MainConcept;

uses
  Forms,
  MainU in 'MainU.pas' {MainWindow},
  Feeding_U in 'Feeding_U.pas' {FeedingForm},
  Class_Data in 'Class_Data.pas',
  Shedding_U in 'Shedding_U.pas' {SheddingForm};

{$R *.res}

begin
  Application.Initialize;
  Application.Title := 'Snake Records';
  Application.CreateForm(TMainWindow, MainWindow);
  Application.CreateForm(TFeedingForm, FeedingForm);
  Application.CreateForm(TSheddingForm, SheddingForm);
  Application.Run;
end.
