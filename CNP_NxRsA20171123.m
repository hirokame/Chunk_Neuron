function CNP_NxRsA20171123%ConstantInput 
%Variable startに対応, Vs=0.02で-70mV から-50mVまで振れる。
close all;
clear all;

global nFile RefPeriod Vreset Vth dt num_Pilgrim tau_m tmax Delay Rm tau_m tau_Es tau_Is Vth Vreset Vstart

% cd C:\Users\B133\Documents\MATLAB\GroupCMX\GroupCnxMatrix1000M1
cd C:\Users\B133_2\Documents\MATLAB\GroupCMX\GroupCnxMatrix10000M1

iFile='_M4_N10000_G50_E5_R1_Match1000000'
iFile='_M3_N10000_G50_E5_R1_Match100000'
iFile='_M2_N10000_G50_E5_R1_Match10000'
iFile='_M1_N10000_G50_E5_R1_Match1000'
% iFile='_M0_N10000_G50_E5_R1_Match1000000'

Vs=0.02;
% Vs=0;

Nlist=[10];
Rlist=[6];
SaveName=['CVCORvs_',iFile(1,1:4)];%,Matrix,'R',int2str(RefPeriod*10),'D',int2str(Delay)];
if ~exist([SaveName,'.mat'])
    eval(['save ',SaveName,' Nlist Rlist']);
end

