function W2_Pattern_3_20201208
path=['C:\Users\C238\Desktop\touchcellLtRt_Hirokane'];
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
               LtouchUnitPositive= LtouchUnit(:,[1:6]);                                         
               RtouchUnit=[RtouchSpikeOnUnit;[zeros(length(RtouchSpikeOffUnit(:,1)),1) RtouchSpikeOffUnit]];
               RtouchUnitPositive= RtouchUnit(:,[1:6]);
              
               
               %Ltouch
               for x=1:length(LtouchUnitPositive(:,1));
                   if LtouchUnitPositive(x,[2:6])==[1,1,0,0,0];
                      LtW12Point=LtW12Point+1;
                      LtW12Fire=LtW12Fire+LtouchUnitPositive(x,1);
                   end
                   
                    if LtouchUnitPositive(x,[2:6])==[0,1,1,0,0];
                      LtW23Point=LtW23Point+1;
                      LtW23Fire=LtW23Fire+LtouchUnitPositive(x,1);
                    end
                   
                   if LtouchUnitPositive(x,[2:6])==[0,0,1,1,0];
                      LtW34Point=LtW34Point+1;
                      LtW34Fire=LtW34Fire+LtouchUnitPositive(x,1);
                   end
                   
                    if LtouchUnitPositive(x,[2:6])==[0,0,0,1,1];
                      LtW45Point=LtW45Point+1;
                      LtW45Fire=LtW45Fire+LtouchUnitPositive(x,1);
                    end
                    
                   if LtouchUnitPositive(x,[2:6])==[1,0,0,0,1];
                      LtW15Point=LtW15Point+1;
                      LtW15Fire=LtW15Fire+LtouchUnitPositive(x,1);
                   end
                   
                   if LtouchUnitPositive(x,[2:6])==[1,0,0,1,0];
                      LtW14Point=LtW14Point+1;
                      LtW14Fire=LtW14Fire+LtouchUnitPositive(x,1);
                   end
                   
                   if LtouchUnitPositive(x,[2:6])==[1,0,1,0,0];
                      LtW13Point=LtW13Point+1;
                      LtW13Fire=LtW13Fire+LtouchUnitPositive(x,1);
                   end
                   
                   if LtouchUnitPositive(x,[2:6])==[0,1,0,1,0];
                      LtW24Point=LtW24Point+1;
                      LtW24Fire=LtW24Fire+LtouchUnitPositive(x,1);
                   end
                   
                   if LtouchUnitPositive(x,[2:6])==[0,1,0,0,1];
                      LtW25Point=LtW25Point+1;
                      LtW25Fire=LtW25Fire+LtouchUnitPositive(x,1);
                   end
                   
                   if LtouchUnitPositive(x,[2:6])==[0,0,1,0,1];
                      LtW35Point=LtW35Point+1;
                      LtW35Fire=LtW35Fire+LtouchUnitPositive(x,1);
                   end
               end
               
               LtWFR=[LtW12Fire/(LtW12Point*10),LtW23Fire/(LtW23Point*10),LtW34Fire/(LtW34Point*10),LtW45Fire/(LtW45Point*10),LtW13Fire/(LtW13Point*10)...
                   ,LtW14Fire/(LtW14Point*10),LtW15Fire/(LtW15Point*10),LtW24Fire/(LtW24Point*10),LtW25Fire/(LtW25Point*10),LtW35Fire/(LtW35Point*10),];
               
               %Rtouch
                for x=1:length(RtouchUnitPositive(:,1));
                   if RtouchUnitPositive(x,[2:6])==[1,1,0,0,0];
                      RtW12Point=LtW12Point+1;
                      RtW12Fire=RtW12Fire+RtouchUnitPositive(x,1);
                   end
                   
                    if RtouchUnitPositive(x,[2:6])==[0,1,1,0,0];
                      RtW23Point=RtW23Point+1;
                      RtW23Fire=RtW23Fire+RtouchUnitPositive(x,1);
                    end
                   
                   if RtouchUnitPositive(x,[2:6])==[0,0,1,1,0];
                      RtW34Point=RtW34Point+1;
                      RtW34Fire=RtW34Fire+RtouchUnitPositive(x,1);
                   end
                   
                    if RtouchUnitPositive(x,[2:6])==[0,0,0,1,1];
                      RtW45Point=RtW45Point+1;
                      RtW45Fire=RtW45Fire+RtouchUnitPositive(x,1);
                    end
                    
                   if RtouchUnitPositive(x,[2:6])==[1,0,0,0,1];
                      RtW15Point=RtW15Point+1;
                      RtW15Fire=RtW15Fire+RtouchUnitPositive(x,1);
                   end
                   
                   if RtouchUnitPositive(x,[2:6])==[1,0,0,1,0];
                      RtW14Point=RtW14Point+1;
                      RtW14Fire=RtW14Fire+RtouchUnitPositive(x,1);
                   end
                   
                   if RtouchUnitPositive(x,[2:6])==[1,0,1,0,0];
                      RtW13Point=RtW13Point+1;
                      RtW13Fire=RtW13Fire+RtouchUnitPositive(x,1);
                   end
                   
                   if RtouchUnitPositive(x,[2:6])==[0,1,0,1,0];
                      RtW24Point=RtW24Point+1;
                      RtW24Fire=RtW24Fire+RtouchUnitPositive(x,1);
                   end
                   
                   if RtouchUnitPositive(x,[2:6])==[0,1,0,0,1];
                      RtW25Point=RtW25Point+1;
                      RtW25Fire=RtW25Fire+RtouchUnitPositive(x,1);
                   end
                   
                   if RtouchUnitPositive(x,[2:6])==[0,0,1,0,1];
                      RtW35Point=RtW35Point+1;
                      RtW35Fire=RtW35Fire+RtouchUnitPositive(x,1);
                      
                   end
                end
               RtWFR=[RtW12Fire/(RtW12Point*10),RtW23Fire/(RtW23Point*10),RtW34Fire/(RtW34Point*10),RtW45Fire/(RtW45Point*10),RtW13Fire/(RtW13Point*10)...
                   ,RtW14Fire/(RtW14Point*10),RtW15Fire/(RtW15Point*10),RtW24Fire/(RtW24Point*10),RtW25Fire/(RtW25Point*10),RtW35Fire/(RtW35Point*10),];
               
               
                LtWFRUnit=[LtWFRUnit;LtWFR];
                RtWFRUnit=[RtWFRUnit;RtWFR];
                
           
           end   
       end
    end
end


MeanLtWFRUnit=[];
StdLtWFRUnit=[];
for i=1:length(LtWFRUnit(1,:))
    MeanLtWFRUnit=[MeanLtWFRUnit nanmean(LtWFRUnit(:,i))];
    StdLtWFRUnit=[StdLtWFRUnit nanstd(LtWFRUnit(:,i))];
end

MeanRtWFRUnit=[];
StdRtWFRUnit=[];
for i=1:length(RtWFRUnit(1,:))
    MeanRtWFRUnit=[MeanRtWFRUnit nanmean(RtWFRUnit(:,i))];
    StdRtWFRUnit=[StdRtWFRUnit nanstd(RtWFRUnit(:,i))];
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


