function ObliqueModel20151013
%Oblique model
%タンパク質、1万～数10万の分子量、大きさは数nm～10数nm程度
%2個のNeuronそれぞれに発現遺伝子数を決定できるように対応
%リン酸化されない、FAKもつかないBetaを想定したBetaを導入
%リン酸化されずFAKが常時接着するCNPを導入、＜Arena1側からの解析になっている＞％
clear all;
close all;
global Size figArena StayProb

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Model='Vertical';
Model='Oblique';

Itineracy=10000;
StayProb=0.15;
Size=20;%Arenaの一片の長さ
numTetramer=50;
FreeTetLimit=0;

Regulated=1;%1のときCommonExpを決められる。０のときは結果的なCommonExpが返される

%Regulated=0のとき設定
Genes=[10 20 20];% a b g %30;%Regulated=1のときは遺伝子数は関係ない
Exp=[2 2 4];%a b g
numCtype=3;%101,102,103,104,,,

%Regulated=1のとき設定
%%%Neuron1
ExpN1=2;
numCtypeN1=0;
%%%Neuron2
ExpN2=1;
numCtypeN2=0;
CommonExp=1;%Regulated=1の場合に使用。重複発現は当面なしにする。Regulated=0のときは関係なし

Beta=[];%11:30];%betaを想定 ];%リン酸化部位もFAK結合部位もなし。ニューロン管結合してもFAK吸着せず、PKCを阻害しない。
CNP=[];%104];%リン酸化しないので、常にFAKが結合、FAKの機能を阻害することになる。CompulsoryNoPhosphorylation ];%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

Arena1=zeros(Size,Size);
Arena2=zeros(Size,Size);

Neuron1exp=[];
Neuron2exp=[];
ExpArray1=zeros(1,sum(Genes));
ExpArray2=zeros(1,sum(Genes));

if Regulated==1
%共通する発現遺伝子数をあらかじめ決めておく場合
    for n=1:ExpN1%Neuron1
        if n<=CommonExp
            Neuron1exp=[Neuron1exp n];
            ExpArray1(n)=1;
        else
            Neuron1exp=[Neuron1exp n];
            ExpArray1(n)=1;
        end
    end
    for n=1:ExpN2%Neuron2
        if n<=CommonExp
            Neuron2exp=[Neuron2exp n];
            ExpArray2(n)=1;
        else
            Neuron2exp=[Neuron2exp ExpN1+n-CommonExp];
            ExpArray2(ExpN1+n-CommonExp)=1;
        end
    end
else
%     ランダムに発現させる場合に使用
SumG=0;
    for m=1:length(Genes)%クラスタの数
        if m>1;SumG=SumG+Genes(m-1);end
        for  n=1:Exp(m)
            E1=ceil(rand*Genes(m));E2=ceil(rand*Genes(m));
            Neuron1exp=[Neuron1exp E1+SumG];
            ExpArray1(E1+SumG)=ExpArray1(E1+SumG)+1;
            Neuron2exp=[Neuron2exp E2+SumG];
            ExpArray2(E2+SumG)=ExpArray2(E2+SumG)+1;
        end
    end
end

if Regulated==1
    Common=sum(ExpArray1.*ExpArray2);%かけ算で計算するので、2回ずつ同一遺伝子が発現すると、４になる。
    %Neuron1
    Ctype=[];
    for n=1:numCtypeN1
        for m=1:2
            Ctype=[Ctype 100+n];
        end
    end
    Neuron1exp=sort([Neuron1exp Ctype],'ascend');
    %Neuron1
    Ctype=[];
    for n=1:numCtypeN2
        for m=1:2
            Ctype=[Ctype 100+n];
        end
    end
    Neuron2exp=sort([Neuron2exp Ctype],'ascend');
else
    Common=sum(ExpArray1.*ExpArray2);%かけ算で計算するので、2回ずつ同一遺伝子が発現すると、４になる。
    Ctype=[];
    for n=1:numCtype
        for m=1:2
            Ctype=[Ctype 100+n];
        end
    end

    Neuron1exp=sort([Neuron1exp Ctype],'ascend');
    Neuron2exp=sort([Neuron2exp Ctype],'ascend');
