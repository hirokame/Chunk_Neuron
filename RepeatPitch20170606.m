function RepeatPitch20170606

global ACvalue Pitch MainPointX AutoCorrValue SE lengthEvent T autoy CCresult AutoCal Repeat...
    SpikeCount EventCount1 EventCount2 EventCount3 EventCount4 EventCount5 AC ControlSp MainPoint AutoPitch...
    Ratio111 Ratio110 Ratio101 Ratio100 Ratio011 Ratio010 Ratio001 Ratio000 Present...
    ERatio111 ERatio110 ERatio101 ERatio100 ERatio011 ERatio010 ERatio001 ERatio000...
    SE1sum SE2sum SE3sum SE4sum SE5sum SE12sum SE23sum SE34sum SE45sum SE123sum...
    SE234sum SE345sum SE1234sum SE2345sum SE12345sum...
    SE01100sum SE00110sum SE01110sum SE11110sum SE01111sum...
    SE10101sum SE11011sum SE11010sum SE01011sum SE01010sum SE00100sum SE00110sum SE11100sum...
    DurationA SEoo01110sum SEo01110osum SE01110oosum...
    SEoo01111sum SEo01111osum SE01111oosum SEoo11110sum SEo11110osum SE11110oosum

ControlSp 

%yはwindowの赤線の高さ,これをAutoCalcでは別に指定する。高さを変えて示すため
AutoCal=1;%%%%%%%赤線を表示する場合に使用
EventCount1=[]; EventCount2=[]; EventCount3=[]; EventCount4=[]; EventCount5=[];
if AutoCorrValue==10%AutoCorrValue==10はDrinkOff
%     MainPointStart=-150;%Drinkの場合、spikeから-150msから15ms刻みで行う。
    MainPoint0=-150:10:150;%[-150,-120,-90,-60,-30,0,30,60,90,120,150];
    MainPoint=MainPoint0+500;%Drinkの場合、全長2000ms、中心1000ms
    AutoPitch=30:10:200;%[60,80,100,120,140,160,180,200,240,260,280];%,250,300,350,400,450,500,550,600,650,700,750,800];
else
%     AutoPitch=[300,350,400,450,500,550,600,650,700,750,800];
%     MainPointStart=-500;%Drink以外の場合、spikeから-500msから50ms刻みで行う。
    MainPoint0=-500:25:500;%[-500,-400,-300,-200,-100,0,100,200,300,400,500];

    MainPoint=MainPoint0+2500;%Drink以外の場合、全長5000ms、中心2500ms
%     AutoPitch=[600,625,650,675,700,725,750,775,800];
    AutoPitch=[200,225,250,275,300,325,350,375,400,425,450,475,500,525,550,575,600,625,650,675,700,725,750,775,800,825,850,875,900,925,950,975,1000];

end

SE1oooo=zeros(length(MainPoint),length(AutoPitch));
SEo1ooo=zeros(length(MainPoint),length(AutoPitch));
SEoo1oo=zeros(length(MainPoint),length(AutoPitch));
SEooo1o=zeros(length(MainPoint),length(AutoPitch));
SEoooo1=zeros(length(MainPoint),length(AutoPitch));
    
SE11ooo=zeros(length(MainPoint),length(AutoPitch));
SEo11oo=zeros(length(MainPoint),length(AutoPitch));
SEoo11o=zeros(length(MainPoint),length(AutoPitch));
SEooo11=zeros(length(MainPoint),length(AutoPitch));
SE111oo=zeros(length(MainPoint),length(AutoPitch));
SEo111o=zeros(length(MainPoint),length(AutoPitch));
SEoo111=zeros(length(MainPoint),length(AutoPitch));
SE1111o=zeros(length(MainPoint),length(AutoPitch));
SEo1111=zeros(length(MainPoint),length(AutoPitch));
SE11111=zeros(length(MainPoint),length(AutoPitch));

SE00100=zeros(length(MainPoint),length(AutoPitch));
SE01100=zeros(length(MainPoint),length(AutoPitch));
SE00110=zeros(length(MainPoint),length(AutoPitch));

