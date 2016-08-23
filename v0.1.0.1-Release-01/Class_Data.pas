unit Class_Data;

interface
Uses Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, ExtCtrls, DBCtrls, DB, ADODB, Grids, DBGrids, Mask;

type
  DataBaseClean = Class
  Private
  Public
    procedure FitGrid(dbgMain: TDBGrid);
  end;

implementation

{ DataBaseClean }

uses Feeding_U, MainU, Shedding_U;

procedure DataBaseClean.FitGrid(dbgMain: TDBGrid);
//Credit for this procedure goes to bummi @ http://stackoverflow.com/questions/17509924/adjust-column-width-dbgrid
const
  C_ADD = 3;
var ds : TDataSet;
    bm : TBookmark;
    i, w : integer;
    a : Array of Integer;
begin
  ds := dbgMain.DataSource.DataSet;
  if Assigned(ds) then
  begin
    ds.DisableControls;
    bm := ds.GetBookmark;
    try
      ds.First;
      SetLength(a, dbgMain.Columns.Count);
      while not ds.Eof do
      begin
        for i := 0 to dbgMain.Columns.Count - 1 do
        begin
          if Assigned(dbgMain.Columns[i].Field) then
          begin
            w := dbgMain.Canvas.TextWidth(ds.FieldByName(dbgMain.Columns[i].Field.FieldName).DisplayText);
            if a[i] < w then
              a[i] :=w;
          end;
        end;
        ds.Next;
      end;
      for i := 0 to dbgMain.Columns.Count - 1 do
      begin
        w := dbgMain.Canvas.TextWidth(dbgMain.Columns[i].Field.FieldName);
        if a[i] < w then
          a[i] := w
      end;
      for i := 0 to dbgMain.Columns.Count - 1 do
      dbgMain.Columns[i].Width := a[i] + C_Add;
      ds.GotoBookmark(bm);
      Finally
        ds.FreeBookmark(bm);
        ds.EnableControls;
      end;
  end;
end;

end.
