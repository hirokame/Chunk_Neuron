function PeakTouchInterval 
% クロスコリオグラムのインターバルのピーク分布
global CCresultRtouchWon CCresultLtouchWon RpegTouchallWon LpegTouchallWon SpikeArrayWon tfile pegpatternname trimFolder2 IntervalCount PeakInterval

findpeaks(CCresultLtouchWon,'MinPeakDistance',30);
[Lpks,Llocs]=findpeaks(CCresultLtouchWon,'MinPeakDistance',30);
LlocsInterval=Llocs-250;
LlocsInterval1=LlocsInterval(LlocsInterval>0);
Linterval1=sort(abs(LlocsInterval1),'ascend');
LlocsInterval2=LlocsInterval(LlocsInterval<0);
Linterval2=sort(LlocsInterval2,'descend');
% subplot(2,2,4);
findpeaks(CCresultRtouchWon,'MinPeakDistance',30);
[Rpks,Rlocs]=findpeaks(CCresultRtouchWon,'MinPeakDistance',30);
RlocsInterval=Rlocs-250;
RlocsInterval1=RlocsInterval(RlocsInterval>0);
Rinterval1=sort(abs(RlocsInterval1),'ascend');
RlocsInterval2=RlocsInterval(RlocsInterval<0);
Rinterval2=sort(RlocsInterval2,'descend');

if length(Linterval1)>2 && length(Linterval2)>2 && length(Rinterval1)>2 && length(Rinterval2)>2;  
    if Rinterval2(1) < Linterval2(1) && Linterval2(1) < Rinterval1(1) && Rinterval1(1) < Linterval1(1) && abs(Rinterval2(1)) < abs(Linterval1(1)) % ウインドウRLRの順
        PeakInterval=(Rinterval1(1)-Rinterval2(1))*10;
    elseif Linterval2(1) < Rinterval2(1) && Rinterval2(1) < Linterval1(1) && Linterval1(1) < Rinterval1(1) && abs(Linterval2(1)) > abs(Rinterval1(1)) % ウインドウRLRの順
        PeakInterval=(Rinterval1(1)-Rinterval2(1))*10;
    end
    if Rinterval2(1) < Linterval2(1) && Linterval2(1) < Rinterval1(1) && Rinterval1(1) < Linterval1(1) && abs(Rinterval2(1)) > abs(Linterval1(1)) % ウインドウLRLの順   
        PeakInterval=(Linterval1(1)-Linterval2(1))*10;
    elseif Linterval2(1) < Rinterval2(1) && Rinterval2(1) < Linterval1(1) && Linterval1(1) < Rinterval1(1) && abs(Linterval2(1)) < abs(Rinterval1(1)) % ウインドウLRLの順
        PeakInterval=(Linterval1(1)-Linterval2(1))*10;
    end
end  