function RLphase190313
global  ACresult ACresultW CCresultDrinkOn SpikeArray TurnMarkerTime RpegTouchallWon LpegTouchallWon...
    RpNum LpNum   CCresultSpike locsP1time locsP2time locsP1time2 locsP2time2 pksA1 pksA2 CCresultRtouchWon CCresultLtouchWon dpath3...
    StartTime FinishTime DiffMaxMinR DiffMaxMinL fname OnestepHist1msR OnestepHist1msL SpikeArrayWon OnestepSpikeHistogramR OnestepSpikeHistogramL
%%すべてのタッチに位相を当てはめてからターンマーカーでアラインしたバージョン
% RmedianPTTM
% LmedianPTTM
% dpath3 = uigetdir('C:\Users\kit\Desktop\CheetahData');
% load ('Bdata.mat','RpegTouchCell','LpegTouchCell');
% yhight=20;
% [fig_touchR_TM,PTTMHistoCell_R RmedianPTTM Rmax]=TouchAlignByTM(RpegTouchCell,TurnMarkerTime,yhight);
% [fig_touchL_TM,PTTMHistoCell_L LmedianPTTM Lmax]=TouchAlignByTM(LpegTouchCell,TurnMarkerTime,yhight);
bin1=20;
phaseR=zeros(1,bin1);
for i=1:length(RpegTouchallWon)-1
    for j=1:length(SpikeArray)-1
        if RpegTouchallWon(i)<SpikeArray(j)&&SpikeArray(j)<RpegTouchallWon(i+1);   %%タッチ間でスパイクがあったか
           binarrayR=linspace(RpegTouchallWon(i),RpegTouchallWon(i+1),bin1+1);     %%タッチ間をbin1の数に分割
           for k=1:length(phaseR)-1
               if binarrayR(k)<SpikeArray(j)&&SpikeArray(j)<binarrayR(k+1);        %%どのビンでスパイクがあったか
                   phaseR(k)=phaseR(k)+1;
               end
           end
        end
    end
end
phaseL=zeros(1,bin1);
for i=1:length(LpegTouchallWon)-1
    for j=1:length(SpikeArray)-1
        if LpegTouchallWon(i)<SpikeArray(j)&&SpikeArray(j)<LpegTouchallWon(i+1);   %%タッチ間でスパイクがあったか
           binarrayL=linspace(LpegTouchallWon(i),LpegTouchallWon(i+1),bin1+1);   %%タッチ間をbin1の数に分割
           for k=1:length(phaseL)-1
               if binarrayL(k)<SpikeArray(j)&&SpikeArray(j)<binarrayL(k+1);  %%どのビンでスパイクがあったか
                   phaseL(k)=phaseL(k)+1;
               end
           end
        end
    end
end
fs=100;%%サンプリング周波数
dft_size=4096;
%右足タッチでアラインしたスパイクのフーリエ変換
Y1=fft(CCresultRtouchWon,dft_size);
k=1:dft_size/2+1;
A1(k)=abs(Y1(k));
P1(k)=abs(Y1(k)).^2;
frequency(k)=(k-1)*fs/dft_size;

%左足タッチでアラインしたスパイクのフーリエ変換
Y2=fft(CCresultLtouchWon,dft_size);
A2(k)=abs(Y2(k));
P2(k)=abs(Y2(k)).^2;
frequency(k)=(k-1)*fs/dft_size;

% 振幅
% 右足
[pksA1,locsA1]=findpeaks(A1,'sortstr','descend');  %%%ピークになる周波数
locsA1=(locsA1-1)*fs/dft_size;
locsA1time=1/locsA1(1)*100;
% 左足
[pksA2,locsA2]=findpeaks(A2,'sortstr','descend');
locsA2=(locsA2-1)*fs/dft_size;
locsA2time=1/locsA2(1)*100;


[MaxR,IndexR]=max(phaseR);
[MaxL,IndexL]=max(phaseL);
RPeakIndexRatio=IndexR/bin1;
LPeakIndexRatio=IndexL/bin1;

Old2=cd;
cd('C:\Users\C238\Desktop\CheetahData\2019-2-24_15-41-22 15101-03\15102_190224_98__')
load('15102_190224_98__touchfile','RpegTouchallWon98','LpegTouchallWon98','TurnMarkerTime98','OneTurnTime98','FinishTime98');


