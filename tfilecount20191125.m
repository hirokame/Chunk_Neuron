function tfilecount20191125

path=('C:\Users\C238\Desktop\CheetahWRLV20180729Part1');

cd(path)

LS1=ls;
tfilecount=0;
for i=1:length(LS1(:,1))
    trimFolder1=strtrim(LS1(i,:));
    if  ~strcmp(trimFolder1,'.') && ~strcmp(trimFolder1,'..') && isempty(strfind(trimFolder1,'.mat')) && isempty(strfind(trimFolder1,'.bmp'));
        cd([path,'\',trimFolder1]);
        LS2=ls;
        for j=1:length(LS2(:,1))
            trimFolder2=strtrim(LS2(j,:));
            if length(trimFolder2)>4;
               dpath3=[path,'\',trimFolder1,'\',trimFolder2];
               cd(dpath3)
               LS3=ls;
               for k=1:length(LS3(:,1))
                   trimFile3=strtrim(LS3(k,:));
                   if length(trimFile3)>4 && strcmp(trimFile3(end-1:end),'.t');
                      tfilecount=tfilecount+1; 
                   end
               end
            end
        end
    end
end
tfilecount