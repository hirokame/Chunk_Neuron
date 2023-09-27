function MakeMultimerProb20160830

%総当たりで100000回とか多量体比較をして、そのペアが結合を作る確率を算出する戦法

% %配線の方法　C
% %相互認識の回数で指定する場合、C=0、細胞ペアあたりの回数をMatchingで指定。
% %結合数を指定する場合、C=1、本数はConnectionsで指定。多重辺をすべてカウントする。
% %結合細胞の割合を指定する場合、C=2、割合はPercentで指定。多重辺を1としてカウントする。
% % C=2;

%ConnectionsとPercentが以下の数値になったらネットワークを保存
% Connections=[100 200];%[500 1000 1500 2000];%
% Cnct=1;
% Percent=[1 2];%[5 10 15 20];%
% Prc=1;

% Matching=1000000;%多量体比較回数 M4
Matching=1000;%多量体比較回数 M3
% Matching=10000;%多量体比較回数 M2

%遺伝子発現様式　1:重複なし、monoallele、2:biallel、・・・、-1:重複有り
Repeat=1;

Multimer=1;
Neurons=10000;
Genes=50;
Exp=5;

ExpMatrix1=[1 2 3 4 5;1 6 7 8 9];
ExpMatrix2=[1 2 3 4 5;1 2 7 8 9];
ExpMatrix3=[1 2 3 4 5;1 2 3 8 9];
ExpMatrix4=[1 2 3 4 5;1 2 3 4 9];
ExpMatrix5=[1 2 3 4 5;1 2 3 4 5];

NumConnection=zeros(Exp,Matching);
for n=1:5
    eval(['ExpMatrix=ExpMatrix',int2str(n)]);
    for m=1:100000
        [n m]
        Multimer1=[];
        for k=1:Multimer
            Multimer1=[Multimer1;ExpMatrix(1,ceil(rand(1,Matching)*Exp))];
%             Multimer1=[ExpMatrix(1,ceil(rand(1,Matching)*Exp));ExpMatrix(1,ceil(rand(1,Matching)*Exp));ExpMatrix(1,ceil(rand(1,Matching)*Exp));ExpMatrix(1,ceil(rand(1,Matching)*Exp))];
        end
        Multimer1=sort(Multimer1,1,'ascend');

        Multimer2=[];
        for k=1:Multimer
            Multimer2=[Multimer2;ExpMatrix(2,ceil(rand(1,Matching)*Exp))];%;ExpMatrix(2,ceil(rand(1,Matching)*Exp));ExpMatrix(2,ceil(rand(1,Matching)*Exp));ExpMatrix(2,ceil(rand(1,Matching)*Exp))];
        end
        Multimer2=sort(Multimer2,1,'ascend');


        Sum=sum(abs(Multimer1- Multimer2),1);
        A=length(Sum(Sum==0));

        NumConnection(n,m)=length(Sum(Sum==0));
    end
end

SaveName=strcat('MultimerConProb11M',num2str(Multimer),'_E',num2str(Exp),'_R',num2str(Repeat),'_Match',num2str(Matching));
save(SaveName,'NumConnection');
