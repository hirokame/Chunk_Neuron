%PegTouch.m   %PegTouch analysis
%1A：Info（date, mouseID, sessionNo,training condition, Num.Turns,TotalTouchTime, TotalWaterOn, Num.Stops, 1-10, 11-20, 21-30, 31-40,,,)
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

%26Z:Floor Touch sensor
%27AA:Spout Touch sensor//

%28AB-39AM:Right DetachTime sensor 1-12

%40AN:Floor Detach sensor
%41AO:Spout Detach sensor//

%42AP-53BA Left TouchTime Sensor
%54BB-65BM Left DetachTime Sensor

function [PegTouchCell,PegTouchTurn]=PegTouch24ch(PegTouchSensor)
global data TurnMarkerTime OneTurnTimeArray RpegTimeArray OneTurnTime WaterOnArray WaterOffArray...
    RpegTimeArray2D RpegTimeArray2D_turn MedPegTimeR MedPegTimeL RefPeriod WonTouch
%RpegTouchall LpegTouchall
%WonTouch=1のとき、WaterOnのときのTouchのみを選別。

% PegTouchSensor=[data(:,14),data(:,15),data(:,16),data(:,17),data(:,18),data(:,19),data(:,20),data(:,21),data(:,22),data(:,23),data(:,24),data(:,25)];


% %Touchだけまとめる。
% PegTouchSensor=[data(:,19),data(:,18),data(:,17),data(:,16),data(:,15),data(:,14),data(:,25),data(:,24),...
%     data(:,23),data(:,22),data(:,21),data(:,20)];

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% %タッチで振幅が減少するタイプ　以前からのモノ
% PegTouchSensor=[data(:,19),data(:,18),data(:,17),data(:,16),data(:,15),data(:,14),data(:,25),data(:,24),...
%     data(:,23),data(:,22),data(:,21),data(:,20)];
 
% %右ペグ　タッチで振幅が増加するタイプ　20130918作成　左ペグはそのまま
% PegTouchSensor=[data(:,33),data(:,32),data(:,31),data(:,30),data(:,29),data(:,28),data(:,25),data(:,24),...
%     data(:,23),data(:,22),data(:,21),data(:,20)];
% 
% %左ペグ　タッチで振幅が増加するタイプ　20141226作成　右ペグはそのまま
% PegTouchSensor=[data(:,19),data(:,18),data(:,17),data(:,16),data(:,15),data(:,14),data(:,39),data(:,38),...
%     data(:,37),data(:,36),data(:,35),data(:,34)];
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

% PegTouchSensor=[data(:,17),data(:,16),data(:,15),data(:,14),data(:,25),data(:,24),...
%     data(:,23),data(:,22),data(:,21),data(:,20),data(:,19),data(:,18)];
%PegDetachSensor=[data(:,31),data(:,30),data(:,29),data(:,28),data(:,39),data(:,38),...
    %data(:,37),data(:,36),data(:,35),data(:,34),data(:,33),data(:,32)];

% % % %連続する近い値のものを削除。たぶんノイズ。10msより近い値のものは削除、したいが、とりあえず代わりに０を代入。
% % % for n=1:length(PegTouchSensor(1,:))
% % %     for m=length(PegTouchSensor(:,n)):-1:2
% % %         if PegTouchSensor(m,n)<(PegTouchSensor(m-1,n)+RefPeriod);PegTouchSensor(m,n)=0;end%touch
% % %         %if PegDetachSensor(m,n)~=0;%detach
% % %         %else
% % %             %if PegDetachSensor(m,n)<PegDetachSensor(m-1,n)+OneTurnTime*0.2;PegDetachSensor(m-1,n)=0;end%detach
% % %         %end
% % %     end
% % % end

if WonTouch==1%WonTouch=1のとき、WaterOnのときのTouchのみを選別。
%NonStopTurnかつWatarOn時のデータのみを選別%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    for n=1:length(PegTouchSensor(1,:))
       PegTouchSensor(:,n)=DataSelect(PegTouchSensor(:,n),TurnMarkerTime,OneTurnTime,WaterOnArray,WaterOffArray);
       %PegTouchSensor(:,n)=ResultArray;
    end      
end

