function W1_Pattern_2_20201208
path=['C:\Users\C238\Desktop\touchcellLtRt_Hirokane'];
cd(path);

LS=ls;
LtWFRUnit=[];
RtWFRUnit=[];
LtW1Point=0;
LtW1Fire=0;
LtW2Point=0;
LtW2Fire=0;
LtW3Point=0;
LtW3Fire=0;
LtW4Point=0;
LtW4Fire=0;
LtW5Point=0;
LtW5Fire=0;
RtW1Point=0;
RtW1Fire=0;
RtW2Point=0;
RtW2Fire=0;
RtW3Point=0;
RtW3Fire=0;
RtW4Point=0;
RtW4Fire=0;
RtW5Point=0;
RtW5Fire=0;

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
                   if LtouchUnitPositive(x,[2:6])==[1,0,0,0,0];
                      LtW1Point=LtW1Point+1;
                      LtW1Fire=LtW1Fire+LtouchUnitPositive(x,1);
                   end
                   
                    if LtouchUnitPositive(x,[2:6])==[0,1,0,0,0];
                      LtW2Point=LtW2Point+1;
                      LtW2Fire=LtW2Fire+LtouchUnitPositive(x,1);
                    end
                   
                   if LtouchUnitPositive(x,[2:6])==[0,0,1,0,0];
                      LtW3Point=LtW3Point+1;
                      LtW3Fire=LtW3Fire+LtouchUnitPositive(x,1);
                   end
                   
                    if LtouchUnitPositive(x,[2:6])==[0,0,0,1,0];
                      LtW4Point=LtW4Point+1;
                      LtW4Fire=LtW4Fire+LtouchUnitPositive(x,1);
                    end
                   if LtouchUnitPositive(x,[2:6])==[0,0,0,0,1];
                      LtW5Point=LtW5Point+1;
                      LtW5Fire=LtW5Fire+LtouchUnitPositive(x,1);
                   end
               end
               
               LtWFR=[LtW1Fire/(LtW1Point*10),LtW2Fire/(LtW2Point*10),LtW3Fire/(LtW3Point*10),LtW4Fire/(LtW4Point*10),LtW5Fire/(LtW5Point*10)];
               
               %Rtouch
                for x=1:length(RtouchUnitPositive(:,1));
                   if RtouchUnitPositive(x,[2:6])==[1,0,0,0,0];
                      RtW1Point=RtW1Point+1;
                      RtW1Fire=RtW1Fire+RtouchUnitPositive(x,1);
                   end
                   
                    if RtouchUnitPositive(x,[2:6])==[0,1,0,0,0];
                      RtW2Point=RtW2Point+1;
                      RtW2Fire=RtW2Fire+RtouchUnitPositive(x,1);
                    end
                   
                   if RtouchUnitPositive(x,[2:6])==[0,0,1,0,0];
                      RtW3Point=RtW3Point+1;
                      RtW3Fire=RtW3Fire+RtouchUnitPositive(x,1);
                   end
                   
                    if RtouchUnitPositive(x,[2:6])==[0,0,0,1,0];
                      RtW4Point=RtW4Point+1;
                      RtW4Fire=RtW4Fire+RtouchUnitPositive(x,1);
                    end
                   if RtouchUnitPositive(x,[2:6])==[0,0,0,0,1];
                      RtW5Point=RtW5Point+1;
                      RtW5Fire=RtW5Fire+RtouchUnitPositive(x,1);
                   end
                   
                end
                
               RtWFR=[RtW1Fire/(RtW1Point*10),RtW2Fire/(RtW2Point*10),RtW3Fire/(RtW3Point*10),RtW4Fire/(RtW4Point*10),RtW5Fire/(RtW5Point*10)];
               
               
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
LtRtW1FRUnit=figure
subplot(1,2,1);
bar(x,MeanLtWFRUnit,0.5);hold on
errorbar(x,MeanLtWFRUnit,StdLtWFRUnit,'o','MarkerSize',0.2);
title('MeanLtWFRUnit')


subplot(1,2,2);
bar(x,MeanRtWFRUnit,0.5);hold on
errorbar(x,MeanRtWFRUnit,StdRtWFRUnit,'o','MarkerSize',0.2);
title('MeanRtWFRUnit')

figname=['LtRtFR_W1_Pattern2.bmp'];
cd(path)
saveas(LtRtW1FRUnit,figname);