SE11100=zeros(length(MainPoint),length(AutoPitch));
SE00111=zeros(length(MainPoint),length(AutoPitch));
SE01110=zeros(length(MainPoint),length(AutoPitch));
SE11110=zeros(length(MainPoint),length(AutoPitch));
SE01111=zeros(length(MainPoint),length(AutoPitch));
SE10101=zeros(length(MainPoint),length(AutoPitch));
SE01010=zeros(length(MainPoint),length(AutoPitch));
SE11011=zeros(length(MainPoint),length(AutoPitch));
SE11010=zeros(length(MainPoint),length(AutoPitch));
SE01011=zeros(length(MainPoint),length(AutoPitch));
SE01010=zeros(length(MainPoint),length(AutoPitch));

SE1in3=zeros(length(MainPoint),length(AutoPitch));
SE2in3=zeros(length(MainPoint),length(AutoPitch));
SE3in3=zeros(length(MainPoint),length(AutoPitch));

SEtop1in4=zeros(length(MainPoint),length(AutoPitch));
SEtop2in4=zeros(length(MainPoint),length(AutoPitch));
SEtop3in4=zeros(length(MainPoint),length(AutoPitch));
SElast1in4=zeros(length(MainPoint),length(AutoPitch));
SElast2in4=zeros(length(MainPoint),length(AutoPitch));
SElast3in4=zeros(length(MainPoint),length(AutoPitch));

Event1=cell(length(MainPoint),length(AutoPitch));Event2=cell(length(MainPoint),length(AutoPitch));Event3=cell(length(MainPoint),length(AutoPitch));Event4=cell(length(MainPoint),length(AutoPitch));Event5=cell(length(MainPoint),length(AutoPitch));
% SE_ADD=zeros(length(AutoPitch),length(SE(1,:)),length(MainPoint));
% Event_ADD=zeros(length(AutoPitch),length(SE(1,:)),length(MainPoint));
SE_ADD=zeros(length(AutoPitch),34,length(MainPoint));
Event_ADD=zeros(length(AutoPitch),34,length(MainPoint));

for m=1:length(MainPoint)

%     MainPointX=MainPointStart+(-0.1)*MainPointStart*m;%MainPointStartはマイナスの値
    MainPointX=MainPoint(m);
    
% SE=[SE1sum SE2sum SE3sum SE4sum SE5sum SE12sum SE23sum SE34sum SE45sum SE123sum... 
%      SE234sum SE345sum SE12345sum SE24Inv3sum SE1245Inv3sum SE3Inv234sum SE3Inv12345sum];

%     SEadd=[];lengthEventAdd=[];
    for n=1:length(AutoPitch)
%         AC
        Pitch=AutoPitch(n);
        [MainPointX-2500 Pitch]
        autoy=max(CCresult)*(1/(length(AutoPitch)*length(MainPoint)))*((m-1)*length(AutoPitch)+n);