for n=5%
    if n==1;Neurons=100
    elseif n==2; Neurons=500
    elseif n==3; Neurons=1000
    elseif n==4; Neurons=5000
    elseif n==5; Neurons=10000
    end
    Vstart=rand(Neurons,1)*Vs;
    
    for RR=Rlist
        for NN=Nlist
            for nF=1:10
                Neurons
                nF
                if nF<10
                    nFile=['Group_CnxMatrix',int2str(nF),iFile];
                else
                    nFile=['Group_CnxMatrix',int2str(nF),iFile];
                end
                
                [OutMatrix]=CircularNetPilgrimNxRsA20160822(iFile,nFile,Neurons,RR,NN);

                [FR CV CORR]=CalcCVCorr(OutMatrix, Neurons);
                
                eval(['fr=''FR_N',int2str(Neurons),'N',int2str(NN),'R',int2str(RR),'''']);
                eval(['Cv=''CV_N',int2str(Neurons),'N',int2str(NN),'R',int2str(RR),'''']);
                eval(['cor=''CORR_N',int2str(Neurons),'N',int2str(NN),'R',int2str(RR),'''']);
                
                eval([fr,'(nF)','=FR;']);
                eval([Cv,'(nF)','=CV;']);
                eval([cor,'(nF)','=CORR;']);
                
%                 eval(['FR_N',int2str(Neurons),'N',int2str(NN),'R',int2str(RR),'(nF)','=FR;']);
%                 eval(['CV_N',int2str(Neurons),'N',int2str(NN),'R',int2str(RR),'(nF)','=CV;']);
%                 eval(['CORR_N',int2str(Neurons),'N',int2str(NN),'R',int2str(RR),'(nF)','=CORR;']);
            end
%             Neurons=100;NN=2;RR=3;
            eval(['MFR=''MeanFR_N',int2str(Neurons),'N',int2str(NN),'R',int2str(RR),'''']);
            eval(['MCV=''MeanCV_N',int2str(Neurons),'N',int2str(NN),'R',int2str(RR),'''']);
            eval(['MCORR=''MeanCORR_N',int2str(Neurons),'N',int2str(NN),'R',int2str(RR),'''']);
            
            eval(['SFR=''StdFR_N',int2str(Neurons),'N',int2str(NN),'R',int2str(RR),'''']);
            eval(['SCV=''StdCV_N',int2str(Neurons),'N',int2str(NN),'R',int2str(RR),'''']);
            eval(['SCORR=''StdCORR_N',int2str(Neurons),'N',int2str(NN),'R',int2str(RR),'''']);
            
            eval([MFR,'=mean(',fr,')']);
            eval([MCV,'=mean(',Cv,')']);
            eval([MCORR,'=mean(',cor,')']);
            
            eval([SFR,'=std(',fr,')']);
            eval([SCV,'=std(',Cv,')']);
            eval([SCORR,'=std(',cor,')']);
                
%             eval(['MeanFR_N',int2str(Neurons),'N',int2str(NN),'R',int2str(RR),'(nF)','=mean(FR_N',int2str(Neurons),'N',int2str(NN),'R',int2str(RR),')']);
%             eval(['MeanCV_N',int2str(Neurons),'N',int2str(NN),'R',int2str(RR),'(nF)','=mean(CV_N',int2str(Neurons),'N',int2str(NN),'R',int2str(RR),')']);
%             eval(['MeanCORR_N',int2str(Neurons),'N',int2str(NN),'R',int2str(RR),'(nF)','=mean(CORR_N',int2str(Neurons),'N',int2str(NN),'R',int2str(RR),')']);
            
%             eval(['StdFR_N',int2str(Neurons),'N',int2str(NN),'R',int2str(RR),'(nF)','=std(FR_N',int2str(Neurons),'N',int2str(NN),'R',int2str(RR),')']);
%             eval(['StdCV_N',int2str(Neurons),'N',int2str(NN),'R',int2str(RR),'(nF)','=std(CV_N',int2str(Neurons),'N',int2str(NN),'R',int2str(RR),')']);
%             eval(['StdCORR_N',int2str(Neurons),'N',int2str(NN),'R',int2str(RR),'(nF)','=std(CORR_N',int2str(Neurons),'N',int2str(NN),'R',int2str(RR),')']);
            
            eval(['save ',SaveName,' ',fr,' ',Cv,' ',cor,' ',MFR,' ',MCV,' ',MCORR,' ',SFR,' ',SCV,' ',SCORR,' -append']);
        end
    end
end
        
% eval(['save ',SaveName]);
            
% nFile='Group_CnxMatrix001_M4_N5000_G50_E5_R1_Match1000000'

% MM='M3';%cd
% Neurons

% SaveMaterials=['nFile RefPeriod Vreset Vth dt num_Pilgrim tau_m tmax Nlist Rlist Delay Rm tau_m tau_Es tau_Is Vth Vreset'];

%     if NoFile==1
% %         SaveName=['ACT5a2020_',iFile,Matrix,'R',int2str(RefPeriod*10),'D',int2str(Delay)];
%         eval(['save ',SaveName,' ',SaveMaterials,';']);
%         NoFile=0;
%     end
%     exist(SaveName)
%     exist('ACT5a2020_001_MCnxMatrix10000R20D1')
    
%     eval(['OutMatrixN',int2str(N),'R',int2str(R),'=OutMatrix;']);
%     eval(['SaveFile=[SaveFile ',''' OutMatrixN',int2str(N),'R',int2str(R),'''];']);
%     eval(['SaveFile=[''OutMatrixN',int2str(N),'R',int2str(R),'];']);
%     eval(['SaveFile=''OutMatrixN',int2str(N),'R',int2str(R),'''']);
    
% % % %     eval(['save ',SaveName,' ',SaveFile,' Nmatrix Rmatrix -append']);
%     eval(['clear ',SaveFile])
    SaveName



function [OutMatrix]=CircularNetPilgrimNxRsA20160822(iFile,nFile,Neurons,RR,NN)
%1200ニューロン、1000個はGroup~より、200個のInhは追加でランダム

%Srndを増加させてMIを解析, Snetは一定
%Neuron, RefPeriodSet, SFLを設定してcd、Net名を調整して実行

% MI=0;
% global Vreset  dt tau_m tmax Matrix
global Vreset Vth dt tau_m tmax Matrix nFile RefPeriod Vreset Vth dt num_Pilgrim tau_m tmax Delay Rm tau_m tau_Es tau_Is Vth Vreset
% Neurons=5000;
% SRND=0.1;
RefPeriod=2;%ms?
Delay=1;%ms
SFL=1;%SFL:1, CnxMatrix; 2, SflCnxMatrix; 3, SflPrCnxMatrix; 4, RndMatrix; 5, EvenMatrix; 6, IdealMatrix; 7, IdealSflMatrix; 8, IdealSflPrMatrix. 678はM3で行う。M4では不可%%%

% cd C:\Users\B133\Documents\MATLAB\GroupCMX\GroupCnxMatrix10000M3

% % iFile='M4_N10000_G50_E5_R1_Match1000000'
% iFile='M3_N10000_G50_E5_R1_Match100000'
% % iFile='M2_N10000_G50_E5_R1_Match10000'
% % iFile='M1_N10000_G50_E5_R1_Match1000'
% 
% nFile=['Group_CnxMatrix001_',iFile];
% % nFile='Group_CnxMatrix001_M4_N5000_G50_E5_R1_Match1000000'

Rm=10e6;
tau_m=20e-3;
tau_Es=4e-3;%シナプス電位時定数%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
tau_Is=8e-3;%シナプス電位時定数%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
Vth=-50e-3;
Vreset=-70e-3;%resting potential

% E=ones(NeuronsEI,1)*Vreset;%reversal potential of leak

num_Pilgrim = 10000;
% Nmatrix=zeros(30,40);
% Rmatrix=zeros(30,40);
% MImatrix=zeros(30,40);
% MIarrayAll=zeros(num_Pilgrim,30,40);
% OutMatrixAll=zeros(Neurons,num_Pilgrim,50,25);

ExtNeurons=1:Neurons;
InhNeurons=[];%いらない場合は[]
NeuronsEI=Neurons+length(InhNeurons);%ニューロン数合計

% Wie=0.00001;
% Wei=0.00001;
% Wii=0.00001;
% ConProbEE=0.05;
ConProbIE=0.05;
ConProbEI=0.05;
ConProbII=0.05;

CnxMatrixAll=zeros(Neurons+length(InhNeurons),Neurons+length(InhNeurons));

ItoI=rand(length(InhNeurons),length(InhNeurons));
ItoI(ItoI<ConProbII)=1;ItoI(ItoI<1)=0;
ItoI=ItoI-diag(diag(ItoI));
% ItoI=ItoI*5;
ItoI=ItoI*80;
% ItoI=ItoI*1/(Neurons*Neurons)*5;%CnxMatrix部分の値は全体で１．つまり1/(Neurons*Neurons)が平均値
CnxMatrixAll(InhNeurons,InhNeurons)=ItoI;%Wii;%from inh to inh

EtoI=rand(length(InhNeurons),length(ExtNeurons));
EtoI(EtoI<ConProbEI)=1;EtoI(EtoI<1)=0;
% EtoI=EtoI*1
EtoI=EtoI*5.5;
% EtoI=EtoI*1/(Neurons*Neurons)*50;%%%
CnxMatrixAll(InhNeurons,ExtNeurons)=EtoI;%from ext to inh

ItoE=rand(length(ExtNeurons),length(InhNeurons));
ItoE(ItoE<ConProbIE)=1;ItoE(ItoE<1)=0;
% ItoE=ItoE*1/(Neurons*Neurons)*0.9;
% CnxMatrixAll(ExtNeurons,InhNeurons)=ItoE;%from inh to ext

% SaveMaterials=['nFile Matrix RefPeriod Vreset Vth dt num_Pilgrim tau_m tmax Nmatrix Rmatrix Neurons Delay CnxMatrixAll ExtNeurons InhNeurons Rm tau_m tau_Es tau_Is Vth Vreset'];
% SaveName=['save ACTa3040_',nFile(1,16:20),Matrix,'R',int2str(RefPeriod*10),'D',int2str(Delay),' ',SaveFile];
% eval(SaveName);
% for N=[50 100 150 200]

% for P=80%[5 10 15 20 25 30 35 40 45 50]
% for N=1:30%0:10:5000%:5:50%:10
% for R=1:40%=3%2:100
% NoFile=1;
for N=NN%0:10:5000%:5:50%:10
for R=RR%=3%2:100
% N=10
% R=1
[N R]
% 通常のセット
% Snet=(N-1)*(Neurons*0.01)^2*(100/Neurons);%ACT1
Snet=2*(N-1)*(Neurons*0.01)^2*(100/Neurons);%5000,10000

% Srnd=0.0038+R*0.00004;%R=0の場合、最初はSrnd=0.005;%ACT1
Srnd=0.0038+R*0.00006;%R=0の場合、最初はSrnd=0.005;%5000,10000

ItoE1=ItoE*(1*80);

CnxMatrixAll(ExtNeurons,InhNeurons)=ItoE1;%from inh to ext

    Nmatrix(N,R)=Snet;
    Rmatrix(N,R)=Srnd;
%     [a b c]=LastZero(nFile,RefPeriod,Snet,Srnd,Neurons,num_Pilgrim,N,R,SFL,Delay);
%     [MIarrayAll(:,N) MImatrix(N) OutMatrixAll(:,:,N)]=LastZero(nFile,RefPeriod,Snet,Srnd,Neurons,num_Pilgrim,N,R,SFL,Delay);
%     [MIarrayAll(:,N,R) MImatrix(N,R) OutMatrixAll(:,:,N,R)]=LastZero(nFile,RefPeriod,Snet,Srnd,Neurons,num_Pilgrim,N,R,SFL,Delay);
    [OutMatrix CnxMatrixAll]=LastZero(nFile,RefPeriod,Snet,Srnd,Neurons,num_Pilgrim,N,R,SFL,Delay,CnxMatrixAll,...
        ExtNeurons,InhNeurons,NeuronsEI,Rm,tau_m,tau_Es,tau_Is,Vth,Vreset);
% % % % % %     SaveName=['ACT1a2020_',iFile(1,1:3),Matrix,'R',int2str(RefPeriod*10),'D',int2str(Delay)];
%     if exist([SaveName,'.mat'])~=2
%     if NoFile==1
% %         SaveName=['ACT5a2020_',iFile,Matrix,'R',int2str(RefPeriod*10),'D',int2str(Delay)];
%         eval(['save ',SaveName,' ',SaveMaterials,';']);
%         NoFile=0;
%     end
% %     exist(SaveName)
% %     exist('ACT5a2020_001_MCnxMatrix10000R20D1')
%     
%     eval(['OutMatrixN',int2str(N),'R',int2str(R),'=OutMatrix;']);
% %     eval(['SaveFile=[SaveFile ',''' OutMatrixN',int2str(N),'R',int2str(R),'''];']);
% %     eval(['SaveFile=[''OutMatrixN',int2str(N),'R',int2str(R),'];']);
%     eval(['SaveFile=''OutMatrixN',int2str(N),'R',int2str(R),'''']);
%     
%     eval(['save ',SaveName,' ',SaveFile,' Nmatrix Rmatrix -append']);
%     eval(['clear ',SaveFile])
%     SaveName
%     FileName=['ACTa3040_',nFile(1,16:20),Matrix,'R',int2str(RefPeriod*10),'D',int2str(Delay)]

%     A=OutMatrix;
%     figure
%     image(A*255);colormap gray;zoom xon
%     title(['N',int2str(N),'R',num2str(R),'  Snet=',num2str(Snet),'  Srnd=',num2str(Srnd)]);
%     
%     SumE=zeros(1,600);
%     SumI=zeros(1,600);
% 
%     for k=1:1000
%         SumE(k)=sum(sum(A(ExtNeurons,1+5*(k-1):5+5*(k-1))))/Neurons*1000;
%         SumI(k)=sum(sum(A(InhNeurons,1+5*(k-1):5+5*(k-1))))/length(InhNeurons)*1000;
%     end
%     figure
%     plot(SumE,'r');hold on
%     plot(SumI);
%     zoom yon

%     sum(A(1:1000,2001:2500),2)
% SumIni=sum(sum(A(ExtNeurons,1:1000),2))
% SumEnd=sum(sum(A(ExtNeurons,num_Pilgrim-1000:num_Pilgrim),2))
%     sum(sum(A(1001:1200,2001:2500),2))*5

end
end


% % % PlotOutMatrix20160810(FileName);


function [OutMatrix CnxMatrixAll]=LastZero(nFile,RefPeriodSet,Snet,SRND,Neurons,num_Pilgrim,N,R,sfl,Delay,CnxMatrixAll,...
    ExtNeurons,InhNeurons,NeuronsEI,Rm,tau_m,tau_Es,tau_Is,Vth,Vreset)
global dt Matrix Vstart

for Neuron=Neurons%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%     Snet=NetStrength*0.0001*(Neuron*0.01)^2;
    str=['load ',nFile,';'];
    eval(str);
    File=nFile;
    Neurons=Neuron;    
%     tmax=20;
for SFL=sfl% 6 7 8]%SFL:1, CnxMatrix; 2, SflCnxMatrix; 3, SflPrCnxMatrix; 4, RndMatrix; 5, EvenMatrix; 6, IdealMatrix; 7, IdealSflMatrix; 8, IdealSflPrMatrix. 678はM3で行う。M4では不可%%%%%%%%%%%%%%%%
    if SFL==1
        Matrix=['CnxMatrix',int2str(Neurons)];
%         Matrix=[M1,'_',int2str(Fnum)];
        CM=['CnxMatrix=',Matrix,';'];%tmax=100%+Neurons/25;%Shuffle=0;ShufflePair=0;Random=0;Even=0; 
    elseif SFL==2
        Matrix=['SflCnxMatrix',int2str(Neurons)];
%         Matrix=[M1,'_',int2str(Fnum)];
        CM=['CnxMatrix=',Matrix,';'];%tmax=100%+Neurons/25;%Shuffle=1;ShufflePair=0;Random=0;Even=0; 
    elseif SFL==3
        Matrix=['SflPrCnxMatrix',int2str(Neurons)];
%         Matrix=[M1,'_',int2str(Fnum)];
        CM=['CnxMatrix=',Matrix,';'];%tmax=100%+Neurons/25;%Shuffle=0;ShufflePair=1;Random=0;Even=0; 
    elseif SFL==4
        Matrix=['RndMatrix',int2str(Neurons)];
%         Matrix=[M1,'_',int2str(Fnum)];
        CM=['CnxMatrix=',Matrix,';'];%tmax=8;%Shuffle=0;ShufflePair=0;Random=1;Even=0;
    elseif SFL==5
        Matrix=['EvenMatrix',int2str(Neurons)];
%         Matrix=[M1,'_',int2str(Fnum)];
        CM=['CnxMatrix=',Matrix,';'];%tmax=100%;%Shuffle=0;ShufflePair=0;Random=0;Even=1;
    elseif SFL==6
        Matrix=['IdealMatrix',int2str(Neurons)];
        CM=['CnxMatrix=',Matrix,';'];%tmax=100
    elseif SFL==7
        Matrix=['IdealSflMatrix',int2str(Neurons)];
        CM=['CnxMatrix=',Matrix,';'];%tmax=100
    elseif SFL==8
        Matrix=['IdealSflPrMatrix',int2str(Neurons)];
        CM=['CnxMatrix=',Matrix,';'];%tmax=100        
    end
%     Matrix='CnxMatrix';
CnxMatrix=CnxMatrix(1:Neurons,1:Neurons);
%     eval(CM);

CnxMatrix=CnxMatrix/sum(sum(CnxMatrix));%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
ratio=1;%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

% ratio=1/MeanCM*5.5/10;%0.0076
CnxMatrixAll(ExtNeurons,ExtNeurons)=CnxMatrix*ratio;
 
InSize=0.000001*500000000;
% Snet
% SRND
% tmax=5;%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

% E=ones(NeuronsEI,1)*-70e-3;%reversal potential of leak
E=ones(NeuronsEI,1)*Vreset;%reversal potential of leak
V_E=zeros(NeuronsEI,1);%reversal potential of excitatory
V_I=ones(NeuronsEI,1)*-80e-3;%reversal potential of inhibitory

% Vspike = 20e-3;      

dt=0.0002;%sec
% tpulse=0.1;
% lengthpulse=0.5;

% num_Pilgrim = tmax/dt;

for RP=1:length(RefPeriodSet)
%     RefPeriod=RefPeriodSet(RP);

% for N=1:10
    File
    Matrix
    RefPeriod=RefPeriodSet(RP)
%     N

    I=zeros(NeuronsEI,num_Pilgrim);
    V=zeros(NeuronsEI,num_Pilgrim);
    V1=zeros(NeuronsEI,num_Pilgrim);
    
%     RndIn=rand(NeuronsEI,num_Pilgrim);RndIn(InhNeurons,:)=0;%抑制性ニューロンにはRndInを入れない
%     M0=mean(mean(RndIn))
    
%     RndIn=0.5+0.1*randn(NeuronsEI,num_Pilgrim);
RndIn=0.5*ones(NeuronsEI,num_Pilgrim);
    
    RndIn(InhNeurons,:)=0;%GaussianNoise
%     M1=mean(mean(RndIn))
    
%     RndIn=0.5+0.1*randn(NeuronsEI,num_Pilgrim);RndIn(InhNeurons,:)=0;%GaussianNoise
    
    ExtIn=zeros(NeuronsEI,1);
    InhIn=zeros(NeuronsEI,1);

    V(:,1)=E+Vstart;                 % begin simulation with membrane potential at leak level
    InMatrix=zeros(NeuronsEI,num_Pilgrim);
    OutMatrix=zeros(NeuronsEI,num_Pilgrim);
%     NewIn=zeros(NeuronsEI,1);
    RefPerArray=zeros(NeuronsEI,1);
    
%     OutMs=zeros(100,num_Pilgrim);
%     NotOutMs=zeros(100,num_Pilgrim);


%     MIarray=zeros(1,num_Pilgrim);
%     Len=100;

    for n = 2:num_Pilgrim
%         n
%         Srnd=n*Increment;%0.0026;%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%         RandomIn=RndIn(:,n)./sum(RndIn(:,n));%正規化
    if SRND==0
        if n>1000
             Srnd=0;       
%              Srnd=SRND;
        else
            Srnd=0.005;%0.05*0.13;
%             Srnd=0.0025;%0.02*0.13;  
        end
    else
        Srnd=SRND;
    end
%         Srnd=0.0025;%0.02*0.13;
        NewIn=InMatrix(:,n-1);

%         if sum(NewIn)~=0
%             NewIn=NewIn/sum(NewIn);%正規化
%         end

        Rin=RndIn(:,n);
%         Rin=RndIn(:,n)/sum(RndIn(:,n));%Rinのほうはネット合計を１に。
    %     In=(Prnd*RandomIn+(1-Prnd)*NewIn)/sum(Prnd*RandomIn+(1-Prnd)*NewIn);
%         L=InSize*(Srnd*RndIn(:,n)+Snet*NewIn);
%         I(:,n)=InSize*(Srnd*RndIn(:,n)+Snet*NewIn);
        I(:,n)=InSize*(Srnd*Rin+Snet*NewIn);
%         a=InSize*(Srnd*Rin+Snet*NewIn);
%         W=dt/tau_m*(E - V(:,n-1) + Rm * I(:,n));
%         V(:,n) = V(:,n-1) + dt/tau_m*(E - V(:,n-1) + Rm * I(:,n));


% S1=sum(dt/tau_m*(E - V(:,n-1)))
% S=sum(dt*I(:,n))
% S2=sum(dt/tau_m*(Rm * I(:,n)))

        V(:,n) = V(:,n-1) + dt/tau_m*(E - V(:,n-1))+ dt*I(:,n);
%         v=V(:,n-1) + dt/tau_m*(E - V(:,n-1))+ dt*I(:,n);
        
        
V1(:,n)=V(:,n);

        V(OutMatrix(:,n-1)==1,n)=Vreset;%1つ前のnで発火したものはreset電位に。
        
V1(OutMatrix(:,n-1)==1,n)=0;
        
        RefPerArray=RefPerArray-0.2;%nごとに0.2ms　refractory periodを消化
        V(RefPerArray>= -0.1,n)=Vreset;%1つ前のnで発火したものはreset電位に。
%         K=V(:,n);
        RefPerArray(RefPerArray<0)=0;

        
%         if n>5000
%             n
%             
%         end
        
        Out=V(:,n);
        Out(Out>=Vth)=1;
        Out(Out<Vth)=0;
        
%         S(n)=sum(Out);
%         if S(n)>50
%             S(n)
%         end
        
        RefPerArray(Out==1)=RefPeriod;%発火したNeuronのrefractory periodをRefPeriodに。  

        OutMatrix(:,n)=Out;
        if n<11;Dly=0;else Dly=Delay*5;end
%         if n>10;Delay=10;else Delay=0;end%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
        DelayedOut=OutMatrix(:,n-Dly);
        
        %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
       
        
        InhOut=zeros(size(DelayedOut));
        ExtOut=zeros(size(DelayedOut));
        
        InhOut(InhNeurons)=DelayedOut(InhNeurons);
        SI=sum(InhOut);
        ExtOut(ExtNeurons)=DelayedOut(ExtNeurons);
        SE=sum(ExtOut);
        InhInAdd=CnxMatrixAll*InhOut;
        
        InhIn=InhInAdd+(InhIn-dt/tau_Is*InhIn);
        
        ExtInAdd=CnxMatrixAll*ExtOut;
        ExtIn=ExtInAdd+(ExtIn-dt/tau_Es*ExtIn);%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%         A=(V_E - V(:,n-1)).*ExtIn+(V_I - V(:,n-1)).*InhIn;
%         B=ExtIn-InhIn;
%         B=sum(A);
        InMatrix(:,n)=(V_E - V(:,n-1)).*ExtIn+(V_I - V(:,n-1)).*InhIn;%%%%%
%         InMatrix(:,n)=CnxMatrix*(ExtIn-InhIn);  

%         InMatrix(:,n)=CnxMatrix*DelayedOut;           
%         InMatrix(:,n)=InMatrix(:,n)+(InMatrix(:,n-1)-dt/tau_s*InMatrix(:,n-1));

% figure
% plot(InMatrix(55,:));

        %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%     if MI==1
%         OMs=OutMatrix(1:100,n);
%         %     OMs=sum(OMs,2);
%         %     OMs(OMs>1)=1;
%         NotOMs=OMs;
%         NotOMs(NotOMs==0)=-1;
%         NotOMs(NotOMs==1)=0;
%         NotOMs=NotOMs*(-1);
% 
%         OutMs(:,n)=OMs;
%         NotOutMs(:,n)=NotOMs;
%         if n>100
%             
%             Ent=zeros(1,100);
%             for p=1:100
%                 A=OutMs(p,n-100:n-100+Len-1);
%                 if sum(A)==0
%                     A1=0;
%                     A0=1;
%                     L2A1=0;L2A0=0;
%                 elseif sum(A)==Len
%                     A1=1;
%                     A0=0;
%                     L2A1=0;L2A0=0;
%                 else
%                     A1=sum(A)/Len;
%                     A0=1-A1;
%                     L2A1=log2(A1);L2A0=log2(A0);
%                 end
% 
%                 Ent(p)=-1*A1*L2A1+(-1)*A0*L2A0;
%             end

%             mi=1;
%             for p=1:100-1
%                 A=OutMs(p,n-100:n-100+Len-1);
% 
%                 NotA=NotOutMs(p,n-100:n-100+Len-1);
%                 for m=p+1:100
% 
%                     B=OutMs(m,n-100:n-100+Len-1);
% 
%                     NotB=NotOutMs(m,n-100:n-100+Len-1);
% 
%                     if sum(A.*B)==0
%                         A1andB1=0;
%                         L2A1andB1=0;
%                     else
%                         A1andB1=sum(A.*B)/Len;
%                         L2A1andB1=log2(sum(A.*B)/Len);
%                     end
%                     if sum(A.*NotB)==0
%                         A1andB0=0;
%                         L2A1andB0=0;
%                     else
%                         A1andB0=sum(A.*NotB)/Len;
%                         L2A1andB0=log2(sum(A.*NotB)/Len);
%                     end
%                     if sum(NotA.*B)==0
%                         A0andB1=0;
%                         L2A0andB1=0;
%                     else
%                         A0andB1=sum(NotA.*B)/Len;
%                         L2A0andB1=log2(sum(NotA.*B)/Len);
%                     end
%                     if sum(NotA.*NotB)==0
%                         A0andB0=0;
%                         L2A0andB0=0;
%                     else
%                         A0andB0=sum(NotA.*NotB)/Len;
%                         L2A0andB0=log2(sum(NotA.*NotB)/Len);
%                     end
%                     
%                     MI(mi)=Ent(p)+Ent(m)+A1andB1*L2A1andB1+A1andB0*L2A1andB0+A0andB1*L2A0andB1+A0andB0*L2A0andB0;
% 
%                     mi=mi+1;
%                 end
% %             end
% 
%             MIarray(n-100)=mean(MI);
% 
%         end
%     end
    end
    
    
%     MeanMI=mean(MIarray(1:end-100));
    
end%Refractory periods

end%SFL

end%Neuron size

