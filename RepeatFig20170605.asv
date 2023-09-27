function RepeatFig20170605
close all

%　o11ooとoo11oで最も高い部分を探して、そこを中心に10bin四方くらい？の範囲で合計値を求める
%　それぞれの領域について、oo1oo、o11oo、oo11o、o111o、1111o、o1111、11111での値を求める。
%　

cd C:\Users\B133_2\Desktop\MatFig\11901_170607aSc8_SS_02

rFileName='11901_170607';
load(rFileName);

K=2;%計測する範囲
AL=10;%AreaLimit

Max=2;

MeanEventNum=mean(mean(Repeat.EventNum,1),3)
MeanEventNum2=mean(mean(Repeat.EventNum,2),3)
MeanEventNum3=mean(mean(Repeat.EventNum,1),2)

MainPoint=Repeat(1).MainPoint;
MainPoint0=MainPoint-2500;
AutoPitch=Repeat(1).Pitch;


SEoo1oo=Repeat(1).SEoo1oo;
SEo11oo=Repeat(1).SEo11oo;
SEoo11o=Repeat(1).SEoo11o;
SEo111o=Repeat(1).SEo111o;
SE1111o=Repeat(1).SE1111o;
SEo1111=Repeat(1).SEo1111;
SE11111=Repeat(1).SE11111;
SE00100=Repeat(1).SE00100;
SE01100=Repeat(1).SE01100;
SE00110=Repeat(1).SE00110;
SE11100=Repeat(1).SE11100;
SE00111=Repeat(1).SE00111;
SE01110=Repeat(1).SE01110;
SE11110=Repeat(1).SE11110;
SE01111=Repeat(1).SE01111;
SE11111=Repeat(1).SE11111;
SE1in3=Repeat(1).SE1in3;
SE2in3=Repeat(1).SE2in3;
SE3in3=Repeat(1).SE3in3;
SEtop1in4=Repeat(1).SEtop1in4;
SEtop2in4=Repeat(1).SEtop2in4;
SEtop3in4=Repeat(1).SEtop3in4;
SElast3in4=Repeat(1).SElast3in4;
SElast2in4=Repeat(1).SElast2in4;
SElast1in4=Repeat(1).SElast1in4;

    
Cline=[HighArea_o111oValue(1) max(HighArea_o111oValue(2),HighArea_o111oValue(3)) HighArea_o111oValue(4) max(HighArea_o111oValue(5),HighArea_o111oValue(6)) HighArea_o111oValue(7)];
Dline=[HighArea_01110Value(8) max(HighArea_01110Value(9),HighArea_01110Value(10)) HighArea_01110Value(13) max(HighArea_01110Value(14),HighArea_01110Value(15)) HighArea_01110Value(7)];


Point=['SEoo1oo' 'SEo11oo' 'SEoo11o' 'SEo111o' 'SE1111o' 'SEo1111' 'SE11111' 'SE00100' 'SE01100' 'SE00110'...
    'SE11100' 'SE00111' 'SE01110' 'SE11110' 'SE01111'];

save(rFileName,'HighArea_o111oValue','HighArea_01110Value',...
    'HighPoint_oo11o','HighPoint_o11oo','HighPoint_o111o','HighPoint_01110','Point','HighArea123in3','HighArea123_234in4','-append');


function CalcAreaValue(K,AL)



[a b]=find(SEo11oo==(max(max(SEo11oo(K+1:end-K-1,K+1:end-K-1)))));
[c d]=find(SEoo11o==(max(max(SEoo11o(K+1:end-K-1,K+1:end-K-1)))));
[e f]=find(SEo111o==(max(max(SEo111o(K+1:end-K-1,K+1:end-K-1)))));
[g h]=find(SE01110==(max(max(SE01110(K+1:end-K-1,K+1:end-K-1)))));