end

if FreeTetLimit>0
    PlusTet=Size*(Size-5);
else 
    PlusTet=0;
end
TetExp1=zeros(numTetramer,4);
TetExp2=zeros(numTetramer,4);
for n=1:numTetramer+PlusTet%+以下の増加分は、FreeTetLimitよりFree4量体が減ってしまった場合の追加用
    for m=1:4
        TetExp1(n,m)=Neuron1exp(ceil(rand*length(Neuron1exp)));
        TetExp2(n,m)=Neuron2exp(ceil(rand*length(Neuron2exp)));
    end
end
% TetExp3=TetExp1;
% TetExp2=TetExp1;
% TetExp1=TetExp3;


%重ならないようにして初期場所設定
TetPosi1=zeros(numTetramer,2);
TetPosi2=zeros(numTetramer,2);
%Arena1,2ともこちらから見ての図
%左上が１，時計回りに右上が２，右下が３、左下が４
PosiMatrix1=zeros(Size,Size);%tetramerの部位
PosiMatrix2=zeros(Size,Size);
for n=1:numTetramer
    %Arena1
    a=ceil(rand*(Size-1));b=ceil(rand*(Size-1));
%     if a==Size;c=a-Size;else c=a;end
%     if b==Size;d=b-Size;else d=b;end
    while ~(Arena1(a,b)==0 && Arena1(a,b+1)==0 && Arena1(a+1,b+1)==0 && Arena1(a+1,b)==0)
        a=ceil(rand*(Size-1));
        b=ceil(rand*(Size-1));
%         if a==Size;c=a-Size;else c=a;end
%         if b==Size;d=b-Size;else d=b;end
    end
    TetPosi1(n,:)=[a b];
    Arena1(a,b)=TetExp1(n,1);Arena1(a,b+1)=TetExp1(n,2);Arena1(a+1,b+1)=TetExp1(n,3);Arena1(a+1,b)=TetExp1(n,4);%時計回り％
    PosiMatrix1(a,b)=1;PosiMatrix1(a,b+1)=2;PosiMatrix1(a+1,b+1)=3;PosiMatrix1(a+1,b)=4;
    
    %Arena2
    a=ceil(rand*(Size-1));b=ceil(rand*(Size-1));
%     if a==Size;c=a-Size;else c=a;end
%     if b==Size;d=b-Size;else d=b;end
    while ~(Arena2(a,b)==0 && Arena2(a,b+1)==0 && Arena2(a+1,b+1)==0 && Arena2(a+1,b)==0)
        a=ceil(rand*(Size-1));
        b=ceil(rand*(Size-1));
%         if a==Size;c=a-Size;else c=a;end
%         if b==Size;d=b-Size;else d=b;end
    end
    TetPosi2(n,:)=[a b];
    Arena2(a,b)=TetExp2(n,1);Arena2(a,b+1)=TetExp2(n,2);Arena2(a+1,b+1)=TetExp2(n,3);Arena2(a+1,b)=TetExp2(n,4);%時計回り％
    PosiMatrix2(a,b)=1;PosiMatrix2(a,b+1)=2;PosiMatrix2(a+1,b+1)=3;PosiMatrix2(a+1,b)=4;
%     a=ceil(rand*Size);b=ceil(rand*Size);
%     if a==Size;c=a-Size;else c=a;end
%     if b==Size;d=b-Size;else d=b;end
%     while ~(Arena2(a,b)==0 && Arena2(c+1,b)==0 && Arena2(a,d+1)==0 && Arena2(c+1,d+1)==0)
%         a=ceil(rand*Size);
%         b=ceil(rand*Size);
%         if a==Size;c=a-Size;else c=a;end
%         if b==Size;d=b-Size;else d=b;end
%     end
%     TetPosi2(n,:)=[a b];
%     Arena2(a,b)=TetExp2(n,1);Arena2(a,d+1)=TetExp2(n,2);Arena2(c+1,d+1)=TetExp2(n,3);Arena2(c+1,b)=TetExp2(n,4);%時計回り％
%     PosiMatrix2(a,b)=1;PosiMatrix2(a,d+1)=2;PosiMatrix2(c+1,d+1)=3;PosiMatrix2(c+1,b)=4;
end