% RmedianPTTM10=round(sort(RmedianPTTM*10,'ascend'));
% LmedianPTTM10=round(sort(LmedianPTTM*10,'ascend'));
% RmedianPTTM10=RmedianPTTM10(find(~isnan(RmedianPTTM10)));
% LmedianPTTM10=LmedianPTTM10(find(~isnan(LmedianPTTM10)));
% RmedianPTTM1=[RmedianPTTM10 RmedianPTTM10+OneTurnTime];
% LmedianPTTM1=[LmedianPTTM10 LmedianPTTM10+OneTurnTime];
RAllSteptime=[];
LAllSteptime=[];

for a=1:length(RpegTouchallWon98)-1
    bin2=abs(round(RpegTouchallWon98(a)-RpegTouchallWon98(a+1)));
    if bin2<500;
        ROneSteptime=[];
        OnestepHist1msRamp=OnestepHist1msR*pksA1(1);
        ROneSteptime=OnestepHist1msRamp((length(OnestepHist1msRamp)-bin2+1):end);
    else
        ROneSteptime=zeros(1,bin2);
    end
    RAllSteptime=[RAllSteptime ROneSteptime];
end
for b=1:length(LpegTouchallWon98)-1
    bin2=abs(round(LpegTouchallWon98(b)-LpegTouchallWon98(b+1)));
    if bin2<500;
        LOneSteptime=[];
        OnestepHist1msLamp=OnestepHist1msL*pksA2(1);
        B=ceil(bin2/length(OnestepHist1msLamp));
        LOneSteptime=OnestepHist1msLamp((length(OnestepHist1msLamp)-bin2+1):end);
    else
        LOneSteptime=zeros(1,bin2);
    end
    LAllSteptime=[LAllSteptime LOneSteptime];
end
fig=figure
subplot(2,1,1)
plot(linspace(0,1,length(OnestepSpikeHistogramR)),OnestepSpikeHistogramR,'color','b');hold on
plot(linspace(0,1,length(OnestepSpikeHistogramL)),OnestepSpikeHistogramL,'color','r');
RAllSteptime=[zeros(1,round(RpegTouchallWon98(1))) RAllSteptime zeros(1,round(FinishTime98-RpegTouchallWon98(end)))];   %%
LAllSteptime=[zeros(1,round(LpegTouchallWon98(1))) LAllSteptime zeros(1,round(FinishTime98-LpegTouchallWon98(end)))];
RLPhase=RAllSteptime+LAllSteptime;
BIN=1000;
Mbin=round(length(RLPhase)/BIN)+1;
RLPhaseTM1=[];
RLPhaseTMsum=zeros(1,OneTurnTime98*2+1);
S=length(TurnMarkerTime98);
for i=2:length(TurnMarkerTime98)-1
    RLPhaseTM1=[];
    RLPhaseTM1=RLPhase((TurnMarkerTime98(i)-OneTurnTime98):(TurnMarkerTime98(i)+OneTurnTime98));
    RLPhaseTMsum=RLPhaseTMsum+RLPhaseTM1;
