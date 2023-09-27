function Touches202003003


path=['C:\Users\C238\Desktop\touchcellLtRt_terashita'];
cd(path);


TouchesArray=[];
PNTouches=[];
morePPoint=0;
moreNPoint=0;
morePTouches=0;
moreNTouches=0;
OOTouches=0;
NOTouches=0;
NOTouchesFire=0;
NOTouchesFR=[];
LS=ls;
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
               LtouchUnit=[LtouchSpikeOnUnit;[zeros(length(LtouchSpikeOffUnit(:,1)),1) LtouchSpikeOffUnit]]; %%%% SpikeOffUnit‚Ì‘O—ñ‚É”­‰Î”—ñ‚ð’Ç‰Á‚µ‚ÄSpikeOnUnit‚Æ˜AŒ‹BSpikeOffŽž‚Ì”­‰Î”‚ðƒ[ƒ‚ÉÝ’è
                                                  
               RtouchUnit=[RtouchSpikeOnUnit;[zeros(length(RtouchSpikeOffUnit(:,1)),1) RtouchSpikeOffUnit]];
               
              for x=1:length(LtouchUnit(:,1))
                IndexTouchesPositive=find(LtouchUnit(x,[2:10])==1);
                IndexTouchesNegative=find(LtouchUnit(x,[2:10])==-1);
                if length(IndexTouchesPositive)==0 && length(IndexTouchesNegative)==0;
                    OOTouches=OOTouches+1;
                end
                
                if length(IndexTouchesNegative)==0;
                   NOTouches=NOTouches+1; 
                   NOTouchesFire=NOTouchesFire+LtouchUnit(x,1);
                end
                TouchesArray=[TouchesArray length(IndexTouchesPositive)+length(IndexTouchesNegative)];
%                 if length(IndexTouchesPositive)>length(IndexTouchesNegative);
%                     morePPoint=morePPoint+1;
%                     morePTouches=morePTouches+LtouchUnit(x,1);
%                 end
%                 
%                 if length(IndexTouchesPositive)<length(IndexTouchesNegative);
%                     moreNPoint=moreNPoint+1;
%                     moreNTouches=moreNTouches+LtouchUnit(x,1);
%                 end
              end
               
               NOTouchesFR=[NOTouchesFR NOTouchesFire./(NOTouches*10)];
           
           end   
       end
    end
end
MeanTouches=mean(TouchesArray);
MeanTouches


morePFR=morePTouches/(morePPoint*10);
moreNFR=moreNTouches/(moreNPoint*10);
OOTouches
NOTouches

MeanNOTouchesFR=mean(NOTouchesFR);
MeanNOTouchesFR
figure

histogram(TouchesArray);



