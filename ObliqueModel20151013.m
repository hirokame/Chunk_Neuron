function ObliqueModel20151013
%Oblique model
%�^���p�N���A1���`��10���̕��q�ʁA�傫���͐�nm�`10��nm���x
%2��Neuron���ꂼ��ɔ�����`�q��������ł���悤�ɑΉ�
%�����_������Ȃ��AFAK�����Ȃ�Beta��z�肵��Beta�𓱓�
%�����_�����ꂸFAK���펞�ڒ�����CNP�𓱓��A��Arena1������̉�͂ɂȂ��Ă��遄��
clear all;
close all;
global Size figArena StayProb

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Model='Vertical';
Model='Oblique';

Itineracy=10000;
StayProb=0.15;
Size=20;%Arena�̈�Ђ̒���
numTetramer=50;
FreeTetLimit=0;

Regulated=1;%1�̂Ƃ�CommonExp�����߂���B�O�̂Ƃ��͌��ʓI��CommonExp���Ԃ����

%Regulated=0�̂Ƃ��ݒ�
Genes=[10 20 20];% a b g %30;%Regulated=1�̂Ƃ��͈�`�q���͊֌W�Ȃ�
Exp=[2 2 4];%a b g
numCtype=3;%101,102,103,104,,,

%Regulated=1�̂Ƃ��ݒ�
%%%Neuron1
ExpN1=2;
numCtypeN1=0;
%%%Neuron2
ExpN2=1;
numCtypeN2=0;
CommonExp=1;%Regulated=1�̏ꍇ�Ɏg�p�B�d�������͓��ʂȂ��ɂ���BRegulated=0�̂Ƃ��͊֌W�Ȃ�

Beta=[];%11:30];%beta��z�� ];%�����_�����ʂ�FAK�������ʂ��Ȃ��B�j���[�����ǌ������Ă�FAK�z�������APKC��j�Q���Ȃ��B
CNP=[];%104];%�����_�����Ȃ��̂ŁA���FAK�������AFAK�̋@�\��j�Q���邱�ƂɂȂ�BCompulsoryNoPhosphorylation ];%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

Arena1=zeros(Size,Size);
Arena2=zeros(Size,Size);

Neuron1exp=[];
Neuron2exp=[];
ExpArray1=zeros(1,sum(Genes));
ExpArray2=zeros(1,sum(Genes));

if Regulated==1
%���ʂ��锭����`�q�������炩���ߌ��߂Ă����ꍇ
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
%     �����_���ɔ���������ꍇ�Ɏg�p
SumG=0;
    for m=1:length(Genes)%�N���X�^�̐�
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
    Common=sum(ExpArray1.*ExpArray2);%�����Z�Ōv�Z����̂ŁA2�񂸂����`�q����������ƁA�S�ɂȂ�B
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
    Common=sum(ExpArray1.*ExpArray2);%�����Z�Ōv�Z����̂ŁA2�񂸂����`�q����������ƁA�S�ɂȂ�B
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
for n=1:numTetramer+PlusTet%+�ȉ��̑������́AFreeTetLimit���Free4�ʑ̂������Ă��܂����ꍇ�̒ǉ��p
    for m=1:4
        TetExp1(n,m)=Neuron1exp(ceil(rand*length(Neuron1exp)));
        TetExp2(n,m)=Neuron2exp(ceil(rand*length(Neuron2exp)));
    end
end
% TetExp3=TetExp1;
% TetExp2=TetExp1;
% TetExp1=TetExp3;


%�d�Ȃ�Ȃ��悤�ɂ��ď����ꏊ�ݒ�
TetPosi1=zeros(numTetramer,2);
TetPosi2=zeros(numTetramer,2);
%Arena1,2�Ƃ������炩�猩�Ă̐}
%���オ�P�C���v���ɉE�オ�Q�C�E�����R�A�������S
PosiMatrix1=zeros(Size,Size);%tetramer�̕���
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
    Arena1(a,b)=TetExp1(n,1);Arena1(a,b+1)=TetExp1(n,2);Arena1(a+1,b+1)=TetExp1(n,3);Arena1(a+1,b)=TetExp1(n,4);%���v��聓
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
    Arena2(a,b)=TetExp2(n,1);Arena2(a,b+1)=TetExp2(n,2);Arena2(a+1,b+1)=TetExp2(n,3);Arena2(a+1,b)=TetExp2(n,4);%���v��聓
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
%     Arena2(a,b)=TetExp2(n,1);Arena2(a,d+1)=TetExp2(n,2);Arena2(c+1,d+1)=TetExp2(n,3);Arena2(c+1,b)=TetExp2(n,4);%���v��聓
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
        %������v���Ă���Ό�������}�X�����o
        NoMoveMatrix=PosiMatrix1.*PosiMatrix2;
        NoMoveMatrix(NoMoveMatrix==3)=-1;%�E���̂R�ƍ���̂P���d�Ȃ����ꍇ
        NoMoveMatrix(NoMoveMatrix==8)=-1;%�E��̂Q�ƍ����̂S���d�Ȃ����ꍇ\
        NoMoveMatrix(NoMoveMatrix>0)=0;
        NoMoveMatrix(NoMoveMatrix<0)=1;

        AR1=Arena1.*NoMoveMatrix;%�����ł���z�u�̃}�X�݈̂�`�q�ԍ����c���B
        AR2=Arena2.*NoMoveMatrix;
