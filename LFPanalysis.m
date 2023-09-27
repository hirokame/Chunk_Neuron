function LFPanalysis(SpikeStartTime,SpikeStopTime,StartTime,FinishTime,TurnMarkerTime,OneTurnTime,Timestamp,Samples,RPegTouchAll,ts_spike,event_name,event_ts)
global fname dpath DrName SpikeStartTime SpikeStopTime StartTime FinishTime TurnMarkerTime OneTurnTime Timestamp Samples RPegTouchAll ts_spike event_name event_ts
% load('C:\Documents and Settings\永田雅俊\デスクトップ\WR LVdata\DataAnalysed\CSC\100823CSC1.mat');
% 
% [fname,dpath]=FileSelectSpikeData;

% 初めにSpikeStartTime、SpikeStopTimeを指定する。
% そのマウスの走行データ、Reference、WorkingFileをロード

format long;
Time1=[];Time2=[];a=1;
for n=1:length(event_name)-1
    if event_name(n)==2&&event_name(n+1)==3
        T1=event_ts(n);T2=event_ts(n+1);
        Time1=[Time1,T1];Time2=[Time2,T2];
        a=a+1;
    end
end
delStartStop=Time2-Time1
Time1=num2str(Time1,9)
Time2=num2str(Time2,9)

SpikeStartTime=input('Enter Time1:')
SpikeStopTime=input('Enter Time2:')

[fnamemat,dpathmat]=FileSelectMat;
load(fnamemat);
cd 'C:\Documents and Settings\永田雅俊\デスクトップ\WR LVdata\CSCmat';
[fnamemat,dpathmat] = uigetfile('*.mat');
fnamemat
cd(dpathmat)
load(fnamemat,'Samples')
LFPsamples_Ref=Samples;
[fnamemat,dpathmat] = uigetfile('*.mat');
cd(dpathmat)
fnamemat
load(fnamemat);
LFPsamples=Samples-LFPsamples_Ref;

AllTimestamp=[];
TimestampArray=[];

for n=1:length(Timestamp)
    m=0:511;
    AllTimestamp=[AllTimestamp,Timestamp(n)+528*m];
end
AllTimestampLength=length(AllTimestamp);

% SpikeStartTime=409341.576;
% SpikeStopTime=568603.338;
% 100926
% SpikeStartTime=483.150145;
% SpikeStopTime=744.02026;
% 100921
% SpikeStartTime=219.145911;
% SpikeStopTime=463.740261
% 100930#35
% SpikeStartTime=49.354326;
% SpikeStopTime=317.055078;
% 101001#35
% SpikeStartTime=328.112632;
% SpikeStopTime=574.118293;
% 101002#35
% SpikeStartTime=623.568627;SpikeStopTime=928.740978;
% 101014#37
% SpikeStartTime=570.618764;
% SpikeStopTime=819.324518;
% 101019#37
% SpikeStartTime=295.735459;SpikeStopTime=458.529607; % AG
% SpikeStartTime=501.746902;SpikeStopTime=671.890513; % ref=5

