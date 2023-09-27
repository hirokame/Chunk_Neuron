function NW2_Pattern_3_20200302
path=['C:\Users\C238\Desktop\touchcellLtRt_terashita'];
cd(path);

LS=ls;
LtNWFRUnit=[];
RtNWFRUnit=[];
LtNW12Point=0;
LtNW12Fire=0;
LtNW23Point=0;
LtNW23Fire=0;
LtNW34Point=0;
LtNW34Fire=0;
LtNW13Point=0;
LtNW13Fire=0;
LtNW14Point=0;
LtNW14Fire=0;
LtNW24Point=0;
LtNW24Fire=0;

RtNW12Point=0;
RtNW12Fire=0;
RtNW23Point=0;
RtNW23Fire=0;
RtNW34Point=0;
RtNW34Fire=0;
RtNW13Point=0;
RtNW13Fire=0;
RtNW14Point=0;
RtNW14Fire=0;
RtNW24Point=0;
RtNW24Fire=0;

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
               LtouchUnitNegative= LtouchUnit(:,[1 7:10]);                                         
               RtouchUnit=[RtouchSpikeOnUnit;[zeros(length(RtouchSpikeOffUnit(:,1)),1) RtouchSpikeOffUnit]];
               RtouchUnitNegative= RtouchUnit(:,[1 7:10]);
              
               
               %Ltouch
               for x=1:length(LtouchUnitNegative(:,1));
                   if LtouchUnitNegative(x,[2:5])==[-1,-1,0,0];
                      LtNW12Point=LtNW12Point+1;
                      LtNW12Fire=LtNW12Fire+LtouchUnitNegative(x,1);
                   end
                   
                    if LtouchUnitNegative(x,[2:5])==[0,-1,-1,0];
                      LtNW23Point=LtNW23Point+1;
                      LtNW23Fire=LtNW23Fire+LtouchUnitNegative(x,1);
                    end
                   
                   if LtouchUnitNegative(x,[2:5])==[0,0,-1,-1];
                      LtNW34Point=LtNW34Point+1;
                      LtNW34Fire=LtNW34Fire+LtouchUnitNegative(x,1);
                   end
                   
                   if LtouchUnitNegative(x,[2:5])==[-1,0,0,-1];
                      LtNW14Point=LtNW14Point+1;
                      LtNW14Fire=LtNW14Fire+LtouchUnitNegative(x,1);
                   end
                   
                   if LtouchUnitNegative(x,[2:5])==[-1,0,-1,0];
                      LtNW13Point=LtNW13Point+1;
                      LtNW13Fire=LtNW13Fire+LtouchUnitNegative(x,1);
                   end
                   
                   if LtouchUnitNegative(x,[2:5])==[0,-1,0,-1];
                      LtNW24Point=LtNW24Point+1;
                      LtNW24Fire=LtNW24Fire+LtouchUnitNegative(x,1);
                   end
                 
               end
               
               LtWFR=[LtNW12Fire/(LtNW12Point*10),LtNW23Fire/(LtNW23Point*10),LtNW34Fire/(LtNW34Point*10),LtNW13Fire/(LtNW13Point*10)...
                   ,LtNW14Fire/(LtNW14Point*10),LtNW24Fire/(LtNW24Point*10)];
               
               %Rtouch
                for x=1:length(RtouchUnitNegative(:,1));
                   if RtouchUnitNegative(x,[2:5])==[-1,-1,0,0];
                      RtNW12Point=LtNW12Point+1;
                      RtNW12Fire=RtNW12Fire+RtouchUnitNegative(x,1);
                   end
                   
                    if RtouchUnitNegative(x,[2:5])==[0,-1,-1,0];
                      RtNW23Point=RtNW23Point+1;
                      RtNW23Fire=RtNW23Fire+RtouchUnitNegative(x,1);
                    end
                   
                   if RtouchUnitNegative(x,[2:5])==[0,0,-1,-1];
                      RtNW34Point=RtNW34Point+1;
                      RtNW34Fire=RtNW34Fire+RtouchUnitNegative(x,1);
                   end
                   
                   
                   if RtouchUnitNegative(x,[2:5])==[-1,0,0,-1];
                      RtNW14Point=RtNW14Point+1;
                      RtNW14Fire=RtNW14Fire+RtouchUnitNegative(x,1);
                   end
                   
                   if RtouchUnitNegative(x,[2:5])==[-1,0,-1,0];
                      RtNW13Point=RtNW13Point+1;
                      RtNW13Fire=RtNW13Fire+RtouchUnitNegative(x,1);
                   end
                   
                   if RtouchUnitNegative(x,[2:5])==[0,-1,0,-1];
                      RtNW24Point=RtNW24Point+1;
                      RtNW24Fire=RtNW24Fire+RtouchUnitNegative(x,1);
                   end
                   
                end
               RtWFR=[RtNW12Fire/(RtNW12Point*10),RtNW23Fire/(RtNW23Point*10),RtNW34Fire/(RtNW34Point*10),RtNW13Fire/(RtNW13Point*10)...
                   ,RtNW14Fire/(RtNW14Point*10),RtNW24Fire/(RtNW24Point*10)];
               
               
                LtNWFRUnit=[LtNWFRUnit;LtWFR];
                RtNWFRUnit=[RtNWFRUnit;RtWFR];
                
           
           end   
       end
    end
end


MeanLtWFRUnit=[];
StdLtWFRUnit=[];
for i=1:length(LtNWFRUnit(1,:))
    MeanLtWFRUnit=[MeanLtWFRUnit nanmean(LtNWFRUnit(:,i))];
    StdLtWFRUnit=[StdLtWFRUnit nanstd(LtNWFRUnit(:,i))];
end

MeanRtWFRUnit=[];
StdRtWFRUnit=[];
for i=1:length(RtNWFRUnit(1,:))
    MeanRtWFRUnit=[MeanRtWFRUnit nanmean(RtNWFRUnit(:,i))];
    StdRtWFRUnit=[StdRtWFRUnit nanstd(RtNWFRUnit(:,i))];
end



x=1:6;
LtRtNW2FRUnit=figure
subplot(1,2,1);
bar(x,MeanLtWFRUnit,0.5);hold on
set(gca,'xticklabel',{'12','23','34','13','14','24'});

errorbar(x,MeanLtWFRUnit,StdLtWFRUnit,'o','MarkerSize',0.2);
title('MeanLtNWFRUnit_Pattern3')


subplot(1,2,2);
bar(x,MeanRtWFRUnit,0.5);hold on
set(gca,'xticklabel',{'12','23','34','13','14','24'});

errorbar(x,MeanRtWFRUnit,StdRtWFRUnit,'o','MarkerSize',0.2);
title('MeanRtNWFRUnit_Pattern3')

figname=['LtRtFR_NW2_Pattern3.bmp'];
cd(path)
saveas(LtRtNW2FRUnit,figname);


