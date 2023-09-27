function modulation20190709

global  ACresult ACresultW CCresultDrinkOn SpikeArray TurnMarkerTime RpegTouchallWon LpegTouchallWon render...
    RpNum LpNum   CCresultSpike locsP1time locsP2time locsP1time2 locsP2time2 pksA1 pksA2 CCresultRtouchWon CCresultLtouchWon dpath3...
    StartTime FinishTime DiffMaxMinR DiffMaxMinL fname tfile OneTurnTime EnveRLPhaseTM EnveCCresultSpikePro  dpath meanKldistDiff KldistSame FLName KLfname KLD...
    TrimStrB AFreq ZFreq

Old=cd;
trimtfile=strtrim(tfile);
% if strcmp(TrimStrB(end-7:end-4),'98__');
CC=CCresultSpike;
% end
% if strcmp(TrimStrB(end-7:end-4),'Bgra');
% CCBgra=CCresultSpike;
% end

AFreqArray=[];
pksCC=findpeaks(CC,'MinPeakDistance',30);
%     findpeaks(CC98,'MinPeakDistance',30);
L=linspace(0,1,length(pksCC));
if render == 1
    fig=figure;
    subplot(2,2,[1,2]);
    plot(L,pksCC);
end
if ~isempty(pksCC)
    pksCC=pksCC-mean(pksCC);
    bin=length(pksCC);
    %     dft_size=2^nextpow2(bin);
    dft_size=bin*2;
    fs=bin;
    Y1=fft(pksCC,dft_size)/bin;
    P=1:dft_size/2+1;
    frequency=[];
    A=[];
    for k=1:length(P)
        A(k)=2*abs(Y1(k));
        frequency(k)=(k-1)*fs/dft_size;
    end
    if render == 1
        subplot(2,2,3);
        plot(frequency,A,'color','b');
    end
    
    Z=zscore(A);
    if render == 1
        subplot(2,2,4);
        plot(frequency,Z,'color','r');
        if max(frequency)>0 && max(Z)>0;
            axis([0 max(frequency)*1.1 0 max(Z)*1.1]);
        end
    end
    
    frequency=abs(frequency-2);
    [minFreq locs]=min(frequency);
    AFreqArray=[AFreqArray A(locs)];
    AFreq=A(locs);
    ZFreq=Z(locs);
    if render == 1
        xlabel(['Y2Hz=',num2str(AFreq),' Z2Hz=',num2str(ZFreq)]);
        figname=['modulation',trimtfile(1:end-1),'.bmp'];
    end
    Folder=['modulationtest'];
    if not(exist(Folder,'dir'))
        mkdir(Folder)
    end
    cd(Folder)
    if render == 1
        saveas(fig,figname);
    end
    close;
end
cd(Old)
