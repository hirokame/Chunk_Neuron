function pretouch20191024
%仮説３：スパイクがあった直前のタッチからスパイクまでの時間を用いた予測
%pretouch20190608からの変更点：1000ビンに直すところjMaxの値を小数第一位までに変更、ヒルベルト変換を使わないようにした
global  ACresult ACresultW CCresultDrinkOn SpikeArray TurnMarkerTime RpegTouchallWon LpegTouchallWon...
    RpNum LpNum   CCresultSpike locsP1time locsP2time locsP1time2 locsP2time2 pksA1 pksA2 CCresultRtouchWon CCresultLtouchWon dpath3...
    StartTime FinishTime DiffMaxMinR DiffMaxMinL fname SpikeArrayWon tfile OneTurnTime OnestepHist1msR OnestepHist1msL OnestepSpikeHistogramR OnestepSpikeHistogramL...
    fig FLName EnveRLPhaseTM EnveCCresultSpikePro meanKldistDiff KldistSame  dpath  KLD3 meanXaxiserror3 Envedist3 meanXaxiserror Envedist

bin=20;
OnestepSpikeArray2R=[];
OnestepSpikeArrayAll2R=[];
for i=1:length(RpegTouchallWon)-1
    OnestepSpikeArray2R=[];
    OnestepSpikeArray2R=SpikeArrayWon(RpegTouchallWon(i)<SpikeArrayWon & SpikeArrayWon<RpegTouchallWon(i+1));
    OnestepSpikeArray2R=OnestepSpikeArray2R-RpegTouchallWon(i);
    OnestepSpikeArrayAll2R=[OnestepSpikeArrayAll2R,OnestepSpikeArray2R];
end




OnestepSpikeArray2L=[];
OnestepSpikeArrayAll2L=[];
for i=1:length(LpegTouchallWon)-1
    OnestepSpikeArray2L=[];
    OnestepSpikeArray2L=SpikeArrayWon(LpegTouchallWon(i)<SpikeArrayWon & SpikeArrayWon<LpegTouchallWon(i+1));
    OnestepSpikeArray2L=OnestepSpikeArray2L-LpegTouchallWon(i);
    OnestepSpikeArrayAll2L=[OnestepSpikeArrayAll2L,OnestepSpikeArray2L];
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


% [MaxR,IndexR]=max(phaseR);
% [MaxL,IndexL]=max(phaseL);
% RPeakIndexRatio=IndexR/bin1;
% LPeakIndexRatio=IndexL/bin1;
% 
Old2=cd;
cd(dpath3);
LS=ls;
for k=1:length(LS(:,1));
    FL=strtrim(LS(k,:));
    if (length(FL)>2 && strcmp(FL(end-4:end),'_98__')) || (length(FL)>2 && strcmp(FL(end-4:end),'_89__'));
        CDdir=[dpath,FL];
cd(CDdir);
FLNAME=[strtrim(tfile),'touchfile.mat'];
load(FLNAME,'RpegTouchallWon98','LpegTouchallWon98','TurnMarkerTime98','OneTurnTime98','FinishTime98','SpikeArray98');
break;
    end
end

% cd('C:\Users\C238\Desktop\CheetahData\2019-2-25_10-48-49 15101-04\15101_190225_98__')
% FLNAME=[strtrim(tfile),'touchfile.mat'];
% load(FLNAME,'RpegTouchallWon98','LpegTouchallWon98','TurnMarkerTime98','OneTurnTime98','FinishTime98','SpikeArray98');
% 

% RmedianPTTM10=round(sort(RmedianPTTM*10,'ascend'));
% LmedianPTTM10=round(sort(LmedianPTTM*10,'ascend'));
% RmedianPTTM10=RmedianPTTM10(find(~isnan(RmedianPTTM10)));
% LmedianPTTM10=LmedianPTTM10(find(~isnan(LmedianPTTM10)));
% RmedianPTTM1=[RmedianPTTM10 RmedianPTTM10+OneTurnTime];
% LmedianPTTM1=[LmedianPTTM10 LmedianPTTM10+OneTurnTime];
RAllTouchPhase=[];
LAllTouchPhase=[];

for i=1:length(RpegTouchallWon98)-1
    bin2=abs(round(RpegTouchallWon98(i)-RpegTouchallWon98(i+1)));
    ROneStepPhase=zeros(1,bin2);
    OnestepSpikeArrayAll2R=OnestepSpikeArrayAll2R(abs(OnestepSpikeArrayAll2R)<bin2);
    phaseR=hist(OnestepSpikeArrayAll2R,bin);
    phaseRamp=phaseR*pksA1(1);
    B=ceil(bin2/length(phaseRamp));
    for j=1:length(phaseRamp)
        for x=1:B
            if (x+B*(j-1))<bin2;
                ROneStepPhase(x+B*(j-1))=phaseRamp(j);
            end
        end
    end
    RAllTouchPhase=[RAllTouchPhase ROneStepPhase];
