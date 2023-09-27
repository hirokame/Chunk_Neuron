function NW1_Pattern_2_20201208
path=['C:\Users\C238\Desktop\touchcellLtRt_Hirokane'];
cd(path);

LS=ls;
LtNWFRUnit=[];
RtNWFRUnit=[];
LtNW1Point=0;
LtNW1Fire=0;
LtNW2Point=0;
LtNW2Fire=0;
LtNW3Point=0;
LtNW3Fire=0;
LtNW4Point=0;
LtNW4Fire=0;
LtNW5Point=0;
LtNW5Fire=0;
RtNW1Point=0;
RtNW1Fire=0;
RtNW2Point=0;
RtNW2Fire=0;
RtNW3Point=0;
RtNW3Fire=0;
RtNW4Point=0;
RtNW4Fire=0;
RtNW5Point=0;
RtNW5Fire=0;

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
                   if LtouchUnitNegative(x,[2:5])==[-1,0,0,0];
                      LtNW1Point=LtNW1Point+1;
                      LtNW1Fire=LtNW1Fire+LtouchUnitNegative(x,1);
                   end
                   
                    if LtouchUnitNegative(x,[2:5])==[0,-1,0,0];
                      LtNW2Point=LtNW2Point+1;
                      LtNW2Fire=LtNW2Fire+LtouchUnitNegative(x,1);
                    end
                   
                   if LtouchUnitNegative(x,[2:5])==[0,0,-1,0];
                      LtNW3Point=LtNW3Point+1;
                      LtNW3Fire=LtNW3Fire+LtouchUnitNegative(x,1);
                   end
                   
                    if LtouchUnitNegative(x,[2:5])==[0,0,0,-1];
                      LtNW4Point=LtNW4Point+1;
                      LtNW4Fire=LtNW4Fire+LtouchUnitNegative(x,1);
                    end
                   
               end
               
               LtWFR=[LtNW1Fire/(LtNW1Point*10),LtNW2Fire/(LtNW2Point*10),LtNW3Fire/(LtNW3Point*10),LtNW4Fire/(LtNW4Point*10)];
               
               %Rtouch
                for x=1:length(RtouchUnitNegative(:,1));
                   if RtouchUnitNegative(x,[2:5])==[-1,0,0,0];
                      RtNW1Point=RtNW1Point+1;
                      RtNW1Fire=RtNW1Fire+RtouchUnitNegative(x,1);
                   end
                   
                    if RtouchUnitNegative(x,[2:5])==[0,-1,0,0];
                      RtNW2Point=RtNW2Point+1;
                      RtNW2Fire=RtNW2Fire+RtouchUnitNegative(x,1);
                    end
                   
                   if RtouchUnitNegative(x,[2:5])==[0,0,-1,0];
                      RtNW3Point=RtNW3Point+1;
                      RtNW3Fire=RtNW3Fire+RtouchUnitNegative(x,1);
                   end
                   
                    if RtouchUnitNegative(x,[2:5])==[0,0,0,-1];
                      RtNW4Point=RtNW4Point+1;
                      RtNW4Fire=RtNW4Fire+RtouchUnitNegative(x,1);
                    end
                   
                end
                
               RtWFR=[RtNW1Fire/(RtNW1Point*10),RtNW2Fire/(RtNW2Point*10),RtNW3Fire/(RtNW3Point*10),RtNW4Fire/(RtNW4Point*10)];
               
               
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



x=1:4;
LtRtW1FRUnit=figure
subplot(1,2,1);
bar(x,MeanLtWFRUnit,0.5);hold on
errorbar(x,MeanLtWFRUnit,StdLtWFRUnit,'o','MarkerSize',0.2);
title('MeanLtNWFRUnit')


subplot(1,2,2);
bar(x,MeanRtWFRUnit,0.5);hold on
errorbar(x,MeanRtWFRUnit,StdRtWFRUnit,'o','MarkerSize',0.2);
title('MeanRtNWFRUnit')

figname=['LtRtFR_NW1_Pattern2.bmp'];
cd(path)
saveas(LtRtW1FRUnit,figname);


