program AdjRivCond;

uses
  Vcl.Forms,
  uAdjRivCond in 'uAdjRivCond.pas' {Form3};

{$R *.res}

begin
  Application.Initialize;
  Application.MainFormOnTaskbar := True;
  Application.CreateForm(TForm3, Form3);
  {Application.Run;}
  Form3.Button1.Click;
end.