end
for i=1:length(LpegTouchallWon98)-1
    bin2=abs(round(LpegTouchallWon98(i)-LpegTouchallWon98(i+1)));
    LOneStepPhase=zeros(1,bin2);
    OnestepSpikeArrayAll2L=OnestepSpikeArrayAll2L(abs(OnestepSpikeArrayAll2L)<bin2);
    phaseL=hist(OnestepSpikeArrayAll2L,bin);
    phaseLamp=phaseL*pksA2(1);
    B=ceil(bin2/length(phaseLamp));
    for j=1:length(phaseLamp)
        for x=1:B
            if (x+B*(j-1))<bin2;
                LOneStepPhase(x+B*(j-1))=phaseLamp(j);
            end
        end
    end
    LAllTouchPhase=[LAllTouchPhase LOneStepPhase];
end
fig2=figure;%off
subplot(2,1,1)%off
plot(linspace(0,1,length(phaseRamp)),phaseRamp,'color','b');hold on%off
plot(linspace(0,1,length(phaseLamp)),phaseLamp,'color','r');%off
RAllTouchPhase=[zeros(1,round(RpegTouchallWon98(1))) RAllTouchPhase zeros(1,round(FinishTime98-RpegTouchallWon98(end)))];   %%
LAllTouchPhase=[zeros(1,round(LpegTouchallWon98(1))) LAllTouchPhase zeros(1,round(FinishTime98-LpegTouchallWon98(end)))];

RAllTouchPhaseTMsum=zeros(1,OneTurnTime98*2+1);
LAllTouchPhaseTMsum=zeros(1,OneTurnTime98*2+1);
for i=2:length(TurnMarkerTime98)-1
    RAllTouchPhaseTM=[];
    LAllTouchPhaseTM=[];
    RAllTouchPhaseTM=RAllTouchPhase(round(TurnMarkerTime98(i)-OneTurnTime98):round(TurnMarkerTime98(i)+OneTurnTime98));
    LAllTouchPhaseTM=LAllTouchPhase(round(TurnMarkerTime98(i)-OneTurnTime98):round(TurnMarkerTime98(i)+OneTurnTime98));
    RAllTouchPhaseTMsum=RAllTouchPhaseTMsum+RAllTouchPhaseTM;
    LAllTouchPhaseTMsum=LAllTouchPhaseTMsum+LAllTouchPhaseTM;
end
RAllTouchPhaseTM=RAllTouchPhaseTMsum/(length(TurnMarkerTime98)-1);
LAllTouchPhaseTM=LAllTouchPhaseTMsum/(length(TurnMarkerTime98)-1);
RAllTouchPhaseTM=MovWindow(RAllTouchPhaseTM,20);
LAllTouchPhaseTM=MovWindow(LAllTouchPhaseTM,20);
% RAllTouchPhaseTM=RAllTouchPhaseTM-mean(RAllTouchPhaseTM);
% LAllTouchPhaseTM=LAllTouchPhaseTM-mean(LAllTouchPhaseTM);
% negativeR=find(RAllTouchPhaseTM<0);
% negativeL=find(LAllTouchPhaseTM<0);
% RAllTouchPhaseTM(negativeR)=0;
% LAllTouchPhaseTM(negativeL)=0;

% figure
% plot(linspace(0,OneTurnTime98*2,length(RAllTouchPhaseTM)),RAllTouchPhaseTM,'color','b');hold on 
% plot(linspace(0,OneTurnTime98*2,length(LAllTouchPhaseTM)),LAllTouchPhaseTM,'color','r')
% if max(max(RAllTouchPhaseTM),max(LAllTouchPhaseTM))>0;
% axis([0 OneTurnTime98*2 0 max(max(RAllTouchPhaseTM),max(LAllTouchPhaseTM))*1.1]);
% end

% MeanR=mean(RAllTouchPhase);
% MeanL=mean(LAllTouchPhase);
% RAllTouchPhase=RAllTouchPhase-MeanR;
% LAllTouchPhase=LAllTouchPhase-MeanL;
RLPhase=RAllTouchPhase+LAllTouchPhase;
RLPhase(RLPhase<0)=0;
BIN=1000;
Mbin=round(length(RLPhase)/BIN)+1;
RLPhaseTM1=[];
RLPhaseTMsum=zeros(1,OneTurnTime98*2+1);
S=length(TurnMarkerTime98);
for i=2:length(TurnMarkerTime98)-2
    RLPhaseTM1=[];
    RLPhaseTM1=RLPhase(round(TurnMarkerTime98(i)-OneTurnTime98):round(TurnMarkerTime98(i)+OneTurnTime98));
    RLPhaseTMsum=RLPhaseTMsum+RLPhaseTM1;
end


