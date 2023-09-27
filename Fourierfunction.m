function Fourierfunction(CCresultDrinkOn)
%UNTITLED2 この関数の概要をここに記述
%   詳細説明をここに記述
global fname tfile TotalTime ADon figWon MaxADon MaxZ MaxA1Rt_count render
bin=500;
% M=mean(CCresultDrinkOn);

if render == 1
    figWon=figure;
    subplot(2,1,1);
    plot(linspace(1,2000,bin),CCresultDrinkOn,'color','k');hold on
    axis([0 2000 0 max(CCresultDrinkOn)*1.1]);
    xlabel('Spike/DrinkOn');
    ylabel(['CCDrinkon'])
end
CCresultDrinkOn=CCresultDrinkOn/mean(CCresultDrinkOn);
CCresultDrinkOn1=(CCresultDrinkOn-mean(CCresultDrinkOn));

fs=250;
dft_size=5000;
Y=fft(CCresultDrinkOn1,dft_size)/bin;
Y(1)=0;
k=1:dft_size/2+1;
ADon(k)=abs(Y(k));
P(k)=abs(Y(k)).^2;
frequency(k)=(k-1)*fs/dft_size;
% figure
% subplot(2,1,1)
% plot(frequency,A)
% axis([0 10 0 max(A)*1.1])
if render == 1
    subplot(2,1,2)
    plot(frequency,ADon)
    axis([0 10 0 max(ADon)*1.1])
    ylabel(['DrinkOn spectrum'])
end
FigNameWon=[fname(1:end-4),tfile(1:end-2),'CCW1','.bmp'];

IndexFreq=find(7<frequency & frequency<10);
[MaxADon locsADon]=max(ADon(IndexFreq(1):IndexFreq(end)));

Z=zscore(ADon);
if render == 1
    figure
    plot(frequency,Z);
    axis([0 10 0 max(Z)*1.1]);
    close;
end
fname;
tfile;
[MaxZ locsZ]=max(Z(IndexFreq(1):IndexFreq(end)));