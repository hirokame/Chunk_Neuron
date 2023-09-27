function FourierfunctionRLPeg20190925
%
%   詳細説明をここに記述
global  ACresult ACresultW CCresultDrinkOn SpikeArray RpegTouchallWon LpegTouchallWon TurnMarkerTime RmedianPTTM RpegMedian LmedianPTTM LpegMedian render...
    RpNum LpNum  OneTurnTime CCresultSpike locsP1time locsP2time locsP1time2 locsP2time2 fname tfile WaterOnArrayOriginal A1Rt A2Lt htouch phaseLpeg phaseRpeg OnePhaseLindex...
    pksP1 locsP1 pksP2 locsP2 OnePhaseRindex MaxA1Rt MaxA2Lt MaxZR MaxZL frequency mensekiR mensekiL RpegTimeArray LpegTimeArray CCresultRpeg CCresultLpeg

% RmedianPTTM=[RmedianPTTM;RmedianPTTM+OneTurnTime];
% RpegMedian=horzcat(RpegMedian,RpegMedian);
% LmedianPTTM=horzcat(LmedianPTTM,LmedianPTTM);
% LpegMedian=horzcat(LpegMedian,LpegMedian);
% figure
% BIN=1000;
% Max=max(CCresultSpike);
% plot(linspace(1,OneTurnTime*2,BIN),CCresultSpike,'color','b');hold on
%  for n=1:RpNum*2
%         text(RmedianPTTM(n)*10,Max*1.05,'l','FontSize',18,'color',[0 1 0]);
%         text(RpegMedian(n),Max*1.2,'l','FontSize',16,'color',[0 1 1]);
%  end
%  for n=1:LpNum*2
%         text(LmedianPTTM(n)*10,Max*1.13,'l','FontSize',18,'color',[1 0 0]);        
%         text(LpegMedian(n),Max*1.3,'l','FontSize',16,'color',[1 0 1]);
%  end
%  axis([0 OneTurnTime*2 0 Max*1.5]);
% RLphase
% FourierfunctionAC
% Fourierfunction(CCresultDrinkOn)
% WaterOnOffRaster
bin1=20;
phaseRpeg=zeros(1,bin1);
for i=1:length(RpegTimeArray)-1
    for j=1:length(SpikeArray)-1
        if RpegTimeArray(i)<SpikeArray(j)&&SpikeArray(j)<RpegTimeArray(i+1);   %%タッチ間でスパイクがあったか
           binarrayR=linspace(RpegTimeArray(i),RpegTimeArray(i+1),bin1+1);     %%タッチ間をbin1の数に分割
           for k=1:length(phaseRpeg)-1
               if binarrayR(k)<SpikeArray(j)&&SpikeArray(j)<binarrayR(k+1);        %%どのビンでスパイクがあったか
                   phaseRpeg(k)=phaseRpeg(k)+1;
                   
                   
                   
               end
           end
        end
    end
end
phaseLpeg=zeros(1,bin1);
for i=1:length(LpegTouchallWon)-1
    for j=1:length(SpikeArray)-1
        if LpegTouchallWon(i)<SpikeArray(j)&&SpikeArray(j)<LpegTouchallWon(i+1);   %%タッチ間でスパイクがあったか
           binarrayL=linspace(LpegTouchallWon(i),LpegTouchallWon(i+1),bin1+1);   %%タッチ間をbin1の数に分割
           for k=1:length(phaseLpeg)-1
               if binarrayL(k)<SpikeArray(j)&&SpikeArray(j)<binarrayL(k+1);  %%どのビンでスパイクがあったか
                   phaseLpeg(k)=phaseLpeg(k)+1;
               end
           end
        end
    end
