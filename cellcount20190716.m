function cellcount20190716


path='C:\Users\C238\CheetahWRLV20220213';

cd(path)

LS1=ls;
Cellsum=0;%% �S�Ă̍זE��
Rtcountsum=0;%% �E���̃^�b�`�ɔ��������זE��
Ltcountsum=0;%% �����̃^�b�`�ɔ��������זE��
RtLtcountsum=0;%% ���E�̑��̃^�b�`�ɔ��������זE��
Woncountsum=0;%% Water on�̂Ƃ��ɔ�������זE
Woffcountsum=0;%% Water off�̎��ɔ�������זE
WonWoffcountsum=0;%% On�ł�Off�ł���������זE
Doncountsum=0;%% �����݂��Ă���Ƃ��ɔ�������זE
DonDRDLcountsum=0;
WoDoncountsum=0;%% water on�Ɛ����݂ɔ�������זE
tDoncountsum=0;%% ���̃^�b�`�Ɛ����݂ɔ�������זE
Wotcountsum=0;%% water on�ƃ^�b�`�ɔ�������זE
tWoDoncountsum=0;%%  �^�b�`��water on �Ɛ����݂ɔ�������זE
modBgracountsum=0;%% Bgra�̃��W�����[�V���������זE
mod98countsum=0;%% 98
modBgra98countsum=0;%% Bgra��98
for i=1:length(LS1(:,1)) %%���ꂼ��̃}�E�X���ƂɃt�@�C���𑖍�
    trimFolder=strtrim(LS1(i,:));
    if  ~strcmp(trimFolder,'.') && ~strcmp(trimFolder,'..') && isempty(strfind(trimFolder,'.mat')) && isempty(strfind(trimFolder,'.bmp'))...
            && isempty(strfind(trimFolder,'.fig')) && isempty(strfind(trimFolder,'CCSfigure')) && isempty(strfind(trimFolder,'.xlsx'))...
            && isempty(strfind(trimFolder,'Heatmap')) && isempty(strfind(trimFolder,'Hirokane')) && isempty(strfind(trimFolder,'Chunk'))...
            && isempty(strfind(trimFolder,'Window')) && isempty(strfind(trimFolder,'touchcell'));
        CDFolder=[path,'\',trimFolder];
        cd(CDFolder);
        LS2=ls;
        for j=1:length(LS2(:,1))%%�}�E�X���̃Z�b�V���������ƂɃt�@�C�����Q��
            trimFolder2=strtrim(LS2(j,:));
            if length(trimFolder2)>4;
                CDFolder2=[CDFolder,'\',trimFolder2];
                cd(CDFolder2);
                CDFolder3=[CDFolder2,'\CellCell2'];
                cd(CDFolder3)
                count=['count.mat'];
                load(count) %%�}�E�X�ԍ�/�Z�b�V������/CellCell/count.mat�@�t�@�C����ǂݍ���
                Cellsum=Cellsum+Cells; %%count�t�@�C�����ɂ�Cells, Rtcount�Ȃǂ̐����������Ă���A����𑫂��Ă���
                Rtcountsum=Rtcountsum+Rtcount;
                Ltcountsum=Ltcountsum+Ltcount;
                RtLtcountsum=RtLtcountsum+RtLtcount;
                Woncountsum=Woncountsum+Woncount;
                Woffcountsum=Woffcountsum+Woffcount;
                WonWoffcountsum=WonWoffcountsum+WonWoffcount;
                Doncountsum=Doncountsum+Doncount;
                DonDRDLcountsum=DonDRDLcountsum+DonDRDLcount;
                WoDoncountsum=WoDoncountsum+WoDoncount;
                tDoncountsum=tDoncountsum+tDoncount;
                Wotcountsum=Wotcountsum+Wotcount;
                tWoDoncountsum=tWoDoncountsum+tWoDoncount;
                modBgracountsum=modBgracountsum+modBgracount;
                mod98countsum=mod98countsum+mod98count;
                modBgra98countsum=modBgra98countsum+modBgra98count;
            end
        end
    end
    cd(path)
end
cd(path)
countArray=[Cellsum;Rtcountsum;Ltcountsum;RtLtcountsum;Woncountsum;Woffcountsum;WonWoffcountsum;Doncountsum;DonDRDLcountsum;WoDoncountsum;tDoncountsum;Wotcountsum;tWoDoncountsum;modBgracountsum;mod98countsum;modBgra98countsum];
filename=['Count.xlsx'];
xlswrite(filename,countArray);