%         AR1(AR1==0)=10000;%��`�q���Ȃ����A�����Ă������ł��Ȃ��z�u�̃}�X�͈����Z���Ă��O�ɂȂ�Ȃ��悤�ɁA10000�����Ă����B
%         AR2(AR2==0)=10000;
        AR1(AR1==0)=-10000;%��`�q���Ȃ����A�����Ă������ł��Ȃ��z�u�̃}�X�͈����Z���Ă��O�ɂȂ�Ȃ��悤�ɁA�|�P�ƂP�����Ă����B
        AR2(AR2==0)=10000;
        AdhMatrix=AR1-AR2;%��`�q����v���Ă���΂O�ɂȂ�B
        AdhMatrix(AdhMatrix==0)=10000;
        AdhMatrix(AdhMatrix<10000)=0;
        AdhMatrix(AdhMatrix==10000)=1;%�����}�X
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
            AdhMatrixNP01(AdhMatrix==1 & NPmatrix1==-1)=0.1;%NPmatrix=-1,(beta�̕���)�������B  
%             AdhMatrixNP(NPmatrix1==-1)=0;%NPmatrix=-1,(beta�̕���)�������B
            AdhMatrix(NPmatrix1==-1)=0;%NPmatrix=-1,(beta�̕���)�������B
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
%             AdhMatrixNP(NPmatrixCNP==1)=1;%NPmatrix=-1,(CompulsoryPhosphorylation�̕���)��1�ɂ���B
            AdhMatrix(NPmatrixCNP==1)=1;%NPmatrix=-1,(CompulsoryPhosphorylation�̕���)��1�ɂ���B            
            
            AdhMatrixNP01(NPmatrixCNP==1)=1;%NPmatrix=-1,(beta�̕���)�������B    
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
        SumNoMove=AdhMatrix(a,b)+AdhMatrix(a,d+1)+AdhMatrix(c+1,b)+AdhMatrix(c+1,d+1);%�ڒ����Ă��镪�q��
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
            if rand>0.5;new_a=a+1;else new_a=a-1;end%�V�����ʒu
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
            Arena1(a,b)=0;Arena1(c+1,b)=0;Arena1(a,d+1)=0;Arena1(c+1,d+1)=0;%��������폜
            if Arena1(new_a,new_b)+Arena1(new_c+1,new_b)+Arena1(new_a,new_d+1)+Arena1(new_c+1,new_d+1)==0%����Arena�ŗׂƂԂ���Ȃ��ꍇ
%                 Arena1(a,b)=0;Arena1(c+1,b)=0;Arena1(a,d+1)=0;Arena1(c+1,d+1)=0;%���Ƃ̏ꏊ���N���A
                a=new_a;%a,b�̍X�V
                b=new_b;              
                TetPosi1(n,:)=[a b];
            else
                Arena1(a,b)=t1;Arena1(c+1,b)=t2;Arena1(a,d+1)=t3;Arena1(c+1,d+1)=t4;
            end%�Ԃ���ꍇ��a,b�͂��̂܂܁A�ړ����Ȃ�
           
            if a==Size;c=a-Size;else c=a;end
            if b==Size;d=b-Size;else d=b;end
            Arena1(a,b)=TetExp1(n,1);Arena1(a,d+1)=TetExp1(n,2);Arena1(c+1,d+1)=TetExp1(n,3);Arena1(c+1,b)=TetExp1(n,4);
            
            %�Ƃ肠������]
            if a==Size;c=a-Size;else c=a;end
            if b==Size;d=b-Size;else d=b;end
            Rnd=rand;
            if Rnd<0.25%�E��]�A���E25������
                A=TetExp1(n,1);B=TetExp1(n,2);C=TetExp1(n,3);D=TetExp1(n,4);
                TetExp1(n,1)=D;TetExp1(n,2)=A;TetExp1(n,3)=B;TetExp1(n,4)=C;                
            elseif Rnd>0.75%����]
                A=TetExp1(n,1);B=TetExp1(n,2);C=TetExp1(n,3);D=TetExp1(n,4);
                TetExp1(n,1)=B;TetExp1(n,2)=C;TetExp1(n,3)=D;TetExp1(n,4)=A;     
%             else%��]�Ȃ��A50%
            end
%             a
%             b
            Arena1(a,b)=TetExp1(n,1);Arena1(a,d+1)=TetExp1(n,2);Arena1(c+1,d+1)=TetExp1(n,3);Arena1(c+1,b)=TetExp1(n,4);
            PosiMatrix1(a,b)=1;PosiMatrix1(a,d+1)=2;PosiMatrix1(c+1,d+1)=3;PosiMatrix1(c+1,b)=4;

%             Arena1
%             figure(figArena);image(Arena1*255);colormap(gray);title('Arena1');
        end

