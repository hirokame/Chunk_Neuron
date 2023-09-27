function SpikeFormAnalysis20191125

clear all;close all;
path=['C:\Users\C238\CheetahWRLV20220213'];
cd(path)
LS1=ls;
AllCellwidth=[];
AllCellPtoT=[];
MeanFreqArray=[];
SumCell=0;
for i=1:length(LS1(:,1)) %%�}�E�X�ԍ�
    trimFolder1=strtrim(LS1(i,:));
    if  ~strcmp(trimFolder1,'.') && ~strcmp(trimFolder1,'..') && isempty(strfind(trimFolder1,'.mat')) && isempty(strfind(trimFolder1,'.bmp'))...
            && isempty(strfind(trimFolder1,'.fig')) && isempty(strfind(trimFolder1,'CCSfigure')) && isempty(strfind(trimFolder1,'.xlsx'));
        cd([path,'\',trimFolder1]);
        LS2=ls;
        disp(LS2)
        for j=1:length(LS2(:,1)) %%�Z�b�V������
            trimFolder2=strtrim(LS2(j,:));
            disp(trimFolder2)
            if length(trimFolder2)>4;
                dpath3=[path,'\',trimFolder1,'\',trimFolder2];
                cd(dpath3)
                
                %%%%%%%%%%%%Cell��tfile�ۑ�����������������������������������
                CellCellpath=[dpath3,'\','CellCell'];
                cd(CellCellpath)
                LSC=ls;
                TouchCellName=[]; %%responce�̒���"Cell"���܂܂�Ă���זE��(Sc#_SS_##)�𑫂��Ă���
                for x=1:length(LSC(:,1)); %�זE����
                    trimCellFolder=strtrim(LSC(x,:));
                    if length(trimCellFolder)>4 && ~strcmp(trimCellFolder((end-3):end),'.mat');
                        CDFolder5=[CellCellpath,'\',trimCellFolder];
                        cd(CDFolder5)
                        load('response.mat')
                        if length(strfind(response,'Cell'))>0;
                            TouchCellName=[TouchCellName;trimCellFolder];
                        end
                    end
                end
                %%%%%%%%%%%%%%%%%%CellName�g����SpikeForm�̂�݂Ƃ聓������������������������������������������
                cd(dpath3)%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%���ɂ�folder�ɖ߂�
                
                
                %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%ntt�t�@�C���̑I����������������������������������������������������������������
                if ~isempty(TouchCellName); %����}�E�X�̂�����̃f�[�^�̒���"Cell"���܂ލזE������ꍇ
                    for x=1:length(TouchCellName(:,1)) %�זE���Ƃ�
                        CellName=strtrim(TouchCellName(x,:));
                        SumCell=SumCell+1;
                        LS3=ls;
                        for k=1:length(LS3(:,1))
                            trimFolder3=strtrim(LS3(k,:));
                            if length(trimFolder3)>5 & strcmp(trimFolder3(end-3:end),'.ntt') & strcmp(trimFolder3(1:3),CellName(1:3)); %%CheetahWRLV20200411/�}�E�X�ԍ�/�Z�b�V�������@�t�H���_���́@�ړI�̍זE��.ntt�t�@�C�����Q��
                                Filename=[dpath3,'\',trimFolder3];
                                %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
                                FieldSelection(1) = 1;
                                FieldSelection(2) = 1;
                                FieldSelection(3) = 1;
                                FieldSelection(4) = 1;
                                FieldSelection(5) = 1;
                                
                                ExtractHeader = 0;%1�ɂ���Ƃ��܂������Ȃ��B���Ԃ�AHeader���Ȃ��ꍇ������B
                                
                                ExtractMode = 3;%�L�^���ꂽ�_�̂�Extract.�܂�A臒l�𒴂����_�̂݁B
                                
                                ModeArray=[1:100000];%�L�^���ꂽ�_�̐��B�s���Ȃ̂ŁA��ߗʂ�100000�����Ă���BError���\������邪�v�Z���Ă����B
                                
                                [TimeStamps, ScNumbers, CellNumbers, Params, DataPoints] = ...
                                    Nlx2MatSpike( Filename, FieldSelection, ExtractHeader, ExtractMode, ModeArray );
                                %  for n=1:max(CellNumbers)
                                n=str2double(CellName(end));
                                SpikeForm=DataPoints(:,:,CellNumbers==n);%����̍זE�̃X�p�C�N�g�`�𔲂��o���B32*4*n�̎O�����z��
                                MeanSpikeForm=mean(SpikeForm,3);%% axis=3�ŕ��ρA32*4�̔z��@(���ԃr��*�`�����l��)
                                Max=max(MeanSpikeForm);Min=min(MeanSpikeForm); %�ő�l,�ŏ��l 1*4�z��@(�e�g���[�h4�`�����l�����ꂼ��̍ő�A�ŏ�)
                                Dif=Max-Min; %%���σX�p�C�N�`�̍ő�l-�ŏ��l
                                Half=Max-Dif./2;
                                %     find(Dif==max(Dif));
                                tet4width=[];
                                tet4PtoT=[];
                                %     figure
                                for m=1:4
                                    [pks,locs,widths,proms] = findpeaks(MeanSpikeForm(:,m).'); %proms:(�s�[�N�̍���)-(�x�[�X���C��), width:�v���~�l���X�̔����̕�
                                    tet4width=[tet4width widths];
                                    [maxvalue MaxIndex]=max(MeanSpikeForm(:,m).');
                                    [minvalue MinIndex]=min(MeanSpikeForm(MaxIndex:end,m).'); % maxindex����32�܂ł̃X���C�X�̒��ł̍ŏ��l
                                    PtoT=abs(MinIndex); 
                                    tet4PtoT=[tet4PtoT PtoT];
                                    %         subplot(4,1,m)
                                    %         plot(MeanSpikeForm(:,m));hold on
                                    %         plot([1:1:32],ones(1,32)*Half(m),'k');
                                end
                                meanwidth=mean(tet4width);% width��4�`�����l�����̕���
                                AllCellwidth=[AllCellwidth meanwidth]; %�S�Ă̍זE/�Z�b�V������/�}�E�X�ɂ킽����append���Ă���
                                meanPtoT=mean(tet4PtoT);% Peak to Trough�̒l��4�`�����l���ŕ���
                                AllCellPtoT=[AllCellPtoT meanPtoT]; %�S�Ă̍זE/�Z�b�V������/�}�E�X�ɂ킽����append���Ă���
                                %     SumCell=SumCell+max(CellNumbers);
                                %  end
                                % SumCell=SumCell+n;
                                %     if meanPtoT >12;
                                %        disp(trimFolder2);
                                %        trimFolder3
                                %        pause;
                                %     end 
                            end   
                        end
                    end
                    %���ɂ��t�H���_��ɂ���
                    ParameterFolder=[dpath3,'\','ParameterFolder'];
                    cd(ParameterFolder)
                    
                    LSPara=ls;
                    FreqMatrix=[]; %%
                    MeanFreq=[]; %%���̓��̑S�זE�̕��ϔ��Εp�x�̔z�� �@1�~(�זE��)
                    for x=1:length(TouchCellName(:,1))
                        CellName=strtrim(TouchCellName(x,:));%�זE�̑I��
                        FreqArray=[];
                        for i=1:length(LSPara(:,1))
                            TrimParaFL=strtrim(LSPara(i,:));
                            if length(TrimParaFL)>9 && strcmp(TrimParaFL(1:9),CellName(1:9)); %% ���̓��̑S�זE�~�S�Z�b�V�����̃f�[�^�Ł@Sc#_SS_##�̕�������v������̂��Ƃ��Ă���
                                load(TrimParaFL);
                                FreqArray=[FreqArray Freq]; %Freq �� concat
                            end 
                        end
                        FreqMatrix=[FreqMatrix;FreqArray];
                    end
                    for j=1:length(FreqMatrix(:,1))
                        MeanFreq=[MeanFreq;mean(FreqMatrix(j,:))];
                    end
                    MeanFreqArray=[MeanFreqArray; MeanFreq];
                end
            end
        end
    end
end
fig1=figure;
scatter(AllCellwidth,AllCellPtoT); %�P����scatter plot (Figure1��)

X=[AllCellwidth.' AllCellPtoT.'];
[idx,C] = kmeans(X,2);%% 2-means �N���X�^�����O(MSN��INT) C�ɂ�2*2�s�̃N���X�^�̏d�S�ʒu���i�[

fig2=figure;
plot(X(idx==1,1),X(idx==1,2),'r.','MarkerSize',12) %index==1�̕���Ԃ�scatter plot
hold on
plot(X(idx==2,1),X(idx==2,2),'b.','MarkerSize',12) %index==2�̕����scatter plot (Figure2��)
xlabel('kmeans');
cd(path)
widthPtoT=['widthPtoT'];
save(widthPtoT,'X');

eva = evalclusters(X,'kmeans','CalinskiHarabasz','KList',[1:6]); %�œK�ȃN���X�^�[���̕]��
ClusterGroup = eva.OptimalY; % OptimalK(�œK�ȃN���X�^�[��)�ɑΉ�����œK�ȃN���X�^�[�̉�(�����1 or 2)
fig3=figure;
gscatter(X(:,1),X(:,2),ClusterGroup,'rbg','xod'); % width-PtoT�̓񎟌��ŁA�O���[�v���Ƃ�scattter plot�@(Figure3��)


fig7=figure;
scatter(MeanFreqArray.',AllCellPtoT); %�P����scatter plot (Figure7��)

X=[MeanFreqArray AllCellPtoT.'];
[idx,C] = kmeans(X,2);%% 3-means �N���X�^�����O(MSN��INT) C�ɂ�2*2�s�̃N���X�^�̏d�S�ʒu���i�[

fig8=figure;
plot(X(idx==1,1),X(idx==1,2),'r.','MarkerSize',12) %index==1�̕���Ԃ�scatter plot
hold on
plot(X(idx==2,1),X(idx==2,2),'b.','MarkerSize',12) %index==2�̕����scatter plot (Figure8��)
xlabel('kmeans');
cd(path)
widthPtoT=['widthPtoT'];
save(widthPtoT,'X');

eva = evalclusters(X,'kmeans','CalinskiHarabasz','KList',[1:6]); %�œK�ȃN���X�^�[���̕]��
ClusterGroup = eva.OptimalY; % OptimalK(�œK�ȃN���X�^�[��)�ɑΉ�����œK�ȃN���X�^�[�̉�
fig9=figure;
gscatter(X(:,1),X(:,2),ClusterGroup,'rbg','xo'); % Freq-PtoT�̓񎟌��ŁA�O���[�v���Ƃ�scattter plot�@(Figure9��)


fig4=figure;
scatter3(AllCellwidth,AllCellPtoT,MeanFreqArray.'); %�P����3D scatter plot (Figure4��)

X=[AllCellwidth.' AllCellPtoT.' MeanFreqArray];
[idx,C] = kmeans(X,3);%% 3-means �N���X�^�����O(MSN��INT��TAN)
fig5=figure;
plot3(X(idx==1,1),X(idx==1,2),X(idx==1,3),'r.','MarkerSize',12) %index==1�̕���Ԃ�scatter plot
hold on
plot3(X(idx==2,1),X(idx==2,2),X(idx==2,3),'g.','MarkerSize',12) %index==2�̕���΂�scatter plot
hold on
plot3(X(idx==3,1),X(idx==3,2),X(idx==3,3),'b.','MarkerSize',12) %index==3�̕����scatter plot (Figure5��)
xlabel('kmeans');
cd(path)
widthPtoT=['widthPtoT'];
save(widthPtoT,'X');

eva = evalclusters(X,'kmeans','CalinskiHarabasz','KList',[1:6]); %�œK�ȃN���X�^�[���̕]��
ClusterGroup = eva.OptimalY; % OptimalK(�œK�ȃN���X�^�[��)�ɑΉ�����œK�ȃN���X�^�[�̉�
fig6=figure;
gscatter(X(:,1),X(:,2),X(:,3),ClusterGroup,'rbg','xo'); % width-PtoT�̓񎟌��ŁA�O���[�v���Ƃ�scattter plot�@(Figure6��)

saveas(fig1,'SpikeFormAnalysis.bmp');
saveas(fig2,'SpikeFormAnalysis_kmeans.bmp')
saveas(fig3,'SpikeFormAnalysis_kmeans_optimal.bmp')
saveas(fig4,'3D_SpikeFormAnalysis.bmp');
saveas(fig5,'3D_SpikeFormAnalysis_kmeans.bmp')
saveas(fig6,'3D_SpikeFormAnalysis_kmeans_optimal.bmp')
saveas(fig7,'Freq_SpikeFormAnalysis.bmp');
saveas(fig8,'Freq_SpikeFormAnalysis_kmeans.bmp')
saveas(fig9,'Freq_SpikeFormAnalysis_kmeans_optimal.bmp')