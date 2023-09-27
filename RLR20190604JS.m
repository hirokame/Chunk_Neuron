function RLR20190604JS

global  ACresult ACresultW CCresultDrinkOn SpikeArray TurnMarkerTime RpegTouchallWon LpegTouchallWon...
    RpNum LpNum locsP1time locsP2time locsP1time2 locsP2time2 pksA1 pksA2 CCresultRtouchWon CCresultLtouchWon dpath3...
    StartTime FinishTime DiffMaxMinR DiffMaxMinL fname tfile OneTurnTime dpath FLName meanKldistDiff KldistSame  EnveRLPhaseTM EnveCCresultSpikePro KLD4 KLD5



%Lt⇔Rt
%Lt(i+1)からRtまでのIntervalをRttouchInLtArrayに保存
RttouchInLtArray=[];
bin=30
for i=1:length(LpegTouchallWon)-1
    for j=1:length(SpikeArray)
        RttouchInLt=[];
        if LpegTouchallWon(i)<SpikeArray(j) && SpikeArray(j)<LpegTouchallWon(i+1);
           RttouchInLt=RpegTouchallWon(LpegTouchallWon(i)<RpegTouchallWon & RpegTouchallWon<LpegTouchallWon(i+1));
           if length(RttouchInLt)==1;
               LtRtInterval=LpegTouchallWon(i+1)-RttouchInLt;
               RttouchInLtArray=[RttouchInLtArray LtRtInterval];
           end
        end
    end
end
RttouchInLtArray=[0 RttouchInLtArray 600];

%RttouchInLtArrayをヒストグラムにする
RtInLtHist=hist(RttouchInLtArray,31);      %20ms間隔のビンでヒストグラム
binarrayLt=linspace(0,600,31);
figx=figure 
plot(binarrayLt,RtInLtHist);
xlabel('RtInLttime');

Oldcd=cd;
F=[FLName,'\RtInLttimeFolder'];         
cd(F);
fnametrim=strtrim(fname);
tfiletrim=strtrim(tfile);
figname=[fnametrim(1:end-4),tfiletrim(1:end-2),'.bmp'];
saveas(figx,figname);
cd(Oldcd);
close;
RtInLtHist

bin1=10;
binarrayRt=linspace(0,600,bin+1);
SpikeInbinArray=zeros(1,bin1);
RtSpikeInLtMatrix=zeros(bin,bin1);
RtInbin=0;
for i=1:length(LpegTouchallWon)-1
    binarrayLt=linspace(LpegTouchallWon(i),LpegTouchallWon(i+1),bin1+1);
    RtInLt=RpegTouchallWon(LpegTouchallWon(i)<RpegTouchallWon & RpegTouchallWon<LpegTouchallWon(i+1));
    if length(RtInLt)==1;
        LtRtInterval=LpegTouchallWon(i+1)-RtInLt;
    for j=1:length(binarrayRt)-1
        SpikeInbin=[];
        SpikeInbinArray=zeros(1,bin1);
        if binarrayRt(j)<LtRtInterval && LtRtInterval<binarrayRt(j+1);
           for k=1:length(binarrayLt)-1;
               for l=1:length(SpikeArray)
                  if binarrayLt(k)<SpikeArray(l) & SpikeArray(l)<binarrayLt(k+1);
                    SpikeInbinArray(k)=SpikeInbinArray(k)+1;
                  end
               end
           end
        end
        RtSpikeInLtMatrix(j,:)=RtSpikeInLtMatrix(j,:)+SpikeInbinArray;
        
    end
    end
end
S=sum(RtSpikeInLtMatrix);
S
SS=sum(S);
SS
Nc = 30;                        % 作りたい色の数
A = colormap(colorcube(Nc));      % colorcubeを変えることで、色んな組み合わせの色が作れる。

figure
for i=1:bin
    plot(linspace(0,1,bin1),RtSpikeInLtMatrix(i,:),'Color',A(i,:),'LineWidth',2);hold on 
end
hold off;
close;

% for i=1:bin
%     figure
%     plot(linspace(0,1,bin1),RtSpikeInLtMatrix(i,:),'Color',A(i,:),'LineWidth',2);
%     xlabel(num2str(i*20));
%     close;
% end
% 

Old2=cd;
cd(dpath3);
LS=ls;
for k=1:length(LS(:,1));
    FL=strtrim(LS(k,:));
    if length(FL)>2 && strcmp(FL(end-4:end),'_98__');
        CDdir=[dpath,FL];
