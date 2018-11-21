unit uAdjRivCond;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, uerror, AVGRIDIO, Vcl.StdCtrls,
  uTabstractESRIgrid, uTSingleESRIgrid;

type
  TForm3 = class(TForm)
    Button1: TButton;
    SingleESRIgridRivFLX: TSingleESRIgrid;
    SingleESRIgridRiv: TSingleESRIgrid;
    SingleESRIgridCond: TSingleESRIgrid;
    Memo1: TMemo;
    procedure Button1Click(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  Form3: TForm3;

implementation

{$R *.dfm}

procedure TForm3.Button1Click(Sender: TObject);
var
  filename1, filename2, filename3, filename4: string;
  iResult, nrows, ncols, i, j: Integer;
  x, y, flxM3perD, flxMperD, conductance, cbodem, cAddedValue: Single;
  count: integer;
  ChangeConductanceInThisCell, Infiltration: Boolean;
  fValue, CellArea: Double;
begin
  filename1 := paramstr(1); {RIV FLX}
  filename2 := paramstr(2); {RIV to adjust}
  filename3 := paramstr(3); {RIV conductance}
  fvalue    := StrToFloat( paramstr(4) );
  filename4 := paramstr(5); {Output RIV conductance}

  SingleESRIgridRivFLX := TSingleESRIgrid.InitialiseFromIDFfile( filename1, iResult, self );
  SingleESRIgridRiv := TSingleESRIgrid.InitialiseFromIDFfile( filename2, iResult, self );
  SingleESRIgridCond := TSingleESRIgrid.InitialiseFromIDFfile( filename3, iResult, self );

  nrows:=SingleESRIgridCond.NRows;
  ncols:=SingleESRIgridCond.NCols;

  count := 0;
  CellArea := SingleESRIgridCond.CellArea;
  for i := 1 to NRows do
    for j := 1 to NCols do begin

      if not SingleESRIgridCond.IsMissing(i,j) then begin
        conductance := SingleESRIgridCond[ i, j];
        if conductance > 0 then begin
          cbodem := CellArea / conductance ;
          SingleESRIgridCond.GetCellCentre( i, j, x, y );
          ChangeConductanceInThisCell :=
            ( not SingleESRIgridRiv.IsMissing(i,j) )
            and ( SingleESRIgridRiv.GetValueXY( x, y ) > 0);
          if ChangeConductanceInThisCell then begin

            flxM3perD := SingleESRIgridRivFLX.GetValueXY( x, y );
            Infiltration := flxM3perD > 0;
            if Infiltration then begin
              flxMperD := flxM3perD / CellArea;
              cAddedValue := fValue * flxMperD;
              cbodem := cbodem + cAddedValue;
              SingleESRIgridCond[ i, j] := CellArea / cbodem;
              inc( count );
            end;
          end; {-if ChangeConductanceInThisCell}
        end; {-if conductance > 0}

      end; {-for j}
    end; {-for i}
  SingleESRIgridCond.ExportToIDFfile( filename4 );
  WriteToLogFile( 'Nr of conductances updated: ' + inttoStr( count ) );
end;

procedure TForm3.FormCreate(Sender: TObject);
begin
InitialiseLogFile;
InitialiseGridIO;
end;

procedure TForm3.FormDestroy(Sender: TObject);
begin
FinaliseLogFile;
end;

end.