%         pushbutton_WindowSetA_Callback(hObject, eventdata, handles);
        WindowSetA%Astart,Aend,LenAなど作成
        
        CalcInterval%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%         pushbutton_Calc_Callback(hObject, eventdata, handles);
        global Present
        
        DurA(m,n)=DurationA;
        
    %oは有ってもなくてもよい、0は有るとダメ、1はないとダメ
        SE1oooo(m,n)=SE1sum;SEo1ooo(m,n)=SE2sum;SEoo1oo(m,n)=SE3sum;SEooo1o(m,n)=SE4sum;SEoooo1(m,n)=SE5sum;
    
        SE11ooo(m,n)=SE12sum;SEo11oo(m,n)=SE23sum;SEoo11o(m,n)=SE34sum;SEooo11(m,n)=SE45sum;
        SE111oo(m,n)=SE123sum;SEo111o(m,n)=SE234sum;SEoo111(m,n)=SE345sum;
        SE1111o(m,n)=SE1234sum;SEo1111(m,n)=SE2345sum;SE11111(m,n)=SE12345sum;
        
        SE00100(m,n)=SE00100sum;
        SE01100(m,n)=SE01100sum; 
        SE00110(m,n)=SE00110sum; 
        
        SE11100(m,n)=SE00110sum;
        SE00111(m,n)=SE11100sum;
        SE01110(m,n)=SE01110sum; 
        SE11110(m,n)=SE11110sum; 
        SE01111(m,n)=SE01111sum;
        SE10101(m,n)=SE10101sum;
        SE01010(m,n)=SE01010sum;
        SE11011(m,n)=SE11011sum;
        SE11010(m,n)=SE11010sum;
        SE01011(m,n)=SE01011sum;
        SE01010(m,n)=SE01010sum;
        
        SE1in3(m,n)=SEoo01110sum;%最初
        SE2in3(m,n)=SEo01110osum;%真ん中
        SE3in3(m,n)=SE01110oosum;%最後

        SEtop1in4(m,n)=SEoo01111sum;%最初
        SEtop2in4(m,n)=SEo01111osum;%前から2番目
        SEtop3in4(m,n)=SE01111oosum;%前から3番目
        SElast1in4(m,n)=SE11110oosum;%最後
        SElast2in4(m,n)=SEo11110osum;%最後から2番目
        SElast3in4(m,n)=SEoo11110sum;%最後から3番目

        SE_ADD(n,:,m)=SE;
        Event_ADD(n,:,m)=lengthEvent;

        Event1{m,n}=EventCount1;
        Event2{m,n}=EventCount2;
        Event3{m,n}=EventCount3;
        Event4{m,n}=EventCount4;
        Event5{m,n}=EventCount5;
    end
end
    
% if isempty(AC)
%     AC=1;
% end

Repeat(ACvalue).name=T;
Repeat(ACvalue).Duration=DurA;
Repeat(ACvalue).MainPoint=MainPoint;
Repeat(ACvalue).Pitch=AutoPitch;
Repeat(ACvalue).SE=SE_ADD;
Repeat(ACvalue).EventNum=Event_ADD;
Repeat(ACvalue).spike=SpikeCount;
Repeat(ACvalue).Event1=Event1;
Repeat(ACvalue).Event2=Event2;
Repeat(ACvalue).Event3=Event3;
Repeat(ACvalue).Event4=Event4;
Repeat(ACvalue).Event5=Event5;
Repeat(ACvalue).SE1oooo=SE1oooo;Repeat(ACvalue).SEo1ooo=SEo1ooo;Repeat(ACvalue).SEoo1oo=SEoo1oo;Repeat(ACvalue).SEooo1o=SEooo1o;Repeat(ACvalue).SEoooo1=SEoooo1;
Repeat(ACvalue).SE11ooo=SE11ooo;Repeat(ACvalue).SEo11oo=SEo11oo;Repeat(ACvalue).SEoo11o=SEoo11o;Repeat(ACvalue).SEooo11=SEooo11;
Repeat(ACvalue).SE111oo=SE111oo;Repeat(ACvalue).SEo111o=SEo111o;Repeat(ACvalue).SEoo111=SEoo111;
Repeat(ACvalue).SE1111o=SE1111o;Repeat(ACvalue).SEo1111=SEo1111;
Repeat(ACvalue).SE11111=SE11111;
Repeat(ACvalue).SE00100=SE00100;
Repeat(ACvalue).SE01100=SE01100;
Repeat(ACvalue).SE00110=SE00110;

Repeat(ACvalue).SE11100=SE11100;
Repeat(ACvalue).SE00111=SE00111;
Repeat(ACvalue).SE01110=SE01110;
Repeat(ACvalue).SE11110=SE11110;
Repeat(ACvalue).SE01111=SE01111;
Repeat(ACvalue).SE10101=SE10101;
Repeat(ACvalue).SE01010=SE01010;
Repeat(ACvalue).SE11011=SE11011;
Repeat(ACvalue).SE11010=SE11010;
Repeat(ACvalue).SE01011=SE01011;
Repeat(ACvalue).SE01010=SE01010;

Repeat(ACvalue).SE1in3=SE1in3;%最初
Repeat(ACvalue).SE2in3=SE2in3;%真ん中
Repeat(ACvalue).SE3in3=SE3in3;%最後

