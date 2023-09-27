function ThreePhaseSpike320190516
%左足のタッチの間のどこで右タッチがあったか⇔左足のタッチ間でどこでスパイクがあったか
% global 

cd('C:\Users\C238\Desktop\CheetahWRLV20180729\119\2017-6-7_20-8-33 11901-51');
dpath=('C:\Users\C238\Desktop\CheetahWRLV20180729\119\2017-6-7_20-8-33 11901-51\');
dpath3=('C:\Users\C238\Desktop\CheetahWRLV20180729\119\2017-6-7_20-8-33 11901-51');
% data=load([dpath '15103_190313_98__'],'-ascii');
dpath3
load 11931_170607_98__\Bdata
SpikeArray=GetSpikeAll(dpath3,'Sc4_SS_03.t');
%WaterOnのときのみのRpegTouchall
    if ~isempty(RpegTouchall)
        RTWon=ones(1,length(RpegTouchall));
        for k=1:length(RpegTouchall)
            if OnWater(RpegTouchall(k))==0
                RTWon(k)=0;
            end
        end
        RpegTouchallWon=RpegTouchall.*RTWon;
        RpegTouchallWon(RpegTouchallWon==0)=[];
        RpegTouchallWoff=RpegTouchall.*not(RTWon);
        RpegTouchallWoff(RpegTouchallWoff==0)=[];
    else
        RpegTouchallWon=0;
        RpegTouchallWoff=0;
    end
%WaterOnのときのみのLpegTouchall
    if ~isempty(LpegTouchall)
        LTWon=ones(1,length(LpegTouchall));
        for k=1:length(LpegTouchall)
            if OnWater(LpegTouchall(k))==0
                LTWon(k)=0;
            end
        end
        LpegTouchallWon=LpegTouchall.*LTWon;
        LpegTouchallWon(LpegTouchallWon==0)=[];
        LpegTouchallWoff=LpegTouchall.*not(LTWon);
        LpegTouchallWoff(LpegTouchallWoff==0)=[];
    else
        LpegTouchallWon=0;
        LpegTouchallWoff=0;
    end
bin1=30;
phase=zeros(1,bin1);
SpikeX=[];
OneStepSpike=[];
B=zeros(1,bin1);
ALLStepArray=zeros(bin1,bin1);
for i=1:length(LpegTouchallWon)-3
    binarray1=linspace(LpegTouchallWon(i),LpegTouchallWon(i+1),bin1/3+1); 
    binarray2=linspace(LpegTouchallWon(i+1),LpegTouchallWon(i+2),bin1/3+1);
    binarray3=linspace(LpegTouchallWon(i+2),LpegTouchallWon(i+3),bin1/3+1);
    binarray=[binarray1(1:end-1) binarray2(1:end-1) binarray3(1:end)];
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
    ALLStepArray(x,:)=[ALLStepArray(x,:)+OneStepSpike];
    end
end
linL=linspace(0,1.5,bin1+1);
Nc = 40;                        % 作りたい色の数
A = colormap(colorcube(Nc));      % colorcubeを変えることで、色んな組み合わせの色が作れる。
	
figure
for t=1:bin1
    plot(linL(1:length(linL)-1),ALLStepArray(t,:),'Color',A(t,:),'LineWidth',2,'DisplayName',num2str(0.05*t));hold on 
%     plot([0.05*t 0.05*t],[0 max(ALLStepArray(t,:))],'color','b','LineWidth',1);
    legend([num2str(0.05*t)]);
%     xlabel(['RtbinNum=',num2str(t),'kaisuu=',num2str(B(t))]);
end
hold off
BS=sum(B);
BS


MaxArray=[];
for s=1:bin1
    Max1=mean(ALLStepArray(s,:));
    MaxArray=[MaxArray Max1];
end

MaxArray
Mean=mean(MaxArray);

IndexS=find(MaxArray<Mean);
% for i=1:length(IndexS)
%     ALLStepArray(IndexS(i),:)=zeros(1,bin1);
% end
% ALLStepArray

t=1;
% figure
for t=1:bin1
    figure
    plot(linL(1:length(linL)-1),ALLStepArray(t,:),'Color',A(t,:),'LineWidth',2,'DisplayName',num2str(0.05*t));hold on 
    plot([0.05*t 0.05*t],[0 max(ALLStepArray(t,:))],'color','b','LineWidth',1);
    legend([num2str(0.05*t)]);
    xlabel(['RtbinNum=',num2str(t),'kaisuu=',num2str(B(t))]);
end