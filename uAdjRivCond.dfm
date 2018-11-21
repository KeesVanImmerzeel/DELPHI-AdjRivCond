object Form3: TForm3
  Left = 0
  Top = 0
  Caption = 'Form3'
  ClientHeight = 471
  ClientWidth = 570
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  OldCreateOrder = False
  OnCreate = FormCreate
  OnDestroy = FormDestroy
  PixelsPerInch = 96
  TextHeight = 13
  object Button1: TButton
    Left = 440
    Top = 400
    Width = 75
    Height = 25
    Caption = 'Button1'
    TabOrder = 0
    OnClick = Button1Click
  end
  object Memo1: TMemo
    Left = 41
    Top = 136
    Width = 457
    Height = 249
    Lines.Strings = (
      
        'Verlagen river conductance op basis van berekende river flux (m/' +
        '3)'
      
        'River conductance is omgekeerd evenredig verondersteld aan de st' +
        'erkte van de '
      'infiltratieflux bij een bodemweerstand van 1 dag(m/d).'
      ''
      'De oorspronkelijke conductance wordt navenant verlaagd.'
      ''
      'Alle bestanden in idf-formaat in dezelfde resolutie.'
      ''
      'Invoerbestanden:'
      
        'ParamStr( 1 ): bdgriv_STEADY-STATE (idf-bestand als berekeningsr' +
        'esultaat van iMod '
      '(m3/d))'
      
        'ParamStr( 2 ): idf met river lokaties die aangepast moeten worde' +
        'n (als waarde > 0); '
      'ParamStr( 3 ): Oorspronkelijke conductance (m2/d)'
      
        'ParamStr( 4 ): Evenredigheidsconstante MBT CORRESPONDERENDE C-WA' +
        'ARDE (d2/m)'
      'ParamStr( 5 ): Idf-bestand met verlaagde conductances (m2/d)'
      ''
      'KVI 25-8-2017')
    TabOrder = 1
  end
  object SingleESRIgridRivFLX: TSingleESRIgrid
    Left = 120
    Top = 32
  end
  object SingleESRIgridRiv: TSingleESRIgrid
    Left = 216
    Top = 32
  end
  object SingleESRIgridCond: TSingleESRIgrid
    Left = 296
    Top = 32
  end
end
