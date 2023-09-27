function WeightPreferAttach20171116
% WeightPreferAttach20151231
global Neurons Add
%結合の多い相手とさらに結合を作りやすいネットワーク
%結合強度による優先的結合モデル
%結合の作りやすさ、最初は一様分布、結合ができるとAddにより作りやすさが増加

clear all;
close all;

% Reciprocal=0.2;%0以外のときには、同時に反対向きの結合も作成。(a,b)に加わったとき(b,a)にもAdd*Reciprocalを加える。

Neurons=100;
Add=0.001;%10/Neurons;
% RndSelect=0;
Reciprocal=0;%0:片方向、1: 両方向、2: triangle一方通行、3: triangleの一方通行が強いものへ逆向きを(reciprocal)を強化
% effect=1;%%1:片方向、3；triangle

SaveName=['WeightPreferN',int2str(Neurons),'Add',int2str(Add*10000),'Rcp',int2str(Reciprocal)];%, 'RS',int2str(RndSelect*10)];
eval(['save ',SaveName]);%,' Neurons']);%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% eval(['load ',SaveName]);%,' Neurons']);%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Net='Rand';%random networkからスタート
% Net='OnesAll';%すべて１
Net='Ones40';%40%結合

% SaveT=[1 5000 10000 15000 20000 25000 30000 35000 40000 45000 50000 55000 60000 65000 70000 75000 80000 85000 90000 95000 100000];% 110000 120000 130000 140000 150000 160000 170000 180000 190000 200000];
% SaveT=[1 100 200 300 400 500 600 700 800 900 1000 1500 2000 2500 3000 4000 5000 6000 7000 8000 9000 10000 12000 14000 15000 16000 18000 20000 25000 30000 40000 50000 60000 70000 80000 90000 100000 110000 120000 130000 140000 150000 160000 170000 180000 190000 200000];
SaveT1=[10000 20000 30000 40000 50000 60000 70000 80000 90000 100000 110000 120000 130000 140000 150000 160000 170000 180000 190000 200000 210000 220000 230000 240000 250000 260000 270000 280000 290000 300000 310000 320000 330000 340000 350000 360000 370000 380000 390000 400000 410000 420000 430000 440000 450000 460000 470000 480000 490000 500000];

SaveT2=SaveT1+500000;
SaveT=[SaveT1 SaveT2];

for n=1:10
    
    if strcmp(Net,'Rand')
        Matrix=rand(Neurons,Neurons);%
        Diag=diag(Matrix);
        Matrix=Matrix-diag(Diag);
    elseif strcmp(Net,'Ones')
        Matrix=ones(Neurons,Neurons)-eye(Neurons,Neurons);
    elseif strcmp(Net,'Ones40')
        Matrix=zeros(Neurons,Neurons);%
        while sum(sum(Matrix))<(Neurons*Neurons-Neurons)*0.4
            X=ceil(rand*Neurons);
            Y=ceil(rand*Neurons);
            if X~=Y && Matrix(X,Y)==0
                Matrix(X,Y)=1;
            end
        end        
    end
    CnxMatrix=Matrix/sum(sum(Matrix));%(Matrix-min(min(Matrix)))/(max(max(Matrix))-min(min(Matrix)));
    SaveFile=['WPA_',Net,'T',num2str(0),'_',int2str(n)];%,'Add00',int2str(Add*100),'Rec',int2str(Reciprocal*10)];
    eval([SaveFile,'=CnxMatrix;']);
    eval(['save ',SaveName,' ',SaveFile,' -append;']);

% eval(['CnxMatrix=WPA_RandT10000_',int2str(n),';']);

    for T=1:1000000
        if rem(T,1000)==0;disp([n T]);end
        CnxMatrix=PreferedAttach(CnxMatrix,Neurons,Add,Reciprocal);%,RndSelect);

        if ismember(T,SaveT)
            SaveFile=['WPA_',Net,'T',int2str(T),'_',int2str(n)];%,'Add00',int2str(Add*100),'Rec',int2str(Reciprocal*10)];
            eval([SaveFile,'=CnxMatrix;']);
            eval(['save ',SaveName,' ',SaveFile,' -append;']);

        end        
