function ITS20191031

global SpikeArray RpegTouchallWon LpegTouchallWon TurnMarkerTime fname tfile ITS FLName dpath3


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
bin=1000;
[CrossCoRtouchWon]=CrossCorr(SpikeArray',RpegTouchallWon,10000,0,TurnMarkerTime);
CCresultRtouchWon=hist(CrossCoRtouchWon,bin)/length(RpegTouchallWon);                                       %20190606hennkou
CCresultRtouchWon=MovWindow(CCresultRtouchWon,10);
[CrossCoLtouchWon]=CrossCorr(SpikeArray',LpegTouchallWon,10000,0,TurnMarkerTime);
CCresultLtouchWon=hist(CrossCoLtouchWon,bin)/length(LpegTouchallWon);                                       %20190606hennkou
CCresultLtouchWon=MovWindow(CCresultLtouchWon,10);


%%%%%%%%%%%%%%%%%inter-touch Spike  ITS  Right or Left%%%%%%%%%%%%%
ITSR=phaseR;
ITSL=phaseL;
ITS=[ITSR;ITSL];

tfiletrim=strtrim(tfile);
fnametrim=strtrim(fname);
FLName
% if strcmp(fnametrim(end-7),'C');
    OLD=cd;
    path=[dpath3,'\R_LPhaseFolder'];
    cd(path);
    FLname=[tfiletrim(1:end-2),fnametrim(1:end-4),'ITS'];
    ITS
    save(FLname,'ITS');

    cd(OLD);
% end