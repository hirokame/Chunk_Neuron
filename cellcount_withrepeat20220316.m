function cellcount_withrepeat20220316

%%% ヒートマップ0~5(何回当てはまったか)それぞれの解析
%%% それぞれのヒートマップの一番大きな値or上位1/4とかでその細胞の繰り返し時の発火頻度を計算する。

path='C:\Users\C238\CheetahWRLV20220213\touchcellLtRt_Hirokane';

MSN=0;
modBgracount=0;
mod98count=0;
modRrepcount=0;
modLrepcount=0;
modRepcount=0;
modBgra98count=0;
modBgraRepcount=0;
mod98Repcount=0;
modBgra98Repcount=0;
cd(path)
LS = ls;

for i=1:length(LS) %それぞれの細胞でイテレーションを回す。 
    folder = LS(i,:);
    if ~isempty(strfind(folder,'.'))
        continue
    end
    path1 = [path, '\', folder];
    cd(path1)
    load('response.mat');
    response
    if ~isempty(strfind(response,'MSN'));
        MSN=MSN+1;
    end
    if ~isempty(strfind(response,'modBgra'));
        modBgracount=modBgracount+1;
    end
    if ~isempty(strfind(response,'mod98'));
        mod98count=mod98count+1;
    end
    if ~isempty(strfind(response,'Rrep'));
        modRrepcount=modRrepcount+1;
    end
    if ~isempty(strfind(response,'Lrep'));
        modLrepcount=modLrepcount+1;
    end
    if ~isempty(strfind(response,'rep'));
        modRepcount=modRepcount+1;
    end
    if ~isempty(strfind(response,'modBgra')) && ~isempty(strfind(response,'mod98'));
        modBgra98count=modBgra98count+1;
    end
    if ~isempty(strfind(response,'modBgra')) && ~isempty(strfind(response,'rep'));
        modBgraRepcount=modBgraRepcount+1;
    end
    if ~isempty(strfind(response,'mod98')) && ~isempty(strfind(response,'rep'));
        mod98Repcount=mod98Repcount+1;
    end
    if ~isempty(strfind(response,'modBgra')) && ~isempty(strfind(response,'mod98')) && ~isempty(strfind(response,'rep'));
        modBgra98Repcount=modBgra98Repcount+1;
    end
end

MSN
modBgracount
mod98count
modRrepcount
modLrepcount
modRepcount
modBgra98count
modBgraRepcount
mod98Repcount
modBgra98Repcount