%         if T==100000 || T==200000 ||T==300000 || T==400000 ||T==500000
%             CnxMatrix
%             a=CnxMatrix(:);
%             b=sort(a,'descend');
%             b=b/sum(b);
% %             figure
% %             plot(b);
%             figure
%             loglog(b);
%         end
    end
end

function PLOT(CnxMatrixRec00,CnxMatrixRec02,CnxMatrixRec04,CnxMatrixRec06,CnxMatrixRec08,CnxMatrixRec10)
figure
subplot(3,2,1)
plot(hist(CnxMatrixRec00(:),100));
subplot(3,2,2)
plot(hist(CnxMatrixRec02(:),100));
subplot(3,2,3)
plot(hist(CnxMatrixRec04(:),100));
subplot(3,2,4)
plot(hist(CnxMatrixRec06(:),100));
subplot(3,2,5)
plot(hist(CnxMatrixRec08(:),100));
subplot(3,2,6)
plot(hist(CnxMatrixRec10(:),100));

figure
subplot(3,2,1)
loglog(hist(CnxMatrixRec00(:),100));
subplot(3,2,2)
loglog(hist(CnxMatrixRec02(:),100));
subplot(3,2,3)
loglog(hist(CnxMatrixRec04(:),100));
subplot(3,2,4)
loglog(hist(CnxMatrixRec06(:),100));
subplot(3,2,5)
loglog(hist(CnxMatrixRec08(:),100));
subplot(3,2,6)
loglog(hist(CnxMatrixRec10(:),100));

function Matrix=PreferedAttach(Matrix,Neurons,Add,Reciprocal)%,RndSelect)

if Reciprocal==0

%     Rnd=rand(Neurons,Neurons);
%     Bigger=Matrix-Rnd;
%     Bigger(Bigger>0)=1;Bigger(Bigger<=0)=0;
% 
%     Rnd2=rand(Neurons,Neurons);
% 
%     Rnd2(Rnd2>0.9)=1;Rnd2(Rnd2<=RndSelect)=0;
%     Bigger=Bigger.*Rnd2;
%     Sum=sum(sum(Bigger));
%     Bigger=Bigger*Add;
%     Matrix=Matrix+Bigger;
% 
%     Matrix=(Matrix-min(min(Matrix)))/(max(max(Matrix))-min(min(Matrix)));      
    for n=1:Neurons
        Cum=cumsum(Matrix(n,:));
        [Big idx]=find(Cum>rand);
        if Matrix(n,min(idx))~=0
            Matrix(n,min(idx))=Matrix(n,min(idx))+Add;            
        else
            Matrix(n,min(idx)+1)=Matrix(n,min(idx)+1)+Add;
        end
        Matrix(n,:)=Matrix(n,:)/sum(Matrix(n,:));
    end
        
elseif Reciprocal==1
    SecondMatrix=zeros(Neurons,Neurons);
    for p=1:Neurons
        Array=zeros(Neurons,1);
        Array(p)=1;
        P1=Matrix*Array;%
%         P=Matrix(:,p);
        P_1=Matrix(p,:);
%         P3=Matrix(p,:).*P2';
%         K=P1.*P_1';
        SecondMatrix(p,:)=P1.*P_1';
        SecondMatrix(p,:)=SecondMatrix(p,:)/sum(SecondMatrix(p,:));
    end
%     SecondMatrix=SecondMatrix/sum(sum(SecondMatrix));
    for n=1:Neurons
        CumS=cumsum(SecondMatrix(n,:));
        MaxN=max(CumS);
        [Big idx]=find(CumS>rand*MaxN);
        if Matrix(n,min(idx))~=0
            Matrix(n,min(idx))=Matrix(n,min(idx))+Add;         
        else
            Matrix(n,min(idx)+1)=Matrix(n,min(idx)+1)+Add;
        end
        Matrix(n,:)=Matrix(n,:)/sum(Matrix(n,:));
    end
    
