function MultimerConnProb20160527
%MakeMultimerProb20160517.m(Exp=5の場合）
%MakeMultimerProb20160526.m（Exp=10の場合）
%により一致数ごとにファイルを作成
%それを用いてMultimerConProbAllファイルを作成する。Matching10万回の結合数が保存される。
%MakeMultimerNet_Group20160520.mでネットワーク作成

clear all;
close all;

Exp=5;

% load MultimerConProb11M2_E5_R-1_Match10000
load MultimerConProb11M1_E5_R1_Match1000

NumConnAll=zeros(10,100000);
for n=1:Exp%=5の場合
%     eval(['load MultimerConProb',int2str(n),'M4_E10_R1_Match1000000']);

    NumConnAll(n,:)=NumConnection(n,:);
    
% end
% 
% 
% % NumConnAll=NumConnAll(:,1:100000);
% 
% for n=1:10
    A=NumConnAll(n,:);
    NumConnSort(n,:)=sort(A,'Ascend');
    C=cumsum(NumConnSort(n,:));
%     D=C/max(C);
    CumSumProb(n,:)=C/max(C);
    
    R=rand;
    E=CumSumProb(CumSumProb<R);
    F=length(E);
    G=NumConnSort(F);
    
    
    figure
    [a b]=hist(NumConnAll(n,:),1000);hold on
    bar(b,a);
end
save MultimerConProbAllM1_E5_R1_Match1000 NumConnAll NumConnSort CumSumProb