if isempty(Beta);Beta=0;end
if isempty(CNP);CNP=0;end

if Regulated==1
    Title=['Regulated, ExpN1 ',int2str(ExpN1),', ExpN2 ',int2str(ExpN2),', cN1 ',int2str(numCtypeN1),', cN2 ',int2str(numCtypeN2),', ',int2str(Common),' common, Bc ',int2str(Beta(1)),'-',int2str(Beta(end)),', CNP ', int2str(CNP),', ',int2str(numTetramer),' tetramers, Stay ',int2str(StayProb*100),'%'];
else
    Title=['G',int2str(Genes),' E',int2str(Exp),' c',int2str(numCtype),', ',int2str(Common),'common, Bc ',int2str(Beta(1)),'-',int2str(Beta(end)),', CNP ', int2str(CNP),', ',int2str(numTetramer),' tetramers, Stay ',int2str(StayProb*100),'%'];
end
if Beta==0;Beta=[];end
if CNP==0;CNP=[];end

Arena_Adh=figure;

% if ~isempty(Beta)
%     SumAdhNP=figure;
% %     SumAdh2NP=figure;
% 
%     SumAdheNP=[];
% %     SumAdhe2NP=[];
% else
    SumAdh=figure;
%     SumAdh2=figure;
    SumAdhe=[];
%     SumAdhe2=[];
% end
AddTet1=0;AddTet2=0;
% SumAdhesion=zeros(1,Itineracy);
% SumAdhesion2=zeros(1,Itineracy);
for N=1:Itineracy
    
    if strcmp(Model,'Vertical')
        AdhMatrix=zeros(Size,Size);
        for n=1:length(TetPosi1(:,1))
            for m=1:length(TetPosi2(:,1))
                if TetPosi1(n,:)==TetPosi2(m,:)
                    if TetExp1(n,:)==TetExp2(m,:)
                        AdhMatrix(TetPosi1(n,1):TetPosi1(n,1)+1,TetPosi1(n,2):TetPosi1(n,2)+1)=1;
                    end
                end
            end
        end
    elseif strcmp(Model,'Oblique')
        %数が一致していれば結合するマスを検出
        NoMoveMatrix=PosiMatrix1.*PosiMatrix2;
        NoMoveMatrix(NoMoveMatrix==3)=-1;%右下の３と左上の１が重なった場合
        NoMoveMatrix(NoMoveMatrix==8)=-1;%右上の２と左下の４が重なった場合\
        NoMoveMatrix(NoMoveMatrix>0)=0;
        NoMoveMatrix(NoMoveMatrix<0)=1;

        AR1=Arena1.*NoMoveMatrix;%結合できる配置のマスのみ遺伝子番号を残す。
        AR2=Arena2.*NoMoveMatrix;