elseif Reciprocal==2
    ThirdMatrix=zeros(Neurons,Neurons);
    for p=1:Neurons
        Array=zeros(Neurons,1);
        Array(p)=1;
        P1=Matrix*Array;
        P2=Matrix*P1;
        P_1=Matrix(p,:);
%         P3=P_1.*P2';
        ThirdMatrix(p,:)=P2.*P_1';
        ThirdMatrix(p,:)=ThirdMatrix(p,:)/sum(ThirdMatrix(p,:));
    end
%     ThirdMatrix=ThirdMatrix/sum(sum(ThirdMatrix));
    for n=1:Neurons
        CumS=cumsum(ThirdMatrix(n,:));
        MaxN=max(CumS);
        [Big idx]=find(CumS>rand*MaxN);
        if Matrix(n,min(idx))~=0
            Matrix(n,min(idx))=Matrix(n,min(idx))+Add;            
        else
            Matrix(n,min(idx)+1)=Matrix(n,min(idx)+1)+Add;
        end
        Matrix(n,:)=Matrix(n,:)/sum(Matrix(n,:));
    end
elseif Reciprocal==3
    ThirdMatrix=zeros(Neurons,Neurons);
    for p=1:Neurons
        Array=zeros(Neurons,1);
        Array(p)=1;
        P1=Matrix*Array;
        P2=Matrix*P1;
        P_1=Matrix(p,:);
%         P3=P_1.*P2';
        ThirdMatrix(p,:)=P2.*P_1';
        ThirdMatrix(p,:)=ThirdMatrix(p,:)/sum(ThirdMatrix(p,:));
    end
%     ThirdMatrix=ThirdMatrix/sum(sum(ThirdMatrix));
    for n=1:Neurons
        CumS=cumsum(ThirdMatrix(n,:));
        MaxN=max(CumS);
        R=rand;
        [Big idx]=find(CumS>R*MaxN);
        if Matrix(min(idx),n)~=0
            Matrix(min(idx),n)=Matrix(min(idx),n)+Add;            
        else
            Matrix(min(idx)+1,n)=Matrix(min(idx)+1,n)+Add;
        end
        Matrix(n,:)=Matrix(n,:)/sum(Matrix(n,:));
    end
end
    
% if Reciprocal==0
%     for n=1:Neurons
%         CumS=cumsum(Matrix(n,:));
%         [Big idx]=find(CumS>rand);
%         if Matrix(n,min(idx))~=0
%             Matrix(n,min(idx))=Matrix(n,min(idx))+Add;            
%         else
%             Matrix(n,min(idx)+1)=Matrix(n,min(idx))+Add;
%         end
%         Matrix(n,:)=Matrix(n,:)/sum(Matrix(n,:));
%     end
% else
%     for n=1:Neurons
%         CumS=cumsum(Matrix(n,:));
%         [Big idx]=find(CumS>rand);
%         if Matrix(n,min(idx))~=0 
%             Matrix(n,min(idx))=Matrix(n,min(idx))+Add;
%             Matrix(min(idx),n)=Matrix(min(idx),n)+Add*Reciprocal;
%             Matrix(n,:)=Matrix(n,:)/sum(Matrix(n,:));
%             Matrix(min(idx),:)=Matrix(min(idx),:)/sum(Matrix(min(idx),:));
%         else
%             Matrix(n,min(idx)+1)=Matrix(n,min(idx))+Add;
%             Matrix(min(idx)+1,n)=Matrix(min(idx)+1,n)+Add*Reciprocal;
%             Matrix(n,:)=Matrix(n,:)/sum(Matrix(n,:));
%             Matrix(min(idx)+1,:)=Matrix(min(idx)+1,:)/sum(Matrix(min(idx)+1,:));
%         end
%     end
% end


