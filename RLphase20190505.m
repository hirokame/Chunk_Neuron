function RLphase20190505
global  ACresult ACresultW CCresultDrinkOn SpikeArray TurnMarkerTime RpegTouchallWon LpegTouchallWon...
    RpNum LpNum   CCresultSpike locsP1time locsP2time locsP1time2 locsP2time2 pksA1 pksA2 CCresultRtouchWon CCresultLtouchWon dpath3...
    StartTime FinishTime DiffMaxMinR DiffMaxMinL fname tfile OneTurnTime

bin1=20;
phaseR1=zeros(1,bin1);
SpikeArray1=SpikeArray;
for i=1:length(RpegTouchallWon)-1
    for j=1:length(SpikeArray1)-1
        if RpegTouchallWon(i)<SpikeArray1(j)&&SpikeArray1(j)<RpegTouchallWon(i+1);   %%タッチ間でスパイクがあったか
           binarrayR=linspace(RpegTouchallWon(i),RpegTouchallWon(i+1),bin1+1);     %%タッチ間をbin1の数に分割
           for k=1:length(phaseR1)-1
               if binarrayR(k)<SpikeArray1(j)&&SpikeArray1(j)<binarrayR(k+1);        %%どのビンでスパイクがあったか
                   phaseR1(k)=phaseR1(k)+1;
               end
           end
        end
    end
end
phaseL1=zeros(1,bin1);
for i=1:length(LpegTouchallWon)-1
    for j=1:length(SpikeArray1)-1
        if LpegTouchallWon(i)<SpikeArray1(j)&&SpikeArray1(j)<LpegTouchallWon(i+1);   %%タッチ間でスパイクがあったか
           binarrayR=linspace(LpegTouchallWon(i),LpegTouchallWon(i+1),bin1+1);   %%タッチ間をbin1の数に分割
           for k=1:length(phaseL1)-1
               if binarrayR(k)<SpikeArray1(j)&&SpikeArray1(j)<binarrayR(k+1);  %%どのビンでスパイクがあったか
                   phaseL1(k)=phaseL1(k)+1;
               end
           end
        end
    end
end


figure
subplot(2,1,1);
plot(linspace(0,1,length(phaseR1)),phaseR1,'color','b');hold on
plot(linspace(0,1,length(phaseL1)),phaseL1,'color','r');

[MaxphaseR locsphaseR]=max(phaseR1);

binarrayR=[];
binarrayR=[];
% i=0;
% j=0;
% k=0;
phaseRR=zeros(1,bin1);
SpikeArray1=[];
for i=1:length(RpegTouchallWon)-1
    for j=1:length(SpikeArray)-1
        if RpegTouchallWon(i)<SpikeArray(j)&&SpikeArray(j)<RpegTouchallWon(i+1);   %%タッチ間でスパイクがあったか
           binarrayR=linspace(RpegTouchallWon(i),RpegTouchallWon(i+1),bin1+1);     %%タッチ間をbin1の数に分割
           if locsphaseR-2>0;    
           for k=locsphaseR-2:locsphaseR+2-1
                   if binarrayR(k)<SpikeArray(j)&&SpikeArray(j)<binarrayR(k+1);
                    phaseRR(k)=phaseRR(k)+1;
                    SpikeArray1=[SpikeArray1 SpikeArray(j)];
                   end
           end
           elseif locsphaseR-2<=0;
           for k=1:locsphaseR+2-1
                   if binarrayR(k)<SpikeArray(j)&&SpikeArray(j)<binarrayR(k+1);
                    phaseRR(k)=phaseRR(k)+1;
                    SpikeArray1=[SpikeArray1 SpikeArray(j)];
                   end
           end
           elseif locsphaseR+2-1>bin1
           for k=locsphaseR-2:bin1
                   if binarrayR(k)<SpikeArray(j)&&SpikeArray(j)<binarrayR(k+1);
                    phaseRR(k)=phaseRR(k)+1;
                    SpikeArray1=[SpikeArray1 SpikeArray(j)];
                   end
           end   
           end
        end
    end
end
phaseRR
% SpikeArray1(isnan(SpikeArray1)) = []; 


phaseLL=zeros(1,bin1);
for i=1:length(LpegTouchallWon)-1
    for j=1:length(SpikeArray1)-1
        if LpegTouchallWon(i)<SpikeArray1(j)&&SpikeArray1(j)<LpegTouchallWon(i+1);   %%タッチ間でスパイクがあったか
           binarrayL=linspace(LpegTouchallWon(i),LpegTouchallWon(i+1),bin1+1);     %%タッチ間をbin1の数に分割
           for k=1:length(phaseLL)-1
               if binarrayL(k)<SpikeArray1(j)&&SpikeArray1(j)<binarrayL(k+1);        %%どのビンでスパイクがあったか
                   phaseLL(k)=phaseLL(k)+1;
               end
           end
        end
    end
end

subplot(2,1,2);
plot(linspace(0,1,length(phaseRR)),phaseRR,'color','b');hold on
plot(linspace(0,1,length(phaseLL)),phaseLL,'color','r');