%         [a b]=find(SEo11oo==(max(max(SEo11oo))));
%         [c d]=find(SEoo11o==(max(max(SEoo11o))));
%         [e f]=find(SEo111o==(max(max(SEo111o))));
%         [g h]=find(SE01110==(max(max(SE01110))));
%         if a-K<1;a=1;end
%         if b-K<1;b=1;end
%         if c-K<1;c=1;end
%         if d-K<1;d=1;end
%         if e-K<1;e=1;end
%         if f-K<1;f=1;end
%         if g-K<1;b=1;end

[a b]=find(SEo11oo==(max(max(SEo11oo(AL:end-AL,AL:end-AL)))));
[c d]=find(SEoo11o==(max(max(SEoo11o(AL:end-AL,AL:end-AL)))));
[e f]=find(SEo111o==(max(max(SEo111o(AL:end-AL,AL:end-AL)))));
[g h]=find(SE01110==(max(max(SE01110(AL:end-AL,AL:end-AL)))));


% HighArea_o11ooValue(2)=sum(sum(SEo11oo(a-K:a+K,b-K:b+K)));

% HighArea_oo11oValue(3)=sum(sum(SEoo11o(c-K:c+K,d-K:d+K)));
% HighArea_o11ooValue(3)=sum(sum(SEoo11o(a-K:a+K,b-K:b+K)));
% HighArea_oo11oValue(2)=sum(sum(SEo11oo(c-K:c+K,d-K:d+K)));
% HighArea_oo11oValue(1)=sum(sum(SEoo1oo(c-K:c+K,d-K:d+K)));
% HighArea_o11ooValue(1)=sum(sum(SEoo1oo(a-K:a+K,b-K:b+K)));


% HighArea_oo11oValue(4)=sum(sum(SEo111o(c-K:c+K,d-K:d+K)));
% HighArea_o11ooValue(4)=sum(sum(SEo111o(a-K:a+K,b-K:b+K)));
HighArea_o111oValue(4)=sum(sum(SEo111o(e-K:e+K,f-K:f+K)));
HighArea_o111oValue(1)=sum(sum(SEoo1oo(e-K:e+K,f-K:f+K)));
HighArea_o111oValue(2)=sum(sum(SEo11oo(e-K:e+K,f-K:f+K)));
HighArea_o111oValue(3)=sum(sum(SEoo11o(e-K:e+K,f-K:f+K)));

% HighArea_oo11oValue(5)=sum(sum(SE1111o(c-K:c+K,d-K:d+K)));
% HighArea_o11ooValue(5)=sum(sum(SE1111o(a-K:a+K,b-K:b+K)));
HighArea_o111oValue(5)=sum(sum(SE1111o(e-K:e+K,f-K:f+K)));
% HighArea_oo11oValue(6)=sum(sum(SEo1111(c-K:c+K,d-K:d+K)));
% HighArea_o11ooValue(6)=sum(sum(SEo1111(a-K:a+K,b-K:b+K)));
HighArea_o111oValue(6)=sum(sum(SEo1111(e-K:e+K,f-K:f+K)));
% HighArea_oo11oValue(7)=sum(sum(SE11111(c-K:c+K,d-K:d+K)));
% HighArea_o11ooValue(7)=sum(sum(SE11111(a-K:a+K,b-K:b+K)));
HighArea_o111oValue(7)=sum(sum(SE11111(e-K:e+K,f-K:f+K)));
% HighArea_oo11oValue(8)=sum(sum(SE00100(c-K:c+K,d-K:d+K)));
% HighArea_o11ooValue(8)=sum(sum(SE00100(a-K:a+K,b-K:b+K)));
HighArea_o111oValue(8)=sum(sum(SE00100(e-K:e+K,f-K:f+K)));
% HighArea_oo11oValue(9)=sum(sum(SE01100(c-K:c+K,d-K:d+K)));
% HighArea_o11ooValue(9)=sum(sum(SE01100(a-K:a+K,b-K:b+K)));
HighArea_o111oValue(9)=sum(sum(SE01100(e-K:e+K,f-K:f+K)));
% HighArea_oo11oValue(10)=sum(sum(SE00110(c-K:c+K,d-K:d+K)));
% HighArea_o11ooValue(10)=sum(sum(SE00110(a-K:a+K,b-K:b+K)));
HighArea_o111oValue(10)=sum(sum(SE00110(e-K:e+K,f-K:f+K)));
% HighArea_oo11oValue(11)=sum(sum(SE11100(c-K:c+K,d-K:d+K)));
% HighArea_o11ooValue(11)=sum(sum(SE11100(a-K:a+K,b-K:b+K)));
HighArea_o111oValue(11)=sum(sum(SE11100(e-K:e+K,f-K:f+K)));
% HighArea_oo11oValue(12)=sum(sum(SE00111(c-K:c+K,d-K:d+K)));
% HighArea_o11ooValue(12)=sum(sum(SE00111(a-K:a+K,b-K:b+K)));
HighArea_o111oValue(12)=sum(sum(SE00111(e-K:e+K,f-K:f+K)));


