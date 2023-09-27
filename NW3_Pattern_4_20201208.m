function NW3_Pattern_4_20201208
path=['C:\Users\C238\Desktop\touchcellLtRt_Hirokane'];
cd(path);

LS=ls;
LtNWFRUnit=[];
RtNWFRUnit=[];

LtNW123Point=0;
LtNW123Fire=0;
LtNW234Point=0;
LtNW234Fire=0;
LtNW124Point=0;
LtNW124Fire=0;
LtNW134Point=0;
LtNW134Fire=0;

RtNW123Point=0;
RtNW123Fire=0;
RtNW234Point=0;
RtNW234Fire=0;
RtNW124Point=0;
RtNW124Fire=0;
RtNW134Point=0;
RtNW134Fire=0;


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
                   if LtouchUnitNegative(x,[2:5])==[-1,-1,-1,0];
                      LtNW123Point=LtNW123Point+1;
                      LtNW123Fire=LtNW123Fire+LtouchUnitNegative(x,1);
                   end
                   
                    if LtouchUnitNegative(x,[2:5])==[0,-1,-1,-1];
                      LtNW234Point=LtNW234Point+1;
                      LtNW234Fire=LtNW234Fire+LtouchUnitNegative(x,1);
                    end
                   
                    if LtouchUnitNegative(x,[2:5])==[-1,-1,0,-1];
                      LtNW124Point=LtNW124Point+1;
                      LtNW124Fire=LtNW124Fire+LtouchUnitNegative(x,1);
                    end
                    
                   if LtouchUnitNegative(x,[2:5])==[-1,0,-1,-1];
                      LtNW134Point=LtNW134Point+1;
                      LtNW134Fire=LtNW134Fire+LtouchUnitNegative(x,1);
                   end
                   
               end
               
               LtWFR=[LtNW123Fire/(LtNW123Point*10),LtNW234Fire/(LtNW234Point*10),LtNW124Fire/(LtNW124Point*10),LtNW134Fire/(LtNW134Point*10)];
               
               %Rtouch
                for x=1:length(RtouchUnitNegative(:,1));
                   if RtouchUnitNegative(x,[2:5])==[-1,-1,-1,0];
                      RtNW123Point=LtNW123Point+1;
                      RtNW123Fire=RtNW123Fire+RtouchUnitNegative(x,1);
                   end
                   
                    if RtouchUnitNegative(x,[2:5])==[0,-1,-1,-1];
                      RtNW234Point=RtNW234Point+1;
                      RtNW234Fire=RtNW234Fire+RtouchUnitNegative(x,1);
                    end
                   
                   if RtouchUnitNegative(x,[2:5])==[-1,-1,0,-1];
                      RtNW124Point=RtNW124Point+1;
                      RtNW124Fire=RtNW124Fire+RtouchUnitNegative(x,1);
                   end
                   
                    if RtouchUnitNegative(x,[2:5])==[-1,0,-1,-1];
                      RtNW134Point=RtNW134Point+1;
                      RtNW134Fire=RtNW134Fire+RtouchUnitNegative(x,1);
                    end
                   
                end
               RtWFR=[RtNW123Fire/(RtNW123Point*10),RtNW234Fire/(RtNW234Point*10),RtNW124Fire/(RtNW124Point*10),RtNW134Fire/(RtNW134Point*10)];
               
               
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
LtRtNW3FRUnit=figure
subplot(1,2,1);
bar(x,MeanLtWFRUnit,0.5);hold on
set(gca,'xticklabel',{'123','234','124','134'});
errorbar(x,MeanLtWFRUnit,StdLtWFRUnit,'o','MarkerSize',0.2);
title('MeanLtNWFRUnit_Pattern4')


subplot(1,2,2);
bar(x,MeanRtWFRUnit,0.5);hold on
set(gca,'xticklabel',{'123','234','124','134'});

errorbar(x,MeanRtWFRUnit,StdRtWFRUnit,'o','MarkerSize',0.2);
title('MeanRtNWFRUnit_Pattern4')

figname=['LtRtFR_NW3_Pattern4.bmp'];
cd(path)
saveas(LtRtNW3FRUnit,figname);