RLPhaseTM=RLPhaseTMsum/(length(TurnMarkerTime98)-1);
RLPhaseTM=MovWindow(RLPhaseTM,20);
RLPhaseTM=RLPhaseTM-mean(RLPhaseTM);
negative= RLPhaseTM<0;
% negative=find(RLPhaseTM<0);
RLPhaseTM(negative)=0;

%ビン数→1000
jMax=round(length(RLPhaseTM)/1000,1);%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%変更点 
RLPhaseTM1000=zeros(1,1000);
for i=1:1000
        if jMax+(i-1)*jMax<length(RLPhaseTM);
        RLPhaseTM1000(i)=sum(RLPhaseTM(floor(1+(i-1)*jMax):floor(jMax+(i-1)*jMax)));
        end
end


BIN=1000;
[CrossCoSpike98]=CrossCorr(SpikeArray98',TurnMarkerTime98,OneTurnTime98*2,0,TurnMarkerTime98);
CCresultSpike98=hist(CrossCoSpike98,BIN)/length(TurnMarkerTime98);
CCresultSpike98=MovWindow(CCresultSpike98,5);

C=sum(CCresultSpike98);
CCresultSpikePro=CCresultSpike98/C;
RLPhaseTM1000Pro=RLPhaseTM1000/sum(RLPhaseTM1000);
% dist=KLDiv(RLPhaseTM1000Pro,CCresultSpikePro);


% 平均化フィルター
% N=round(length(RLPhaseTM)/length(CCresultSpike));
N=20;
coeff = ones(1, N)/N;
delay=(length(coeff)-1)/2;
avgRLPhaseTM = filter(coeff, 1, RLPhaseTM1000Pro);
% plot(linspace(0,OneTurnTime98*2-delay,length(RLPhaseTM)),avgRLPhaseTM);
% % % % % 包絡線
% % % % x = hilbert(avgRLPhaseTM);%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%ヒルベルト変換は使用しない                                                  
EnveRLPhaseTM=avgRLPhaseTM;%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%変数名変えるのめんどいからそのまま使用                             



% 平均化フィルター
% N=round(length(RLPhaseTM)/length(CCresultSpike));
N=20;
coeff = ones(1, N)/N;
delay=(length(coeff)-1)/2;
avgCCresultSpikePro = filter(coeff, 1, CCresultSpikePro);
% plot(linspace(0,OneTurnTime98*2-delay,length(RLPhaseTM)),CCresultSpikePro);
% % % % % % 包絡線
% % % % % x = hilbert(avgCCresultSpikePro);%%%%%%%%%%%%%%%%%%%ヒルベルト変換は使用しない                                                                     
EnveCCresultSpikePro=avgCCresultSpikePro;%%%%%%%%%%%%%%%%%%%%%%変数名変えるのめんどいからそのまま使用

if isnan(EnveRLPhaseTM)==0 & isnan(EnveCCresultSpikePro)==0;
dist=KLDiv(EnveRLPhaseTM,EnveCCresultSpikePro);
else
    dist=Inf;
end
subplot(2,1,2)%off
plot(linspace(0,OneTurnTime98*2,length(EnveRLPhaseTM)),EnveRLPhaseTM,'color','r');hold on %off
plot(linspace(0,OneTurnTime98*2,length(EnveCCresultSpikePro)),EnveCCresultSpikePro,'color','k');%off
if max(EnveRLPhaseTM)>0;%off
axis([0 OneTurnTime98*2 0 max(max(EnveRLPhaseTM),max(EnveCCresultSpikePro))*1.1]);%off
end%off
ylabel('mean');%off
xlabel(['dist=',num2str(dist)]);%off
% [h,p] = kstest2(EnveRLPhaseTM,EnveCCresultSpikePro);
% h
% p
Old1=cd;


% figure
% plot(linspace(0,OneTurnTime98*2,length(RAllTouchPhaseTM)),RAllTouchPhaseTM,'color','b');hold on 
% plot(linspace(0,OneTurnTime98*2,length(LAllTouchPhaseTM)),LAllTouchPhaseTM,'color','r')
% if max(max(RAllTouchPhaseTM),max(LAllTouchPhaseTM))>0;
% axis([0 OneTurnTime98*2 0 max(max(RAllTouchPhaseTM),max(LAllTouchPhaseTM))*1.1]);
% end

cd(Old1);
% close
cd(Old2);
F=[FLName,'\prepost'];
cd(F)
tfiletrim=strtrim(tfile);
figname=[tfiletrim(1:end-2),'pretouch','.bmp'];
saveas(fig2,figname);%off
cd(Old2);
close;%off

ALLCellKL20190618
cd(F);
dirName=['pretouchKL'];
mkdir(dirName);
Z=[F,'\pretouchKL'];
cd(Z);
filename=[tfiletrim(1:end-2),'pretouch','KL'];
save(filename,'KldistSame','meanKldistDiff');
cd(Old2);
KLD3=KldistSame;


prediction20190729

meanXaxiserror3=meanXaxiserror;
Envedist3=Envedist;
