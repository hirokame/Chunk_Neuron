function Both_RLt_Pattern_6Seq_20200304

path=['C:\Users\C238\Desktop\touchcellLtRt_terashita'];
cd(path);

LS=ls;

RLtouchPoint=zeros(1,5);
RLtouchFire=zeros(1,5);
X=[];

RLtouchUnit=[];

RLtouchPointUnit=[];


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
              
               
               for x=1:length(Positive_NegativeUnit(:,1))
                  TargetArray=Positive_NegativeUnit(x,[2:11]);    %%%%%%Positive部分を抜き出し：場合分けにかける
                  
                   if TargetArray==[1,1,1,1,1,1,0,0,0,0];
                       RLtouchPoint(1)=RLtouchPoint(1)+1;              %%%%%123456回数
                       RLtouchFire(1)=RLtouchFire(1)+Positive_NegativeUnit(x,1);  %%%%%123456発火数
                   end
                   
                   if TargetArray==[0,1,1,1,1,1,1,0,0,0];
                       RLtouchPoint(2)=RLtouchPoint(2)+1;              %%%%%234567回数
                       RLtouchFire(2)=RLtouchFire(2)+Positive_NegativeUnit(x,1);  %%%%%234567発火数
                   end
                   
                   if TargetArray==[0,0,1,1,1,1,1,1,0,0];
                       RLtouchPoint(3)=RLtouchPoint(3)+1;              %%%%%345678回数
                       RLtouchFire(3)=RLtouchFire(3)+Positive_NegativeUnit(x,1);  %%%%%345678発火数
                   end
                   
                   if TargetArray==[0,0,0,1,1,1,1,1,1,0];
                       RLtouchPoint(4)=RLtouchPoint(4)+1;              %%%%%456789回数
                       RLtouchFire(4)=RLtouchFire(4)+Positive_NegativeUnit(x,1);  %%%%%456789　発火数
                   end
                   
                   if TargetArray==[0,0,0,0,1,1,1,1,1,1];
                       RLtouchPoint(5)=RLtouchPoint(5)+1;              %%%%%5678910回数
                       RLtouchFire(5)=RLtouchFire(5)+Positive_NegativeUnit(x,1);  %%%%%5678910発火数
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

MeanRLtouchPointUnit=nanmean(RLtouchPointUnit);

x=1:5;
Fig1=figure;
bar(x,MeanRLtouchUnit,0.5);hold on
errorbar(x,MeanRLtouchUnit,StdRLtouchUnit,'o','MarkerSize',0.2);
set(gca,'xticklabel',{'123456','234567','345678','456789','5678910'});
title('MeanSumRLtouchUnit_Pattern_Sum');


figname=['Both_LtRt_Pattern_6Seq.bmp'];
cd(path)
saveas(Fig1,figname);


% figure
% subplot(1,2,1);
% bar(x,MeanSumRLtouchPointUnit,0.5);
% 
% subplot(1,2,2);
% bar(x,MeanSumRtouchPointUnit,0.5);
