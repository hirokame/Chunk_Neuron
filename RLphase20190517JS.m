function RLphase20190517JS

global ...
      ACresult ACresultW CCresultDrinkOn SpikeArray TurnMarkerTime RpegTouchallWon LpegTouchallWon...
    RpNum LpNum   CCresultSpike locsP1time locsP2time locsP1time2 locsP2time2 pksA1 pksA2 CCresultRtouchWon CCresultLtouchWon dpath3...
    StartTime FinishTime DiffMaxMinR DiffMaxMinL fname SpikeArrayWon tfile OneTurnTime OnestepHist1msR OnestepHist1msL OnestepSpikeHistogramR OnestepSpikeHistogramL...
    fig FLName EnveRLPhaseTM EnveCCresultSpikePro meanKldistDiff KldistSame  dpath  KLD6 


% cd('C:\Users\C238\Desktop\CheetahWRLV20180729\77\2016-12-10_16-14-9 7701-7771o');
% dpath=('C:\Users\C238\Desktop\CheetahWRLV20180729\77\2016-12-10_16-14-9 7701-7771o\');
% dpath3=('C:\Users\C238\Desktop\CheetahWRLV20180729\77\2016-12-10_16-14-9 7701-7771o');
% % data=load([dpath '15103_190313_98__'],'-ascii');
% dpath3
% 
MD=['RLphase20190517_C7']
mkdir(MD);
% LS=ls;
% for i=1:length(LS(:,1))
%     FL=strtrim(LS(i,:));
%     if length(FL)>2 && strcmp(FL(end-1:end),'.t');
%         tfile=FL;
%     

% tfile=('Sc8_SS_07.t');
% SpikeArray=GetSpikeAll(dpath3,tfile);
% load 7771_161210_C7__\Bdata
% SpikeArray(SpikeArray<StartTime | SpikeArray>FinishTime)=[];
% %WaterOnのときのみのRpegTouchall
%     if ~isempty(RpegTouchall)
%         RTWon=ones(1,length(RpegTouchall));
%         for k=1:length(RpegTouchall)
%             if OnWater(RpegTouchall(k))==0
%                 RTWon(k)=0;
%             end
%         end
%         RpegTouchallWon=RpegTouchall.*RTWon;
%         RpegTouchallWon(RpegTouchallWon==0)=[];
%         RpegTouchallWoff=RpegTouchall.*not(RTWon);
%         RpegTouchallWoff(RpegTouchallWoff==0)=[];
%     else
%         RpegTouchallWon=0;
%         RpegTouchallWoff=0;
%     end
% %WaterOnのときのみのLpegTouchall
%     if ~isempty(LpegTouchall)
%         LTWon=ones(1,length(LpegTouchall));
%         for k=1:length(LpegTouchall)
%             if OnWater(LpegTouchall(k))==0
%                 LTWon(k)=0;
%             end
%         end
%         LpegTouchallWon=LpegTouchall.*LTWon;
%         LpegTouchallWon(LpegTouchallWon==0)=[];
%         LpegTouchallWoff=LpegTouchall.*not(LTWon);
%         LpegTouchallWoff(LpegTouchallWoff==0)=[];
%     else
%         LpegTouchallWon=0;
%         LpegTouchallWoff=0;
%     end
%     
bin1=10;
phase=zeros(1,bin1);
SpikeX=[];
OneStepSpike=[];
B=zeros(1,bin1);
ALLStepArray=zeros(bin1,bin1);
for i=1:length(LpegTouchallWon)-1
    binarray=linspace(LpegTouchallWon(i),LpegTouchallWon(i+1),bin1+1); 
    for x=1:length(binarray)-1;
    OneStepSpike=zeros(1,bin1);
    N=RpegTouchallWon(binarray(x)<RpegTouchallWon & RpegTouchallWon<binarray(x+1));
    if isempty(N)==0;
        B(x)=B(x)+1;
    for j=1:length(binarray)-1
        for k=1:length(SpikeArray)
            if binarray(j)<SpikeArray(k) && SpikeArray(k)<binarray(j+1);
               OneStepSpike(j)=OneStepSpike(j)+1;
            end
        end
    end
    end
    ALLStepArray(x,:)=[ALLStepArray(x,:)+OneStepSpike];                          %%%M行M列の行列　LタッチをMビンに分割　それぞれのビンにおける発火のヒストグラム
    end
end

for t=1:bin1
    ALLStepArray(t,:)=ALLStepArray(t,:)/B(t);
end	
% for t=1:bin1
%     Sum=sum(ALLStepArray(t,:));
%     ALLStepArray(t,:)=ALLStepArray(t,:)/Sum;
% end
Index=find(B==0);

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% bin1=20;
% phaseL=zeros(1,bin1);
% for i=1:length(LpegTouchallWon)-1
%     for j=1:length(SpikeArray)-1
%         if LpegTouchallWon(i)<SpikeArray(j)&&SpikeArray(j)<LpegTouchallWon(i+1);   %%タッチ間でスパイクがあったか
%            binarrayL=linspace(LpegTouchallWon(i),LpegTouchallWon(i+1),bin1+1);   %%タッチ間をbin1の数に分割
%            for k=1:length(phaseL)-1
%                if binarrayL(k)<SpikeArray(j)&&SpikeArray(j)<binarrayL(k+1);  %%どのビンでスパイクがあったか
%                    phaseL(k)=phaseL(k)+1;
%                end
%            end
%         end
%     end
% end
% %タッチの位相のピーク
% linL=linspace(0,1,bin1+1);
% PhaseLCell=[phaseL;linL(1:length(phaseL))];
% [MPL locsMPL]=max(phaseL);
% OnePhaseLindex=PhaseLCell(2,locsMPL);
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

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

% load 7721_161210_98__\Bdata
% SpikeArray=GetSpikeAll(dpath3,tfile);
% SpikeArray(SpikeArray<StartTime | SpikeArray>FinishTime)=[];
% 
% %WaterOnのときのみのRpegTouchall
%     if ~isempty(RpegTouchall)
%         RTWon=ones(1,length(RpegTouchall));
%         for k=1:length(RpegTouchall)
%             if OnWater(RpegTouchall(k))==0
%                 RTWon(k)=0;
%             end
%         end
%         RpegTouchallWon=RpegTouchall.*RTWon;
%         RpegTouchallWon(RpegTouchallWon==0)=[];
%         RpegTouchallWoff=RpegTouchall.*not(RTWon);
%         RpegTouchallWoff(RpegTouchallWoff==0)=[];
%     else
%         RpegTouchallWon=0;
%         RpegTouchallWoff=0;
%     end
% %WaterOnのときのみのLpegTouchall
%     if ~isempty(LpegTouchall)
%         LTWon=ones(1,length(LpegTouchall));
%         for k=1:length(LpegTouchall)
%             if OnWater(LpegTouchall(k))==0
%                 LTWon(k)=0;
%             end
%         end
%         LpegTouchallWon=LpegTouchall.*LTWon;
%         LpegTouchallWon(LpegTouchallWon==0)=[];
%         LpegTouchallWoff=LpegTouchall.*not(LTWon);
%         LpegTouchallWoff(LpegTouchallWoff==0)=[];
%     else
%         LpegTouchallWon=0;
%         LpegTouchallWoff=0;
%     end
% 


%新しいSpikeArraNを作る
%     SpikeArrayN=[];
OneStepSpike=[];
AllSessionSpike=[];
binarray=zeros(1,bin1);
for i=1:length(LpegTouchallWon98)-1
    intervalL=LpegTouchallWon98(i+1)-LpegTouchallWon98(i);
    binarray=linspace(LpegTouchallWon98(i),LpegTouchallWon98(i+1),bin1+1); 
    if length(RpegTouchallWon98(LpegTouchallWon98(i)<RpegTouchallWon98 & RpegTouchallWon98<LpegTouchallWon98(i+1))) < 2
    for x=1:length(binarray)-1;
        for j=1:length(RpegTouchallWon98)
            if RpegTouchallWon98(j)>binarray(x) && RpegTouchallWon98(j)<binarray(x+1)
                 bin2=LpegTouchallWon98(i+1)-LpegTouchallWon98(i);
                 OneStepSpike=zeros(1,bin2);
                B=ceil(bin2/length(ALLStepArray(x,:)));
                for t=1:length(ALLStepArray(x,:))
                    for y=1:B
                        if (y+B*(t-1))<bin2;
                            OneStepSpike(y+B*(t-1))=ALLStepArray(x,t);
                        end
                    end
                end
%                 break;
            else
               bin2=LpegTouchallWon98(i+1)-LpegTouchallWon98(i);
               OneStepSpike=zeros(1,bin2); 
            end
        end
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
[CrossCoSpike98]=CrossCorr(SpikeArray98',TurnMarkerTime98,OneTurnTime98*2,0,TurnMarkerTime98);
CCresultSpike98=hist(CrossCoSpike98,BIN)/length(TurnMarkerTime98);
CCresultSpike98=MovWindow(CCresultSpike98,5);% figure
% plot(linspace(1,OneTurnTime*2,BIN),CCresultSpikeAll,'color','k');hold on

%ビン数→1000
jMax=round(length(RLPhaseTM)/1000);
for i=1:1000
    for j=1;jMax
        if jMax+(i-1)*jMax<length(RLPhaseTM);
        RLPhaseTM1000(i)=sum(RLPhaseTM(j+(i-1)*jMax:jMax+(i-1)*jMax));
        end
    end
end

C=sum(CCresultSpike98);
CCresultSpikePro=CCresultSpike98/C;
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

x=figure;
plot(linspace(0,OneTurnTime98*2,length(EnveRLPhaseTM)),EnveRLPhaseTM,'color','b');hold on 
plot(linspace(0,OneTurnTime98*2,length(EnveCCresultSpikePro)),EnveCCresultSpikePro,'color','r');
xlabel([tfile,'dist=',num2str(dist)]);
axis([0 OneTurnTime98*2 0 max(max(EnveRLPhaseTM),max(EnveCCresultSpikePro))*1.1]);
OldC=cd;
MD1=[FLName,'\',MD];
cd(MD1);
figname=[tfile(1:end-2),'RL','.bmp'];
saveas(x,figname);

close;

ALLCellKL20190618JS
cd(MD1);
dirName=['RinLphaseKL'];
mkdir(dirName);
Z=[MD1,'\RinLphaseKL'];
cd(Z);
tfiletrim=strtrim(tfile);
filename=[tfiletrim(1:end-2),'RinLphase','KL'];
save(filename,'KldistSame','meanKldistDiff');
cd(Old2);
KLD6=KldistSame;
%     end
% end
