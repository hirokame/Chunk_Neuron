function SflCnxMatrixMaker20160822%(File,ExpMatrix,ProbMatrix,CnxMatrix,VarMatrix)

global ExpMatrix ProbMatrix CnxMatrix VarMatrix
File='Group_CnxMatrix001_M4_N10000_G50_E5_R1_Match1000000';
eval(['load ',File]);

Neurons=length(ExpMatrix(:,1));
Genes=length(VarMatrix(1,:));
Exp=length(ExpMatrix(1,:));
%CircularPilgrim　Voltageをそのまま加えていくもの。
%CircularPilgrim20140610　カレントを加えるように変更 leaky Integrate and Fire
%267行目に下を加えて、leakyにしただけ。
%delta=0.001*(0-In)+(Prnd*(RndIn(:,n)./sum(RndIn(:,n)))+NewIn);% LEAKY %G50E3の場合だと、係数0.001だとうまくいかない。より小さく。

% ShowParameters=0;%クラスタ性、ショートカット、スモールワールド性を計算
% 4量体の場合、ProteinMatching20130717で作成した細胞群を利用。reshapeA.mでCnxMatrixを作成し、loadする。ProteinExpMatrix4_1000_1_500_5000_c00000_100
%MakeMultimerNet_Group20150318で作成したGroup_ProbMatrix_M4_N1000_G50_E10_R-1_Match100000.mat

% close all;
% clear all;

% load Reshaped CnxMatrix %reshapeA.m

% File='Group_CnxMatrix8_M4_N1000_G50_E5_R-1_Match3000000';

% for Fnum=1:10

% if isempty(File)
%     File=['Group_CnxMatrix1_M1_N1000_G50_E5_R-1_Match1000']
%     % File=['Group_CnxMatrix', int2str(Fnum),'_M4_N1000_G50_E5_R-1_Match3000000']
%     % File=['Group_CnxMatrix1_M4_N1000_G50_E5_R-1_Match100000']
% 
%     str=['load ',File,';'];
%     eval(str);
% 
%     VarMatrix=zeros(Neurons,50);%Neurons, Genes
%     for n=1:length(ExpMatrix(:,1))
%         for m=1:length(ExpMatrix(1,:))
%             VarMatrix(n,ExpMatrix(n,m))=VarMatrix(n,m)+1;
%         end
%     end
% end

Ideal=zeros(Neurons,Neurons);%Neurons=1000
for n=1:Neurons
    for m=n+1:Neurons
        Ideal(n,m)=sum(VarMatrix(n,:).*VarMatrix(m,:));
    end
end
IdealMatrix=Ideal+Ideal';

    for Neurons=Neurons
%         Neurons
        
        CNXMatrix=CnxMatrix(1:Neurons,1:Neurons);
        STR1=['CnxMatrix',int2str(Neurons),'=CNXMatrix;'];
        eval(STR1);
        
        Str0=['IdealMatrix',int2str(Neurons),'=IdealMatrix(1:Neurons,1:Neurons);'];
        eval(Str0);

        STR=['[SflCnxMatrix',int2str(Neurons), ' SflPrCnxMatrix',int2str(Neurons),']=ShuffleMatrix(CNXMatrix)',';'];
        eval(STR);
        
        STR1=['[IdealSflMatrix',int2str(Neurons), ' IdealSflPrMatrix',int2str(Neurons),']=ShuffleMatrix2(IdealMatrix(1:Neurons,1:Neurons));'];
        eval(STR1);
        
%         STR2=['EvenMatrix',int2str(Neurons),'=MakeEvenMatrix(CNXMatrix)'];
%         eval(STR2);
        
