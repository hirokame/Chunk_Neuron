function AllCombination_W5_20200306



path=['C:\Users\C238\Desktop\touchcellLtRt_terashita'];
cd(path);


Index5=[];
Index6=[];
Index56=[];
SeqIndex=[];
Seq56Index=[]; 
Array=linspace(1,10,10);
CombinationIndex = nchoosek(Array,5);

for i=1:length(CombinationIndex(:,1))
    Target=CombinationIndex(i,:);
    if ~isempty(find(Target==5));
       Index5=[Index5 i];
    end
    if ~isempty(find(Target==6));
        Index6=[Index6 i];
    end
    if ~isempty(find(Target==6)) && ~isempty(find(Target==5));
       Index56=[Index56 i]; 
    end
    
    Difference=diff(Target);
    Indexdiff=find(Difference==1);
    if length(Indexdiff)==length(Target)-1;
       SeqIndex=[SeqIndex i]; 
    end
    if length(Indexdiff)==length(Target)-1 && ~isempty(find(Target==6)) && ~isempty(find(Target==5));
       Seq56Index=[Seq56Index i]; 
    end
end

RLtouchPoint=zeros(1,length(CombinationIndex(:,1)));
RLtouchFire=zeros(1,length(CombinationIndex(:,1)));


RLtouchUnit=[];

RLtouchPointUnit=[];




LS=ls;



for i=1:length(LS(:,1))
    TrimFolder=strtrim(LS(i,:));
    if ~strcmp(TrimFolder,'.') && ~strcmp(TrimFolder,'..') && isempty(strfind(TrimFolder,'.mat')) && isempty(strfind(TrimFolder,'.bmp'));
       CdFolder=[path,'\',TrimFolder];
       cd(CdFolder);
       LS1=ls;
       for j=1:length(LS1(:,1))
           TrimFolder2=strtrim(LS1(j,:));
           if length(TrimFolder2)>18 && strcmp(TrimFolder2(end-17:end),'Both_LtRt_Unit.mat');
               load(TrimFolder2);               
               PositiveUnit=Positive_NegativeUnit(:,[1 2:11]);
               
               for x=1:length(PositiveUnit(:,1))
                   for y=1:length(CombinationIndex)
                       MatchArray=zeros(1,10);
                       MatchArray(CombinationIndex(y,:))=MatchArray(CombinationIndex(y,:))+1;
                       if PositiveUnit(x,[2:11])== MatchArray;
                           RLtouchPoint(y)=RLtouchPoint(y)+1;
                           RLtouchFire(y)=RLtouchFire(y)+PositiveUnit(x,1);
                       end
                   end
               end
               
               RLtouchFR=RLtouchFire./(RLtouchPoint*10);     %%%%%発火頻度に変換
               
               RLtouchUnit=[RLtouchUnit;RLtouchFR];          %%%%５連続 ６パターンまでの発火頻度を保存
               
               RLtouchPointUnit=[RLtouchPointUnit;RLtouchPoint];      %%%%% 回数も保存
           end   
       end
    end
end

MeanRLtouchUnit=nanmean(RLtouchUnit);  %%%%%列ごとに平均、NaNはのぞく
StdRLtouchUnit=nanstd(RLtouchUnit);

% MeanRLtouchPointUnit=nanmean(RLtouchPointUnit);

cd(path)

filename=['Both_LtRt_Pattern_W5.mat'];

save(filename,'CombinationIndex','RLtouchUnit','Index5','Index6','Index56','SeqIndex','Seq56Index','MeanRLtouchUnit','StdRLtouchUnit');

x=1:length(CombinationIndex(:,1));
Fig1=figure;
b=bar(x,MeanRLtouchUnit,0.5,'k');hold on
% b(Index5).FaceColor = [1 0 0];
% b(Index6).EdgeColor = [0 1 0];
% b(Index56).EdgeColor = [0 0 1];
% b(SeqIndex).EdgeColor = [0 1 1];
% b(Seq56Index).EdgeColor = [1 0 1];
errorbar(x,MeanRLtouchUnit,StdRLtouchUnit,'o','MarkerSize',0.2);
% set(gca,'xticklabel',num2str(CombinationIndex(x,:)));
title('Both_RLtouchUnit_Pattern_W5');


%%%%%%%並び替えバージョン
[SortMeanRLtouchUnit,IndexSort]=sort(MeanRLtouchUnit,'descend');
SortCombinationIndex=CombinationIndex(IndexSort);
x=1:length(SortCombinationIndex(:,1));
Fig1=figure;
b=bar(x,SortMeanRLtouchUnit,0.5,'k');hold on
% b(Index5).FaceColor = [1 0 0];
% b(Index6).EdgeColor = [0 1 0];
% b(Index56).EdgeColor = [0 0 1];
% b(SeqIndex).EdgeColor = [0 1 1];
% b(Seq56Index).EdgeColor = [1 0 1];





figname=['Both_LtRt_Pattern_W5.bmp'];
cd(path)
saveas(Fig1,figname);

% Index5=[];
% Index6=[];
% Index56=[];
% SeqIndex=[];
% Seq56Index=[]; 
% figure
% subplot(1,2,1);
% bar(x,MeanSumRLtouchPointUnit,0.5);
% 
% subplot(1,2,2);
% bar(x,MeanSumRtouchPointUnit,0.5);
