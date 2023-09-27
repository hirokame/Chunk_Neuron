function MSNcount20200108

global dpath3

cd(dpath3)
dpath=[dpath3,'\'];

path=[dpath,'CellCell'];



MSNsum=0;
Rtcount=0;
Ltcount=0;
RtLtcount=0;
Touchcount=0;
Woncount=0;
Woffcount=0;
WonWoffcount=0;
Doncount=0;
WoDoncount=0;
tDoncount=0;
Wotcount=0;
tWoDoncount=0;
modBgracount=0;
mod98count=0;
repcount=0;
Bgra98count=0;
rep98count=0;
repBgracount=0;
rhythmcount_mt3=0;

cd(path);
LS=ls;

for i=1:length(LS(:,1));
    trimFolder=strtrim(LS(i,:));
    cd(path)
    if length(trimFolder)>4 && ~strcmp(trimFolder(end-3:end),'.mat');
       cd(trimFolder);
       load('response.mat');
       if ~isempty(strfind(response,'MSN'));
           MSNsum=MSNsum+1;
           if ~isempty(strfind(response,'Rt'));
                Rtcount=Rtcount+1;
            end
            if ~isempty(strfind(response,'Lt'));
                Ltcount=Ltcount+1;
            end
            if ~isempty(strfind(response,'Rt')) && ~isempty(strfind(response,'Lt'));
                RtLtcount=RtLtcount+1;
            end
            if ~isempty(strfind(response,'Rt')) || ~isempty(strfind(response,'Lt'));
                Touchcount=Touchcount+1;
            end
            if ~isempty(strfind(response,'Won'));
               Woncount=Woncount+1; 
            end
            if ~isempty(strfind(response,'Woff'));
               Woffcount=Woffcount+1; 
            end
            if ~isempty(strfind(response,'WonWoff'));
               WonWoffcount=WonWoffcount+1;
            end
            if ~isempty(strfind(response,'Don'));
               Doncount=Doncount+1; 
            end
            if ~isempty(strfind(response,'Wo')) && ~isempty(strfind(response,'Don'));
               WoDoncount=WoDoncount+1; 
            end
            if ~isempty(strfind(response,'t')) && ~isempty(strfind(response,'Don'));
               tDoncount=tDoncount+1;
            end
            if ~isempty(strfind(response,'t')) && ~isempty(strfind(response,'Wo'));
                Wotcount=Wotcount+1;
            end
            if ~isempty(strfind(response,'t')) && ~isempty(strfind(response,'Wo')) && ~isempty(strfind(response,'Don'));
               tWoDoncount=tWoDoncount+1; 
            end
            if ~isempty(strfind(response,'modBgra'));
               modBgracount=modBgracount+1;
            end
            if ~isempty(strfind(response,'mod98'));
               mod98count=mod98count+1; 
            end
            if ~isempty(strfind(response,'Rep'));
               repcount=repcount+1;
            end
            if ~isempty(strfind(response,'modBgra')) && ~isempty(strfind(response,'mod98'));
               Bgra98count=Bgra98count+1; 
            end
            if (~isempty(strfind(response,'mod98')) && ~isempty(strfind(response,'Rep')))
                rep98count=rep98count+1;
            end
            if (~isempty(strfind(response,'Rep')) && ~isempty(strfind(response,'modBgra')))
                repBgracount=repBgracount+1;
            end
            if ~isempty(strfind(response,'mod98')) && ~isempty(strfind(response,'modBgra')) && ~isempty(strfind(response,'Rep'));
                rhythmcount_mt3=rhythmcount_mt3+1;
            end
       end
    end
end
pathdesktop=['C:\Users\C238\Desktop'];
cd(pathdesktop)
countArray=[MSNsum;Rtcount;Ltcount;RtLtcount;Woncount;Woffcount;WonWoffcount;Doncount;WoDoncount;tDoncount;Wotcount;tWoDoncount;modBgracount;mod98count;modBgra98countsum];
filename=['MSNCount.xlsx'];
xlswrite(filename,countArray);