% SpikeStartTime(LabViewのStartボタンが押された時のNeurarynxの時間）と
% StartTime(LabView開始からStartボタンが押されるまでの時間)をそろえる必要がある。
% なのでTimestampからSpikeStartTimeを引いてStartTimeを加える。
% LFPは528μsecごとに記録されており、時間単位をマイクロ秒に揃えてで計算しないとずれが生じる。

% disp('LFPTimestamp(1:10)=');disp(AllTimestamp(1:10));
T=AllTimestamp-SpikeStartTime*10^6+StartTime*1000;
TimestampArray=T(StartTime*1000<T&T<FinishTime*1000);

BeforeRec=length(AllTimestamp(SpikeStartTime*10^6>AllTimestamp));
AfterRec=length(AllTimestamp(SpikeStopTime*10^6<AllTimestamp));
RecLength=length(AllTimestamp(SpikeStartTime*10^6<AllTimestamp&SpikeStopTime*10^6>AllTimestamp));
TimestampArayLength=length(TimestampArray)

LFPsamples_Run=LFPsamples(BeforeRec+1:BeforeRec+RecLength);
LFPsample_length=length(LFPsamples_Run)

%   StartTimeからFinishTimeまでのLFPとTimestampは
%   LFPsamples_Run、TimestampArray

%   LFPのタッチなどによるアライン


Align_Base=TurnMarkerTime;T='TurnMarkerTime';
% Align_Base=RPegTouchAll;T='RPegTouch';
% Align_Base=LPegTouchAll;T='LPegTouch';
% Align_Base=DrinkOnArray;T='DrinkOn';
% Spike_Array=(ts_spike-SpikeStartTime)*1000+StartTime;
% Spike_Array=Spike_Array(StartTime<Spike_Array&Spike_Array<FinishTime);
% Align_Base=Spike_Array;T='Spike_Array';
% LFP_aligned=zeros(length(Align_Base)-1,ceil((OneTurnTime*1000/2)/528)*2+1);
format short;
ValidIndex=[];
Direction=0;   % 両方向か片方向か
duration=(OneTurnTime*1000)/528;
if Direction==1 %片方向
    for n=1:length(Align_Base)
%        A=min(TimestampArray(TimestampArray>Align_Base(n).*1000));
       Index=find(TimestampArray==min(TimestampArray(TimestampArray>Align_Base(n).*1000)));
       if Index>0&&Index+ceil(duration)<length(LFPsamples_Run)
          ValidIndex=[ValidIndex n];
%           x=LFPsamples_Run(Index-ceil((OneTurnTime*1000/2)/528):Index+ceil((OneTurnTime*1000/2)/528));
          LFP_aligned(length(ValidIndex),:)=LFPsamples_Run(Index:Index+ceil(duration));
       end
    end
else
    for n=1:length(Align_Base)
%        A=min(TimestampArray(TimestampArray>Align_Base(n).*1000));
       Index=find(TimestampArray==min(TimestampArray(TimestampArray>Align_Base(n).*1000)));
       if Index-ceil(duration/2)>0&&Index+ceil(duration/2)<length(LFPsamples_Run)
          ValidIndex=[ValidIndex n];
%           x=LFPsamples_Run(Index-ceil((OneTurnTime*1000/2)/528):Index+ceil((OneTurnTime*1000/2)/528));
          LFP_aligned(length(ValidIndex),:)=LFPsamples_Run(Index-ceil(duration/2):Index+ceil(duration/2));
       end
    end
end

LFP=mean(LFP_aligned,1);
% GaussSmooth
LFParray=instantArray(LFP,20);
% LFParray=LFP;
figure
plot(LFParray)
axis([0 ceil(duration) min(mean(LFP_aligned)) max(mean(LFP_aligned))])
if Direction==1
    set(gca,'xtick',0:ceil(duration)/8:ceil(duration)+1,'xticklabel',0:round(OneTurnTime*0.1/8)*10:round(OneTurnTime*0.1/8)*80)
else
    set(gca,'xtick',0:ceil(duration)/8:ceil(duration)+1,'xticklabel',-round(OneTurnTime*0.1/8)*40:round(OneTurnTime*0.1/8)*10:round(OneTurnTime*0.1/8)*40)
end
Title=char(strcat({T},{' '},{strrep(fnamemat,'.mat','')}));
% disp(Title);
title(Title);
saveas(gca,Title,'bmp')



%  振幅スペクトルとパワースペクトルの範囲を変更するには、dft_sizeの範囲を変える
%  spectrogramの範囲を変更するには、window_size、shift_sizeの範囲を変える
fs=10^6/528;
dft_size=8192;
window_size=2048;
shift_size=64;
Turnframe=floor(OneTurnTime/(shift_size*0.528))+window_size/shift_size-1;


% 有効なTurnMarkerTimeからOneTurnTimeまでの区間のLFPを抽出
ValidTurn=[];   
AllTurnLFP=[];
AllTurnLFPplus=[];
for n=1:length(TurnMarkerTime)-1
    if TurnMarkerTime(n+1)-TurnMarkerTime(n)<OneTurnTime*1.05
        ValidTurn=[ValidTurn n];
        Index=find(TimestampArray==min(TimestampArray(TimestampArray>TurnMarkerTime(n).*1000)));
        L=LFPsamples_Run(Index:Index+floor(OneTurnTime/0.528)-1);
        LL=LFPsamples_Run(Index:Index+floor(OneTurnTime/0.528)-1+window_size);
        AllTurnLFP(length(ValidTurn),:)=L;   % TurnMarkerTimeからOneTurnTimeまでのLFPsamples
        AllTurnLFPplus(length(ValidTurn),:)=LL;   % TurnMarkerTimeからOneTurnTime+window_sizeまでのLFPsamples
    end
    
end

A=zeros(1,dft_size/2+1);
P=zeros(1,dft_size/2+1);
frequency=zeros(1,dft_size/2+1);

% 走行始め・中盤・終盤3点の振幅スペクトルとパワースペクトルの表示
st=1:length(ValidTurn)/2-1:length(ValidTurn);
st=floor(st);
for n=1:length(st)
    Y=fft(AllTurnLFP((st(n)),:),dft_size);
    k=1:dft_size/2+1;
    A(k)=abs(Y(k));
    P(k)=abs(Y(k)).^2;
    frequency(k)=(k-1)*fs/dft_size;
    figure
    subplot(2,1,1)
    plot(frequency,A)
    axis([0 50 0 max(A)*1.1])
    subplot(2,1,2)
    plot(frequency,P)
    axis([0 50 0 max(P)*1.1])
end

% x=AllTurnLFP(st(1));
% [Pxx,Pxxc,f] = pmtm(x,4,dft_size,fs);
% hpsd = dspdata.psd([Pxx Pxxc],'Fs',fs);
% figure;plot(hpsd)

% 全有効Turnのdft_sizeにおける平均振幅スペクトル、平均パワースペクトル
for x=1:length(ValidTurn)
    X=fft(AllTurnLFP(x,:),dft_size);
    k=1:dft_size/2+1;
    A(k)=abs(X(k));
    P(k)=(abs(X(k))).^2;
    An(x,:)=A(k);
    Pn(x,:)=P(k);
    frequency(k)=(k-1)*fs/dft_size;
end
figure
subplot(2,1,1)
plot(frequency,mean(An))
axis([0 50 0 max(mean(An))*1.1])
subplot(2,1,2)
plot(frequency,mean(Pn))
axis([0 50 0 max(mean(Pn))*1.1])

w=HanningWindow_(window_size);   % 窓関数
% shift_sizeごとにfftを実行。
c=nan(window_size/2+1,floor((length(AllTurnLFPplus)-window_size)/shift_size+1),length(AllTurnLFPplus(:,1)));
for n=1:length(AllTurnLFPplus(:,1))
    s=AllTurnLFPplus(n,:);
    [Ps,time,frequency]=Spectrogram_(s,fs,window_size,shift_size,w);
    c(:,:,n)=Ps;
end
% 走行始め・中盤・終盤3点のspectrogramの表示
st=1:length(ValidTurn)/2-1:length(ValidTurn);
st=floor(st);
for n=1:length(st)
    figure
    imagesc(time,frequency,c(:,:,st(n)));
    axis xy
    ylim([0 10])
    colorbar
end
    
% 平均spectrogram
% 各有効なTurnMarkerTime数分のパワースペクトルを平均する。
AvePs=mean(c,3);
figure
% Clim=([0 10^10])
imagesc(time,frequency,AvePs);
axis xy
ylim([0 10])
colorbar
Title=(char(strcat({'Spectrogram'},{' '},{strrep(fnamemat,'.mat','')})));
title(Title);
saveas(gca,Title,'bmp')

% % pow2=nextpow2(LFPsample_length)-1
% % dft_size=2^pow2;

% x=LFPsamples_Run;
% X=fft(x,dft_size);   % Xはdft_sizeの長さをもつ、直流成分と基本周波数倍の複素数
% A=zeros(1,dft_size/2+1);
% P=zeros(1,dft_size/2+1);
% frequency=zeros(1,dft_size/2+1);
% for k=1:dft_size/2+1,
%     A(k)=abs(X(k));
%     P(k)=abs(X(k))^2;
%     frequency(k)=(k-1)*fs/dft_size;
% end
% 
% figure
% subplot(2,1,1)
% plot(frequency,A)
% axis([0 50 0 max(A)*1.1])
% subplot(2,1,2)
% plot(frequency,P)
% axis([0 50 0 max(P)*1.1])

%   全区間のspectrogram

% s=LFPsamples_Run;
% % s=LFPsamples_Run(1:9600);
% [Ps,time,frequency]=Spectrogram_(s,fs,window_size,shift_size);
% figure
% % Clim=([0 10^10])
% imagesc(time,frequency,Ps);
% axis xy
% ylim([0 10])
% colorbar