Repeat(ACvalue).SEtop1in4=SEtop1in4;%最初
Repeat(ACvalue).SEtop2in4=SEtop2in4;%前から2番目
Repeat(ACvalue).SEtop3in4=SEtop3in4;%前から3番目
Repeat(ACvalue).SElast1in4=SElast1in4;%最後
Repeat(ACvalue).SElast2in4=SElast2in4;%最後から2番目
Repeat(ACvalue).SElast3in4=SElast3in4;%最後から3番目

if Present==1
Repeat(ACvalue).Ratio3nan=Ratio3Allnan;
Repeat(ACvalue).Ratio3=Ratio3All;
Repeat(ACvalue).Ratio5nan=Ratio5Allnan;
Repeat(ACvalue).Ratio5=Ratio5All;
Repeat(ACvalue).Ratio111=Ratio111All;
Repeat(ACvalue).Ratio110=Ratio110All;
Repeat(ACvalue).Ratio101=Ratio101All;
Repeat(ACvalue).Ratio100=Ratio100All;
Repeat(ACvalue).Ratio011=Ratio011All;
Repeat(ACvalue).Ratio010=Ratio010All;
Repeat(ACvalue).Ratio001=Ratio001All;
Repeat(ACvalue).Ratio000=Ratio000All;
end

function CalcInterval

global Astart Aend ACselect CCselect CCselect2 CCselect3 SE lengthEvent ACvalue ACselect...
    SpikeCount EventCount1 EventCount2 EventCount3 EventCount4 EventCount5 ControlSp...
    Ratio111 Ratio110 Ratio101 Ratio100 Ratio011 Ratio010 Ratio001 Ratio000...
    ERatio111 ERatio110 ERatio101 ERatio100 ERatio011 ERatio010 ERatio001 ERatio000 SpikeBinWidth Present...
    SE1sum SE2sum SE3sum SE4sum SE5sum SE12sum SE23sum SE34sum SE45sum SE123sum...
    SE234sum SE345sum SE1234sum SE2345sum SE12345sum...
    SE01100sum SE00110sum SE01110sum SE11110sum SE01111sum...
    SE10101sum SE11011sum SE11010sum SE01011sum SE01010sum SE00100sum SE00110sum SE11100sum...
    DurationA SEoo01110sum SEo01110osum SE01110oosum...
    SEoo01111sum SEo01111osum SE01111oosum SEoo11110sum SEo11110osum SE11110oosum
%ACselectがRPegtouchALLあるいはRpegTimeArray,CCselect3がSpikeArray1などになるはず%%%%

% contents=cellstr(get(handles.popupmenu_SpikeBin,'String'));
% SpikeBinWidth=str2double(contents{get(handles.popupmenu_SpikeBin,'Value')});%50;

SpikeWindow=ACselect(1)+Astart(1):10:ACselect(end)-Aend(5);
SpikeWindowsize=size(SpikeWindow);
% SpikeWindow(1:20)
A1start=Astart(1);
A1end=Aend(1);
A3start=Astart(3);
A3end=Aend(3);
A5start=Astart(5);
A5end=Aend(5);

DurationA=Aend(3)-Astart(3);

SpikeCount=zeros(1,length(SpikeWindow));EventCount1=zeros(1,length(SpikeWindow));EventCount2=zeros(1,length(SpikeWindow));EventCount3=zeros(1,length(SpikeWindow));EventCount4=zeros(1,length(SpikeWindow));EventCount5=zeros(1,length(SpikeWindow));
for n=1:length(SpikeWindow)
    SpikeCount(n)=length(CCselect(CCselect>=SpikeWindow(n)-SpikeBinWidth/2 & CCselect<SpikeWindow(n)+SpikeBinWidth/2));
    EventCount0(n)=length(ACselect(ACselect>=SpikeWindow(n)+Astart(1) & ACselect<SpikeWindow(n)+Aend(1)+10));
    EventCount1(n)=length(ACselect(ACselect>=SpikeWindow(n)+Astart(2) & ACselect<SpikeWindow(n)+Aend(2)+10));
    EventCount2(n)=length(ACselect(ACselect>=SpikeWindow(n)+Astart(3) & ACselect<SpikeWindow(n)+Aend(3)+10));
    EventCount3(n)=length(ACselect(ACselect>=SpikeWindow(n)+Astart(4) & ACselect<SpikeWindow(n)+Aend(4)+10));
    EventCount4(n)=length(ACselect(ACselect>=SpikeWindow(n)+Astart(5) & ACselect<SpikeWindow(n)+Aend(5)+10));
    EventCount5(n)=length(ACselect(ACselect>=SpikeWindow(n)+Astart(6) & ACselect<SpikeWindow(n)+Aend(6)+10));
    EventCount6(n)=length(ACselect(ACselect>=SpikeWindow(n)+Astart(7) & ACselect<SpikeWindow(n)+Aend(7)+10));