end
RLPhaseTM=RLPhaseTMsum/(length(TurnMarkerTime98)-1);
RLPhaseTM=MovWindow(RLPhaseTM,20);
subplot(2,1,2)
plot(linspace(0,OneTurnTime98*2,length(RLPhaseTM)),RLPhaseTM);
% Old1=cd;
% cd('C:\Users\C238\Desktop\WR_LVdata')
% load('15102_190227_98__touchfile','RmedianPTTM98','LmedianPTTM98','RpegMedian98','LpegMedian98','OneTurnTime98');
% Max=max(RLPhaseTM);
% RmedianPTTM98=round(sort(RmedianPTTM98*10,'ascend'));
% LmedianPTTM98=round(sort(LmedianPTTM98*10,'ascend'));
% RmedianPTTM98=RmedianPTTM98(find(~isnan(RmedianPTTM98)));
% LmedianPTTM98=LmedianPTTM98(find(~isnan(LmedianPTTM98)));
% RmedianPTTM98=[RmedianPTTM98 RmedianPTTM98+OneTurnTime98];
% LmedianPTTM98=[LmedianPTTM98 LmedianPTTM98+OneTurnTime98];
% for n=1:length(RmedianPTTM98)
%     text(RmedianPTTM98(n),Max-0.5,'l','FontSize',18,'color',[0 1 0]);
% end
% for n=1:length(LmedianPTTM98)
%     text(LmedianPTTM98(n),Max,'l','FontSize',18,'color',[1 0 0]);        
% end
% 
% % % % % % % % pdR=fitdist(phaseRamp','Normal');
% % % % % % % % x_valueR=linspace(0,OneTurnTime98*2,1000);
% % % % % % % % yR=pdf(pdR,x_valueR);
% % % % % % % % 
% % % % % % % % pdL=fitdist(phaseLamp','Normal');
% % % % % % % % x_valueL=linspace(0,OneTurnTime98*2,1000);
% % % % % % % % yL=pdf(pdL,x_valueL);
% % % % % % % % 
% % % % % % % % figure
% % % % % % % % plot(x_valueR,yR,'color','b');hold on
% % % % % % % % plot(x_valueL,yL,'color','r');
% % % % % % % % 
% cd(Old1);

close
cd(Old2);

% Raxis(0  0 max(RLPhaseTM)*1.5)
% RLPhaseTM=CrossCorr(RLPhase',TurnMarkerTime,OneTurnTime*2,0,TurnMarkerTime);
% NewRLPhaseTM=[];
% NewRLPhaseTM1=[];
% for i=1:BIN
%     RLPhaseTMmean=0;
%     RLPhaseTMsum=0;
%     for j=1:Mbin
%         if j+(i-1)*round(Mbin)>length(RLPhaseTM);
%             break;
%         end
%         RLPhaseTMsum=RLPhaseTMsum+RLPhaseTM(j+(i-1)*Mbin);
%         RLPhaseTMmean=RLPhaseTMsum/Mbin;
%     end
%     NewRLPhaseTM1(i)=RLPhaseTMmean;
%     NewRLPhaseTM=[NewRLPhaseTM NewRLPhaseTM1];
% end
% NewRLPhaseTM=hist(NewRLPhaseTM,OneTurnTime*2)/length(TurnMarkerTime);
% NewRLPhaseTM=MovWindow(NewRLPhaseTM,5);
% figure 
% plot(linspace(1,OneTurnTime*2,length(NewRLPhaseTM)),NewRLPhaseTM,'color','b');
% cd(Old);


% ROneTurnPhase=[];
% LOneTurnPhase=[];
% for i=1:length(TurnMarkerTime)-1;
%     ROneTurnPhaseCell(i,:)=RAllTouchPhase(TurnMarkerTime(i)<RAllTouchPhase & RAllTouchPhase<TurnMarkerTime(i+1))
% end
% 
% RAllTouchPhase=[zeros(1,round(RpegTouchallWon(1))) RAllTouchPhase zeros(1,round(OneTurnTime*2-RpegTouchallWon(end)))];
% LAllTouchPhase=[zeros(1,round(LpegTouchallWon(1))) LAllTouchPhase zeros(1,round(OneTurnTime*2-LpegTouchallWon(end)))];
% 
% 
% figure
% subplot(2,2,1);
% plot(linspace(0,OneTurnTime*2,length(RAllTouchPhase)),RAllTouchPhase);
% subplot(2,2,2);
% plot(linspace(0,OneTurnTime*2,length(LAllTouchPhase)),LAllTouchPhase);
% RLPhase=RAllTouchPhase+LAllTouchPhase;
% RLPhase=RLPhase-mean(RLPhase);
% subplot(2,2,[3,4])
% plot(linspace(0,OneTurnTime*2,length(RLPhase)),RLPhase);hold on
% axis([0 OneTurnTime*2 0 max(RLPhase)*1.3]);
% RpegMedian=[RpegMedian,RpegMedian+OneTurnTime];
% LpegMedian=[LpegMedian,LpegMedian+OneTurnTime];
% for n=1:length(RpegMedian)
%         text(RpegMedian(n),max(RLPhase)*1.05,'l','FontSize',16,'color',[0 1 1]);
% end
% for n=1:length(LpegMedian)
%         text(LpegMedian(n),max(RLPhase)*1.13,'l','FontSize',16,'color',[1 0 1]);
% end

