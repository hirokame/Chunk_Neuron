%1A�FInfo�idate, mouseID, sessionNo,training condition, Num.Turns,TotalTouchTime, TotalWaterOn, Num.Stops, 1-10, 11-20, 21-30, 31-40,,,)
%2B:Start time array
%3C:Stop time array
%4D:TurnTime, cumulative
%5E:OneTurnTime
%6F:cumulativeTouchTime array; fall down
%7G:WaterOnTime array
%8H:WaterOffTime array
%9I:Stop Time array
%10J:Lpeg Time array
%11K:Rpeg Time array
%12L:CumulativeTouchTime; fall down
%13M:TotalTouchTime by 10;fall down 
%14N-25Y:Right TouchTime sensor 1-12
%26Z-37AK:Left TouchTime sensor 1-12
%38AL:Floor Touch sensor
%39AM:Spout Touch sensor
%40AN-51AY:Right DetachTime sensor 1-12
%52AZ-63BK:Left DetachTime sensor 1-12
%64BL:Floor Detach sensor
%65BM:Spout Detach sensor//
function [PegTouchCell,PegTouchTurn]=PegTouch
global data TurnMarkerTime OneTurnTimeArray RpegTimeArray OneTurnTime WaterOnArray WaterOffArray...
    RpegTimeArray2D RpegTimeArray2D_turn MedPegTimeR MedPegTimeL PegTouchCell RefPeriod;

%Touch�����܂Ƃ߂�B
PegTouchSensor=[data(:,25),data(:,24),data(:,23),data(:,22),data(:,21),data(:,20),data(:,19),...
    data(:,18),data(:,17),data(:,16),data(:,15),data(:,14),data(:,37),data(:,36),data(:,35),...
    data(:,34),data(:,33),data(:,34),data(:,31),data(:,30),data(:,29),data(:,28),data(:,27),data(:,26)];
% PegTouchSensor=[data(:,17),data(:,16),data(:,15),data(:,14),data(:,25),data(:,24),...
%     data(:,23),data(:,22),data(:,21),data(:,20),data(:,19),data(:,18)];
%PegDetachSensor=[data(:,31),data(:,30),data(:,29),data(:,28),data(:,39),data(:,38),...
    %data(:,37),data(:,36),data(:,35),data(:,34),data(:,33),data(:,32)];

%�A������߂��l�̂��̂��폜�B���Ԃ�m�C�Y�B10ms���߂��l�̂��͍̂폜�B
for n=1:length(PegTouchSensor(1,:))
    for m=length(PegTouchSensor(:,n)):-1:2
        if PegTouchSensor(m,n)<(PegTouchSensor(m-1,n)+RefPeriod);PegTouchSensor(m,n)=0;end%touch
        %if PegDetachSensor(m,n)~=0;%detach
        %else
            %if PegDetachSensor(m,n)<PegDetachSensor(m-1,n)+OneTurnTime*0.2;PegDetachSensor(m-1,n)=0;end%detach
        %end
    end
end

