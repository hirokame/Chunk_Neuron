function DrinkTouch_Analysis(DrinkOnArray,DrinkOffArray,RPegTouchAll,LPegTouchAll,TurnMarkerTime,DrName)
% RPegTouch‚¨‚æ‚ÑLPegTouch‚ðDrink‚Åalign‚µ‚½‚Æ‚«‚Ìfrequency‚ð”äŠr‚·‚é
global DrinkOnArray DrinkOffArray RPegTouchAll LPegTouchAll TurnMarkerTime DrName

DrName

% ACselect=DrinkOnArray;
ACselect=DrinkOffArray;
duration=5000;
bin=1024;   % bin‚Ì”‚É‚æ‚Á‚Äfrequency‚ÌŒ©‚¦•û‚ª•Ï‚í‚é
Direction=0;

CCselect1=RPegTouchAll;
CCselect2=LPegTouchAll;

[AutoCo]=AutoCorr(ACselect,duration,Direction);
figure
subplot(3,1,1)
hist(AutoCo,bin);
ACresult=hist(AutoCo,bin);
[CrossCo]=CrossCorr(ACselect,CCselect1,duration,Direction,TurnMarkerTime);
subplot(3,1,2)
hist(CrossCo,bin)
CCresult1=hist(CrossCo,bin);
[CrossCo]=CrossCorr(ACselect,CCselect2,duration,Direction,TurnMarkerTime);
subplot(3,1,3)
hist(CrossCo,bin)
CCresult2=hist(CrossCo,bin);

fs=1/(duration*10^-3/bin);
dft_size=512;

Ad=zeros(1,dft_size/2+1);
Ar=zeros(1,dft_size/2+1);
Al=zeros(1,dft_size/2+1);
Pd=zeros(1,dft_size/2+1);
Pr=zeros(1,dft_size/2+1);
Pl=zeros(1,dft_size/2+1);
frequency=zeros(1,dft_size/2+1);
% FFT‚ðŽÀs‚·‚é”ÍˆÍ
X=fft(ACresult,dft_size); % -2500:2500
Y=fft(CCresult1,dft_size);
Z=fft(CCresult2,dft_size);
% X=fft(ACresult(2*bin/4+1:3*bin/4),dft_size); % 0:1250
% Y=fft(CCresult1(2*bin/4+1:3*bin/4),dft_size);
% Z=fft(CCresult2(2*bin/4+1:3*bin/4),dft_size);
% X=fft(ACresult(3*bin/4+1:4*bin/4),dft_size); % 1250:2500
% Y=fft(CCresult1(3*bin/4+1:4*bin/4),dft_size);
% Z=fft(CCresult2(3*bin/4+1:4*bin/4),dft_size);
for k=1:dft_size/2+1;
    Ad(k)=abs(X(k));
    Ar(k)=abs(Y(k));
    Al(k)=abs(Z(k));
    Pd(k)=(abs(X(k))).^2;
    Pr(k)=(abs(Y(k))).^2;
    Pl(k)=(abs(Z(k))).^2;
    frequency(k)=(k-1)*fs/dft_size;
end
frequency=frequency(2:end);
Ad=Ad(2:end);
Ar=Ar(2:end);
Al=Al(2:end);
Pd=Pd(2:end);
Pr=Pr(2:end);
Pl=Pl(2:end);

figure
subplot(3,2,1)
plot(frequency,Ad)
axis([0 15 0 max(Ad)*1.1])
ylabel('DrinkOn')
subplot(3,2,2)
plot(frequency,Pd)
axis([0 15 0 max(Pd)*1.1])
subplot(3,2,3)
plot(frequency,Ar)
axis([0 15 0 max(Ar)*1.1])
ylabel('Drink/Right')
subplot(3,2,4)
plot(frequency,Pr)
axis([0 15 0 max(Pr)*1.1])
subplot(3,2,5)
plot(frequency,Al)
axis([0 15 0 max(Al)*1.1])
ylabel('Drink/Left')
subplot(3,2,6)
plot(frequency,Pl)
axis([0 15 0 max(Pl)*1.1])

In=find(frequency>=8&frequency<=12); % 8-12Hz‚Å’T‚·
Index=find(Ad==max(Ad(In)))
DrinkFr=frequency(Index)
PdValue=Pd(Index)

% Ar(Index)
% Pr(Index)
% Al(Index)
% Pl(Index)
Right_Drink=1000*Pr(Index)/Pd(Index)
Left_Drink=1000*Pl(Index)/Pd(Index)
RLratio=Right_Drink/Left_Drink

disp('------------------------------');

