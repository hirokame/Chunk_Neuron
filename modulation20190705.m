function modulation20190705

global  ACresult ACresultW CCresultDrinkOn SpikeArray TurnMarkerTime RpegTouchallWon LpegTouchallWon...
    RpNum LpNum   CCresultSpike locsP1time locsP2time locsP1time2 locsP2time2 pksA1 pksA2 CCresultRtouchWon CCresultLtouchWon dpath3...
    StartTime FinishTime DiffMaxMinR DiffMaxMinL fname tfile OneTurnTime EnveRLPhaseTM EnveCCresultSpikePro  dpath meanKldistDiff KldistSame FLName KLfname KLD...
    CCresultSpike modulationratioArray



cd(dpath3)
CCS=[dpath,'CCSFolder'];
cd(CCS);


% cd('C:\Users\C238\Desktop\CheetahWRLV20180729\119\2017-6-7_20-8-33 11901-51\CCSFolder');


LS=ls;
CC98=[];
CCBgra=[];
for i=1:length(LS(:,1))
    FL=strtrim(LS(i,:));
    if length(FL)>2 && strcmp(FL(end-7:end-4),'98__');
        load(FL);
        CC98=[CC98;CCresultSpike];
        
    end
    if length(FL)>2 && strcmp(FL(end-7:end-4),'Bgra');
        load(FL);
        CCBgra=[CCBgra;CCresultSpike];
    end
end
if length(CC98)>1;
AFreqArray=[];
modulationratio=0;
modulationratioArray=[];
for i=1:length(CC98(:,1));
    modulationratio=0;
    pksCC98=findpeaks(CC98(i,:),'MinPeakDistance',30);
    findpeaks(CC98(i,:),'MinPeakDistance',30);
    L=linspace(0,1,length(pksCC98));
%     fig=figure;
%     subplot(2,2,[1,2]);
%     plot(L,pksCC98);
    pksCC98=pksCC98-mean(pksCC98);
    bin=length(pksCC98);
%     dft_size=2^nextpow2(bin);
    dft_size=20;
    fs=bin;
    Y1=fft(pksCC98,dft_size)/bin;
    P=1:dft_size/2+1;
    frequency=[];
    A98=[];
    for k=1:length(P)
    A98(k)=2*abs(Y1(k));
    frequency(k)=(k-1)*fs/dft_size;
    end
%     fig=figure
%     subplot(2,2,3);
%     plot(frequency,A98,'color','b');
    
    
    Z=zscore(A98);
%     subplot(2,2,4);
%     plot(frequency,Z,'color','r');
%     if max(frequency)>0 && max(Z)>0;
%     axis([0 max(frequency)*1.1 0 max(Z)*1.1]);
%     end
    
    
    frequency=abs(frequency-2);
    [minFreq locs]=min(frequency);
    AFreqArray=[AFreqArray A98(locs)];
    AFreq=A98(locs);
    ZFreq=Z(locs);
    if ZFreq>1.5;
%     xlabel(['Y2Hz=',num2str(A98Freq)]);
%     figname=['modulation',num2str(i),'.bmp'];
%     saveas(fig,figname);
    if length(pksCC98)>10;
    [pkspksCC98 IndexpksCC98]=findpeaks(pksCC98,'MinPeakDistance',7);
    else
        IndexpksCC98=[];
    end
    if length(IndexpksCC98)>0
    modulationratio=IndexpksCC98(1)/length(pksCC98);
    modulationratioArray=[modulationratioArray modulationratio];
    else
        modulationratio=NaN;
        modulationratioArray=[modulationratioArray modulationratio];
    end
    end
end
else
   modulationratioArray=[modulationratioArray NaN]; 
end
% figure

modulationratioArray