% HighArea_oo11oValue(13)=sum(sum(SE01110(c-K:c+K,d-K:d+K)));
% HighArea_o11ooValue(13)=sum(sum(SE01110(a-K:a+K,b-K:b+K)));
HighArea_o111oValue(13)=sum(sum(SE01110(e-K:e+K,f-K:f+K)));
% HighArea_oo11oValue(14)=sum(sum(SE11110(c-K:c+K,d-K:d+K)));
% HighArea_o11ooValue(14)=sum(sum(SE11110(a-K:a+K,b-K:b+K)));
HighArea_o111oValue(14)=sum(sum(SE11110(e-K:e+K,f-K:f+K)));
% HighArea_oo11oValue(15)=sum(sum(SE01111(c-K:c+K,d-K:d+K)));
% HighArea_o11ooValue(15)=sum(sum(SE01111(a-K:a+K,b-K:b+K)));
HighArea_o111oValue(15)=sum(sum(SE01111(e-K:e+K,f-K:f+K)));

% HighArea_oo11oValue
% HighArea_o11ooValue
% HighArea_o111oValue
HighPoint_oo11o=[c d];
HighPoint_o11oo=[a b];
HighPoint_o111o=[e f];
HighPoint_01110=[g h];
% Aline=[HighArea_o11ooValue(1) HighArea_o11ooValue(2) HighArea_o11ooValue(4) HighArea_o11ooValue(5) HighArea_o11ooValue(7)];
% Bline=[HighArea_oo11oValue(1) HighArea_oo11oValue(3) HighArea_oo11oValue(4) HighArea_oo11oValue(6) HighArea_oo11oValue(7)];
HighArea_01110Value(1:6)=[0 0 0 0 0 0];
HighArea_01110Value(7)=sum(sum(SE11111(e-K:e+K,f-K:f+K)));
HighArea_01110Value(8)=sum(sum(SE00100(e-K:e+K,f-K:f+K)));
HighArea_01110Value(9)=sum(sum(SE01100(e-K:e+K,f-K:f+K)));
HighArea_01110Value(10)=sum(sum(SE00110(e-K:e+K,f-K:f+K)));
HighArea_01110Value(11)=sum(sum(SE11100(e-K:e+K,f-K:f+K)));
HighArea_01110Value(12)=sum(sum(SE00111(e-K:e+K,f-K:f+K)));
HighArea_01110Value(13)=sum(sum(SE01110(e-K:e+K,f-K:f+K)));
HighArea_01110Value(14)=sum(sum(SE11110(e-K:e+K,f-K:f+K)));
HighArea_01110Value(15)=sum(sum(SE01111(e-K:e+K,f-K:f+K)));
% SEoo1oo SEo11oo SEoo11o SEo111o SE1111o SEo1111 SE11111 SE00100 SE01100 SE00110 SE11100 SE00111 SE01110 SE11110 SE01111