%         AR1(AR1==0)=10000;%遺伝子がないか、あっても結合できない配置のマスは引き算しても０にならないように、10000を入れておく。
%         AR2(AR2==0)=10000;
        AR1(AR1==0)=-10000;%遺伝子がないか、あっても結合できない配置のマスは引き算しても０にならないように、－１と１を入れておく。
        AR2(AR2==0)=10000;
        AdhMatrix=AR1-AR2;%遺伝子が一致していれば０になる。
        AdhMatrix(AdhMatrix==0)=10000;
        AdhMatrix(AdhMatrix<10000)=0;
        AdhMatrix(AdhMatrix==10000)=1;%結合マス
    end

    Free1=0;Free2=0;
    for n=1:numTetramer+min(AddTet1,AddTet2)
        [Arena1 TetPosi1 TetExp1 PosiMatrix1 Free1]=RenewArena(Arena1,TetPosi1,TetExp1,PosiMatrix1,AdhMatrix,n,Free1);
        [Arena2 TetPosi2 TetExp2 PosiMatrix2 Free2]=RenewArena(Arena2,TetPosi2,TetExp2,PosiMatrix2,AdhMatrix,n,Free2);
    end
    
    while Free1<FreeTetLimit && AddTet1+numTetramer<(Size*Size)*0.1
        AddTet1=AddTet1+1;        
        a=ceil(rand*(Size-1));
        b=ceil(rand*(Size-1));
        while Arena1(a,b)+Arena1(a,b+1)+Arena1(a+1,b+1)+Arena1(a+1,b)~=0
            a=ceil(rand*(Size-1));
            b=ceil(rand*(Size-1));
        end
        TetPosi1(AddTet1+numTetramer,:)=[a b];
        Arena1(a,b)=TetExp1(numTetramer+AddTet1,1);Arena1(a,b+1)=TetExp1(numTetramer+AddTet1,2);Arena1(a+1,b+1)=TetExp1(numTetramer+AddTet1,3);Arena1(a+1,b)=TetExp1(numTetramer+AddTet1,4);
        PosiMatrix1(a,b)=1;PosiMatrix1(a,b+1)=2;PosiMatrix1(a+1,b+1)=3;PosiMatrix1(a+1,b)=4;
        Free1=Free1+1;
    end

    while Free2<FreeTetLimit && AddTet2+numTetramer<(Size*Size)*0.1
        AddTet2=AddTet2+1;        
        a=ceil(rand*(Size-1));
        b=ceil(rand*(Size-1));
        while Arena1(a,b)+Arena1(a,b+1)+Arena1(a+1,b+1)+Arena1(a+1,b)~=0
            a=ceil(rand*(Size-1));
            b=ceil(rand*(Size-1));
        end
        TetPosi2(AddTet2+numTetramer,:)=[a b];
        Arena2(a,b)=TetExp2(numTetramer+AddTet2,1);Arena2(a,b+1)=TetExp2(numTetramer+AddTet2,2);Arena2(a+1,b+1)=TetExp2(numTetramer+AddTet2,3);Arena2(a+1,b)=TetExp2(numTetramer+AddTet2,4);
        PosiMatrix2(a,b)=1;PosiMatrix2(a,b+1)=2;PosiMatrix2(a+1,b+1)=3;PosiMatrix2(a+1,b)=4;
        Free2=Free2+1;
    end
       
    if mod(N,100)==0
        N
        NPmatrixCNP=[];AdhMatrixNP01=[];AdhMatrixNP=[];
        
        ArenaZeroOne1=Arena1;
        ArenaZeroOne2=Arena2;
        ArenaZeroOne1(ArenaZeroOne1>0)=1;
        ArenaZeroOne2(ArenaZeroOne2>0)=1;
        
        if ~isempty(Beta)            
            NPmatrix1=Arena1;
            for k=Beta
                NPmatrix1(NPmatrix1==k)=-1;
            end
            NPmatrix1(NPmatrix1>0)=0;
           
%             AdhMatrixNP=AdhMatrix;
            AdhMatrixNP01=AdhMatrix;
            AdhMatrixNP01(AdhMatrix==1 & NPmatrix1==-1)=0.1;%NPmatrix=-1,(betaの部分)を消す。  
%             AdhMatrixNP(NPmatrix1==-1)=0;%NPmatrix=-1,(betaの部分)を消す。
            AdhMatrix(NPmatrix1==-1)=0;%NPmatrix=-1,(betaの部分)を消す。
        end
        if ~isempty(CNP)            
            NPmatrixCNP=Arena1;
            for k=CNP
                NPmatrixCNP(NPmatrixCNP==k)=-1;
            end
            NPmatrixCNP(NPmatrixCNP>0)=0;
            NPmatrixCNP(NPmatrixCNP<0)=1;
            if isempty(AdhMatrixNP01)