%         str2=['save ',File,',IdealMatrix',int2str(Neurons),',IdealSflMatrix',int2str(Neurons),',IdealSflPrMatrix',int2str(Neurons),',CnxMatrix',int2str(Neurons),',SflCnxMatrix',int2str(Neurons),',SflPrCnxMatrix',int2str(Neurons), ',RndMatrix',int2str(Neurons),',EvenMatrix',int2str(Neurons), ',''','-append;',''''];

        str2=['save ',File,',IdealMatrix',int2str(Neurons),',IdealSflMatrix',int2str(Neurons),',IdealSflPrMatrix',int2str(Neurons),',CnxMatrix',int2str(Neurons),',SflCnxMatrix',int2str(Neurons),',SflPrCnxMatrix',int2str(Neurons),',''','-append;',''''];
        eval(str2);
    
    end
% end


function [SflCnxMatrix SflPrCnxMatrix]=ShuffleMatrix(CnxMatrixIn)

% if Shuffle==1 && length(CnxMatrix(1,:))~=1000
    CnxMatrix=CnxMatrixIn;
    SflCnxMatrix=CnxMatrixIn;
    SflPrCnxMatrix=CnxMatrixIn;
    
    Neurons=length(CnxMatrix(1,:));
    for n=1:(Neurons^2)*10
        n
        a=ceil(rand*Neurons);
        b=ceil(rand*Neurons);
        c=ceil(rand*Neurons);
        d=ceil(rand*Neurons);
        if a~=b && c~=d
            A=SflCnxMatrix(a,b);
            B=SflCnxMatrix(c,d);
            SflCnxMatrix(a,b)=B;
            SflCnxMatrix(c,d)=A;
            
            A2=SflPrCnxMatrix(a,b);
            B2=SflPrCnxMatrix(c,d);
            A3=SflPrCnxMatrix(b,a);
            B3=SflPrCnxMatrix(d,c);
            
            SflPrCnxMatrix(a,b)=B2;
            SflPrCnxMatrix(c,d)=A2;
            SflPrCnxMatrix(b,a)=B3;
            SflPrCnxMatrix(d,c)=A3;
            
        end
    end
%    CnxMatrix=CnxMatrixA;%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% elseif Shuffle==1 && length(CnxMatrix(1,:))==1000
%     if ShufflePair==1
%         CnxMatrix=SflPrCnxMatrix;
%     else
%         CnxMatrix=SflCnxMatrix;
%     end
% end
% RndMatrix=MakeRndMatrix(CnxMatrix,0);
% EvenMatrix=MakeEvenMatrix(CnxMatrix);
% if Random==1;CnxMatrix=MakeRndMatrix(CnxMatrix,0);end
% if RandomPair==1;CnxMatrix=MakeRndMatrix(CnxMatrix,1);end

function [SflCnxMatrix SflPrCnxMatrix]=ShuffleMatrix2(CnxMatrixIn)

% if Shuffle==1 && length(CnxMatrix(1,:))~=1000
    CnxMatrix=CnxMatrixIn;
    SflCnxMatrix=CnxMatrixIn;
    SflPrCnxMatrix=CnxMatrixIn;
    
    Neurons=length(CnxMatrix(1,:));
    for n=1:(Neurons^2)*10
        n
        a=ceil(rand*Neurons);
        b=ceil(rand*Neurons);
        c=ceil(rand*Neurons);
        d=ceil(rand*Neurons);
        if a~=b && c~=d
            A=SflCnxMatrix(a,b);
            B=SflCnxMatrix(c,d);
            SflCnxMatrix(a,b)=B;
            SflCnxMatrix(c,d)=A;
            
            A2=SflPrCnxMatrix(a,b);
            B2=SflPrCnxMatrix(c,d);
            A3=SflPrCnxMatrix(b,a);
            B3=SflPrCnxMatrix(d,c);
            
            SflPrCnxMatrix(a,b)=B2;
            SflPrCnxMatrix(c,d)=A2;
            SflPrCnxMatrix(b,a)=B3;
            SflPrCnxMatrix(d,c)=A3;
            
        end
    end

function EvenMatrix=MakeEvenMatrix(CnxMatrix)

ZeroOneMatrix=CnxMatrix;
Sum=sum(sum(CnxMatrix));
ZeroOneMatrix(ZeroOneMatrix>0)=1;
SumOne=sum(sum(ZeroOneMatrix));
Ave=Sum/SumOne;
EvenMatrix=ZeroOneMatrix*Ave;

function CnxMatrix=MakeRndMatrix(CnxMatrix,RandomPair)
Neurons=length(CnxMatrix(1,:));
SumConnect=sum(sum(CnxMatrix));
%RandomNet%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
if RandomPair==0
    CnxMatrixRnd=zeros(Neurons,Neurons);
    n=1;
    while n<=SumConnect/2
        a=ceil(rand*Neurons);
        b=ceil(rand*Neurons);
        c=ceil(rand*Neurons);
        d=ceil(rand*Neurons);
        if a~=b && c~=d
            CnxMatrixRnd(a,b)=CnxMatrixRnd(a,b)+1;
            CnxMatrixRnd(c,d)=CnxMatrixRnd(c,d)+1;
            n=n+1;
        end
    end
    CnxMatrix=CnxMatrixRnd;

%RandomNet%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%RandomPairNet%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
elseif RandomPair==1
    CnxMatrixRnd=zeros(Neurons,Neurons);
    n=1;
    while n<=SumConnect/2
        a=ceil(rand*Neurons);
        b=ceil(rand*Neurons);
        if a~=b
            CnxMatrixRnd(a,b)=CnxMatrixRnd(a,b)+1;
            CnxMatrixRnd(b,a)=CnxMatrixRnd(b,a)+1;
            n=n+1;
        end
    end
    CnxMatrix=CnxMatrixRnd;
end
%RandomPairNet%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

        
function CnxMatrix=MakeCnxMatrix(Tetramer,Shuffle,ShufflePair,Random,RandomPair,Regular,SmallWorld)
%4量体%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
if Tetramer==1
%     load Reshaped CnxMatrix %reshapeA.m
%     CnxMatrix=CnxMatrix*(SumConnect/sum(sum(CnxMatrix)));

load Group1_ProbMatrix_M4_N1000_G50_E10_R-1_Match100000.mat CnxMatrix SflCnxMatrix SflPrCnxMatrix
% CnxMatrix=ProbMatrix/min(min(ProbMatrix(ProbMatrix~=0)));

% CnxMatrix=CnxMatrix(1:100,1:100);
% CnxMatrix=CnxMatrix(1:200,1:200);

end
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

SumConnect=sum(sum(CnxMatrix));
Neurons=length(CnxMatrix(1,:));

% sum(CnxMatrix)
% figure;bar(sum(CnxMatrix));

% %Shuffle%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
if Shuffle==1
    for n=1:Neurons^2*10
        n
        a=ceil(rand*100);
        b=ceil(rand*100);
        c=ceil(rand*100);
        d=ceil(rand*100);
        if a~=b && c~=d
            A=CnxMatrix(a,b);
            B=CnxMatrix(c,d);

            CnxMatrix(a,b)=B;
            CnxMatrix(c,d)=A;
            
            if ShufflePair==1
                A2=CnxMatrix(b,a);
                B2=CnxMatrix(d,c);

                CnxMatrix(b,a)=B2;
                CnxMatrix(d,c)=A2;
            end
        end
    end
end
% %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% sum(CnxMatrix)
% figure;bar(sum(CnxMatrix));
% CnxMatrix;
%RandomNet%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
if Random==1
    CnxMatrixRnd=zeros(Neurons,Neurons);
    n=1;
    while n<=SumConnect/2
        a=ceil(rand*Neurons);
        b=ceil(rand*Neurons);
        c=ceil(rand*Neurons);
        d=ceil(rand*Neurons);
        if a~=b && c~=d
            CnxMatrixRnd(a,b)=CnxMatrixRnd(a,b)+1;
            CnxMatrixRnd(c,d)=CnxMatrixRnd(c,d)+1;
            n=n+1;
        end
    end
    CnxMatrix=CnxMatrixRnd;
end
%RandomNet%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%RandomPairNet%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
if RandomPair==1
    CnxMatrixRnd=zeros(Neurons,Neurons);
    n=1;
    while n<=SumConnect/2
        a=ceil(rand*Neurons);
        b=ceil(rand*Neurons);
        if a~=b
            CnxMatrixRnd(a,b)=CnxMatrixRnd(a,b)+1;
            CnxMatrixRnd(b,a)=CnxMatrixRnd(b,a)+1;
            n=n+1;
        end
    end
    CnxMatrix=CnxMatrixRnd;
end
%RandomPairNet%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%RegularNet%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
if Regular==1
    CnxMatrixReg=zeros(Neurons,Neurons);
    a=1;
    n=0;
    while sum(sum(CnxMatrixReg))<SumConnect
        n=n+1;
        if n>Neurons;n=n-Neurons;a=a+1;end
        ZeroM=zeros(Neurons,Neurons);
        if n+a<=Neurons
            ZeroM(n,n+a)=1;
        else
            ZeroM(n,n+a-Neurons)=1;
        end
        CnxMatrixReg=CnxMatrixReg+ZeroM+ZeroM';
    end
    CnxMatrix=CnxMatrixReg;
end
% RegularNet%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%SmallWorldNetowrk%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
if SmallWorld==1
CnxMatrixSWp0001=CnxMatrixReg;%zeros(size(CnxMatrixReg));
% CnxMatrixSWp001=zeros(size(CnxMatrixReg));
% CnxMatrixSWp01=zeros(size(CnxMatrixReg));

%まず結合を減らしていく。
WSSW=0.12;%0.2の場合、20%までつなぎ替える。
k=0;
while k<=ceil(SumConnect*WSSW)
    while k<=ceil(SumConnect*WSSW/2)
        while k<=ceil(SumConnect*WSSW/4)
            a=ceil(rand*Neurons);
            b=ceil(rand*Neurons);
            if CnxMatrixSWp0001(a,b)==1
                CnxMatrixSWp0001(a,b)=0;
                CnxMatrixSWp0001(b,a)=0;
                k=k+1;
            end
            if k==ceil(SumConnect*WSSW/4)+1
                CnxMatrixSWp001=CnxMatrixSWp0001;
            end
        end
        a=ceil(rand*Neurons);
        b=ceil(rand*Neurons);
        if CnxMatrixSWp001(a,b)==1
            CnxMatrixSWp001(a,b)=0;
            CnxMatrixSWp001(b,a)=0;
            k=k+1;
        end
        if k==ceil(SumConnect*WSSW/2)+1
            CnxMatrixSWp01=CnxMatrixSWp001;
        end
    end
    a=ceil(rand*Neurons);
    b=ceil(rand*Neurons);
    if CnxMatrixSWp01(a,b)==1
        CnxMatrixSWp01(a,b)=0;
        CnxMatrixSWp01(b,a)=0;
        k=k+1;
    end
end
%次に結合を増やしていく。
k=0;
while k<=ceil(SumConnect*WSSW)
    while k<=ceil(SumConnect*WSSW/2)
        while k<=ceil(SumConnect*WSSW/4)
            a=ceil(rand*Neurons);
            b=ceil(rand*Neurons);
            if a~=b
                CnxMatrixSWp0001(a,b)=CnxMatrixSWp0001(a,b)+1;
                CnxMatrixSWp0001(b,a)=CnxMatrixSWp0001(b,a)+1;
                k=k+1;
            end
            if k==ceil(SumConnect*WSSW/4)+1
                CnxMatrixSWp001=CnxMatrixSWp0001;
            end
        end
        a=ceil(rand*Neurons);
        b=ceil(rand*Neurons);
        if a~=b
            CnxMatrixSWp001(a,b)=CnxMatrixSWp001(a,b)+1;
            CnxMatrixSWp001(b,a)=CnxMatrixSWp001(b,a)+1;
            k=k+1;
        end
        if k==ceil(SumConnect*WSSW/2)+1
            CnxMatrixSWp01=CnxMatrixSWp001;
        end
    end
    a=ceil(rand*Neurons);
    b=ceil(rand*Neurons);
    if a~=b
        CnxMatrixSWp01(a,b)=CnxMatrixSWp01(a,b)+1;
        CnxMatrixSWp01(b,a)=CnxMatrixSWp01(b,a)+1;
        k=k+1;
    end
end
% CnxMatrixSWp0001
% CnxMatrixSWp001
% CnxMatrixSWp01

sum(sum(CnxMatrixSWp0001))
sum(sum(CnxMatrixSWp001))
sum(sum(CnxMatrixSWp01))
end
%SmallWorldNetowrk%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

% if ShowParameters==1%ネットワークの性質を計算%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%     [ClusterCoefGMN ShortPathLenGMN]=ClusterCoef_ShortPathLen(Neurons,CnxMatrix)
%     [ClusterCoefRnd ShortPathLenRnd]=ClusterCoef_ShortPathLen(Neurons,CnxMatrixRnd)
%     [ClusterCoefReg ShortPathLenReg]=ClusterCoef_ShortPathLen(Neurons,CnxMatrixReg)
% 
%     [ClusterCoefSWp0001 ShortPathLenSWp0001]=ClusterCoef_ShortPathLen(Neurons,CnxMatrixSWp0001)
%     [ClusterCoefSWp001 ShortPathLenSWp001]=ClusterCoef_ShortPathLen(Neurons,CnxMatrixSWp001)
%     [ClusterCoefSWp01 ShortPathLenSWp01]=ClusterCoef_ShortPathLen(Neurons,CnxMatrixSWp01)
% 
%     %SmallWorldness
%     SWnessGMN=(ClusterCoefGMN/ClusterCoefRnd)/(ShortPathLenGMN/ShortPathLenRnd);
%     SWnessReg=(ClusterCoefReg/ClusterCoefRnd)/(ShortPathLenReg/ShortPathLenRnd);
% end


function [ClusterCoef ShortPathLen]=ClusterCoef_ShortPathLen(Neurons,CnxMatrix)

CnxMatrix(CnxMatrix>=1)=1;%２本以上の結合で結ばれているものは１本にする。
ClusterNum=trace(CnxMatrix*CnxMatrix*CnxMatrix)/6;
NumDouble=0;
for n=1:Neurons
    sumN=sum(CnxMatrix(n,:));%あるニューロンからの次数
%     NumD=length(perms([1:sumN]));
    NumD=length(combnk(1:sumN,2));
    NumDouble=NumDouble+NumD;
end
ClusterCoef=ClusterNum*3/NumDouble;
%ShortPath

CnxE=CnxMatrix+eye(Neurons);
CNX=CnxE;
Zero=length(CnxE(CnxE==0));
ZeroNum=[];
ShortPathL=[Neurons*Neurons-Neurons-Zero];%最初は距離１のペア数、
while Zero>0
%     ZeroNum=[ZeroNum Zero];
    SumSP=sum(ShortPathL);
    
%     NonZero=length(CnxMatrix(CnxMatrix~=0));
    CNX=CNX*CnxE;
    Zero=length(CNX(CNX==0));
    ShortPathL=[ShortPathL Neurons*Neurons-Neurons-Zero-SumSP];%最初は距離１のペア数、
end
Total=0;
for n=1:length(ShortPathL)
    Total=Total+ShortPathL(n)*n;
end
ShortPathLen=Total/(Neurons*Neurons-Neurons);

function VarMatrix=MakeVarMatrix(Neurons,Genes,Exp)

VarMatrix=zeros(Neurons,Genes);

% AllExp=Neurons*Exp;
GeneArray=zeros(1,Neurons*Exp);
for n=1:Genes
    GeneArray(floor((n-1)*(Neurons*Exp/Genes))+1:end)=n;
end

GeneExp=rand(1,Neurons*Exp);
[S idxG]=sort(GeneExp,'descend');

% VarArray=zeros(1,Neurons*Genes);

VarArray=GeneArray(idxG);

for n=1:Neurons
    for m=1:Exp
        GG=VarArray((n-1)*Exp+m);
        VarMatrix(n,GG)=VarMatrix(n,GG)+1;
    end
end


%         %歌探し％％％％％％％％％％％％％％％％％％％％％％％％％％％％％％％％％％％時間かかる
%         %歌探し％％％％％％％％％％％％％％％％％％％％％％％％％％％％％％％％％％％時間かかる
%         if Net==1
%             D=20;%Window幅
%             
%             OutMatrixE=OutMatrix;
%             OutMatrixE(idx(1:5),:)=0;
% 
%     %         Duration=12001:12050;
%             Score=zeros(1,num_Pilgrim/D);
%             for Dur=5001:D:7000%num_Pilgrim-D
%                 Duration=Dur:Dur+D-1;
%                 Temp=OutMatrixE(:,Duration);
%                 sum(sum(Temp))
%                 A=zeros(1,num_Pilgrim-D);
%                 for wid=1:num_Pilgrim-D
%                     A(wid)=sum(sum(Temp.*OutMatrixE(:,wid:wid+Duration(end)-Duration(1))));
%                 end
%     %             figure
%     %             bar(A);zoom xon;
% 
%                 [S ind]=sort(A,'descend');
%     %             figure
%     %             image(OutMatrixE(:,Duration)*255);colormap(gray);
%     %             zoom xon;
%     % 
%     %             figure
%     %             image(OutMatrixE(:,ind(2):ind(2)+D-1)*255);colormap(gray);
%     %             zoom xon;
%     % 
%     %             figure
%     %             image(OutMatrixE(:,Duration).*OutMatrixE(:,ind(2):ind(2)+D-1)*255);colormap(gray);
%     %             zoom xon;
%     %             figure
%     %             image(OutMatrixE(:,Duration).*OutMatrixE(:,ind(3):ind(3)+D-1)*255);colormap(gray);
%     %             zoom xon;
%     %             figure
%     %             image(OutMatrixE(:,Duration).*OutMatrixE(:,ind(4):ind(4)+D-1)*255);colormap(gray);
%     %             zoom xon;
% 
%                 A2=OutMatrixE(:,Duration).*OutMatrixE(:,ind(2):ind(2)+D-1);
%                 A3=OutMatrixE(:,Duration).*OutMatrixE(:,ind(3):ind(3)+D-1);
%                 A4=OutMatrixE(:,Duration).*OutMatrixE(:,ind(4):ind(4)+D-1);
%                 Score((Dur-1)/D+1)=sum(sum(A2.*A3.*A4));
%             end
%             figure
%             bar(Score);zoom xon
%             DurMax=(find(Score==max(Score))-1)*D+1;
% 
% 
%             Duration=DurMax:DurMax+D-1;
%              Temp=OutMatrixE(:,Duration);
%             sum(sum(Temp))
%             A=zeros(1,num_Pilgrim-D);
%             for wid=1:num_Pilgrim-D
%                 A(wid)=sum(sum(Temp.*OutMatrixE(:,wid:wid+Duration(end)-Duration(1))));
%             end
%             figure
%             bar(A);zoom xon;
% 
%             [S ind]=sort(A,'descend');
%             figure
%             image(OutMatrixE(:,Duration)*255);colormap(gray);
%             title('Original -5');
%             zoom xon;
% 
%             figure
%             image(OutMatrixE(:,ind(2):ind(2)+D-1)*255);colormap(gray);
%             title('TopSimilar -5');
%             zoom xon;
% 
%             figure
%             image(OutMatrixE(:,Duration).*OutMatrixE(:,ind(2):ind(2)+D-1)*255);colormap(gray);
%             title('OriginalxTop -5');
%             zoom xon;
%             figure
%             image(OutMatrixE(:,Duration).*OutMatrixE(:,ind(3):ind(3)+D-1)*255);colormap(gray);
%             title('OriginalxSecond -5');
%             zoom xon;
%             figure
%             image(OutMatrixE(:,Duration).*OutMatrixE(:,ind(4):ind(4)+D-1)*255);colormap(gray);
%             title('OriginalxThird -5');
%             zoom xon;
%             
%             figure
%             image(OutMatrixE(:,ind(2):ind(2)+D-1).*OutMatrixE(:,ind(3):ind(3)+D-1).*OutMatrixE(:,Duration)*255);colormap(gray);
%             title('OriginalxTopxSecond -5');
%             zoom xon;
%             figure
%             image(OutMatrix(:,ind(2):ind(2)+D-1).*OutMatrix(:,ind(3):ind(3)+D-1).*OutMatrix(:,Duration)*255);colormap(gray);
%             title('OriginalxTopxSecond');
%             zoom xon;      
%             
%             figure
%             image(OutMatrix(:,Duration)*255);colormap(gray);title('Original');
%             zoom xon;
% 
%             figure
%             image(OutMatrix(:,ind(2):ind(2)+D-1)*255);colormap(gray);title('TopSimilar');
%             zoom xon;            
%         end
%         %歌探し％％％％％％％％％％％％％％％％％％％％％％％％％％％％％％％％％％％時間かかる
%         %歌探し％％％％％％％％％％％％％％％％％％％％％％％％％％％％％％％％％％％時間かかる