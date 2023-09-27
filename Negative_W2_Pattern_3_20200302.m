function Negative_W2_Pattern_3_20200302
path=['C:\Users\C238\Desktop\touchcellLtRt_terashita'];
cd(path);

LS=ls;
LtWFRUnit=[];
RtWFRUnit=[];
LtW12Point=0;
LtW12Fire=0;
LtW23Point=0;
LtW23Fire=0;
LtW34Point=0;
LtW34Fire=0;
LtW45Point=0;
LtW45Fire=0;
LtW13Point=0;
LtW13Fire=0;
LtW14Point=0;
LtW14Fire=0;
LtW15Point=0;
LtW15Fire=0;
LtW24Point=0;
LtW24Fire=0;
LtW25Point=0;
LtW25Fire=0;
LtW35Point=0;
LtW35Fire=0;

RtW12Point=0;
RtW12Fire=0;
RtW23Point=0;
RtW23Fire=0;
RtW34Point=0;
RtW34Fire=0;
RtW45Point=0;
RtW45Fire=0;
RtW13Point=0;
RtW13Fire=0;
RtW14Point=0;
RtW14Fire=0;
RtW15Point=0;
RtW15Fire=0;
RtW24Point=0;
RtW24Fire=0;
RtW25Point=0;
RtW25Fire=0;
RtW35Point=0;
RtW35Fire=0;



LtouchN4_Unit=[];
LtouchN3_Unit=[];
LtouchN2_Unit=[];
LtouchN1_Unit=[];
LtouchN0_Unit=[];