HighArea123in3(1)=sum(sum(SE1in3(e-K:e+K,f-K:f+K)));
HighArea123in3(2)=sum(sum(SE2in3(e-K:e+K,f-K:f+K)));
HighArea123in3(3)=sum(sum(SE3in3(e-K:e+K,f-K:f+K)));
HighArea123_234in4(1)=sum(sum(SEtop1in4(e-K:e+K,f-K:f+K)));
HighArea123_234in4(2)=sum(sum(SEtop2in4(e-K:e+K,f-K:f+K)));
HighArea123_234in4(3)=sum(sum(SEtop3in4(e-K:e+K,f-K:f+K)));
HighArea123_234in4(4)=sum(sum(SElast3in4(e-K:e+K,f-K:f+K)))
HighArea123_234in4(5)=sum(sum(SElast2in4(e-K:e+K,f-K:f+K)));
HighArea123_234in4(6)=sum(sum(SElast3in4(e-K:e+K,f-K:f+K)));


function FigureArea
        
SEoo1oofig=figure
imagesc(SEoo1oo);colorbar
% axis([min(AutoPitch) max(AutoPitch) min(MainPoint0) max(MainPoint0) 0 Max]);
caxis([0 Max]);
title('SEoo1oo');
saveas(SEoo1oofig,'SEoo1oo.fig');

SEo11oofig=figure
imagesc(SEo11oo);colorbar
% axis([min(AutoPitch) max(AutoPitch) min(MainPoint0) max(MainPoint0) 0 Max]);
caxis([0 Max]);
title('SEo11oo');
saveas(SEo11oofig,'SEo11oo.fig');

SEoo11ofig=figure
imagesc(SEoo11o);colorbar
% axis([min(AutoPitch) max(AutoPitch) min(MainPoint0) max(MainPoint0) 0 Max]);
caxis([0 Max]);
title('SEoo11o');
saveas(SEoo11ofig,'SEoo11o.fig');

SEo111ofig=figure
imagesc(SEo111o);colorbar
% axis([min(AutoPitch) max(AutoPitch) min(MainPoint0) max(MainPoint0) 0 Max]);
caxis([0 Max]);
title('SEo111o');
saveas(SEo111ofig,'SEo111o.fig');

SE1111ofig=figure
imagesc(SE1111o);colorbar
% axis([min(AutoPitch) max(AutoPitch) min(MainPoint0) max(MainPoint0) 0 Max]);
caxis([0 Max]);
title('SE1111o');
saveas(SE1111ofig,'SE1111o.fig');

SEo1111fig=figure
imagesc(SEo1111);colorbar
% axis([min(AutoPitch) max(AutoPitch) min(MainPoint0) max(MainPoint0) 0 Max]);
caxis([0 Max]);
title('SEo1111');
saveas(SEo1111fig,'SEo1111.fig');

SE11111fig=figure
imagesc(SE11111);colorbar
% axis([min(AutoPitch) max(AutoPitch) min(MainPoint0) max(MainPoint0) 0 Max]);
caxis([0 Max]);
title('SE11111');
saveas(SE11111fig,'SE11111.fig');

SE00100fig=figure
imagesc(SE00100);colorbar
% axis([min(AutoPitch) max(AutoPitch) min(MainPoint0) max(MainPoint0) 0 Max]);
caxis([0 Max]);
title('SE00100');
saveas(SE00100fig,'SE00100.fig');

SE01100fig=figure
imagesc(SE01100);colorbar
% axis([min(AutoPitch) max(AutoPitch) min(MainPoint0) max(MainPoint0) 0 Max]);
caxis([0 Max]);
title('SE01100');
saveas(SE01100fig,'SE01100.fig');

SE00110fig=figure
imagesc(SE00110);colorbar
% axis([min(AutoPitch) max(AutoPitch) min(MainPoint0) max(MainPoint0) 0 Max]);
caxis([0 Max]);
title('SE00110');
saveas(SE00110fig,'SE00110.fig');

SE11100fig=figure
imagesc(SE11100);colorbar
% axis([min(AutoPitch) max(AutoPitch) min(MainPoint0) max(MainPoint0) 0 Max]);
caxis([0 Max]);
title('SE11100');
saveas(SE11100fig,'SE11100.fig');

SE00111fig=figure
imagesc(SE00111);colorbar
% axis([min(AutoPitch) max(AutoPitch) min(MainPoint0) max(MainPoint0) 0 Max]);
caxis([0 Max]);
title('SE00111');
saveas(SE00111fig,'SE00111.fig');

