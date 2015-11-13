unit Unit1;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, jpeg, ExtCtrls, StdCtrls;

type
  TForm1 = class(TForm)
    Fundo: TImage;
    P: TImage;
    A: TImage;
    Timer1: TTimer;
    Timer2: TTimer;
    Dragon: TImage;
    Pontos: TLabel;
    Timer3: TTimer;
    Label1: TLabel;
    procedure Timer1Timer(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure Timer2Timer(Sender: TObject);
    procedure Timer3Timer(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  Form1: TForm1;
  varPontos:integer;

implementation
    function bateu(obj1:TImage; obj2:TImage): boolean;
    begin
        Result := true;
        if (obj1.Left+obj1.Width<obj2.Left) or
        (obj1.Left>obj2.Width+obj2.Left) or
        (obj1.Top+obj1.Height<obj2.Top) or
        (obj1.Top> obj2.Top+obj2.Height) then
        Result := false;
    end;

{$R *.dfm}

procedure novojogo();
begin
Form1.Timer1.Enabled := true;
Form1.Timer2.Enabled := true;
Form1.Timer3.Enabled := true;
Form1.dragon.Left := random(800);
Form1.dragon.Top := random(400);
Form1.A.Left := 500 ;
Form1.A.top := 180;
Form1.P.Left := 60;
Form1.P.top := 200;
Form1.pontos.Caption := '0';
VarPontos :=0;
end;

procedure TForm1.Timer1Timer(Sender: TObject);
begin
    if(getkeystate(vk_up)<0)
        then
            P.Top:=P.Top-5;
    if(getkeystate(vk_down)<0)
        then
            P.Top:=P.Top+5;
    if(getkeystate(vk_right)<0)
        then
            P.Left:=P.Left+5;
    if(getkeystate(vk_left)<0)
        then
            P.Left:=P.Left-5;

    if(P.Left>=Form1.Width-50)
        then
            P.Left:=P.Left-5;
    if(P.Left<=1)
        then
            P.Left:=P.Left+5;
    if(P.Top>=Form1.Height-75)
        then
            P.Top:=P.top-5;
    if(P.Top<=1)
        then
            P.Top:=P.Top+5;

    if(VarPontos=5)
        then
            begin
                A.Picture.LoadFromFile('animations\Silver.ico');
                P.Picture.LoadFromFile('animations\Gold.ico');
                Dragon.Picture.LoadFromFile('animations\Platinum.ico');
            end;
    if(VarPontos=10)
        then
            begin
                A.Picture.LoadFromFile('animations\Gold.ico');
                P.Picture.LoadFromFile('animations\Platinum.ico');
                Dragon.Picture.LoadFromFile('animations\Diamond.ico');
            end;
    if(VarPontos=15)
       then
           begin
               A.Picture.LoadFromFile('animations\Platinum.ico');
               P.Picture.LoadFromFile('animations\Diamond.ico');
               Dragon.Picture.LoadFromFile('animations\Challenger.ico');
           end;
    if(VarPontos=20)
        then
            begin
                A.Picture.LoadFromFile('animations\Diamond.ico');
                P.Picture.LoadFromFile('animations\Challenger.ico');
                Dragon.Picture.LoadFromFile('animations\World.ico');
            end;
end;

procedure TForm1.FormCreate(Sender: TObject);
begin
    doublebuffered:=true;
    novojogo;
end;

procedure TForm1.Timer2Timer(Sender: TObject);
begin
    if (P.Left+P.Width<A.Left)
        then
            A.Left:=A.Left-5;
    if (p.Left>a.Width+a.Left)
        then
            A.Left:=A.Left+5;
    if (p.Top+p.Height<a.Top)
        then
            A.Top:=A.top-5;
    if (p.Top> a.Top+a.Height)
        then
            A.Top:=A.Top+5;
end;

procedure TForm1.Timer3Timer(Sender: TObject);
begin
if bateu(p,dragon)
    then
        begin
            randomize;
            dragon.Left := random(700);
            dragon.Top := random(400);
            VarPontos := VarPontos+1;
            pontos.Caption := IntToStr(VarPontos);
        end;
if bateu(p,a)
    then
        begin
            Timer1.Enabled := false;
            Timer2.Enabled := false;
            Timer3.Enabled := false;
            showmessage('Voce Perdeu!  Pontos: '+inttostr(VarPontos));
            close;
        end;

end;

end.