end

if ControlSp==1%SpikeCountの順番をランダムにふり、ControlのSpikeCountを作成
%     thd=sum(SpikeCount)/length(SpikeCount);
    [rnd,index]=sort(rand(1,length(SpikeCount)),'descend');
    SpikeCount=SpikeCount(index);
end

SpikeCount=int8(SpikeCount);
EventCount0=int8(EventCount0);EventCount1=int8(EventCount1);EventCount2=int8(EventCount2);EventCount3=int8(EventCount3);EventCount4=int8(EventCount4);EventCount5=int8(EventCount5);EventCount6=int8(EventCount6);

% SpikeCount(SpikeCount>1)=1;%ひとつのbinに2つ以上のスパイクが入ってもカウントは１とする。
EventCount0(EventCount0>1)=1;EventCount1(EventCount1>1)=1;EventCount2(EventCount2>1)=1;EventCount3(EventCount3>1)=1;EventCount4(EventCount4>1)=1;EventCount5(EventCount5>1)=1;EventCount6(EventCount6>1)=1;

% Present=get(handles.radiobutton_present_absent,'Value');%Eventがあるときをカウントするか、ないときをカウントするか

% if Present~=1%そこにイベントがないとき
%     EventCount1(EventCount1>=1)=-1;EventCount1(EventCount1==0)=1;EventCount1(EventCount1==-1)=0;
%     EventCount2(EventCount2>=1)=-1;EventCount2(EventCount2==0)=1;EventCount2(EventCount2==-1)=0;
%     EventCount3(EventCount3>=1)=-1;EventCount3(EventCount3==0)=1;EventCount3(EventCount3==-1)=0;
%     EventCount4(EventCount4>=1)=-1;EventCount4(EventCount4==0)=1;EventCount4(EventCount4==-1)=0;
%     EventCount5(EventCount5>=1)=-1;EventCount5(EventCount5==0)=1;EventCount5(EventCount5==-1)=0;
% end
% SE0=SpikeCount.*EventCount0;SE0sum=sum(SE0)/length(EventCount0(EventCount0==1));
SE1=SpikeCount.*EventCount1;SE1sum=sum(SE1)/length(EventCount1(EventCount1==1));
SE2=SpikeCount.*EventCount2;SE2sum=sum(SE2)/length(EventCount2(EventCount2==1));
SE3=SpikeCount.*EventCount3;SE3sum=sum(SE3)/length(EventCount3(EventCount3==1));
SE4=SpikeCount.*EventCount4;SE4sum=sum(SE4)/length(EventCount4(EventCount4==1));
SE5=SpikeCount.*EventCount5;SE5sum=sum(SE5)/length(EventCount5(EventCount5==1));
% SE6=SpikeCount.*EventCount6;SE6sum=sum(SE6)/length(EventCount6(EventCount6==1));

E12=EventCount1.*EventCount2;%disp('SE12');
SE12=SpikeCount.*E12;SE12sum=sum(SE12)/length(E12(E12==1));
E23=EventCount2.*EventCount3;%disp('SE23');
SE23=SpikeCount.*E23;SE23sum=sum(SE23)/length(E23(E23==1));
E34=EventCount3.*EventCount4;%disp('SE34');
SE34=SpikeCount.*E34;SE34sum=sum(SE34)/length(E34(E34==1));
E45=EventCount4.*EventCount5;%disp('SE45');
SE45=SpikeCount.*E45;SE45sum=sum(SE45)/length(E45(E45==1));

