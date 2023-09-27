function [LastPitch123 OffDuration] =Accelerate20170428(dpath,fname) %DataLoad24chより改変
% clear all;close all;
%FinishTime(STOPボタン)の時間＋3000ms加えたものをWaterOnArrayに付け加えた。％％％％％％％％％％％％％％％％

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%  [fname,dpath] = uigetfile('*');
%  disp(fname);
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% dpath='/Users/toru/Desktop/';
% fname='101_150614.mat'
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

if strfind(fname,' ')>0
    data=xlsread([dpath fname]);%'C:\Documents and Settings\kit\デスクトップ\WR LVdata\6 080811.xls');
elseif strfind(fname,'_')>0
    data=load([dpath,'\', fname],'-ascii');
else
    data=xlsread([dpath fname]);%'C:\Documents and Settings\kit\デスクトップ\WR LVdata\6 080811.xls');
end

StartTime=data(1,2);
FinishTime=data(1,3);

disp('StartTime=');disp(StartTime);
disp('FinishTime=');disp(FinishTime);

PegOffset=0;
%PegOffset: Peg　位置補正 TurnMarkerと重なったとき
RpegTimeArrayOriginal=data(:,11)-PegOffset;RpegTimeArrayOriginal(RpegTimeArrayOriginal==-PegOffset)=[];
LpegTimeArrayOriginal=data(:,10)-PegOffset;LpegTimeArrayOriginal(LpegTimeArrayOriginal==-PegOffset)=[];
RpegTimeArray=RpegTimeArrayOriginal(RpegTimeArrayOriginal>StartTime & RpegTimeArrayOriginal<FinishTime);
LpegTimeArray=LpegTimeArrayOriginal(LpegTimeArrayOriginal>StartTime & LpegTimeArrayOriginal<FinishTime);


RpegDiff=zeros(1,length(RpegTimeArray)-1);
LpegDiff=zeros(1,length(LpegTimeArray)-1);
for n=1:length(RpegTimeArray)-1
    RpegDiff(n)=RpegTimeArray(n+1)-RpegTimeArray(n);
end
for n=1:length(LpegTimeArray)-1
    LpegDiff(n)=LpegTimeArray(n+1)-LpegTimeArray(n);
end

% figure
% fname
% size(RpegTimeArray)
% size(RpegDiff)
% plot(RpegTimeArray/1000,[RpegDiff 0]); 
% figure
% plot(LpegTimeArray/1000,[LpegDiff 0]); 

WaterOnArrayOriginal=data(:,7);
WaterOffArrayOriginal=data(:,8);

WaterOnArray=WaterOnArrayOriginal(WaterOnArrayOriginal~=0);
WaterOffArray=WaterOffArrayOriginal(WaterOffArrayOriginal~=0);

WaterOnArray=[WaterOnArray; FinishTime+3000];%Accelerate解析に特異的%FinishTime(STOPボタン)の時間＋3000ms加えたものをWaterOnArrayに付け加えた。％％％％％％％％％％％％％％％％

OffDuration=zeros(1,length(WaterOffArray));

for n=1:length(WaterOffArray)
    OffDuration(n)=min(WaterOnArray(WaterOnArray>WaterOffArray(n)))-WaterOffArray(n);
end


WaterOne=zeros(1,WaterOnArray(end));
WaterOne(1)=1;
for n=2:length(WaterOne)
    if find(WaterOnArray(WaterOnArray==n))==1
        WaterOne(n)=1;
    elseif find(WaterOffArray(WaterOffArray==n))==1
        WaterOne(n)=0;
    else
        WaterOne(n)=WaterOne(n-1);
    end
end
    
RpegTimeArrayON=zeros(1,length(RpegTimeArray));
% RpegTimeArrayOFF=zeros(1,length(RpegTimeArray));

for n=1:length(RpegTimeArray)
    if WaterOne(RpegTimeArray(n))==1
        RpegTimeArrayON(n)=1;
    end
end

% RpegDiff=[RpegDiff 0];
figure
% fname
% size(RpegTimeArray)
% size(RpegDiff)
plot(RpegTimeArray/1000,[RpegDiff 0]); hold on
text(RpegTimeArray/1000,RpegTimeArrayON*max(RpegDiff),'*');
% plot(RpegTimeArray(RpegTimeArrayON==1)/1000,RpegDiff(RpegTimeArrayON==1), 'b'); hold on
% plot(RpegTimeArray(RpegTimeArrayON==0)/1000,RpegDiff(RpegTimeArrayON==0)*(-1), 'r');
% figure
% plot(LpegTimeArray/1000,[LpegDiff 0]); 



MinOff1000=find(OffDuration>1000, 1 );
MinOff2000=find(OffDuration>2000, 1 );
MinOff3000=find(OffDuration>3000, 1 );
LastPitch123=[0 0 0];
if ~isempty(MinOff1000)
    Off1000Time=WaterOffArray(MinOff1000)
    RpegBefore=find(RpegTimeArray<WaterOffArray(MinOff1000));
    LpegBefore=find(LpegTimeArray<WaterOffArray(MinOff1000));
    if length(RpegBefore)>=2
        RpegPitchLast=RpegTimeArray(RpegBefore(end))-RpegTimeArray(RpegBefore(end-1));
    else
        RpegPitchLast=RpegTimeArray(2)-RpegTimeArray(1);
    end
    if length(LpegBefore)>=2
        LpegPitchLast=LpegTimeArray(LpegBefore(end))-LpegTimeArray(LpegBefore(end-1));
    else
        LpegPitchLast=LpegTimeArray(2)-LpegTimeArray(1);
    end
    LastPitch123(1)=min(RpegPitchLast,LpegPitchLast);
end
if ~isempty(MinOff2000)
    Off2000Time=WaterOffArray(MinOff2000)
    RpegBefore=find(RpegTimeArray<WaterOffArray(MinOff2000));
    LpegBefore=find(LpegTimeArray<WaterOffArray(MinOff2000));
    if length(RpegBefore)>=2
        RpegPitchLast=RpegTimeArray(RpegBefore(end))-RpegTimeArray(RpegBefore(end-1));
    else
        RpegPitchLast=RpegTimeArray(2)-RpegTimeArray(1);
    end
    if length(LpegBefore)>=2
        LpegPitchLast=LpegTimeArray(LpegBefore(end))-LpegTimeArray(LpegBefore(end-1));
    else
        LpegPitchLast=LpegTimeArray(2)-LpegTimeArray(1);
    end
    LastPitch123(2)=min(RpegPitchLast,LpegPitchLast);
end
if ~isempty(MinOff3000)
    Off3000Time=WaterOffArray(MinOff3000)
    RpegBefore=find(RpegTimeArray<WaterOffArray(MinOff3000));
    LpegBefore=find(LpegTimeArray<WaterOffArray(MinOff3000));
    if length(RpegBefore)>=2
        RpegPitchLast=RpegTimeArray(RpegBefore(end))-RpegTimeArray(RpegBefore(end-1));
    else
        RpegPitchLast=RpegTimeArray(2)-RpegTimeArray(1);
    end
    if length(LpegBefore)>=2
        LpegPitchLast=LpegTimeArray(LpegBefore(end))-LpegTimeArray(LpegBefore(end-1));
    else
        LpegPitchLast=LpegTimeArray(2)-LpegTimeArray(1);
    end
    LastPitch123(3)=min(RpegPitchLast,LpegPitchLast);
else
    disp('!!! No >3000 Off !!!');
    disp('Pitch at 5s/trial = 417ms');
end
LastPitch123
OffDuration


% %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% %MaxScore, 最後まで走りきった場合のスコア。最短ピッチの3秒前のピッチ。426,430,431,432あたり。
% R3000=RpegTimeArray(find(RpegDiff==min(RpegDiff),1))-3000;
% E=find(RpegTimeArray(RpegTimeArray<R3000));
% MaxScoreR=LpegTimeArray(E(end))-LpegTimeArray(E(end)-1);
% 
% L3000=LpegTimeArray(find(LpegDiff==min(LpegDiff),1))-3000;
% F=find(LpegTimeArray(LpegTimeArray<L3000));
% MaxScoreL=LpegTimeArray(F(end))-LpegTimeArray(F(end)-1);
% 
% MaxScore=min(MaxScoreR,MaxScoreL);
% MaxScore




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
%14N-25Y:TouchTime sensor 1-12
%28AB-39AM:DetachTime sensor 1-12
%26Z:Floor Touch sensor
%27AA:Spout Touch sensor//
%40AN:Floor Detach sensor
%41AU:Spout Detach sensor//