%                 AdhMatrixNP=AdhMatrixNP;
%                 AdhMatrixNP01=AdhMatrixNP01;
%             else
%                 AdhMatrixNP=AdhMatrix;
                AdhMatrixNP01=AdhMatrix;
            end
%             AdhMatrixNP(NPmatrixCNP==1)=1;%NPmatrix=-1,(CompulsoryPhosphorylationの部分)を1にする。
            AdhMatrix(NPmatrixCNP==1)=1;%NPmatrix=-1,(CompulsoryPhosphorylationの部分)を1にする。            
            
            AdhMatrixNP01(NPmatrixCNP==1)=1;%NPmatrix=-1,(betaの部分)を消す。    
%             AdhMatrixNP02=AdhMatrixNP01;
        end

        figure(Arena_Adh);
        subplot(1,3,1);
        image(ArenaZeroOne1*255);colormap(gray);
        subplot(1,3,2);
        if ~isempty(AdhMatrixNP01)%~isempty(Beta) && ~isempty(CNP)
            image(AdhMatrixNP01*255);colormap(gray);
            if ~isempty(NPmatrixCNP)
                [a,b]=find(NPmatrixCNP==1);
                text(a,b,'x');
            end
        else
            image(AdhMatrix*255);colormap(gray);
        end
        subplot(1,3,3);
        image(ArenaZeroOne2*255);colormap(gray);
        if Regulated==1
            TitleN=[Title,', ',int2str(N),' steps'];
        else
            TitleN=[Title,', ',int2str(N),' steps'];
        end
        title(TitleN);
        

%         if ~isempty(AdhMatrixNP)
%             
%             SumAdheNP=[SumAdheNP sum(sum(AdhMatrixNP))];
%             figure(SumAdhNP)
%             plot(SumAdheNP);
%     %         axis([0 Itineracy 0 max(SumAdhesion)+1]);
%             title(Title);
% 
%         else
            SumAdhe=[SumAdhe sum(sum(AdhMatrix))];
            figure(SumAdh)
            plot(SumAdhe);
            axis([0 N/100+1 0 max(SumAdhe)+1]);
            title(Title);

%         end
        
    end
end

% if ~isempty(AdhMatrixNP)
%     AddBin=3;
%     AddMatrix=zeros(Size-AddBin+1,Size-AddBin+1);
%     for n=1:Size-AddBin+1
%         for m=1:Size-AddBin+1
%             AddMatrix(n,m)=sum(sum(AdhMatrixNP(n:n+AddBin-1,m:m+AddBin-1)));
%         end
%     end
% else
    AddBin=5;
    AddMatrix=zeros(Size-AddBin+1,Size-AddBin+1);
    for n=1:Size-AddBin+1
        for m=1:Size-AddBin+1
            AddMatrix(n,m)=sum(sum(AdhMatrix(n:n+AddBin-1,m:m+AddBin-1)));
        end
    end
% end
% AddMatrix

figure
surf(AddMatrix);
colormap winter
title(TitleN);

% figure
% image(AddMatrix./max(max(AddMatrix))*255);
% % image(AddMatrix.*51);
% colormap(gray);
% title(TitleN);

% figure(SumAdh)
% plot(SumAdhe);

                
function [Arena1 TetPosi1 TetExp1 PosiMatrix1 Free]=RenewArena(Arena1,TetPosi1,TetExp1,PosiMatrix1,AdhMatrix,n,Free)
global Size figArena StayProb
 %Arena1
        a=TetPosi1(n,1);b=TetPosi1(n,2);
%         a
%         b
        if a==Size;c=a-Size;else c=a;end
        if b==Size;d=b-Size;else d=b;end
        SumNoMove=AdhMatrix(a,b)+AdhMatrix(a,d+1)+AdhMatrix(c+1,b)+AdhMatrix(c+1,d+1);%接着している分子数
        if SumNoMove==0
            SP=0;
        elseif SumNoMove==1
            SP=StayProb;
        elseif SumNoMove==2
            SP=1;%
%             SP=StayProb+(1-StayProb)*StayProb;
        elseif SumNoMove==3
            SP=1;%