E123=EventCount1.*E23;%disp('SE123');
SE123=SpikeCount.*E123;
SE123sum=sum(SE123)/length(E123(E123==1));

E234=EventCount2.*E34;%disp('SE234');
SE234=SpikeCount.*E234;
SE234sum=sum(SE234)/length(E234(E234==1));

E345=EventCount3.*E45;%disp('SE345');
SE345=SpikeCount.*E345;
SE345sum=sum(SE345)/length(E345(E345==1));

E1234=E123.*EventCount4;%disp('SE1234');
SE1234=SpikeCount.*E1234;
SE1234sum=sum(SE1234)/length(E1234(E1234==1));

E2345=EventCount2.*E345;%disp('SE2345');
SE2345=SpikeCount.*E2345;
SE2345sum=sum(SE2345)/length(E2345(E2345==1));

E12345=E12.*E345;%disp('SE12345');
SE12345=SpikeCount.*E12345;
SE12345sum=sum(SE12345)/length(E12345(E12345==1));

Inv0=int8(not(EventCount0));Inv1=int8(not(EventCount1));Inv2=int8(not(EventCount2));Inv3=int8(not(EventCount3));Inv4=int8(not(EventCount4));Inv5=int8(not(EventCount5));Inv6=int8(not(EventCount6));

E00100=Inv1.*Inv2.*EventCount3.*Inv4.*Inv5;
SE00100=SpikeCount.*E00100;
SE00100sum=sum(SE00100)/length(E00100(E00100==1));

E01100=Inv1.*EventCount2.*EventCount3.*Inv4.*Inv5;
SE01100=SpikeCount.*E01100;
SE01100sum=sum(SE01100)/length(E01100(E01100==1));

E00110=Inv1.*Inv2.*EventCount3.*EventCount4.*Inv5;
SE00110=SpikeCount.*E00110;
SE00110sum=sum(SE00110)/length(E00110(E00110==1));

E11100=EventCount1.*EventCount2.*EventCount3.*Inv4.*Inv5;
SE11100=SpikeCount.*E11100;
SE11100sum=sum(SE11100)/length(E11100(E11100==1));

E00111=Inv1.*Inv2.*EventCount3.*EventCount4.*EventCount5;
SE00111=SpikeCount.*E00111;
SE00111sum=sum(SE00111)/length(E00111(E00111==1));

E01110=Inv1.*EventCount2.*EventCount3.*EventCount4.*Inv5;
SE01110=SpikeCount.*E01110;
SE01110sum=sum(SE01110)/length(E01110(E01110==1));

E11110=EventCount1.*EventCount2.*EventCount3.*EventCount4.*Inv5;
SE11110=SpikeCount.*E11110;
SE11110sum=sum(SE11110)/length(E11110(E11110==1));

E01111=Inv1.*EventCount2.*EventCount3.*EventCount4.*EventCount5;
SE01111=SpikeCount.*E01111;
SE01111sum=sum(SE01111)/length(E01111(E01111==1));

E10101=EventCount1.*Inv2.*EventCount3.*Inv4.*EventCount5;
SE10101=SpikeCount.*E10101;
SE10101sum=sum(SE10101)/length(E10101(E10101==1));

E11011=EventCount1.*EventCount2.*Inv3.*EventCount4.*EventCount5;
SE11011=SpikeCount.*E11011;
SE11011sum=sum(SE11011)/length(E11011(E11011==1));

E11010=EventCount1.*EventCount2.*Inv3.*EventCount4.*Inv5;
SE11010=SpikeCount.*E11010;
SE11010sum=sum(SE11010)/length(E11010(E11010==1));

E01011=Inv1.*EventCount2.*Inv3.*EventCount4.*EventCount5;
SE01011=SpikeCount.*E01011;
SE01011sum=sum(SE01011)/length(E01011(E01011==1));