cd(CDdir);
FLNAME=[strtrim(tfile),'touchfile.mat'];
load(FLNAME,'RpegTouchallWon98','LpegTouchallWon98','TurnMarkerTime98','OneTurnTime98','FinishTime98','SpikeArray98');
    end
end

% cd('C:\Users\C238\Desktop\CheetahData\2019-2-25_10-48-49 15101-04\15101_190225_98__')
% FLNAME=[strtrim(tfile),'touchfile.mat'];
% load(FLNAME,'RpegTouchallWon98','LpegTouchallWon98','TurnMarkerTime98','OneTurnTime98','FinishTime98','SpikeArray98');


OneStepSpike=[];
AllSessionSpike=[];
binarrayLt=zeros(1,bin1);
for i=1:length(LpegTouchallWon98)-1
    intervalL=LpegTouchallWon98(i+1)-LpegTouchallWon98(i);
    binarrayLt=linspace(LpegTouchallWon98(i),LpegTouchallWon98(i+1),bin1+1); 
    RtInLt=RpegTouchallWon98(LpegTouchallWon98(i)<RpegTouchallWon98 & RpegTouchallWon98<LpegTouchallWon98(i+1));
    if length(RtInLt) < 2 && length(RtInLt)>0 
        LtRtInterval=LpegTouchallWon98(i+1)-RtInLt;
    if LtRtInterval<600 && intervalL<600;
    for x=1:length(binarrayRt)-1;
        if LtRtInterval>binarrayRt(x) && LtRtInterval<binarrayRt(x+1);
                bin2=LpegTouchallWon98(i+1)-LpegTouchallWon98(i);
                OneStepSpike=zeros(1,bin2);
                B=ceil(bin2/length(RtSpikeInLtMatrix(x,:)));
                for t=1:length(RtSpikeInLtMatrix(x,:))
                    for y=1:B
                        if (y+B*(t-1))<bin2;
                            OneStepSpike(y+B*(t-1))=RtSpikeInLtMatrix(x,t);
                        end
                    end
                end
%                 break;
        end
    end
    else
       bin2=LpegTouchallWon98(i+1)-LpegTouchallWon98(i);
       OneStepSpike=zeros(1,bin2);
    end
    AllSessionSpike=[AllSessionSpike OneStepSpike];
    else
       bin2=LpegTouchallWon98(i+1)-LpegTouchallWon98(i);
       OneStepSpike=zeros(1,bin2);
       AllSessionSpike=[AllSessionSpike OneStepSpike];
%        continue;
    end
end


AllSessionSpike=[zeros(1,round(LpegTouchallWon98(1))) AllSessionSpike zeros(1,round(FinishTime98-LpegTouchallWon98(end)))];

RLPhaseTMsum=zeros(1,OneTurnTime98*2+1);
for i=2:length(TurnMarkerTime98)-1
    RLPhaseTM1=[];
    RLPhaseTM1=AllSessionSpike((TurnMarkerTime98(i)-OneTurnTime98):(TurnMarkerTime98(i)+OneTurnTime98));
    RLPhaseTMsum=RLPhaseTMsum+RLPhaseTM1;
end

RLPhaseTM=RLPhaseTMsum/(length(TurnMarkerTime98)-1);
RLPhaseTM=MovWindow(RLPhaseTM,50);