RtouchN4_Unit=[];
RtouchN3_Unit=[];
RtouchN2_Unit=[];
RtouchN1_Unit=[];
RtouchN0_Unit=[];
for i=1:length(LS(:,1))
    TrimFolder=strtrim(LS(i,:));
    if ~strcmp(TrimFolder,'.') && ~strcmp(TrimFolder,'..') && isempty(strfind(TrimFolder,'.mat')) && isempty(strfind(TrimFolder,'.bmp'));
       CdFolder=[path,'\',TrimFolder];
       cd(CdFolder);
       LS1=ls;
       for j=1:length(LS1(:,1))
           TrimFolder2=strtrim(LS1(j,:));
           if length(TrimFolder2)>22 && strcmp(TrimFolder2(end-21:end),'SpikeOnOffRtLtUnit.mat');
               load(TrimFolder2);
               LtouchUnit=[LtouchSpikeOnUnit;[zeros(length(LtouchSpikeOffUnit(:,1)),1) LtouchSpikeOffUnit]]; %%%% SpikeOffUnitÇÃëOóÒÇ…î≠âŒêîóÒÇí«â¡ÇµÇƒSpikeOnUnitÇ∆òAåãÅBSpikeOfféûÇÃî≠âŒêîÇÉ[ÉçÇ…ê›íË
%                LtouchUnitPositive= LtouchUnit(:,[1:6]);                                         
               RtouchUnit=[RtouchSpikeOnUnit;[zeros(length(RtouchSpikeOffUnit(:,1)),1) RtouchSpikeOffUnit]];
%                RtouchUnitPositive= RtouchUnit(:,[1:6]);
              
                %%%%Ltouch
               for k=1:length(LtouchUnit(:,1))
                   IndexNegativeNum=find( LtouchUnit(k,[7:10])==-1);
                   IndexNegativeNum
                   if length(IndexNegativeNum)==4;
                      LtouchN4_Unit=[LtouchN4_Unit;LtouchUnit(k,:)];
                   end
                   
                   if length(IndexNegativeNum)==3;
                       LtouchN3_Unit=[LtouchN3_Unit;LtouchUnit(k,:)];
                   end
                   
                   if length(IndexNegativeNum)==2;
                      LtouchN2_Unit=[LtouchN2_Unit;LtouchUnit(k,:)];
                   end
                   
                   if length(IndexNegativeNum)==1;
                      LtouchN1_Unit=[LtouchN1_Unit;LtouchUnit(k,:)];
                   end
                   
                   if length(IndexNegativeNum)==0;
                      LtouchN0_Unit=[LtouchN0_Unit;LtouchUnit(k,:)];
                   end
               end
               
               %%%%%%Rtouch
               for k=1:length(RtouchUnit(:,1))
                   IndexNegativeNum=find(RtouchUnit(k,[7:10])==-1);
                   IndexNegativeNum
                   if length(IndexNegativeNum)==4;
                      RtouchN4_Unit=[RtouchN4_Unit;RtouchUnit(k,:)];
                   end
                   
                   if length(IndexNegativeNum)==3;
                       RtouchN3_Unit=[RtouchN3_Unit;RtouchUnit(k,:)];
                   end
                   
                   if length(IndexNegativeNum)==2;
                      RtouchN2_Unit=[RtouchN2_Unit;RtouchUnit(k,:)];
                   end
                   
                   if length(IndexNegativeNum)==1;
                      RtouchN1_Unit=[RtouchN1_Unit;RtouchUnit(k,:)];
                   end
                   
                   if length(IndexNegativeNum)==0;
                      RtouchN0_Unit=[RtouchN0_Unit;RtouchUnit(k,:)];
                   end
               end
               
               
           end   
       end
    end
end


[LtWFRUnitN4,RtWFRUnitN4]=function_W2_Pattern_3_20200302(LtouchN4_Unit,RtouchN4_Unit) 




%%%% N4
MeanLtWFRUnitN4=[];
StdLtWFRUnitN4=[];
for i=1:length(LtWFRUnitN4(1,:))
    MeanLtWFRUnitN4=[MeanLtWFRUnitN4 nanmean(LtWFRUnitN4(:,i))];
    StdLtWFRUnitN4=[StdLtWFRUnitN4 nanstd(LtWFRUnitN4(:,i))];
end

MeanRtWFRUnitN4=[];
StdRtWFRUnitN4=[];
for i=1:length(RtWFRUnitN4(1,:))
    MeanRtWFRUnitN4=[MeanRtWFRUnitN4 nanmean(RtWFRUnitN4(:,i))];
    StdRtWFRUnitN4=[StdRtWFRUnitN4 nanstd(RtWFRUnitN4(:,i))];
end



%%%N3
MeanLtWFRUnitN3=[];
StdLtWFRUnitN3=[];
for i=1:length(LtWFRUnitN3(1,:))
    MeanLtWFRUnitN3=[MeanLtWFRUnitN3 nanmean(LtWFRUnitN3(:,i))];
    StdLtWFRUnitN3=[StdLtWFRUnitN3 nanstd(LtWFRUnitN3(:,i))];
end

MeanRtWFRUnitN3=[];
StdRtWFRUnitN3=[];
for i=1:length(RtWFRUnitN3(1,:))
    MeanRtWFRUnitN3=[MeanRtWFRUnitN3 nanmean(RtWFRUnitN3(:,i))];
    StdRtWFRUnitN3=[StdRtWFRUnitN3 nanstd(RtWFRUnitN3(:,i))];
end


%%%%%N2
MeanLtWFRUnitN2=[];
StdLtWFRUnitN2=[];
for i=1:length(LtWFRUnitN2(1,:))
    MeanLtWFRUnitN2=[MeanLtWFRUnitN2 nanmean(LtWFRUnitN2(:,i))];
    StdLtWFRUnitN2=[StdLtWFRUnitN2 nanstd(LtWFRUnitN2(:,i))];
end

MeanRtWFRUnitN2=[];
StdRtWFRUnitN2=[];
for i=1:length(RtWFRUnitN2(1,:))
    MeanRtWFRUnitN2=[MeanRtWFRUnitN2 nanmean(RtWFRUnitN2(:,i))];
    StdRtWFRUnitN2=[StdRtWFRUnitN2 nanstd(RtWFRUnitN2(:,i))];
end



%%%%%N1
MeanLtWFRUnitN1=[];
StdLtWFRUnitN1=[];
for i=1:length(LtWFRUnitN1(1,:))
    MeanLtWFRUnitN1=[MeanLtWFRUnitN1 nanmean(LtWFRUnitN1(:,i))];
    StdLtWFRUnitN1=[StdLtWFRUnitN1 nanstd(LtWFRUnitN1(:,i))];
end

MeanRtWFRUnitN1=[];
StdRtWFRUnitN1=[];
for i=1:length(RtWFRUnitN1(1,:))
    MeanRtWFRUnitN1=[MeanRtWFRUnitN1 nanmean(RtWFRUnitN1(:,i))];
    StdRtWFRUnitN1=[StdRtWFRUnitN1 nanstd(RtWFRUnitN1(:,i))];
end


%%%%%%N0
MeanLtWFRUnitN0=[];
StdLtWFRUnitN0=[];
for i=1:length(LtWFRUnitN0(1,:))
    MeanLtWFRUnitN0=[MeanLtWFRUnitN0 nanmean(LtWFRUnitN0(:,i))];
    StdLtWFRUnitN0=[StdLtWFRUnitN0 nanstd(LtWFRUnitN0(:,i))];
end

MeanRtWFRUnitN0=[];
StdRtWFRUnitN0=[];
for i=1:length(RtWFRUnitN0(1,:))
    MeanRtWFRUnitN0=[MeanRtWFRUnitN0 nanmean(RtWFRUnitN0(:,i))];
    StdRtWFRUnitN0=[StdRtWFRUnitN0 nanstd(RtWFRUnitN0(:,i))];
end




x=1:10;
LtRtW2FRUnit=figure
subplot(1,2,1);
bar(x,MeanLtWFRUnit,0.5);hold on
set(gca,'xticklabel',{'12','23','34','45','13','14','15','24','25','35'});

errorbar(x,MeanLtWFRUnit,StdLtWFRUnit,'o','MarkerSize',0.2);
title('MeanLtWFRUnit_Pattern3')


subplot(1,2,2);
bar(x,MeanRtWFRUnit,0.5);hold on
set(gca,'xticklabel',{'12','23','34','45','13','14','15','24','25','35'});

errorbar(x,MeanRtWFRUnit,StdRtWFRUnit,'o','MarkerSize',0.2);
title('MeanRtWFRUnit_Pattern3')

figname=['LtRtFR_W2_Pattern3.bmp'];
cd(path)
saveas(LtRtW2FRUnit,figname);


