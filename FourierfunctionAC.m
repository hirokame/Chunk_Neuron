function FourierfunctionAC
%UNTITLED2 この関数の概要をここに記述
%   詳細説明をここに記述
global ACresult ACresultW fname tfile AAC figAC
bin=500;
figAC=figure;
subplot(2,1,1);
plot(linspace(1,5000,bin),ACresult,'color','k');hold on
plot(linspace(1,5000,bin),ACresultW,'color','b');
ylabel(['AC'])
M=mean(ACresultW);
ACresultW=ACresultW-M;

B=all(ACresultW);    %%ACがすべて0の時B=0で以下の処理を行わない  ACが0以外の時B=1

if B==1;
fs=100;
dft_size=5000;
Y=fft(ACresultW,dft_size);
k=1:dft_size/2+1;
AAC(k)=abs(Y(k));
P(k)=abs(Y(k)).^2;
frequency(k)=(k-1)*fs/dft_size;
% figure
% subplot(2,1,1)
% plot(frequency,A)
% axis([0 10 0 max(A)*1.1])
subplot(2,1,2)
plot(frequency,AAC)
if isnan(AAC)==0;
axis([0 10 0 max(AAC)*1.1])
end
ylabel(['ACspedtrum'])
FigNameAC=[fname(1:end-4),tfile(1:end-2),'AC','.bmp'];
saveas(figAC,FigNameAC);
% figure
% spectrogram(ACresultW,128,120,128,100,'yaxis'); 
% axis([0 5 0 15 -100 10])
% view(-45,50);
% shading interp
% colorbar off
close;
 end