SE01110fig=figure
imagesc(SE01110);colorbar
% axis([min(AutoPitch) max(AutoPitch) min(MainPoint0) max(MainPoint0) 0 Max]);
caxis([0 Max]);
title('SE01110');
saveas(SE01110fig,'SE01110.fig');

SE11110fig=figure
imagesc(SE11110);colorbar
% axis([min(AutoPitch) max(AutoPitch) min(MainPoint0) max(MainPoint0) 0 Max]);
caxis([0 Max]);
title('SE11110');
saveas(SE11110fig,'SE11110.fig');

SE01111fig=figure
imagesc(SE01111);colorbar
% axis([min(AutoPitch) max(AutoPitch) min(MainPoint0) max(MainPoint0) 0 Max]);
caxis([0 Max]);
title('SE01111');
saveas(SE01111fig,'SE01111.fig');

SE11111fig=figure
imagesc(SE11111);colorbar
% axis([min(AutoPitch) max(AutoPitch) min(MainPoint0) max(MainPoint0) 0 Max]);
caxis([0 Max]);
title('SE11111');
saveas(SE11111fig,'SE11111.fig');

SE1in3fig=figure
imagesc(SE1in3);colorbar
% axis([min(AutoPitch) max(AutoPitch) min(MainPoint0) max(MainPoint0) 0 Max]);
caxis([0 Max]);
title('SE1in3');
saveas(SE1in3fig,'SE1in3.fig');

SE2in3fig=figure
imagesc(SE2in3);colorbar
% axis([min(AutoPitch) max(AutoPitch) min(MainPoint0) max(MainPoint0) 0 Max]);
caxis([0 Max]);
title('SE2in3');
saveas(SE2in3fig,'SE2in3.fig');

SE3in3fig=figure
imagesc(SE3in3);colorbar
% axis([min(AutoPitch) max(AutoPitch) min(MainPoint0) max(MainPoint0) 0 Max]);
caxis([0 Max]);
title('SE3in3');
saveas(SE3in3fig,'SE3in3.fig');

SEtop1in4fig=figure
imagesc(SEtop1in4);colorbar
% axis([min(AutoPitch) max(AutoPitch) min(MainPoint0) max(MainPoint0) 0 Max]);
caxis([0 Max]);
title('SEtop1in4');
saveas(SEtop1in4fig,'SEtop1in4.fig');

SEtop2in4fig=figure
imagesc(SEtop2in4);colorbar
% axis([min(AutoPitch) max(AutoPitch) min(MainPoint0) max(MainPoint0) 0 Max]);
caxis([0 Max]);
title('SEtop2in4');
saveas(SEtop2in4fig,'SEtop2in4.fig');

SEtop3in4fig=figure
imagesc(SEtop3in4);colorbar
% axis([min(AutoPitch) max(AutoPitch) min(MainPoint0) max(MainPoint0) 0 Max]);
caxis([0 Max]);
title('SEtop3in4');
saveas(SEtop3in4fig,'SEtop3in4.fig');

SElast3in4fig=figure
imagesc(SElast3in4);colorbar
% axis([min(AutoPitch) max(AutoPitch) min(MainPoint0) max(MainPoint0) 0 Max]);
caxis([0 Max]);
title('SElast3in4');
saveas(SElast3in4fig,'SElast3in4.fig');

SElast2in4fig=figure
imagesc(SElast2in4);colorbar
% axis([min(AutoPitch) max(AutoPitch) min(MainPoint0) max(MainPoint0) 0 Max]);
caxis([0 Max]);
title('SElast2in4');
saveas(SElast2in4fig,'SElast2in4.fig');

SElast1in4fig=figure
imagesc(SElast1in4);colorbar
% axis([min(AutoPitch) max(AutoPitch) min(MainPoint0) max(MainPoint0) 0 Max]);
caxis([0 Max]);
title('SElast1in4');
saveas(SElast1in4fig,'SElast1in4.fig');
