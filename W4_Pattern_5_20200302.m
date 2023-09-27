function W4_Pattern_5_20200302
path=['C:\Users\C238\Desktop\touchcellLtRt_terashita'];
cd(path);

LS=ls;
LtWFRUnit=[];
RtWFRUnit=[];
LtW1234Point=0;
LtW1234Fire=0;
LtW2345Point=0;
LtW2345Fire=0;
LtW1235Point=0;
LtW1235Fire=0;
LtW1245Point=0;
LtW1245Fire=0;
LtW1345Point=0;
LtW1345Fire=0;
RtW1234Point=0;
RtW1234Fire=0;
RtW2345Point=0;
RtW2345Fire=0;
RtW1235Point=0;
RtW1235Fire=0;
RtW1245Point=0;
RtW1245Fire=0;
RtW1345Point=0;
RtW1345Fire=0;

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
                   if LtouchUnitPositive(x,[2:6])==[1,1,1,1,0];
                      LtW1234Point=LtW1234Point+1;
                      LtW1234Fire=LtW1234Fire+LtouchUnitPositive(x,1);
                   end
                   
                    if LtouchUnitPositive(x,[2:6])==[0,1,1,1,1];
                      LtW2345Point=LtW2345Point+1;
                      LtW2345Fire=LtW2345Fire+LtouchUnitPositive(x,1);
                    end
                   
                   if LtouchUnitPositive(x,[2:6])==[1,1,1,0,1];
                      LtW1235Point=LtW1235Point+1;
                      LtW1235Fire=LtW1235Fire+LtouchUnitPositive(x,1);
                   end
                   
                    if LtouchUnitPositive(x,[2:6])==[1,1,0,1,1];
                      LtW1245Point=LtW1245Point+1;
                      LtW1245Fire=LtW1245Fire+LtouchUnitPositive(x,1);
                    end
                   if LtouchUnitPositive(x,[2:6])==[1,0,1,1,1];
                      LtW1345Point=LtW1345Point+1;
                      LtW1345Fire=LtW1345Fire+LtouchUnitPositive(x,1);
                   end
               end
               
               LtWFR=[LtW1234Fire/(LtW1234Point*10),LtW2345Fire/(LtW2345Point*10),LtW1235Fire/(LtW1235Point*10),LtW1245Fire/(LtW1245Point*10),LtW1345Fire/(LtW1345Point*10)];
               
               %Rtouch
                for x=1:length(RtouchUnitPositive(:,1));
                   if RtouchUnitPositive(x,[2:6])==[1,1,1,1,0];
                      RtW1234Point=RtW1234Point+1;
                      RtW1234Fire=RtW1234Fire+RtouchUnitPositive(x,1);
                   end
                   
                    if RtouchUnitPositive(x,[2:6])==[0,1,1,1,1];
                      RtW2345Point=RtW2345Point+1;
                      RtW2345Fire=RtW2345Fire+RtouchUnitPositive(x,1);
                    end
                   
                   if RtouchUnitPositive(x,[2:6])==[1,1,1,0,1];
                      RtW1235Point=RtW1235Point+1;
                      RtW1235Fire=RtW1235Fire+RtouchUnitPositive(x,1);
                   end
                   
                    if RtouchUnitPositive(x,[2:6])==[1,1,0,1,1];
                      RtW1245Point=RtW1245Point+1;
                      RtW1245Fire=RtW1245Fire+RtouchUnitPositive(x,1);
                    end
                   if RtouchUnitPositive(x,[2:6])==[1,0,1,1,1];
                      RtW1345Point=RtW1345Point+1;
                      RtW1345Fire=RtW1345Fire+RtouchUnitPositive(x,1);
                   end
                   
                end
                
               RtWFR=[RtW1234Fire/(RtW1234Point*10),RtW2345Fire/(RtW2345Point*10),RtW1235Fire/(RtW1235Point*10),RtW1245Fire/(RtW1245Point*10),RtW1345Fire/(RtW1345Point*10)];
               
               
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



x=1:5;
LtRtW4FRUnit=figure
subplot(1,2,1);
bar(x,MeanLtWFRUnit,0.5);hold on
errorbar(x,MeanLtWFRUnit,StdLtWFRUnit,'o','MarkerSize',0.2);
title('MeanLtWFRUnit_Pattern5')


subplot(1,2,2);
bar(x,MeanRtWFRUnit,0.5);hold on
errorbar(x,MeanRtWFRUnit,StdRtWFRUnit,'o','MarkerSize',0.2);
title('MeanRtWFRUnit_Pattern5')

figname=['LtRtFR_W4_Pattern5.bmp'];
cd(path)
saveas(LtRtW4FRUnit,figname);