% %チャンネルごとにわける。通時 
% PegTouch1=PegTouchSensor(:,1);PegTouch1(find(PegTouch1==0))=[];
% PegTouch2=PegTouchSensor(:,2);PegTouch2(find(PegTouch2==0))=[];
% PegTouch3=PegTouchSensor(:,3);PegTouch3(find(PegTouch3==0))=[];
% PegTouch4=PegTouchSensor(:,4);PegTouch4(find(PegTouch4==0))=[];
% PegTouch5=PegTouchSensor(:,5);PegTouch5(find(PegTouch5==0))=[];
% PegTouch6=PegTouchSensor(:,6);PegTouch6(find(PegTouch6==0))=[];
% PegTouch7=PegTouchSensor(:,7);PegTouch7(find(PegTouch7==0))=[];
% PegTouch8=PegTouchSensor(:,8);PegTouch8(find(PegTouch8==0))=[];
% PegTouch9=PegTouchSensor(:,9);PegTouch9(find(PegTouch9==0))=[];
% PegTouch10=PegTouchSensor(:,10);PegTouch10(find(PegTouch10==0))=[];
% PegTouch11=PegTouchSensor(:,11);PegTouch11(find(PegTouch11==0))=[];
% PegTouch12=PegTouchSensor(:,12);PegTouch12(find(PegTouch12==0))=[];
% 
% PegTouchCell={PegTouch1,PegTouch2,PegTouch3,PegTouch4,PegTouch5,PegTouch6,PegTouch7,PegTouch8,PegTouch9,PegTouch10,PegTouch11,PegTouch12};

% PegTouchTurnCell=cell(1,12);
% 
% for n=1:length(PegTouchCell)
%     Cell=PegTouchCell{n};
%     Array=[];
%     for m=1:length(Cell)
% %         M=max(TurnMarkerTime(TurnMarkerTime<Cell(m)))
% 
%         for p=1:length(TurnMarkerTime)-1%最後のTurnMarkerより後のデータはすでに削除されているはずなので１を引いてある。
%             if TurnMarkerTime(p)<=Cell(m) && Cell(m)<TurnMarkerTime(p+1)
%                 Array=[Array Cell(m)-TurnMarkerTime(p)];
%             end
%         end
%     end
%     PegTouchTurnCell{n}=Array;
%     
% %     figure
% %     hist(Array,30);
% end   

%TurnごとのArrayも作成
PegTouchTurn=zeros(size(PegTouchSensor));
for n=1:length(PegTouchSensor(1,:))
    for m=length(PegTouchSensor(:,n)):-1:2
        for p=1:length(TurnMarkerTime)-1%最後のTurnMarkerより後のデータはすでに削除されているはずなので１を引いてある。
            if TurnMarkerTime(p)<=PegTouchSensor(m,n)&PegTouchSensor(m,n)<TurnMarkerTime(p+1)
                PegTouchS=PegTouchSensor(m,n);
                TMTime=TurnMarkerTime(p);
                a=PegTouchSensor(m,n)-TurnMarkerTime(p);
                PegTouchTurn(m,n)=PegTouchSensor(m,n)-TurnMarkerTime(p);
            end
        end
    end
end   

%チャンネルごとにわける。通時 
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

% % % % % %1s以上の間隔のあいたもののみ選択、しなくても、のちにDataload内で半周以上空いたもののみ選択
% % % % % for m=1:12
% % % % %     eval(['A=PegTouch',int2str(m),';']);
% % % % %     
% % % % %     while length(A)>n
% % % % %         if A(n+1)-A(n)<=1000
% % % % %             A(n+1)=[];
% % % % %         else
% % % % %             n=n+1;
% % % % %         end
% % % % %     end
% % % % %     eval(['PegTouch',int2str(m),'=A;']);
% % % % % end

PegTouchCell={PegTouch1,PegTouch2,PegTouch3,PegTouch4,PegTouch5,PegTouch6,PegTouch7,PegTouch8,PegTouch9,PegTouch10,PegTouch11,PegTouch12};






% RPegTouchAll=sort([PegTouch1;PegTouch2;PegTouch3;PegTouch4;PegTouch5;PegTouch6]);
% LPegTouchAll=sort([PegTouch7;PegTouch8;PegTouch9;PegTouch10;PegTouch11;PegTouch12]);
% RLPegTouchAll=sort([PegTouch1;PegTouch2;PegTouch3;PegTouch4;PegTouch5;PegTouch6;PegTouch7;PegTouch8;PegTouch9;PegTouch10;PegTouch11;PegTouch12]);
% 

% %チャンネルごとに分ける。Turnごと
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

%Pegのタイミングで整列
%TouchAlignByPeg(PegTouchCell,RpegTimeArray2D,100,20);
      