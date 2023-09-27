function CollectAllData20180804
clear all;
close all;

TargetDirectory='C:\Users\B133_2\Desktop\CheetahWRLV20180729';

cd(TargetDirectory);
% cd('C:\Users\B133_2\Desktop\CheetahWRLV20180729');
H=ls;%CheetahWRLVƒtƒHƒ‹ƒ_“à
disp('H=');
disp(H);

for n=1:length(H(:,1))
    TrimStr1=strtrim(H(n,:));
    if ~strcmp(TrimStr1,'.') && ~strcmp(TrimStr1,'..')
        dpath2=[TargetDirectory '\' TrimStr1];
        cd(dpath2);
        H2=ls;
        disp('H2=');
        disp(H2);
%         TrimStr1
        AllSpikeData=[];
        for m=1:length(H2(:,1))
%             cd(['C:\Users\B133_2\Desktop\CheetahWRLV\' TrimStr1]);
            TrimStr2=strtrim(H2(m,:));
%             isdir(TrimStr2)
            if length(TrimStr2)>2 && isdir(TrimStr2)%~strcmp(TrimStr2(end-4:end),'pptx')
                dpath3=[TargetDirectory '\' TrimStr1 '\' TrimStr2];
                TrimStr2
                cd(dpath3);
                H3=ls;
                for k=1:length(H3(:,1))
                    TrimStr3=strtrim(H3(k,:));
                    if length(TrimStr3)>2 && length(strfind(TrimStr3,'_'))>=2 && isdir(TrimStr3)
%                         TrimStr3
                        dpath4=[TargetDirectory '\' TrimStr1 '\' TrimStr2 '\' TrimStr3];
                        cd(dpath4);
                        H4=ls;
                        for h=1:length(H4(:,1))
                            TrimStr4=strtrim(H4(h,:));
                            if length(TrimStr4)>2 && strcmp(TrimStr4(1),'a')
%                                 TrimStr4
                                eval(['load ',TrimStr4]);
                                AllSpikeData=[AllSpikeData;UnitDataUnited];
                            end
                        end
                    end
                    cd(dpath3);
                end
            end
            cd(dpath2);
        end
        cd(dpath2);
%         cd(['C:\Users\B133_2\Desktop\CheetahWRLV\' TrimStr1]);
        
        save AllSpikeData AllSpikeData
    end
    
end

