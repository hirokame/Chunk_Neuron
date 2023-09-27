function terashita190510
%1周の間でタッチのインターバルに関するヒートマップを作製する
cd('C:\Users\C238\Desktop\CheetahWRLV20180729\119\2017-6-7_20-8-33 11901-51');
dpath=('C:\Users\C238\Desktop\CheetahWRLV20180729\119\2017-6-7_20-8-33 11901-51\');
dpath3=('C:\Users\C238\Desktop\CheetahWRLV20180729\119\2017-6-7_20-8-33 11901-51');
% data=load([dpath '15103_190313_98__'],'-ascii');
dpath3
load 11931_170607_98__\Bdata

% Sc3_SS_01.t
SpikeArray=GetSpikeAll(dpath3,'Sc4_SS_02.t');


%global  SpikeArray RpegTouchall LpegTouchall TurnMarkerTime OneTurnTime OnWater fname tfile




%WaterOnのときのみのRpegTouchall
    if ~isempty(RpegTouchall)
        RTWon=ones(1,length(RpegTouchall));
        for k=1:length(RpegTouchall)
            if OnWater(RpegTouchall(k))==0
                RTWon(k)=0;
            end
        end
        RpegTouchallWon=RpegTouchall.*RTWon;
        RpegTouchallWon(RpegTouchallWon==0)=[];
        RpegTouchallWoff=RpegTouchall.*not(RTWon);
        RpegTouchallWoff(RpegTouchallWoff==0)=[];
    else
        RpegTouchallWon=0;
        RpegTouchallWoff=0;
    end
%WaterOnのときのみのLpegTouchall
    if ~isempty(LpegTouchall)
        LTWon=ones(1,length(LpegTouchall));
        for k=1:length(LpegTouchall)
            if OnWater(LpegTouchall(k))==0
                LTWon(k)=0;
            end
        end
        LpegTouchallWon=LpegTouchall.*LTWon;
        LpegTouchallWon(LpegTouchallWon==0)=[];
        LpegTouchallWoff=LpegTouchall.*not(LTWon);
        LpegTouchallWoff(LpegTouchallWoff==0)=[];
    else
        LpegTouchallWon=0;
        LpegTouchallWoff=0;
    end

    
    
% RpegTouchallWon=RpegTouchallWon(TurnMarkerTime(1)<RpegTouchallWon && TurnMarkerTime(end)>RpegTouchallWon);
% LpegTouchallWon=LpegTouchallWon(TurnMarkerTime(1)<LpegTouchallWon && TurnMarkerTime(end)>LpegTouchallWon);


OneturnInterval=[];
IntervalTable=[];
for i=1:length(TurnMarkerTime)-1
    LpegTouchallWon1=LpegTouchallWon(TurnMarkerTime(i)<LpegTouchallWon & TurnMarkerTime(i+1)>LpegTouchallWon);
    OneturnInterval=[];
    for j=1:length(LpegTouchallWon1)-1
        OneturnInterval=[OneturnInterval LpegTouchallWon1(j+1)-LpegTouchallWon1(j)];
    end
    if i==1;
       IntervalTable=[IntervalTable;OneturnInterval];
    else
    [height width]=size(IntervalTable);
    if width==length(OneturnInterval);
        IntervalTable=[IntervalTable;OneturnInterval];
    end
    end
end
IntervalTable
% h = HeatMap(IntervalTable);




%左右合わせた足の間隔に対する発火のヒストグラム

RLpegTouchallWon=[RpegTouchallWon LpegTouchallWon];

RLpegTouchallWon=sort(RLpegTouchallWon,'ascend');
RLTInterval=[];
for i=1:length(RLpegTouchallWon)-1
    for j=1:length(SpikeArray)
        if RLpegTouchallWon(i)<SpikeArray(j) && SpikeArray(j)<RLpegTouchallWon(i+1);
           IntervalRL=RLpegTouchallWon(i+1)-RLpegTouchallWon(i);
           RLTInterval=[RLTInterval IntervalRL];
        end
    end
end
RLTInterval(RLTInterval>600)=[];
RLTInterval=[0 RLTInterval 600];

RLTIntervalHist=hist(RLTInterval,20);
linRL=linspace(0,600,20);

figure
plot(linRL,RLTIntervalHist,'color','b');
axis([0 600 0 max(RLTIntervalHist)*1.1]);