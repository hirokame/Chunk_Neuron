function PCA20200117

path=['C:\Users\C238\Desktop\CheetahWRLV20180729Part1'];
cd(path)
LS1=ls;

% MaxA1Rt DiffMaxMinR MaxZR A1RtStepFreq
% MaxA2Lt DiffMaxMinL  MaxZL A2LtStepFreq
%         

TouchIndexMatrix=[];
for i=1:length(LS1(:,1))
    trimFolder1=strtrim(LS1(i,:));
    if  ~strcmp(trimFolder1,'.') && ~strcmp(trimFolder1,'..') && isempty(strfind(trimFolder1,'.mat')) && isempty(strfind(trimFolder1,'.bmp')) && isempty(strfind(trimFolder1,'.fig')) ...
        && ~strcmp(trimFolder1,'CCSfigure') && isempty(strfind(trimFolder1,'.xlsx'));
        cd([path,'\',trimFolder1]);%%%%%%%%%%%%%%%%%%%%%%ƒ}ƒEƒXfolder
        LS2=ls;
        for j=1:length(LS2(:,1))
            trimFolder2=strtrim(LS2(j,:));
            if length(trimFolder2)>4;
               dpath3=[path,'\',trimFolder1,'\',trimFolder2];
               cd(dpath3)%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%“ú‚É‚¿folder
               pathparameter=[dpath3,'\','ParameterFolder'];
               cd(pathparameter)
               LS3=ls;
               for k=1:length(LS3(:,1))
                   trimFolder3=strtrim(LS3(k,:));
                   TouchIndex=[];
                   if length(trimFolder3)>10 && strcmp(trimFolder3(end-8:end-7),'_C');
                      load(trimFolder3);
                      TouchIndex=[MaxA1Rt DiffMaxMinR MaxZR A1RtStepFreq MaxA2Lt DiffMaxMinL  MaxZL A2LtStepFreq];
                      TouchIndexMatrix=[TouchIndexMatrix;TouchIndex];
                   end
               end
            end
        end
    end
end
TouchIndexMatrix

TouchIndexMatrix(any(isnan(TouchIndexMatrix)'),:) = []; 
TouchIndexMatrix(any(~isfinite(TouchIndexMatrix)'),:) = []; 

[coeff,score,latent,tsquared,explained,mu] = pca(TouchIndexMatrix);

figure
plot(linspace(1,length(explained),length(explained)),explained);

% figure
% plot(coeff(:,1),coeff(:,2));
figure
scatter(score(:,1),score(:,2));


[coeff,score,latent,tsquared,explained,mu] = pca(TouchIndexMatrix(:,(1:4)));
figure
scatter(score(:,1),score(:,2));


[coeff,score,latent,tsquared,explained,mu] = pca(TouchIndexMatrix(:,(5:8)));
figure
scatter(score(:,1),score(:,2));