%             SP=StayProb+(1-StayProb)*StayProb+((1-StayProb)^2)*StayProb;%1-(StayProb+(1-StayProb)*StayProb)
        else
            SP=1;
%         elseif SumNoMove==4
%             SP=SumNoMove*(StayProb+StayProb^2+StayProb^3+StayProb^4)
        end
        if SumNoMove==0;Free=Free+1;end
        
        if rand>SP
            PosiMatrix1(a,b)=0;PosiMatrix1(a,d+1)=0;PosiMatrix1(c+1,d+1)=0;PosiMatrix1(c+1,b)=0;%%%%%%%%%%%%%%%%%%%%%%%%
            if rand>0.5;new_a=a+1;else new_a=a-1;end%新しい位置
            if rand>0.5;new_b=b+1;else new_b=b-1;end
            if new_a==0
                new_a=new_a+Size;
            elseif new_a>Size
                new_a=new_a-Size;
            end
            if new_a==Size;new_c=new_a-Size;else new_c=new_a;end
        
            if new_b==0
                new_b=new_b+Size;
            elseif new_b>Size
                new_b=new_b-Size;
            end
            if new_b==Size;new_d=new_b-Size;else new_d=new_b;end
%             new_a
%             new_b
            
            t1=Arena1(a,b);t2=Arena1(c+1,b);t3=Arena1(a,d+1);t4=Arena1(c+1,d+1);
            Arena1(a,b)=0;Arena1(c+1,b)=0;Arena1(a,d+1)=0;Arena1(c+1,d+1)=0;%いったん削除
            if Arena1(new_a,new_b)+Arena1(new_c+1,new_b)+Arena1(new_a,new_d+1)+Arena1(new_c+1,new_d+1)==0%同じArenaで隣とぶつからない場合
%                 Arena1(a,b)=0;Arena1(c+1,b)=0;Arena1(a,d+1)=0;Arena1(c+1,d+1)=0;%もとの場所をクリア
                a=new_a;%a,bの更新
                b=new_b;              
                TetPosi1(n,:)=[a b];
            else
                Arena1(a,b)=t1;Arena1(c+1,b)=t2;Arena1(a,d+1)=t3;Arena1(c+1,d+1)=t4;
            end%ぶつかる場合はa,bはそのまま、移動しない
           
            if a==Size;c=a-Size;else c=a;end
            if b==Size;d=b-Size;else d=b;end
            Arena1(a,b)=TetExp1(n,1);Arena1(a,d+1)=TetExp1(n,2);Arena1(c+1,d+1)=TetExp1(n,3);Arena1(c+1,b)=TetExp1(n,4);
            
            %とりあえず回転
            if a==Size;c=a-Size;else c=a;end
            if b==Size;d=b-Size;else d=b;end
            Rnd=rand;
            if Rnd<0.25%右回転、左右25％ずつ
                A=TetExp1(n,1);B=TetExp1(n,2);C=TetExp1(n,3);D=TetExp1(n,4);
                TetExp1(n,1)=D;TetExp1(n,2)=A;TetExp1(n,3)=B;TetExp1(n,4)=C;                
            elseif Rnd>0.75%左回転
                A=TetExp1(n,1);B=TetExp1(n,2);C=TetExp1(n,3);D=TetExp1(n,4);
                TetExp1(n,1)=B;TetExp1(n,2)=C;TetExp1(n,3)=D;TetExp1(n,4)=A;     
%             else%回転なし、50%
            end
%             a
%             b
            Arena1(a,b)=TetExp1(n,1);Arena1(a,d+1)=TetExp1(n,2);Arena1(c+1,d+1)=TetExp1(n,3);Arena1(c+1,b)=TetExp1(n,4);
            PosiMatrix1(a,b)=1;PosiMatrix1(a,d+1)=2;PosiMatrix1(c+1,d+1)=3;PosiMatrix1(c+1,b)=4;

%             Arena1
%             figure(figArena);image(Arena1*255);colormap(gray);title('Arena1');
        end