E01010=Inv1.*EventCount2.*Inv3.*EventCount4.*Inv5;
SE01010=SpikeCount.*E01010;
SE01010sum=sum(SE01010)/length(E01010(E01010==1));

E01110oo=Inv0.*EventCount1.*EventCount2.*EventCount3.*Inv4;%.*Inv5.*Inv6;
SE01110oo=SpikeCount.*E01110oo;
SE01110oosum=sum(SE01110oo)/length(E01110oo(E01110oo==1));%Event3が最後の場合

% Eo01110o=Inv1.*EventCount2.*EventCount3.*EventCount4.*Inv5;
% SEo01110o=SpikeCount.*Eo01110o;
% SEo01110osum=sum(SEo01110o)/length(Eo01110o(Eo01110o==1));
Eo01110o=E01110;
SEo01110osum=SE01110sum;%Event3が真ん中の場合

Eoo01110=Inv2.*EventCount3.*EventCount4.*EventCount5.*Inv6;
SEoo01110=SpikeCount.*Eoo01110;
SEoo01110sum=sum(SEoo01110)/length(Eoo01110(Eoo01110==1));%Event3が最初の場合

E11110oo=EventCount0.*EventCount1.*EventCount2.*EventCount3.*Inv4;%.*Inv5.*Inv6;
SE11110oo=SpikeCount.*E11110oo;
SE11110oosum=sum(SE11110oo)/length(E11110oo(E11110oo==1));%Event3が後ろから１番目の場合

% Eo11110o=EventCount1.*EventCount1.*EventCount2.*EventCount3.*Inv4;%.*Inv5.*Inv6;
% SEo11110o=SpikeCount.*Eo11110o;
% SEo11110osum=sum(SEo11110o)/length(Eo11110o(Eo11110o==1));
Eo11110o=E11110;
SEo11110osum=SE11110sum;%Event3が後ろから2番目の場合

Eoo11110=EventCount2.*EventCount3.*EventCount4.*EventCount5.*Inv6;%.*Inv5.*Inv6;
SEoo11110=SpikeCount.*Eoo11110;
SEoo11110sum=sum(SEoo11110)/length(Eoo11110(Eoo11110==1));%Event3が後ろから３番目の場合

E01111oo=Inv0.*EventCount1.*EventCount2.*EventCount3.*EventCount4;%.*Inv5.*Inv6;
SE01111oo=SpikeCount.*E01111oo;
SE01111oosum=sum(SE01111oo)/length(E01111oo(E01111oo==1));%Event3が前から３番目の場合

% Eo01111o=Inv1.*EventCount2.*EventCount3.*EventCount4.*EventCount5;%.*Inv5.*Inv6;
% SEo01111o=SpikeCount.*Eo01111o;
% SEo01111osum=sum(Eo01111o)/length(Eo01111o(Eo01111o==1));
Eo01111o=E01111;
SEo01111osum=SE01111sum;%Event3が前から2番目の場合

Eoo01111=Inv2.*EventCount3.*EventCount4.*EventCount5.*EventCount6;%.*Inv5.*Inv6;
SEoo01111=SpikeCount.*Eoo01111;
SEoo01111sum=sum(SEoo01111)/length(Eoo01111(Eoo01111==1));%Event3が前から１番目の場合

SE=[SE1sum SE2sum SE3sum SE4sum SE5sum SE12sum SE23sum SE34sum SE45sum SE123sum...
    SE234sum SE345sum SE1234sum SE2345sum SE12345sum...
    SE01100sum SE00110sum SE01110sum SE11110sum SE01111sum...
    SE10101sum SE11011sum SE11010sum SE01011sum SE01010sum...
    SEoo01110sum SEo01110osum SE01110oosum...
    SEoo01111sum SEo01111osum SE01111oosum SEoo11110sum SEo11110osum SE11110oosum];

