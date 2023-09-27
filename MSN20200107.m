function MSN20200107

global  dpath3
%
% trimtfile=strtrim(tfile);

Old=cd;
cd(dpath3)
LS=ls;
for i=1:length(LS(:,1)) % Sc#_SS_##.t　ファイルを回す
    trimFL=strtrim(LS(i,:));
    if length(trimFL)>4 && strcmp(trimFL(end-1:end),'.t');
        trimtfile=strtrim(trimFL);
        nttfile=[trimtfile(1:3),'.ntt'];
        Filename=[dpath3,'\',nttfile];
        
        %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
        FieldSelection(1) = 1;
        FieldSelection(2) = 1;
        FieldSelection(3) = 1;
        FieldSelection(4) = 1;
        FieldSelection(5) = 1;
        
        ExtractHeader = 0;%1にするとうまくいかない。たぶん、Headerがない場合がある。
        
        ExtractMode = 3;%記録された点のみExtract.つまり、閾値を超えた点のみ。
        
        ModeArray=[1:30000];%記録された点の数。不明なので、大過量の100000を入れてある。Errorが表示されるが計算してくれる。
        
        [TimeStamps, ScNumbers, CellNumbers, Params, DataPoints] = ...
            Nlx2MatSpike( Filename, FieldSelection, ExtractHeader, ExtractMode, ModeArray );
        %  for n=1:max(CellNumbers)
        n=str2double(trimtfile(end-2));
        SpikeForm=DataPoints(:,:,CellNumbers==n);%特定の細胞のスパイク波形を抜き出す。
        MeanSpikeForm=mean(SpikeForm,3);
        Max=max(MeanSpikeForm);Min=min(MeanSpikeForm);
        Dif=Max-Min;
        Half=Max-Dif./2;
        %     find(Dif==max(Dif));
        tet4width=[];
        tet4PtoT=[];
        %     figure
        for m=1:4
            [pks,locs,widths,proms] = findpeaks(MeanSpikeForm(:,m).');
            tet4width=[tet4width widths];
            [maxvalue MaxIndex]=max(MeanSpikeForm(:,m).');
            [minvalue MinIndex]=min(MeanSpikeForm(:,m).');
            PtoT=abs(MaxIndex-MinIndex);
            tet4PtoT=[tet4PtoT PtoT];
            %         subplot(4,1,m)
            %         plot(MeanSpikeForm(:,m));hold on
            %         plot([1:1:32],ones(1,32)*Half(m),'k');
        end
        meanwidth=mean(tet4width);%tet4width:1つの細胞の4チャンネル分のHalfPeakwidthのビン数
        %     AllCellwidth=[AllCellwidth meanwidth];
        meanPtoT=mean(tet4PtoT);%tet4ptoT:1つの細胞の4チャンネル分のPeaktoTroughのビン数
        %     AllCellPtoT=[AllCellPtoT meanPtoT];
        %     SumCell=SumCell+max(CellNumbers);
        
        thresholdwidth=5;
        thresholdPtoT=10;
        
        Old2=cd;
        Folder=[dpath3,'\CellCell\',trimtfile(1:end-2)];
        cd(Folder)
        load('response.mat');
        % if ~isempty(strfind(response,'MSN'))
        %    response=erase(response,'MSN');
        % end
        if isempty(strfind(response,'Cell')) %%Cell認定されていなければ次のloopへ
            continue
        else %% 両方threshold以上ならMSN、両方threshold以下ならFSI、それ以外の細胞はITNの文字列を付け加える。
            if isempty(strfind(response,'MSN'));
                if meanwidth>thresholdwidth && meanPtoT>thresholdPtoT;
                    response=[response,'MSN'];
                end
                if meanwidth<thresholdwidth && meanPtoT<thresholdPtoT;
                    response=[response,'FSI'];
                end
                if isempty(strfind(response,'FSI')) && isempty(strfind(response,'MSN'));
                    response=[response,'ITN'];
                end
            end
        end
        filename=['response'];
        save(filename,'response');
        cd(Old2)
    end
end