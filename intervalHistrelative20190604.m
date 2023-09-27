function intervalHistrelative20190604
%発火があったところのインターバルのヒストグラムを作る
%時間インターバル


% cd('C:\Users\C238\Desktop\CheetahWRLV20180729\119\2017-6-7_20-8-33 11901-51');
% dpath=('C:\Users\C238\Desktop\CheetahWRLV20180729\119\2017-6-7_20-8-33 11901-51\');
% dpath3=('C:\Users\C238\Desktop\CheetahWRLV20180729\119\2017-6-7_20-8-33 11901-51');
% % data=load([dpath '15103_190313_98__'],'-ascii');
% dpath3
% load 11941_170607_C7__\Bdata
% 
% % Sc3_SS_01.t
% SpikeArray=GetSpikeAll(dpath3,'Sc4_SS_02.t');

global  SpikeArray RpegTouchall LpegTouchall TurnMarkerTime OneTurnTime OnWater fname tfile Rinterrelative Linterrelative



SpikeArray
if isempty(SpikeArray)==0;
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
LpegTouchallWon
RpegTouchallWon
Touchinterval=[];
% for i=1:length(LpegTouchallWon)-1
%     Touchinterval1=LpegTouchall(i+1)-LpegTouchallWon(i);
%     Touchinterval=[Touchinterval Touchinterval1];
% end
% bin=1000;
% [Ltouchinterval]=CrossCorr(LpegTouchallWon',TurnMarkerTime,OneTurnTime*2,0,TurnMarkerTime);
% CCresultLtouchinterval=hist(Ltouchinterval,bin);
% CCresultLtouchinterval=MovWindow(CCresultLtouchinterval,5);
% 
% figure
% plot(linspace(1,OneTurnTime*2,bin),CCresultLtouchinterval,'color','r','LineWidth',1)
% axis([0 OneTurnTime*2 0 max(CCresultLtouchinterval)*1.1]);

%左右それぞれのインターバル配列
RtIntervalArray=[];
LtIntervalArray=[];
for i=1:length(RpegTouchallWon)-1
    RtInterval=RpegTouchallWon(i+1)-RpegTouchallWon(i);
    RtIntervalArray=[RtIntervalArray RtInterval];
end
for i=1:length(LpegTouchallWon)-1
    LtInterval=LpegTouchallWon(i+1)-LpegTouchallWon(i);
    LtIntervalArray=[LtIntervalArray LtInterval];
end

%左右ぞれぞれのインターバルの平均を求める
MeanRtInterval=mean(RtIntervalArray);
MeanLtInterval=mean(LtIntervalArray);


%右足のインターバル
RTInterval=[];
for i=1:length(RpegTouchallWon)-1
    for j=1:length(SpikeArray)
        if RpegTouchallWon(i)<SpikeArray(j) && SpikeArray(j)<RpegTouchallWon(i+1);
           IntervalR=RpegTouchallWon(i+1)-RpegTouchallWon(i);
           RTInterval=[RTInterval IntervalR];
        end
    end
end
RTInterval=RTInterval-MeanRtInterval;
RTInterval=[-400 RTInterval 400];


RTIntervalHist=hist(RTInterval,20);hold on 
% [MR locsMR]=max(RTInterval);
% MeanR=mean(RTInterval);
linR=linspace(-400,400,21);
RTIntervalHist=[RTIntervalHist 0];


y=figure;
subplot(2,1,1);
plot(linR,RTIntervalHist,'color','b');
axis([-400 400 0 max(RTIntervalHist)*1.1]);
ylabel('Rinterval');

%左足のインターバル
LTInterval=[];
for i=1:length(LpegTouchallWon)-1
    for j=1:length(SpikeArray)
        if LpegTouchallWon(i)<SpikeArray(j) && SpikeArray(j)<LpegTouchallWon(i+1);
           IntervalL=LpegTouchallWon(i+1)-LpegTouchallWon(i);
           LTInterval=[LTInterval IntervalL];
        end
    end
end
LTInterval=LTInterval-MeanLtInterval;
LTInterval=[-400 LTInterval 400];



LTIntervalHist=hist(LTInterval,20);
% [ML locsML]=max(LTInterval);
% MeanL=mean(LTInterval);
linL=linspace(-400,400,21);
LTIntervalHist=[LTIntervalHist 0];


subplot(2,1,2);
plot(linL,LTIntervalHist,'color','r');
axis([-400 400 0 max(LTIntervalHist)*1.1]);
ylabel('Linterval');


% subplot(2,1,2);
% plot(linL,LTIntervalHist.Values,'color','r');
% axis([0 600 0 max(LTIntervalHist.Values)*1.1]);
% ylabel('Linterval');



xlabel([fname,tfile(1:11)]);
figname=[tfile(1:end-2),'Interval22','.bmp'];
saveas(y,figname);
close


RintervalCell=[RTIntervalHist;linR];
LintervalCell=[LTIntervalHist;linL];

[MR locsMR]=max(RTIntervalHist);
[ML locsML]=max(LTIntervalHist);

Rinterrelative=RintervalCell(2,locsMR);
Linterrelative=LintervalCell(2,locsML);


end


