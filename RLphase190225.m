function RLphase190225
global  ACresult ACresultW CCresultDrinkOn SpikeArray RpegTouchallWon LpegTouchallWon TurnMarkerTime RmedianPTTM RpegMedian LmedianPTTM LpegMedian...
    RpNum LpNum  OneTurnTime CCresultSpike locsP1time locsP2time locsP1time2 locsP2time2 pksA1 pksA2 CCresultRtouchWon CCresultLtouchWon
% cd('C:\Users\C238\Desktop\CheetahData\2019-2-25_10-48-49 15101-04\15101_190225_98__');
% load Bdata.mat
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

RmedianPTTM10=round(sort(RmedianPTTM*10,'ascend'));
LmedianPTTM10=round(sort(LmedianPTTM*10,'ascend'));
RmedianPTTM10=RmedianPTTM10(find(~isnan(RmedianPTTM10)));
LmedianPTTM10=LmedianPTTM10(find(~isnan(LmedianPTTM10)));
RmedianPTTM1=[RmedianPTTM10 RmedianPTTM10+OneTurnTime];
LmedianPTTM1=[LmedianPTTM10 LmedianPTTM10+OneTurnTime];
ROneTurnPhase=[];
LOneTurnPhase=[];

for i=1:length(RmedianPTTM1)-1
    bin2=abs(round(RmedianPTTM1(i)-RmedianPTTM1(i+1)));
    B=bin2/8;
    ROneStepPhase=zeros(1,bin2);
    RPeakIndex=round(bin2*RPeakIndexRatio);
    ROneStepPhase(RPeakIndex)=MaxR*pksA1(1);
    for j=1:B
        if (RPeakIndex+j)<length(ROneStepPhase); 
            ROneStepPhase(RPeakIndex+j)=(MaxR*pksA1(1))-(MaxR*pksA1(1)/(B)*j);
        end
        if (RPeakIndex-j)>0;
            ROneStepPhase(RPeakIndex-j)=(MaxR*pksA1(1))-(MaxR*pksA1(1)/(B)*j);
        end
    end
    ROneTurnPhase=[ROneTurnPhase ROneStepPhase];
end
for i=1:length(LmedianPTTM1)-1
    bin2=abs(round(LmedianPTTM1(i)-LmedianPTTM1(i+1)));
    B=bin2/8;
    LOneStepPhase=zeros(1,bin2);
    LPeakIndex=round(bin2*LPeakIndexRatio);
    LOneStepPhase(LPeakIndex)=MaxL*pksA2(1);
    for j=1:B
        if (LPeakIndex+j)<length(LOneStepPhase); 
            LOneStepPhase(LPeakIndex+j)=(MaxL*pksA2(1))-(MaxL*pksA2(1)/(B)*j);
        end
        if (LPeakIndex-j)>0;
            LOneStepPhase(LPeakIndex-j)=(MaxL*pksA2(1))-(MaxL*pksA2(1)/(B)*j);
        end
    end
    LOneTurnPhase=[LOneTurnPhase LOneStepPhase];
end

ROneTurnPhase=[zeros(1,round(RmedianPTTM1(1))) ROneTurnPhase zeros(1,round(OneTurnTime*2-RmedianPTTM1(end)))];
LOneTurnPhase=[zeros(1,round(LmedianPTTM1(1))) LOneTurnPhase zeros(1,round(OneTurnTime*2-LmedianPTTM1(end)))];
S=round(OneTurnTime*2-LmedianPTTM1(end));
figure
subplot(2,2,1);
plot(linspace(0,OneTurnTime*2,length(ROneTurnPhase)),ROneTurnPhase);
subplot(2,2,2);
plot(linspace(0,OneTurnTime*2,length(LOneTurnPhase)),LOneTurnPhase);
RLPhase=ROneTurnPhase+LOneTurnPhase;
subplot(2,2,[3,4])
plot(linspace(0,OneTurnTime*2,length(RLPhase)),RLPhase);


