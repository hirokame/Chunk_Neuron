function cellcount_withrepeat20220316

%%% �q�[�g�}�b�v0~5(���񓖂Ă͂܂�����)���ꂼ��̉��
%%% ���ꂼ��̃q�[�g�}�b�v�̈�ԑ傫�Ȓlor���1/4�Ƃ��ł��̍זE�̌J��Ԃ����̔��Εp�x���v�Z����B

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

for i=1:length(LS) %���ꂼ��̍זE�ŃC�e���[�V�������񂷁B 
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