%NonStopTurn����WatarOn���̃f�[�^�݂̂�I��
for n=1:length(PegTouchSensor(1,:))
   PegTouchSensor(:,n)=DataSelect(PegTouchSensor(:,n),TurnMarkerTime,OneTurnTime,WaterOnArray,WaterOffArray);
   %PegTouchSensor(:,n)=ResultArray;
end      

%Turn���Ƃ�Array���쐬
PegTouchTurn=zeros(size(PegTouchSensor));
for n=1:length(PegTouchSensor(1,:))
    for m=length(PegTouchSensor(:,n)):-1:2
        for p=1:length(TurnMarkerTime)-1%�Ō��TurnMarker����̃f�[�^�͂��łɍ폜����Ă���͂��Ȃ̂łP�������Ă���B
            if TurnMarkerTime(p)<=PegTouchSensor(m,n)&&PegTouchSensor(m,n)<TurnMarkerTime(p+1);PegTouchTurn(m,n)=PegTouchSensor(m,n)-TurnMarkerTime(p);end
        end
    end
end   
%�`�����l�����Ƃɂ킯��B�ʎ� 
PegTouch1=PegTouchSensor(:,1);PegTouch1(find(PegTouch1==0))=[];
PegTouch2=PegTouchSensor(:,2);PegTouch2(find(PegTouch2==0))=[];
PegTouch3=PegTouchSensor(:,3);PegTouch3(find(PegTouch3==0))=[];
PegTouch4=PegTouchSensor(:,4);PegTouch4(find(PegTouch4==0))=[];
PegTouch5=PegTouchSensor(:,5);PegTouch5(find(PegTouch5==0))=[];
PegTouch6=PegTouchSensor(:,6);PegTouch6(find(PegTouch6==0))=[];
PegTouch7=PegTouchSensor(:,7);PegTouch7(find(PegTouch7==0))=[];
PegTouch8=PegTouchSensor(:,8);PegTouch8(find(PegTouch8==0))=[];
PegTouch9=PegTouchSensor(:,9);PegTouch9(find(PegTouch9==0))=[];
PegTouch10=PegTouchSensor(:,10);PegTouch10(find(PegTouch10==0))=[];
PegTouch11=PegTouchSensor(:,11);PegTouch11(find(PegTouch11==0))=[];
PegTouch12=PegTouchSensor(:,12);PegTouch12(find(PegTouch12==0))=[];
PegTouch13=PegTouchSensor(:,13);PegTouch13(find(PegTouch13==0))=[];
PegTouch14=PegTouchSensor(:,14);PegTouch14(find(PegTouch14==0))=[];
PegTouch15=PegTouchSensor(:,15);PegTouch15(find(PegTouch15==0))=[];
PegTouch16=PegTouchSensor(:,16);PegTouch16(find(PegTouch16==0))=[];
PegTouch17=PegTouchSensor(:,17);PegTouch17(find(PegTouch17==0))=[];
PegTouch18=PegTouchSensor(:,18);PegTouch18(find(PegTouch18==0))=[];
PegTouch19=PegTouchSensor(:,19);PegTouch19(find(PegTouch19==0))=[];
PegTouch20=PegTouchSensor(:,20);PegTouch20(find(PegTouch20==0))=[];
PegTouch21=PegTouchSensor(:,21);PegTouch21(find(PegTouch21==0))=[];
PegTouch22=PegTouchSensor(:,22);PegTouch22(find(PegTouch22==0))=[];
PegTouch23=PegTouchSensor(:,23);PegTouch23(find(PegTouch23==0))=[];
PegTouch24=PegTouchSensor(:,24);PegTouch24(find(PegTouch24==0))=[];

PegTouchCell={PegTouch1,PegTouch2,PegTouch3,PegTouch4,PegTouch5,PegTouch6,PegTouch7,PegTouch8,PegTouch9,PegTouch10,PegTouch11,PegTouch12,...
    PegTouch13,PegTouch14,PegTouch15,PegTouch16,PegTouch17,PegTouch18,PegTouch19,PegTouch20,PegTouch21,PegTouch22,PegTouch23,PegTouch24};

% RPegTouchAll=sort([PegTouch1;PegTouch2;PegTouch3;PegTouch4;PegTouch5;PegTouch6]);
% LPegTouchAll=sort([PegTouch7;PegTouch8;PegTouch9;PegTouch10;PegTouch11;PegTouch12]);
% RLPegTouchAll=sort([PegTouch1;PegTouch2;PegTouch3;PegTouch4;PegTouch5;PegTouch6;PegTouch7;PegTouch8;PegTouch9;PegTouch10;PegTouch11;PegTouch12]);


% %�`�����l�����Ƃɕ�����BTurn����
% PegTouchTurn1=PegTouchTurn(:,1);PegTouchTurn1(find(PegTouchTurn1==0))=[];
% PegTouchTurn2=PegTouchTurn(:,2);PegTouchTurn2(find(PegTouchTurn2==0))=[];
% PegTouchTurn3=PegTouchTurn(:,3);PegTouchTurn3(find(PegTouchTurn3==0))=[];
% PegTouchTurn4=PegTouchTurn(:,4);PegTouchTurn4(find(PegTouchTurn4==0))=[];
% PegTouchTurn5=PegTouchTurn(:,5);PegTouchTurn5(find(PegTouchTurn5==0))=[];
% PegTouchTurn6=PegTouchTurn(:,6);PegTouchTurn6(find(PegTouchTurn6==0))=[];
% PegTouchTurn7=PegTouchTurn(:,7);PegTouchTurn7(find(PegTouchTurn7==0))=[];
% PegTouchTurn8=PegTouchTurn(:,8);PegTouchTurn8(find(PegTouchTurn8==0))=[];
% PegTouchTurn9=PegTouchTurn(:,9);PegTouchTurn9(find(PegTouchTurn9==0))=[];
% PegTouchTurn10=PegTouchTurn(:,10);PegTouchTurn10(find(PegTouchTurn10==0))=[];
% PegTouchTurn11=PegTouchTurn(:,11);PegTouchTurn11(find(PegTouchTurn11==0))=[];
% PegTouchTurn12=PegTouchTurn(:,12);PegTouchTurn12(find(PegTouchTurn12==0))=[];
% 
% %Do plot
% %figure
% if PegTouchTurn1;plot(PegTouchTurn1,1,'k.');axis([0 OneTurnTime+10 0 12.5]);end;hold on
% if PegTouchTurn2;plot(PegTouchTurn2,2,'c.');axis([0 OneTurnTime+10 0 12.5]);end
% if PegTouchTurn3;plot(PegTouchTurn3,3,'m.');axis([0 OneTurnTime+10 0 12.5]);end
% if PegTouchTurn4;plot(PegTouchTurn4,4,'r.');axis([0 OneTurnTime+10 0 12.5]);end
% if PegTouchTurn5;plot(PegTouchTurn5,5,'g.');axis([0 OneTurnTime+10 0 12.5]);end
% if PegTouchTurn6;plot(PegTouchTurn6,6,'b.');axis([0 OneTurnTime+10 0 12.5]);end
% if PegTouchTurn7;plot(PegTouchTurn7,7,'k.');axis([0 OneTurnTime+10 0 12.5]);end
% if PegTouchTurn8;plot(PegTouchTurn8,8,'c.');axis([0 OneTurnTime+10 0 12.5]);end
% if PegTouchTurn9;plot(PegTouchTurn9,9,'m.');axis([0 OneTurnTime+10 0 12.5]);end
% if PegTouchTurn10;plot(PegTouchTurn10,10,'r.');axis([0 OneTurnTime+10 0 12.5]);end
% if PegTouchTurn11;plot(PegTouchTurn11,11,'g.');axis([0 OneTurnTime+10 0 12.5]);end
% if PegTouchTurn12;plot(PegTouchTurn12,12,'b.');axis([0 OneTurnTime+10 0 12.5]);end


% %disp(MedPegTimeR);
% cl={'k','c','m','r','g','b','k','c','m','r','g','b'};
% y=(0:1250)*0.01;
% for n=1:length(MedPegTimeR);plot(MedPegTimeR(n),y,cl{n});end;hold off

%Peg�̃^�C�~���O�Ő���
%TouchAlignByPeg(PegTouchCell,RpegTimeArray2D,100,20);
      