function SpikeFormAnalysis20191125

clear all;close all;
path=['C:\Users\C238\CheetahWRLV20220213'];
cd(path)
LS1=ls;
AllCellwidth=[];
AllCellPtoT=[];
MeanFreqArray=[];
SumCell=0;
for i=1:length(LS1(:,1)) %%マウス番号
    trimFolder1=strtrim(LS1(i,:));
    if  ~strcmp(trimFolder1,'.') && ~strcmp(trimFolder1,'..') && isempty(strfind(trimFolder1,'.mat')) && isempty(strfind(trimFolder1,'.bmp'))...
            && isempty(strfind(trimFolder1,'.fig')) && isempty(strfind(trimFolder1,'CCSfigure')) && isempty(strfind(trimFolder1,'.xlsx'));
        cd([path,'\',trimFolder1]);
        LS2=ls;
        disp(LS2)
        for j=1:length(LS2(:,1)) %%セッション日
            trimFolder2=strtrim(LS2(j,:));
            disp(trimFolder2)
            if length(trimFolder2)>4;
                dpath3=[path,'\',trimFolder1,'\',trimFolder2];
                cd(dpath3)
                
                %%%%%%%%%%%%Cellのtfile保存％％％％％％％％％％％％％％％％％
                CellCellpath=[dpath3,'\','CellCell'];
                cd(CellCellpath)
                LSC=ls;
                TouchCellName=[]; %%responceの中に"Cell"が含まれている細胞名(Sc#_SS_##)を足していく
                for x=1:length(LSC(:,1)); %細胞ごと
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
                %%%%%%%%%%%%%%%%%%CellName使ってSpikeFormのよみとり％％％％％％％％％％％％％％％％％％％％％％
                cd(dpath3)%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%日にちfolderに戻る
                
                
                %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%nttファイルの選択％％％％％％％％％％％％％％％％％％％％％％％％％％％％％％％
                if ~isempty(TouchCellName); %あるマウスのある日のデータの中に"Cell"を含む細胞がある場合
                    for x=1:length(TouchCellName(:,1)) %細胞ごとに
                        CellName=strtrim(TouchCellName(x,:));
                        SumCell=SumCell+1;
                        LS3=ls;
                        for k=1:length(LS3(:,1))
                            trimFolder3=strtrim(LS3(k,:));
                            if length(trimFolder3)>5 & strcmp(trimFolder3(end-3:end),'.ntt') & strcmp(trimFolder3(1:3),CellName(1:3)); %%CheetahWRLV20200411/マウス番号/セッション日　フォルダ内の　目的の細胞の.nttファイルを参照
                                Filename=[dpath3,'\',trimFolder3];
                                %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
                                FieldSelection(1) = 1;
                                FieldSelection(2) = 1;
                                FieldSelection(3) = 1;
                                FieldSelection(4) = 1;
                                FieldSelection(5) = 1;
                                
                                ExtractHeader = 0;%1にするとうまくいかない。たぶん、Headerがない場合がある。
                                
                                ExtractMode = 3;%記録された点のみExtract.つまり、閾値を超えた点のみ。
                                
                                ModeArray=[1:100000];%記録された点の数。不明なので、大過量の100000を入れてある。Errorが表示されるが計算してくれる。
                                
                                [TimeStamps, ScNumbers, CellNumbers, Params, DataPoints] = ...
                                    Nlx2MatSpike( Filename, FieldSelection, ExtractHeader, ExtractMode, ModeArray );
                                %  for n=1:max(CellNumbers)
                                n=str2double(CellName(end));
                                SpikeForm=DataPoints(:,:,CellNumbers==n);%特定の細胞のスパイク波形を抜き出す。32*4*nの三次元配列
                                MeanSpikeForm=mean(SpikeForm,3);%% axis=3で平均、32*4の配列　(時間ビン*チャンネル)
                                Max=max(MeanSpikeForm);Min=min(MeanSpikeForm); %最大値,最小値 1*4配列　(テトロード4チャンネルそれぞれの最大、最小)
                                Dif=Max-Min; %%平均スパイク形の最大値-最小値
                                Half=Max-Dif./2;
                                %     find(Dif==max(Dif));
                                tet4width=[];
                                tet4PtoT=[];
                                %     figure
                                for m=1:4
                                    [pks,locs,widths,proms] = findpeaks(MeanSpikeForm(:,m).'); %proms:(ピークの高さ)-(ベースライン), width:プロミネンスの半分の幅
                                    tet4width=[tet4width widths];
                                    [maxvalue MaxIndex]=max(MeanSpikeForm(:,m).');
                                    [minvalue MinIndex]=min(MeanSpikeForm(MaxIndex:end,m).'); % maxindexから32までのスライスの中での最小値
                                    PtoT=abs(MinIndex); 
                                    tet4PtoT=[tet4PtoT PtoT];
                                    %         subplot(4,1,m)
                                    %         plot(MeanSpikeForm(:,m));hold on
                                    %         plot([1:1:32],ones(1,32)*Half(m),'k');
                                end
                                meanwidth=mean(tet4width);% widthの4チャンネル分の平均
                                AllCellwidth=[AllCellwidth meanwidth]; %全ての細胞/セッション日/マウスにわたってappendしていく
                                meanPtoT=mean(tet4PtoT);% Peak to Troughの値を4チャンネルで平均
                                AllCellPtoT=[AllCellPtoT meanPtoT]; %全ての細胞/セッション日/マウスにわたってappendしていく
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
                    %日にちフォルダ上にいる
                    ParameterFolder=[dpath3,'\','ParameterFolder'];
                    cd(ParameterFolder)
                    
                    LSPara=ls;
                    FreqMatrix=[]; %%
                    MeanFreq=[]; %%この日の全細胞の平均発火頻度の配列 　1×(細胞数)
                    for x=1:length(TouchCellName(:,1))
                        CellName=strtrim(TouchCellName(x,:));%細胞の選択
                        FreqArray=[];
                        for i=1:length(LSPara(:,1))
                            TrimParaFL=strtrim(LSPara(i,:));
                            if length(TrimParaFL)>9 && strcmp(TrimParaFL(1:9),CellName(1:9)); %% その日の全細胞×全セッションのデータで　Sc#_SS_##の部分が一致するものをとってくる
                                load(TrimParaFL);
                                FreqArray=[FreqArray Freq]; %Freq を concat
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
scatter(AllCellwidth,AllCellPtoT); %単純にscatter plot (Figure1つ目)

X=[AllCellwidth.' AllCellPtoT.'];
[idx,C] = kmeans(X,2);%% 2-means クラスタリング(MSNとINT) Cには2*2行のクラスタの重心位置が格納

fig2=figure;
plot(X(idx==1,1),X(idx==1,2),'r.','MarkerSize',12) %index==1の方を赤でscatter plot
hold on
plot(X(idx==2,1),X(idx==2,2),'b.','MarkerSize',12) %index==2の方を青でscatter plot (Figure2つ目)
xlabel('kmeans');
cd(path)
widthPtoT=['widthPtoT'];
save(widthPtoT,'X');

eva = evalclusters(X,'kmeans','CalinskiHarabasz','KList',[1:6]); %最適なクラスター数の評価
ClusterGroup = eva.OptimalY; % OptimalK(最適なクラスター数)に対応する最適なクラスターの解(今回は1 or 2)
fig3=figure;
gscatter(X(:,1),X(:,2),ClusterGroup,'rbg','xod'); % width-PtoTの二次元で、グループごとにscattter plot　(Figure3つ目)


fig7=figure;
scatter(MeanFreqArray.',AllCellPtoT); %単純にscatter plot (Figure7つ目)

X=[MeanFreqArray AllCellPtoT.'];
[idx,C] = kmeans(X,2);%% 3-means クラスタリング(MSNとINT) Cには2*2行のクラスタの重心位置が格納

fig8=figure;
plot(X(idx==1,1),X(idx==1,2),'r.','MarkerSize',12) %index==1の方を赤でscatter plot
hold on
plot(X(idx==2,1),X(idx==2,2),'b.','MarkerSize',12) %index==2の方を青でscatter plot (Figure8つ目)
xlabel('kmeans');
cd(path)
widthPtoT=['widthPtoT'];
save(widthPtoT,'X');

eva = evalclusters(X,'kmeans','CalinskiHarabasz','KList',[1:6]); %最適なクラスター数の評価
ClusterGroup = eva.OptimalY; % OptimalK(最適なクラスター数)に対応する最適なクラスターの解
fig9=figure;
gscatter(X(:,1),X(:,2),ClusterGroup,'rbg','xo'); % Freq-PtoTの二次元で、グループごとにscattter plot　(Figure9つ目)


fig4=figure;
scatter3(AllCellwidth,AllCellPtoT,MeanFreqArray.'); %単純に3D scatter plot (Figure4つ目)

X=[AllCellwidth.' AllCellPtoT.' MeanFreqArray];
[idx,C] = kmeans(X,3);%% 3-means クラスタリング(MSNとINTとTAN)
fig5=figure;
plot3(X(idx==1,1),X(idx==1,2),X(idx==1,3),'r.','MarkerSize',12) %index==1の方を赤でscatter plot
hold on
plot3(X(idx==2,1),X(idx==2,2),X(idx==2,3),'g.','MarkerSize',12) %index==2の方を緑でscatter plot
hold on
plot3(X(idx==3,1),X(idx==3,2),X(idx==3,3),'b.','MarkerSize',12) %index==3の方を青でscatter plot (Figure5つ目)
xlabel('kmeans');
cd(path)
widthPtoT=['widthPtoT'];
save(widthPtoT,'X');

eva = evalclusters(X,'kmeans','CalinskiHarabasz','KList',[1:6]); %最適なクラスター数の評価
ClusterGroup = eva.OptimalY; % OptimalK(最適なクラスター数)に対応する最適なクラスターの解
fig6=figure;
gscatter(X(:,1),X(:,2),X(:,3),ClusterGroup,'rbg','xo'); % width-PtoTの二次元で、グループごとにscattter plot　(Figure6つ目)

saveas(fig1,'SpikeFormAnalysis.bmp');
saveas(fig2,'SpikeFormAnalysis_kmeans.bmp')
saveas(fig3,'SpikeFormAnalysis_kmeans_optimal.bmp')
saveas(fig4,'3D_SpikeFormAnalysis.bmp');
saveas(fig5,'3D_SpikeFormAnalysis_kmeans.bmp')
saveas(fig6,'3D_SpikeFormAnalysis_kmeans_optimal.bmp')
saveas(fig7,'Freq_SpikeFormAnalysis.bmp');
saveas(fig8,'Freq_SpikeFormAnalysis_kmeans.bmp')
saveas(fig9,'Freq_SpikeFormAnalysis_kmeans_optimal.bmp')