BIN=1000;
[CrossCoSpikeAll]=CrossCorr(SpikeArray98',TurnMarkerTime98,OneTurnTime98*2,0,TurnMarkerTime98);
CCresultSpikeAll=hist(CrossCoSpikeAll,BIN)/length(TurnMarkerTime98);
CCresultSpikeAll=MovWindow(CCresultSpikeAll,5);
% figure
% plot(linspace(1,OneTurnTime*2,BIN),CCresultSpikeAll,'color','k');hold on

%ビン数→1000
jMax=round(length(RLPhaseTM)/1000);
RLPhaseTM1000=zeros(1,1000);
for i=1:1000
    for j=1;jMax
        if jMax+(i-1)*jMax<length(RLPhaseTM);
        RLPhaseTM1000(i)=sum(RLPhaseTM(j+(i-1)*jMax:jMax+(i-1)*jMax));
        end
    end
end

C=sum(CCresultSpikeAll);
CCresultSpikePro=CCresultSpikeAll/C;
RLPhaseTM1000Pro=RLPhaseTM1000/sum(RLPhaseTM1000);

% 平均化フィルター
% N=round(length(RLPhaseTM)/length(CCresultSpike));
N=20;
coeff = ones(1, N)/N;
delay=(length(coeff)-1)/2;
avgRLPhaseTM = filter(coeff, 1, RLPhaseTM1000Pro);
% plot(linspace(0,OneTurnTime98*2-delay,length(RLPhaseTM)),avgRLPhaseTM);
% 包絡線
x = hilbert(avgRLPhaseTM);
EnveRLPhaseTM=abs(x);



% 平均化フィルター
% N=round(length(RLPhaseTM)/length(CCresultSpike));
N=20;
coeff = ones(1, N)/N;
delay=(length(coeff)-1)/2;
avgCCresultSpikePro = filter(coeff, 1, CCresultSpikePro);
% plot(linspace(0,OneTurnTime98*2-delay,length(RLPhaseTM)),CCresultSpikePro);
% 包絡線
x = hilbert(avgCCresultSpikePro);
EnveCCresultSpikePro=abs(x);

if isnan(EnveRLPhaseTM)==0 & isnan(EnveCCresultSpikePro)==0;
dist=JSDiv(EnveRLPhaseTM,EnveCCresultSpikePro);
else
    dist=Inf;
end

fig=figure;
plot(linspace(0,OneTurnTime98*2,length(EnveRLPhaseTM)),EnveRLPhaseTM); hold on
plot(linspace(1,OneTurnTime98*2,BIN),EnveCCresultSpikePro,'color','r');
tfiletrim=strtrim(tfile);
xlabel([tfiletrim,'dist=',num2str(dist),'Rt-Lt']);
axis([0 OneTurnTime98*2 0 max(max(EnveRLPhaseTM),max(EnveCCresultSpikePro))*1.1]);

cd(Old2);
OldC=cd;
cd(F);                                                                              %F=[FLName,'\RtInLttimeFolder'];
tfiletrim=strtrim(tfile);
figname=[tfiletrim(1:end-2),'RLRtime','Rt-Lt','.bmp'];
saveas(fig,figname);
cd(OldC);
close; 

ALLCellKL20190618JS
meanKldistDiff
KldistSame
cd(F);
dirName=['Rt-LtTime'];
mkdir(dirName);
Z=[F,'\Rt-LtTime'];
cd(Z);
filename=[tfiletrim(1:end-2),'Rt-Lt','KL'];
save(filename,'KldistSame','meanKldistDiff');
cd(OldC);
KLD4=KldistSame;
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%


%Lt⇔Rt
%Lt(i)からRtまでのIntervalをRttouchInLtArrayに保存
RttouchInLtArray=[];
bin=30
for i=1:length(LpegTouchallWon)-1
    for j=1:length(SpikeArray)
        RttouchInLt=[];
        if LpegTouchallWon(i)<SpikeArray(j) && SpikeArray(j)<LpegTouchallWon(i+1);
           RttouchInLt=RpegTouchallWon(LpegTouchallWon(i)<RpegTouchallWon & RpegTouchallWon<LpegTouchallWon(i+1));
           if length(RttouchInLt)==1;
               LtRtInterval=RttouchInLt-LpegTouchallWon(i);
               RttouchInLtArray=[RttouchInLtArray LtRtInterval];
           end
        end
    end
end
RttouchInLtArray=[0 RttouchInLtArray 600];

%RttouchInLtArrayをヒストグラムにする
RtInLtHist=hist(RttouchInLtArray,31);      %20ms間隔のビンでヒストグラム
binarrayLt=linspace(0,600,31);
figx=figure 
plot(binarrayLt,RtInLtHist);
xlabel('RtInLttime');


Oldcd=cd;
F=[FLName,'\RtInLttimeFolder'];         
cd(F);
fnametrim=strtrim(fname);
tfiletrim=strtrim(tfile);
figname=[fnametrim(1:end-4),tfiletrim(1:end-2),'.bmp'];
saveas(figx,figname);
cd(Oldcd);
close;
RtInLtHist
% Old2=cd;
% cd('C:\Users\C238\Desktop\CheetahWRLV20180729\119\2017-6-7_20-8-33 11901-51\11931_170607_98__')
% FLNAME=[strtrim(tfile),'touchfile.mat'];
% load(FLNAME,'RpegTouchallWon98','LpegTouchallWon98','TurnMarkerTime98','OneTurnTime98','FinishTime98','SpikeArray98');


bin1=10;
binarrayRt=linspace(0,600,bin+1);
SpikeInbinArray=zeros(1,bin1);
RtSpikeInLtMatrix=zeros(bin,bin1);
RtInbin=0;
for i=1:length(LpegTouchallWon)-1
    binarrayLt=linspace(LpegTouchallWon(i),LpegTouchallWon(i+1),bin1+1);
    RtInLt=RpegTouchallWon(LpegTouchallWon(i)<RpegTouchallWon & RpegTouchallWon<LpegTouchallWon(i+1));
    if length(RtInLt)==1;
        LtRtInterval=RtInLt-LpegTouchallWon(i);
    for j=1:length(binarrayRt)-1
        SpikeInbin=[];
        SpikeInbinArray=zeros(1,bin1);
        if binarrayRt(j)<LtRtInterval && LtRtInterval<binarrayRt(j+1);
           for k=1:length(binarrayLt)-1;
               for l=1:length(SpikeArray)
                  if binarrayLt(k)<SpikeArray(l) & SpikeArray(l)<binarrayLt(k+1);
                    SpikeInbinArray(k)=SpikeInbinArray(k)+1;
                  end
               end
           end
        end
        RtSpikeInLtMatrix(j,:)=RtSpikeInLtMatrix(j,:)+SpikeInbinArray;
        
    end
    end
end
S=sum(RtSpikeInLtMatrix);
S
SS=sum(S);
SS
Nc = 30;                        % 作りたい色の数
A = colormap(colorcube(Nc));      % colorcubeを変えることで、色んな組み合わせの色が作れる。

figure
for i=1:bin
    plot(linspace(0,1,bin1),RtSpikeInLtMatrix(i,:),'Color',A(i,:),'LineWidth',2);hold on 
end
hold off;
close;

% for i=1:bin
%     figure
%     plot(linspace(0,1,bin1),RtSpikeInLtMatrix(i,:),'Color',A(i,:),'LineWidth',2);
%     xlabel(num2str(i*20));
%     close;
% end
% 

Old2=cd;
cd(dpath3);
LS=ls;
for k=1:length(LS(:,1));
    FL=strtrim(LS(k,:));
    if length(FL)>2 && strcmp(FL(end-4:end),'_98__');
        CDdir=[dpath,FL];
cd(CDdir);
FLNAME=[strtrim(tfile),'touchfile.mat'];
load(FLNAME,'RpegTouchallWon98','LpegTouchallWon98','TurnMarkerTime98','OneTurnTime98','FinishTime98','SpikeArray98');
    end
end
Sum=0;
for i=1:length(LpegTouchallWon98)-1
    S=LpegTouchallWon98(i+1)-LpegTouchallWon98(i);
    Sum=Sum+S;
end
Sum
OneStepSpike=[];
AllSessionSpike=[];
binarrayLt=zeros(1,bin1);
RtInLt=[];
for i=1:length(LpegTouchallWon98)-1
    intervalL=LpegTouchallWon98(i+1)-LpegTouchallWon98(i);
    binarrayLt=linspace(LpegTouchallWon98(i),LpegTouchallWon98(i+1),bin1+1); 
    RtInLt=RpegTouchallWon98(LpegTouchallWon98(i)<RpegTouchallWon98 & RpegTouchallWon98<LpegTouchallWon98(i+1));
    if length(RtInLt) < 2 && length(RtInLt)>0 
        LtRtInterval=RtInLt-LpegTouchallWon98(i);
    if LtRtInterval<600 && intervalL<600;
    for x=1:length(binarrayRt)-1;
        if LtRtInterval>binarrayRt(x) && LtRtInterval<binarrayRt(x+1);
                bin2=LpegTouchallWon98(i+1)-LpegTouchallWon98(i);
                OneStepSpike=zeros(1,bin2);
                B=ceil(bin2/length(RtSpikeInLtMatrix(x,:)));
                for t=1:length(RtSpikeInLtMatrix(x,:))
                    for y=1:B
                        if (y+B*(t-1))<bin2;
                            OneStepSpike(y+B*(t-1))=RtSpikeInLtMatrix(x,t);
                        end
                    end
                end
%                 break;
        end
    end
    else
       bin2=LpegTouchallWon98(i+1)-LpegTouchallWon98(i);
       OneStepSpike=zeros(1,bin2);
    end
    AllSessionSpike=[AllSessionSpike OneStepSpike];
    else
       bin2=LpegTouchallWon98(i+1)-LpegTouchallWon98(i);
       OneStepSpike=zeros(1,bin2);
       AllSessionSpike=[AllSessionSpike OneStepSpike];
%        continue;
    end
end


AllSessionSpike=[zeros(1,round(LpegTouchallWon98(1))) AllSessionSpike zeros(1,round(FinishTime98-LpegTouchallWon98(end)))];

RLPhaseTMsum=zeros(1,OneTurnTime98*2+1);
for i=2:length(TurnMarkerTime98)-1
    RLPhaseTM1=[];
%     if TurnMarkerTime98(i)+OneTurnTime98<length(AllSessionSpike);
    RLPhaseTM1=AllSessionSpike((TurnMarkerTime98(i)-OneTurnTime98):(TurnMarkerTime98(i)+OneTurnTime98));
    RLPhaseTMsum=RLPhaseTMsum+RLPhaseTM1;
%     end
end

RLPhaseTM=RLPhaseTMsum/(length(TurnMarkerTime98)-1);
RLPhaseTM=MovWindow(RLPhaseTM,50);


BIN=1000;
[CrossCoSpikeAll]=CrossCorr(SpikeArray98',TurnMarkerTime98,OneTurnTime98*2,0,TurnMarkerTime98);
CCresultSpikeAll=hist(CrossCoSpikeAll,BIN)/length(TurnMarkerTime98);
CCresultSpikeAll=MovWindow(CCresultSpikeAll,5);
% figure
% plot(linspace(1,OneTurnTime*2,BIN),CCresultSpikeAll,'color','k');hold on

%ビン数→1000
jMax=round(length(RLPhaseTM)/1000);
RLPhaseTM1000=zeros(1,1000);
for i=1:1000
    for j=1;jMax
        if jMax+(i-1)*jMax<length(RLPhaseTM);
        RLPhaseTM1000(i)=sum(RLPhaseTM(j+(i-1)*jMax:jMax+(i-1)*jMax));
        end
    end
end

C=sum(CCresultSpikeAll);
CCresultSpikePro=CCresultSpikeAll/C;
RLPhaseTM1000Pro=RLPhaseTM1000/sum(RLPhaseTM1000);

% 平均化フィルター
% N=round(length(RLPhaseTM)/length(CCresultSpike));
N=20;
coeff = ones(1, N)/N;
delay=(length(coeff)-1)/2;
avgRLPhaseTM = filter(coeff, 1, RLPhaseTM1000Pro);
% plot(linspace(0,OneTurnTime98*2-delay,length(RLPhaseTM)),avgRLPhaseTM);
% 包絡線
x = hilbert(avgRLPhaseTM);
EnveRLPhaseTM=abs(x);



% 平均化フィルター
% N=round(length(RLPhaseTM)/length(CCresultSpike));
N=20;
coeff = ones(1, N)/N;
delay=(length(coeff)-1)/2;
avgCCresultSpikePro = filter(coeff, 1, CCresultSpikePro);
% plot(linspace(0,OneTurnTime98*2-delay,length(RLPhaseTM)),CCresultSpikePro);
% 包絡線
x = hilbert(avgCCresultSpikePro);
EnveCCresultSpikePro=abs(x);

if isnan(EnveRLPhaseTM)==0 & isnan(EnveCCresultSpikePro)==0;
dist=JSDiv(EnveRLPhaseTM,EnveCCresultSpikePro);
else
    dist=Inf;
end

fig2=figure;
plot(linspace(0,OneTurnTime98*2,length(EnveRLPhaseTM)),EnveRLPhaseTM); hold on
plot(linspace(1,OneTurnTime98*2,BIN),EnveCCresultSpikePro,'color','r');
tfiletrim=strtrim(tfile);
xlabel([tfiletrim,'dist=',num2str(dist),'Lt-Rt']);
axis([0 OneTurnTime98*2 0 max(max(EnveRLPhaseTM),max(EnveCCresultSpikePro))*1.1]);
cd(Old2);
OldC=cd;
cd(F);
tfiletrim=strtrim(tfile);
figname=[tfiletrim(1:end-2),'RLRtime','Lt-Rt','.bmp'];
saveas(fig2,figname);
cd(OldC);
close;

%%%%%%%%%%%%ほかの細胞との比較%%%%%%%%%%%%%%%%%

ALLCellKL20190618JS

cd(F);
dirName=['Lt-RtTime'];
mkdir(dirName);
Z=[F,'\Lt-RtTime'];
cd(Z);
filename=[tfiletrim(1:end-2),'Lt-Rt','KL'];
save(filename,'KldistSame','meanKldistDiff');
cd(OldC);
KLD5=KldistSame;


% [h,p] = kstest2(EnveRLPhaseTM,EnveCCresultSpikePro);
% h
% p
% 


