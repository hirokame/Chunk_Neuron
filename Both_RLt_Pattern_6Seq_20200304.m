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
                  TargetArray=Positive_NegativeUnit(x,[2:11]);    %%%%%%Positive�����𔲂��o���F�ꍇ�����ɂ�����
                  
                   if TargetArray==[1,1,1,1,1,1,0,0,0,0];
                       RLtouchPoint(1)=RLtouchPoint(1)+1;              %%%%%123456��
                       RLtouchFire(1)=RLtouchFire(1)+Positive_NegativeUnit(x,1);  %%%%%123456���ΐ�
                   end
                   
                   if TargetArray==[0,1,1,1,1,1,1,0,0,0];
                       RLtouchPoint(2)=RLtouchPoint(2)+1;              %%%%%234567��
                       RLtouchFire(2)=RLtouchFire(2)+Positive_NegativeUnit(x,1);  %%%%%234567���ΐ�
                   end
                   
                   if TargetArray==[0,0,1,1,1,1,1,1,0,0];
                       RLtouchPoint(3)=RLtouchPoint(3)+1;              %%%%%345678��
                       RLtouchFire(3)=RLtouchFire(3)+Positive_NegativeUnit(x,1);  %%%%%345678���ΐ�
                   end
                   
                   if TargetArray==[0,0,0,1,1,1,1,1,1,0];
                       RLtouchPoint(4)=RLtouchPoint(4)+1;              %%%%%456789��
                       RLtouchFire(4)=RLtouchFire(4)+Positive_NegativeUnit(x,1);  %%%%%456789�@���ΐ�
                   end
                   
                   if TargetArray==[0,0,0,0,1,1,1,1,1,1];
                       RLtouchPoint(5)=RLtouchPoint(5)+1;              %%%%%5678910��
                       RLtouchFire(5)=RLtouchFire(5)+Positive_NegativeUnit(x,1);  %%%%%5678910���ΐ�
                   end
                   
                   
              
               end
               
               
               
               
               
               RLtouchFR=RLtouchFire./(RLtouchPoint*10);     %%%%%���Εp�x�ɕϊ�
               
               RLtouchUnit=[RLtouchUnit;RLtouchFR];          %%%%�T�A�� �U�p�^�[���܂ł̔��Εp�x��ۑ�
               
               RLtouchPointUnit=[RLtouchPointUnit;RLtouchPoint];      %%%%% �񐔂��ۑ�
               
           end   
       end
    end
end


MeanRLtouchUnit=nanmean(RLtouchUnit);  %%%%%�񂲂Ƃɕ��ρANaN�͂̂���
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