lengthEvent=[length(EventCount1(EventCount1==1)) length(EventCount2(EventCount2==1)) length(EventCount3(EventCount3==1))...
    length(EventCount4(EventCount4==1)) length(EventCount5(EventCount5==1))...
    length(E12(E12==1)) length(E23(E23==1)) length(E34(E34==1)) length(E45(E45==1))...
    length(E123(E123==1)) length(E234(E234==1)) length(E345(E345==1))...
    length(E1234(E1234==1)) length(E2345(E2345==1)) length(E12345(E12345==1))...
    length(E01100(E01100==1)) length(E00110(E00110==1)) length(E01110(E01110==1))...
    length(E11110(E11110==1)) length(E01111(E01111==1))...
    length(E10101(E10101==1)) length(E11011(E11011==1)) length(E11010(E11010==1)) length(E01011(E01011==1)) length(E01010(E01010==1))...
    length(Eoo01110(Eoo01110==1)) length(Eo01110o(Eo01110o==1)) length(E01110oo(E01110oo==1))...
    length(Eoo01111(Eoo01111==1)) length(Eo01111o(Eo01111o==1)) length(E01111oo(E01111oo==1))...
    length(Eoo11110(Eoo11110==1)) length(Eo11110o(Eo11110o==1)) length(E11110oo(E11110oo==1))];

clearvars SE12 SE23 SE34 SE45 SE123 SE234 SE345 SE12345 SE24inv3 SE1245inv3...
    E12 E23 E34 E45 E123 E234 E345 E12345 E1245 E1245Inv3 E3Inv234 SE3Inv234 E3Inv12345 SE3Inv12345...
    SE1234 SE2345 E1234 E2345


function WindowSetA
global p1valueX p1valueY p2valueX p2valueY p3valueX  p4valueX p4valueY...
    AutoCal autoy Astart Aend Pitch MainPointX MainPointY lengthA FixW FixWindow DUR

% MainPoint=str2num(get(handles.text_MainPoint,'String'));
p0=MainPointX-3*Pitch;
p1=MainPointX-2*Pitch;
p2=MainPointX-Pitch;
p3=MainPointX;
p4=MainPointX+Pitch;
p5=MainPointX+2*Pitch;
p6=MainPointX+3*Pitch;
Points=[p0 p1 p2 p3 p4 p5 p6];

% contents = cellstr(get(handles.popupmenu_lengthA,'String')); 
% lengthA=contents{get(handles.popupmenu_lengthA,'Value')};%Pitchの長さの0.25倍など
LenA=str2num(lengthA);%Windowの長さ　範囲

% % %     Windowのサイズを一定にする場合。
% FixW=get(handles.radiobutton_FixWindowWidth,'Value');
% 
% contents2=cellstr(get(handles.popupmenu_FixWindowWidth,'String'));
% FixWindow=str2double(contents2{get(handles.popupmenu_FixWindowWidth,'Value')});%100;
% Astart=zeros(1,5);Aend=zeros(1,5);
for n=1:7
    if FixW==0
    % WindowのサイズをPitchサイズにより可変にする場合。%%%%%%%%
        Astart(n)=Points(n)-0.5*LenA*Pitch;
        Aend(n)=Points(n)+0.5*LenA*Pitch;
    else
    % % Windowのサイズを一定にする場合。%%%%%%%%%%%%%%    
        Astart(n)=Points(n)-0.5*FixWindow;
        Aend(n)=Points(n)+0.5*FixWindow;
    end
    
%%%%%%%%%%%%%%%%%  %赤線をプロットする場合にON
%         x = Astart(n):1:Aend(n);%%赤線をプロットする場合に使用
%     if AutoCal==1
%         y=autoy;
%     else 
%         y = MainPointY*ones(length(x),100);
%     end

%     plot(x,y,'r');%赤線をプロットする場合にON
%%%%%%%% axes(handles.axes1);%赤線をプロットする場合にON 
end
% popupmenu_ACduration=get(handles.popupmenu_ACduration,'String');
% duration=str2double(popupmenu_ACduration(get(handles.popupmenu_ACduration,'Value')));
Astart=Astart-0.5*DUR;%真ん中(2500ms)がスパイクのタイミング、これに相対させる
Aend=Aend-0.5*DUR;
%Astart、Aendは５つのwindowの左端、右端を決めている。５個の数
