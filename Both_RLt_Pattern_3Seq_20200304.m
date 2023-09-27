function Both_RLt_Pattern_3Seq_20200304

path=['C:\Users\C238\Desktop\touchcellLtRt_terashita'];
cd(path);

LS=ls;

RLtouchPoint=zeros(1,8);
RLtouchFire=zeros(1,8);
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
                  
                   if TargetArray==[1,1,1,0,0,0,0,0,0,0];
                       RLtouchPoint(1)=RLtouchPoint(1)+1;              %%%%%12345��
                       RLtouchFire(1)=RLtouchFire(1)+Positive_NegativeUnit(x,1);  %%%%%12345���ΐ�
                   end
                   
                   if TargetArray==[0,1,1,1,0,0,0,0,0,0];
                       RLtouchPoint(2)=RLtouchPoint(2)+1;              %%%%%23456��
                       RLtouchFire(2)=RLtouchFire(2)+Positive_NegativeUnit(x,1);  %%%%%23456���ΐ�
                   end
                   
                   if TargetArray==[0,0,1,1,1,0,0,0,0,0];
                       RLtouchPoint(3)=RLtouchPoint(3)+1;              %%%%%34567��
                       RLtouchFire(3)=RLtouchFire(3)+Positive_NegativeUnit(x,1);  %%%%%34567���ΐ�
                   end
                   
                   if TargetArray==[0,0,0,1,1,1,0,0,0,0];
                       RLtouchPoint(4)=RLtouchPoint(4)+1;              %%%%%45678��
                       RLtouchFire(4)=RLtouchFire(4)+Positive_NegativeUnit(x,1);  %%%%%45678�@���ΐ�
                   end
                   
                   if TargetArray==[0,0,0,0,1,1,1,0,0,0];
                       RLtouchPoint(5)=RLtouchPoint(5)+1;              %%%%%56789��
                       RLtouchFire(5)=RLtouchFire(5)+Positive_NegativeUnit(x,1);  %%%%%56789���ΐ�
                   end
                   
                   if TargetArray==[0,0,0,0,0,1,1,1,0,0];
                       RLtouchPoint(6)=RLtouchPoint(6)+1;              %%%%%678910��
                       RLtouchFire(6)=RLtouchFire(6)+Positive_NegativeUnit(x,1);  %%%%%678910���ΐ�
                   end
              
                   if TargetArray==[0,0,0,0,0,0,1,1,1,0];
                       RLtouchPoint(7)=RLtouchPoint(7)+1;              %%%%%678910��
                       RLtouchFire(7)=RLtouchFire(7)+Positive_NegativeUnit(x,1);  %%%%%678910���ΐ�
                   end
                   
                   if TargetArray==[0,0,0,0,0,0,0,1,1,1];
                       RLtouchPoint(8)=RLtouchPoint(8)+1;              %%%%%678910��
                       RLtouchFire(8)=RLtouchFire(8)+Positive_NegativeUnit(x,1);  %%%%%678910���ΐ�
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

x=1:8;
Fig1=figure;
bar(x,MeanRLtouchUnit,0.5);hold on
errorbar(x,MeanRLtouchUnit,StdRLtouchUnit,'o','MarkerSize',0.2);
set(gca,'xticklabel',{'123','234','345','456','567','678','789','8910'});
title('MeanSumRLtouchUnit_Pattern_3Seq');


figname=['Both_LtRt_Pattern_3Seq.bmp'];
cd(path)
saveas(Fig1,figname);


% figure
% subplot(1,2,1);
% bar(x,MeanSumRLtouchPointUnit,0.5);
% 
% subplot(1,2,2);
% bar(x,MeanSumRtouchPointUnit,0.5);
