function interval20190527
%スパイクでアラインしたタッチのヒストグラムから左足のインターバルを計算する

global SpikeArray TurnMarkerTime RpegTouchallWon LpegTouchallWon PhaseIndex TotalTime frequencyPksLt pksA1Rt MeanpksA1Rt pksA2Lt MeanpksA2Lt DiffMaxMinR DiffMaxMinL...
    IntervalIndex


cd('C:\Users\C238\Desktop\CheetahWRLV20180729\119\2017-6-7_20-8-33 11901-51');
dpath=('C:\Users\C238\Desktop\CheetahWRLV20180729\119\2017-6-7_20-8-33 11901-51\');
dpath3=('C:\Users\C238\Desktop\CheetahWRLV20180729\119\2017-6-7_20-8-33 11901-51');
% data=load([dpath '15103_190313_98__'],'-ascii');
dpath3
load 11931_170607_98__\Bdata
SpikeArray=GetSpikeAll(dpath3,'Sc8_SS_07.t');
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

bin=500;
CCRtSpike=[];
CCLtSpike=[];
[CCRtSpike]=CrossCorr(RpegTouchallWon',SpikeArray,5000,0,TurnMarkerTime);
CCRtSpikeHist=hist(CCRtSpike,bin);
CCRtSpikeHist=MovWindow(CCRtSpikeHist,10);
[CCLtSpike]=CrossCorr(LpegTouchallWon',SpikeArray,5000,0,TurnMarkerTime);
CCLtSpikeHist=hist(CCLtSpike,bin);
CCLtSpikeHist=MovWindow(CCLtSpikeHist,10);

figure
plot(linspace(1,5000,bin),CCRtSpikeHist,'color','b','LineWidth',1);hold on
plot(linspace(1,5000,bin),CCLtSpikeHist,'color','r','LineWidth',1);
axis([0 5000 0 max(max(CCRtSpikeHist),max(CCLtSpikeHist))*1.1]);
close;
figure
findpeaks(CCRtSpikeHist,'MinPeakDistance',20);
close;
figure
findpeaks(CCLtSpikeHist,'MinPeakDistance',20);
close;

[pksRt locsRt]=findpeaks(CCRtSpikeHist,'MinPeakDistance',20);
[pksLt locsLt]=findpeaks(CCLtSpikeHist,'MinPeakDistance',20);

MpksRt=mean(pksRt);
MpksLt=mean(pksLt);
RtCell=[pksRt;locsRt];
LtCell=[pksLt;locsLt];
for i=1:length(RtCell(1,:));
    if RtCell(1,i)<MpksRt
       RtCell(1,i)=NaN; 
    end
end
i = find(isnan(RtCell(1,:))); 
locsRt=RtCell(2,:);
locsRt(i)=[];
locsRt
for i=1:length(LtCell(1,:))
    if LtCell(1,i)<MpksLt
       LtCell(1,i)=NaN;
    end
end
i = find(isnan(LtCell(1,:))); 
locsLt=LtCell(2,:);
locsLt(i)=[];
locsLt

[IntervalRt IndexlocsRt]=sort(abs(locsRt-250),'ascend');
[IntervalLt IndexlocsLt]=sort(abs(locsLt-250),'ascend');

RtPeakArray=[];
LtPeakArray=[];

if isempty(locsRt)==0 & isempty(locsLt)==0;
RtPeakArray=sort([RtPeakArray locsRt(IndexlocsRt(1)) locsRt(IndexlocsRt(2))],'ascend');
LtPeakArray=sort([LtPeakArray locsLt(IndexlocsLt(1)) locsLt(IndexlocsLt(2))],'ascend');


RtPeakInLt=RtPeakArray(LtPeakArray(1)<RtPeakArray & RtPeakArray<LtPeakArray(2));

IntervalIndex=(LtPeakArray(2)-LtPeakArray(1))*10;
else
    IntervalIndex=0;
end
if isempty(IntervalIndex)==1
   IntervalIndex=0; 
end
if length(IntervalIndex)>1
   IntervalIndex=mean(IntervalIndex); 
end
if length(SpikeArray)/TotalTime >=0.5 && frequencyPksLt(1)>=1.5 && frequencyPksLt(1)<=3.5 && pksA2Lt(1)>MeanpksA2Lt*3 && (DiffMaxMinR>4 || DiffMaxMinL>4);
    IntervalIndex=IntervalIndex;
else
    IntervalIndex=NaN;
end




PhaseIndex