end
bin=1000;
[CrossCoRtouchWon]=CrossCorr(SpikeArray',RpegTimeArray,10000,0,TurnMarkerTime);
CCresultRtouchWon=hist(CrossCoRtouchWon,bin)/length(RpegTimeArray);                                       %20190606hennkou
CCresultRtouchWon=MovWindow(CCresultRtouchWon,10);
[CrossCoLtouchWon]=CrossCorr(SpikeArray',LpegTouchallWon,10000,0,TurnMarkerTime);
CCresultLtouchWon=hist(CrossCoLtouchWon,bin)/length(LpegTouchallWon);                                       %20190606hennkou
CCresultLtouchWon=MovWindow(CCresultLtouchWon,10);



M1=mean(CCresultRtouchWon);
CCresultRtouchWon=CCresultRtouchWon/M1;
M2=mean(CCresultLtouchWon);
CCresultLtouchWon=CCresultLtouchWon/M2;

if render==1;
htouch=figure;
subplot(3,2,1);
plot(linspace(1,10000,bin),CCresultRtouchWon,'color','b','LineWidth',1);hold on
plot(linspace(1,10000,bin),CCresultLtouchWon,'color','r','LineWidth',1);
axis([0 10000 0 max(max(CCresultRtouchWon),max(CCresultLtouchWon))*1.1]);
ylabel(['CCR/LTouch']);
end

% [pksCCresultRtouchWon,locsCCresultRtouchWon]=findpeaks(CCresultRtouchWon);
% [pksCCresultLtouchWon,locsCCresultLtouchWon]=findpeaks(CCresultLtouchWon);
% locsCCresultRtouchWon=locsCCresultRtouchWon*10-5000;
% locsCCresultLtouchWon=locsCCresultLtouchWon*10-5000;

M1=mean(CCresultRtouchWon);
CCresultRtouchWon=CCresultRtouchWon-M1;
M2=mean(CCresultLtouchWon);
CCresultLtouchWon=CCresultLtouchWon-M2;



fs=100;%%サンプリング周波数
% dft_size=2^nextpow2(bin);
dft_size=2000;
%右足タッチでアラインしたスパイクのフーリエ変換
Y1=fft(CCresultRtouchWon,dft_size)/bin;
k=1:dft_size/2+1;
A1Rt(k)=2*abs(Y1(k));
P1(k)=abs(Y1(k)).^2;
frequency(k)=(k-1)*fs/dft_size;

%左足タッチでアラインしたスパイクのフーリエ変換
Y2=fft(CCresultLtouchWon,dft_size)/bin;
A2Lt(k)=2*abs(Y2(k));
P2(k)=abs(Y2(k)).^2;
frequency(k)=(k-1)*fs/dft_size;

[pksP1,locsP1]=findpeaks(A1Rt,'sortstr','descend');  %%%ピークになる周波数
locsP1=(locsP1-1)*fs/dft_size;
locsP1time=1/locsP1(1)*1000;
locsP1time2=1/locsP1(2)*1000;
[pksP2,locsP2]=findpeaks(A2Lt,'sortstr','descend');
locsP2=(locsP2-1)*fs/dft_size;
locsP2time=1/locsP2(1)*1000;
locsP2time2=1/locsP2(2)*1000;

% figure
% subplot(2,1,1)
% plot(frequency,A1,'color','b');hold on
% plot(frequency,A2,'color','r')
% axis([0 10 0 max(max(A1),max(A2))*1.1])
if render=1;
subplot(3,2,2)
plot(frequency,A1Rt,'color','b');hold on
plot(frequency,A2Lt,'color','r')
axis([0 5 0 max(max(A1Rt),max(A2Lt))*1.1])
box off
xlabel(['pFR1st:',num2str(locsP1(1)),'pFR2:',num2str(locsP1(2)),'FR3:',num2str(locsP1(3)),'peakFreqL1st:',num2str(locsP2(1)),'peakFreqL2:',num2str(locsP2(2))]);
ylabel(['CCTouchSpectrum']);
end
% spectrogram(CCresultRtouchWon);
% [pksP1,locsP1]=max(P1);
% locsP1=(locsP1-1)*fs/dft_size;
% 
% locsP1
% figure
% F=0:.1:10;
% figure
if render==1;
subplot(3,2,3)
spectrogram(CCresultRtouchWon,128,120,128,100,'yaxis');     %%スペクトログラム%
axis([0 11 0 15 -50 10])                                     %%軸の範囲
view(-45,50);                                               %%グラフを見る角度
shading interp
colorbar off

subplot(3,2,4)
spectrogram(CCresultLtouchWon,128,120,128,100,'yaxis');
axis([0 11 0 15 -50 10])
view(-45,50);
shading interp
colorbar off
[s,f,t]=spectrogram(CCresultRtouchWon,128,120,128,100,'yaxis');
[Ms,Is]=max(s)
subplot(3,2,5)
plot(linspace(0,1,bin1),phaseRpeg);
subplot(3,2,6)
plot(linspace(0,1,bin1),phaseLpeg);
FigName11=[fname(1:end-4),tfile(1:end-2),'analysis','.bmp'];
saveas(htouch,FigName11);
close;
end

%タッチの位相のピーク左
linL=linspace(0,1,bin1+1);
PhaseLCell=[phaseLpeg;linL(1:length(phaseLpeg))];
[MPL locsMPL]=max(phaseLpeg);
OnePhaseLindex=PhaseLCell(2,locsMPL);
%タッチの位相のピーク右
linR=linspace(0,1,bin1+1);
PhaseRCell=[phaseRpeg;linL(1:length(phaseRpeg))];
[MPR locsMPR]=max(phaseRpeg);
OnePhaseRindex=PhaseLCell(2,locsMPR);

IndexFreq=find(1.5<frequency & frequency<3);
[MaxA1Rt locsA1Rt]=max(A1Rt(IndexFreq(1):IndexFreq(end)));

IndexFreq=find(1.5<frequency & frequency<3);
[MaxA2Lt locsA2Lt]=max(A2Lt(IndexFreq(1):IndexFreq(end)));

mensekiR=trapz(A1Rt(IndexFreq(1):IndexFreq(end)));
mensekiL=trapz(A2Lt(IndexFreq(1):IndexFreq(end)));

ZR=zscore(A1Rt);
if render ==1;
    figure
plot(frequency,ZR);
axis([0 10 0 max(ZR)*1.1]);
close;
end
[MaxZR locsZR]=max(ZR(IndexFreq(1):IndexFreq(end)));

ZL=zscore(A2Lt);
if render==1;
figure
plot(frequency,ZL);
axis([0 10 0 max(ZL)*1.1]);
close;
end
[MaxZL locsZL]=max(ZL(IndexFreq(1):IndexFreq(end)));
