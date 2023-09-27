function touchparameterplot20191128

path=['C:\Users\C238\Desktop\CheetahWRLV20180729Part1'];

cd(path)

MaxA1RtArray=[];
MaxZRArray=[];
MaxA2LtArray=[];
MaxZLArray=[];
LS1=ls;

for i=1:length(LS1(:,1))
   trimFolder=strtrim(LS1(i,:));
   if ~strcmp(trimFolder,'.') && ~strcmp(trimFolder,'..') && length(trimFolder)<5;
       CDFolder=[path,'\',trimFolder];
      cd(CDFolder);
      LS2=ls;
      for j=1:length(LS2(:,1))
        trimFolder2=strtrim(LS2(j,:));
        if length(trimFolder2)>4 & ~strcmp(trimFolder2(end-3:end),'.mat');
            CDFolder2=[CDFolder,'\',trimFolder2];
            cd(CDFolder2)
            TouchCellName=[]; 
            CDFolder3=[CDFolder2,'\CellCell'];
            cd(CDFolder3)
            LSC=ls;
            for x=1:length(LSC(:,1));
                trimCellFolder=strtrim(LSC(x,:));
                if length(trimCellFolder)>4 && ~strcmp(trimCellFolder((end-3):end),'.mat');
                CDFolder5=[CDFolder3,'\',trimCellFolder];
                cd(CDFolder5)
                LS3=ls;
                for y=1:length(LS3(:,1))
                    trimmatfile=strtrim(LS3(y,:));
                    if length(trimmatfile)>9 & strcmp(trimmatfile(end-8:end-4),'_98__');
                       load(trimmatfile)
                       MaxA1RtArray=[MaxA1RtArray MaxA1Rt];
                       MaxZRArray=[MaxZRArray MaxZR];
                       MaxA2LtArray=[MaxA2LtArray MaxA2Lt];
                       MaxZLArray=[MaxZLArray MaxZL];
                    end
                end
                end
            end
            
            
        end
      end
   end
end
MaxA1RtArray
MaxZRArray
MaxA2LtArray
MaxZLArray

figure
scatter(MaxA1RtArray,MaxZRArray);
figure
scatter(MaxA2LtArray,MaxZLArray);