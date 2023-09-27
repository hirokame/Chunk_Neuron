function W3_Pattern_4_20200302
path=['C:\Users\C238\Desktop\touchcellLtRt_terashita'];
cd(path);

LS=ls;
LtWFRUnit=[];
RtWFRUnit=[];
LtW123Point=0;
LtW123Fire=0;
LtW234Point=0;
LtW234Fire=0;
LtW345Point=0;
LtW345Fire=0;
LtW124Point=0;
LtW124Fire=0;
LtW125Point=0;
LtW125Fire=0;
LtW134Point=0;
LtW134Fire=0;
LtW135Point=0;
LtW135Fire=0;
LtW145Point=0;
LtW145Fire=0;
LtW235Point=0;
LtW235Fire=0;
LtW245Point=0;
LtW245Fire=0;

RtW123Point=0;
RtW123Fire=0;
RtW234Point=0;
RtW234Fire=0;
RtW345Point=0;
RtW345Fire=0;
RtW124Point=0;
RtW124Fire=0;
RtW125Point=0;
RtW125Fire=0;
RtW134Point=0;
RtW134Fire=0;
RtW135Point=0;
RtW135Fire=0;
RtW145Point=0;
RtW145Fire=0;
RtW235Point=0;
RtW235Fire=0;
RtW245Point=0;
RtW245Fire=0;

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
                   if LtouchUnitPositive(x,[2:6])==[1,1,1,0,0];
                      LtW123Point=LtW123Point+1;
                      LtW123Fire=LtW123Fire+LtouchUnitPositive(x,1);
                   end
                   
                    if LtouchUnitPositive(x,[2:6])==[0,1,1,1,0];
                      LtW234Point=LtW234Point+1;
                      LtW234Fire=LtW234Fire+LtouchUnitPositive(x,1);
                    end
                   
                   if LtouchUnitPositive(x,[2:6])==[0,0,1,1,1];
                      LtW345Point=LtW345Point+1;
                      LtW345Fire=LtW345Fire+LtouchUnitPositive(x,1);
                   end
                   
                    if LtouchUnitPositive(x,[2:6])==[1,1,0,1,0];
                      LtW124Point=LtW124Point+1;
                      LtW124Fire=LtW124Fire+LtouchUnitPositive(x,1);
                    end
                    
                   if LtouchUnitPositive(x,[2:6])==[1,0,1,0,1];
                      LtW135Point=LtW135Point+1;
                      LtW135Fire=LtW135Fire+LtouchUnitPositive(x,1);
                   end
                   
                   if LtouchUnitPositive(x,[2:6])==[1,0,1,1,0];
                      LtW134Point=LtW134Point+1;
                      LtW134Fire=LtW134Fire+LtouchUnitPositive(x,1);
                   end
                   
                   if LtouchUnitPositive(x,[2:6])==[1,1,0,0,1];
                      LtW125Point=LtW125Point+1;
                      LtW125Fire=LtW125Fire+LtouchUnitPositive(x,1);
                   end
                   
                   if LtouchUnitPositive(x,[2:6])==[1,0,0,1,1];
                      LtW145Point=LtW145Point+1;
                      LtW145Fire=LtW145Fire+LtouchUnitPositive(x,1);
                   end
                   
                   if LtouchUnitPositive(x,[2:6])==[0,1,1,0,1];
                      LtW235Point=LtW235Point+1;
                      LtW235Fire=LtW235Fire+LtouchUnitPositive(x,1);
                   end
                   
                   if LtouchUnitPositive(x,[2:6])==[0,1,0,1,1];
                      LtW245Point=LtW245Point+1;
                      LtW245Fire=LtW245Fire+LtouchUnitPositive(x,1);
                   end
               end
               
               LtWFR=[LtW123Fire/(LtW123Point*10),LtW234Fire/(LtW234Point*10),LtW345Fire/(LtW345Point*10),LtW124Fire/(LtW124Point*10),LtW125Fire/(LtW125Point*10)...
                   ,LtW134Fire/(LtW134Point*10),LtW135Fire/(LtW135Point*10),LtW145Fire/(LtW145Point*10),LtW235Fire/(LtW235Point*10),LtW245Fire/(LtW245Point*10),];
               
               %Rtouch
                for x=1:length(RtouchUnitPositive(:,1));
                   if RtouchUnitPositive(x,[2:6])==[1,1,1,0,0];
                      RtW123Point=LtW123Point+1;
                      RtW123Fire=RtW123Fire+RtouchUnitPositive(x,1);
                   end
                   
                    if RtouchUnitPositive(x,[2:6])==[0,1,1,1,0];
                      RtW234Point=RtW234Point+1;
                      RtW234Fire=RtW234Fire+RtouchUnitPositive(x,1);
                    end
                   
                   if RtouchUnitPositive(x,[2:6])==[0,0,1,1,1];
                      RtW345Point=RtW345Point+1;
                      RtW345Fire=RtW345Fire+RtouchUnitPositive(x,1);
                   end
                   
                    if RtouchUnitPositive(x,[2:6])==[1,1,0,1,0];
                      RtW124Point=RtW124Point+1;
                      RtW124Fire=RtW124Fire+RtouchUnitPositive(x,1);
                    end
                    
                   if RtouchUnitPositive(x,[2:6])==[1,0,1,0,1];
                      RtW135Point=RtW135Point+1;
                      RtW135Fire=RtW135Fire+RtouchUnitPositive(x,1);
                   end
                   
                   if RtouchUnitPositive(x,[2:6])==[1,0,1,1,0];
                      RtW134Point=RtW134Point+1;
                      RtW134Fire=RtW134Fire+RtouchUnitPositive(x,1);
                   end
                   
                   if RtouchUnitPositive(x,[2:6])==[1,1,0,0,1];
                      RtW125Point=RtW125Point+1;
                      RtW125Fire=RtW125Fire+RtouchUnitPositive(x,1);
                   end
                   
                   if RtouchUnitPositive(x,[2:6])==[1,0,0,1,1];
                      RtW145Point=RtW145Point+1;
                      RtW145Fire=RtW145Fire+RtouchUnitPositive(x,1);
                   end
                   
                   if RtouchUnitPositive(x,[2:6])==[0,1,1,0,1];
                      RtW235Point=RtW235Point+1;
                      RtW235Fire=RtW235Fire+RtouchUnitPositive(x,1);
                   end
                   
                   if RtouchUnitPositive(x,[2:6])==[0,1,0,1,1];
                      RtW245Point=RtW245Point+1;
                      RtW245Fire=RtW245Fire+RtouchUnitPositive(x,1);
                   end
                end
               RtWFR=[RtW123Fire/(RtW123Point*10),RtW234Fire/(RtW234Point*10),RtW345Fire/(RtW345Point*10),RtW124Fire/(RtW124Point*10),RtW125Fire/(RtW125Point*10)...
                   ,RtW134Fire/(RtW134Point*10),RtW135Fire/(RtW135Point*10),RtW145Fire/(RtW145Point*10),RtW235Fire/(RtW235Point*10),RtW245Fire/(RtW245Point*10),];
               
               
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
LtRtW3FRUnit=figure
subplot(1,2,1);
bar(x,MeanLtWFRUnit,0.5);hold on
set(gca,'xticklabel',{'123','234','345','124','125','134','135','145','235','245'});
errorbar(x,MeanLtWFRUnit,StdLtWFRUnit,'o','MarkerSize',0.2);
title('MeanLtWFRUnit_Pattern4')


subplot(1,2,2);
bar(x,MeanRtWFRUnit,0.5);hold on
set(gca,'xticklabel',{'123','234','345','124','125','134','135','145','235','245'});

errorbar(x,MeanRtWFRUnit,StdRtWFRUnit,'o','MarkerSize',0.2);
title('MeanRtWFRUnit_Pattern4')

figname=['LtRtFR_W3_Pattern4.bmp'];
cd(path)
saveas(LtRtW3FRUnit,figname);


