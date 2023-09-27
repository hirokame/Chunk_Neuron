function touch_lick_phase
global FigureSave ShowFig dpath3 Both_modnum_L Both_modnum_R All_modnum SignificantNeuron_L SignificantNeuron_R SignificantNeuron_3d


CoreDir='C:\Users\C238\CheetahWRLV20220213';
cd(CoreDir);

FigureSave=0;
ShowFig=0;
% Drink_modnum = 0;
% Touch_modnum = 0;
Both_modnum_L = 0;
Both_modnum_R = 0;
All_modnum = 0;
SignificantNeuron_L = [];
SignificantNeuron_R = [];
SignificantNeuron_3d = [];
H=ls;
for n=1:length(H(:,1)) %%マウス番号
    Mouse=strtrim(H(n,:));
    if ~strcmp(Mouse,'.') && ~strcmp(Mouse,'..') && isempty(strfind(Mouse,'.mat')) && isempty(strfind(Mouse,'.bmp')) && isempty(strfind(Mouse,'.fig'))...
            && isempty(strfind(Mouse,'.xlsx')) && isempty(strfind(Mouse, 'Hirokane'))&& isempty(strfind(Mouse, 'Heatmap'))&& isempty(strfind(Mouse, 'Chunk'))...
            && isempty(strfind(Mouse, 'CCSfigure'))&& isempty(strfind(Mouse, 'touchcellLtRt'));
        cd([CoreDir '\' Mouse]);
        H2=ls;
        M=[];
        for m=1:length(H2(:,1))%%セッション日
            Day=strtrim(H2(m,:));
            if length(Day)>2 && isdir(Day)%~strcmp(TrimStr2(end-4:end),'pptx')
                dpath3=[CoreDir '\' Mouse '\' Day];
%                 if isempty(strfind(Mouse, '70')) || isempty(strfind(Day, '2018-8-28'))
%                     continue
%                 end
                SessionSpike20180625(dpath3, Mouse, Day)
            end
        end
    end
end

function SessionSpike20180625(dpath3, Mouse, Day)%pushbutton_SpikeAnalysis2_Callback(hObject, eventdata, handles)
close all;

global StartTime FinishTime fname SpikeUnits DrinkOnArray SpikeArray TrimStr tfiles dpath ...
    CrossCoWonCell CrossCoWoffCell NumWon NumWoff CleanWater CleanInterval OnWater SpikeArrayWon MotorArrayWon LpegTouchallWon RpegTouchallWon SpikeName TrimStrB FLName...
    Both_modnum_L Both_modnum_R All_modnum SignificantNeuron_L SignificantNeuron_R SignificantNeuron_3d

CleanInterval=1500;
CleanWater=1;%WaterOn, WaterOffをきれいにする（3秒間以上空白の後のWaterOnのみ使用、など）なら1、SpikeAnalysisでは0,SpikeAnalysis2では1
CrossCoWonCell=cell(1,2);
CrossCoWoffCell=cell(1,2);
NumWon=[];
NumWoff=[];

cd(char(dpath3));
dpath=[dpath3,'\'];
SpikeUnits={};
SpikeUnitsWon={};
SpikeName=cell(1,2);
h=ls;
M=0;

for n=1:length(h(:,1))
    TrimStrB=strtrim(h(n,:));
    if length(TrimStrB)>2 && ~strcmp(TrimStrB(1:5),'Event');
        if strcmp(TrimStrB(end-3:end),'.mat')
            if ~strcmp(TrimStrB(end-4:end),'V.mat') && ~strcmp(TrimStrB(1),'a') && ~strcmp(TrimStrB(1),'B') && isempty(strfind(TrimStrB,'touchfile')) %%.matファイルのみを読み込む
%                 if isempty(strfind(TrimStrB, 'C10+'))
%                     continue
%                 end
                M=M+1;
                cd(char(dpath3));
                [SUCCESS,MESSAGE,MESSAGEID] = mkdir(TrimStrB(1:length(TrimStrB)-4));
                if ~strcmp(MESSAGE,'Directory already exists.')%MESSAGE=='ディレクトリが既に存在します。'
                    mkdir(TrimStrB(1:length(TrimStrB)-4));
                end
                FLName=[dpath,TrimStrB(1:length(TrimStrB)-4)];     
                cd(FLName);
                
                fname=TrimStrB;
                Dataload;             %_pushbutton_Callback(hObject, eventdata, handles);
                % % % % % % %         PegTouchAnalysis24ch_SSanalysis(R_PegTouchCell,L_PegTouchCell,TurnMarkerTime,OneTurnTime,RpegTimeArray2D,LpegTimeArray2D,1)
                
                U=0;
                for N=1:length(h(:,1))
                    TrimStr=strtrim(h(N,:));
                    if length(TrimStr)>2;
                        if TrimStr(end-1:end) == '.t'% & h(k,:)~='.';%length(h(k,:))>5;
%                             if isempty(strfind(TrimStr, 'Sc8_SS_02'))
%                                 continue
%                             end
                            response_pass = [dpath '\CellCell2\' TrimStr(1:end-2) '\response.mat'];
                            load(response_pass)
                            if isempty(strfind(response, 'Don')) || isempty(strfind(response, 't'))
                                continue
                            end
                            U=U+1;
                            SpikeName{U}=TrimStr;
                            
                            SpikeArray=GetSpikeAll(dpath3,h(N,:));
                            
                            SpikeArrayWon=[];
                            SpikeArray(SpikeArray<StartTime | SpikeArray>FinishTime)=[];
                            SpikeUnits{U}=SpikeArray;
                            %WaterOnのときのみのスパイク
                            if ~isempty(SpikeArray)
                                SpikeWon=ones(1,length(SpikeArray));
                                for k=1:length(SpikeArray)
                                    if OnWater(SpikeArray(k))==0
                                        SpikeWon(k)=0;
                                    end
                                end
                                SpikeArrayWon=SpikeArray.*SpikeWon;
                                SpikeArrayWon(SpikeArrayWon==0)=[];
                                SpikeUnitsWon{U}=SpikeArrayWon;
                            else
                                SpikeUnitsWon{U}=0;
                            end
                            
                            
                            %%% 各SpikeのTouch/Lickに対するPhaseを判定していく。
                            phase2DL = [];
                            phase2DR = [];
                            phase3D = [];
                            for i=1:length(SpikeArrayWon)
                                
                                %%%Lickingの位相を計算
                                Drinkpre = DrinkOnArray(DrinkOnArray<SpikeArrayWon(i));
                                if numel(Drinkpre)==0
                                    continue
                                end
                                Drinkpre = Drinkpre(end);
                                Drinkpost = DrinkOnArray(DrinkOnArray>SpikeArrayWon(i));
                                if numel(Drinkpost)==0
                                    continue
                                end
                                Drinkpost = Drinkpost(1);
                                
                                %%% Left Touchの位相を計算
                                LTouchpre = LpegTouchallWon(LpegTouchallWon<SpikeArrayWon(i));
                                if numel(LTouchpre)==0
                                    continue
                                end
                                LTouchpre = LTouchpre(end);
                                LTouchpost = LpegTouchallWon(LpegTouchallWon>SpikeArrayWon(i));
                                if numel(LTouchpost)==0
                                    continue
                                end
                                LTouchpost = LTouchpost(1);
                                if numel(LTouchpost)==0 || numel(LTouchpre)==0
                                    continue
                                end
                                
                                %%% Right Touchの位相を計算
                                RTouchpre = RpegTouchallWon(RpegTouchallWon<SpikeArrayWon(i));
                                if numel(RTouchpre)==0
                                    continue
                                end
                                RTouchpre = RTouchpre(end);
                                RTouchpost = RpegTouchallWon(RpegTouchallWon>SpikeArrayWon(i));
                                if numel(RTouchpost)==0
                                    continue
                                end
                                RTouchpost = RTouchpost(1);
                                if numel(RTouchpost)==0 || numel(RTouchpre)==0
                                    continue
                                end
                                
                                %%% LickingとTouchの最低限のCliteria
                                if 90<Drinkpost-Drinkpre<150 && 250<LTouchpost-LTouchpre<500
                                    phase2DL = [phase2DL; [(SpikeArrayWon(i)-Drinkpre)/(Drinkpost-Drinkpre), (SpikeArrayWon(i)-LTouchpre)/(LTouchpost-LTouchpre)]];
                                    if 250<RTouchpost-RTouchpre<500
                                        phase3D = [phase3D; [0.5-0.5*cos(2*pi*(SpikeArrayWon(i)-Drinkpre)/(Drinkpost-Drinkpre)), 0.5-0.5*cos(2*pi*(SpikeArrayWon(i)-LTouchpre)/(LTouchpost-LTouchpre)), 0.5-0.5*cos(2*pi*(SpikeArrayWon(i)-RTouchpre)/(RTouchpost-RTouchpre))]];
                                    end 
                                end
                                if 90<Drinkpost-Drinkpre<150 && 250<RTouchpost-RTouchpre<500
                                    phase2DR = [phase2DR; [(SpikeArrayWon(i)-Drinkpre)/(Drinkpost-Drinkpre), (SpikeArrayWon(i)-RTouchpre)/(RTouchpost-RTouchpre)]];
                                end
                            end
                            
                            %%%　データポイントがないならcontinue
                            if isempty(phase3D)
                                continue
                            end
                            
                            
                            
                            %%% 10000分割で仮想的な点を打ってTouch/Lickに対するPhaseを判定していく(運動の位相のサイクルをプロット)。
%                             MotorArrayWon = linspace(SpikeArrayWon(1),SpikeArrayWon(end), 10000);
%                             motorphase3D = [];
%                             for i=1:length(MotorArrayWon)
%                                 
%                                 %%%Lickingの位相を計算
%                                 Drinkpre = DrinkOnArray(DrinkOnArray<MotorArrayWon(i));
%                                 if numel(Drinkpre)==0
%                                     continue
%                                 end
%                                 Drinkpre = Drinkpre(end);
%                                 Drinkpost = DrinkOnArray(DrinkOnArray>MotorArrayWon(i));
%                                 if numel(Drinkpost)==0
%                                     continue
%                                 end
%                                 Drinkpost = Drinkpost(1);
%                                 
%                                 %%% Left Touchの位相を計算
%                                 LTouchpre = LpegTouchallWon(LpegTouchallWon<MotorArrayWon(i));
%                                 if numel(LTouchpre)==0
%                                     continue
%                                 end
%                                 LTouchpre = LTouchpre(end);
%                                 LTouchpost = LpegTouchallWon(LpegTouchallWon>MotorArrayWon(i));
%                                 if numel(LTouchpost)==0
%                                     continue
%                                 end
%                                 LTouchpost = LTouchpost(1);
%                                 if numel(LTouchpost)==0 || numel(LTouchpre)==0
%                                     continue
%                                 end
%                                 
%                                 %%% Right Touchの位相を計算
%                                 RTouchpre = RpegTouchallWon(RpegTouchallWon<MotorArrayWon(i));
%                                 if numel(RTouchpre)==0
%                                     continue
%                                 end
%                                 RTouchpre = RTouchpre(end);
%                                 RTouchpost = RpegTouchallWon(RpegTouchallWon>MotorArrayWon(i));
%                                 if numel(RTouchpost)==0
%                                     continue
%                                 end
%                                 RTouchpost = RTouchpost(1);
%                                 if numel(RTouchpost)==0 || numel(RTouchpre)==0
%                                     continue
%                                 end
%                                 
%                                 %%% LickingとTouchの最低限のCliteria
%                                 if 90<(Drinkpost-Drinkpre)<150 && 250<(LTouchpost-LTouchpre)<500 && 250<(RTouchpost-RTouchpre)<500
%                                     motorphase3D = [motorphase3D; [0.5-0.5*cos(2*pi*(MotorArrayWon(i)-Drinkpre)/(Drinkpost-Drinkpre)),0.5-0.5*cos(2*pi*(MotorArrayWon(i)-LTouchpre)/(LTouchpost-LTouchpre)), 0.5-0.5*cos(2*pi*(MotorArrayWon(i)-RTouchpre)/(RTouchpost-RTouchpre))]];
%                                 end
%                             end
                            
                            
                            %%%それぞれのLickingに対してTouchの位相を計算
                            lick_phase = [];
                            for i=1:length(DrinkOnArray)
                               %%%Lickingの位相を計算
                                TouchPre = LpegTouchallWon(LpegTouchallWon<DrinkOnArray(i));
                                if numel(TouchPre)==0
                                    continue
                                end
                                TouchPre = TouchPre(end);
                                TouchPost = LpegTouchallWon(LpegTouchallWon>DrinkOnArray(i));
                                if numel(TouchPost)==0
                                    continue
                                end
                                TouchPost = TouchPost(1); 
                                if 250 < TouchPost-TouchPre < 500
                                    lick_phase = [lick_phase; (DrinkOnArray(i)-TouchPre)/(TouchPost-TouchPre)];
                                end
                            end
                            %%% Neuronの識別番号(Mouse, Day, テトロード番号)
                            neuronID = [Mouse Day(1:10) '_' TrimStr(1:end-2)];
                            
                            savefig = ['C:\Users\C238\phase2D_responsive\' neuronID TrimStrB(end-8:end-4) '.bmp'];
                            savefig2 = ['C:\Users\C238\phase2D_responsive\' neuronID TrimStrB(end-8:end-4) 'histogram.bmp'];
                            savemat = ['C:\Users\C238\phase2D_responsive\' neuronID TrimStrB(end-8:end-4) '.mat'];
                            saveresponse = [dpath '\CellCell2\' TrimStr(1:end-2) '\response.mat'];
                            savelick = [dpath '\CellCell2\' TrimStr(1:end-2) '\' TrimStrB(end-8:end-4) 'lickphase.mat'];
                            
                            %%%　Left Touchとlickの2次元マップ
                            if length(phase2DL)>50
                                Drink_hst_L = zscore(histcounts(phase2DL(:,1),10, 'BinLimits', [0,1]));
                                Figure1=figure();
                                scatterhist(phase2DL(:,1), phase2DL(:,2),'Kernel','on','Location','SouthEast','Direction','out', 'Marker', '.', 'MarkerSize', 9, 'Color', 'k')
                                xlim([0,1])
                                ylim([0,1])
                                saveas(Figure1, savefig)

                                Figure5=figure();
                                firehist = histcounts(phase2DL(:,2),4, 'BinLimits',[0,1]);
                                subplot(2,2,1)
                                plot(firehist)
                                xlim([1,4])
                                ylim([0,inf])
                                title('Touch Phase Histogram(fire event)')

                                subplot(2,2,2)
                                lickhist = histcounts(lick_phase,4,'BinLimits',[0,1]);
                                plot(lickhist)
                                title('Touch Phase Histogram(licking)')
                                xlim([1,4])
                                ylim([0,inf])

                                subplot(2,2,3)
                                dividehist = firehist./(lickhist+1);
                                plot(dividehist)
                                xlim([1,4])
                                ylim([0,inf])
                                Zmax = max(zscore(dividehist));
                                maxratio_touch = max(dividehist)/mean(dividehist);
                                thema = ['Divide histogram (ratio=' num2str(maxratio_touch) ')'];
                                title(thema)

                                subplot(2,2,4)
                                lickphasehist = histcounts(phase2DL(:,1),10, 'BinLimits', [0,1]);
                                plot(lickphasehist)
                                xlim([1,10])
                                ylim([0,inf])
                                Zlickmax = max(zscore(lickphasehist));
                                maxratio_lick = max(lickphasehist)/mean(lickphasehist);
                                thema = ['lick phase hist(ratio=' num2str(maxratio_lick) ')'];
                                title(thema)
                                saveas(Figure5, savefig2)
                                
                                if maxratio_touch>2 && maxratio_lick>2 && isempty(strfind(response, 'LiPh')) && ~isempty(strfind(response, 'Don'))
                                    response = [response 'LiPh'];
                                end

                                save(savemat, 'phase2DL', 'dividehist', 'lickphasehist', 'Zmax', 'Zlickmax', 'maxratio_touch', 'maxratio_lick', 'response')
                                save(saveresponse, 'response')
                                save(savelick, 'Drink_hst_L')
                                disp(savelick)
                            end
                            
                            
                            
%                             savefig = ['C:\Users\C238\phase2DR\' neuronID TrimStrB(end-8:end-4) '.bmp'];
%                             savemat = ['C:\Users\C238\phase2DR\' neuronID TrimStrB(end-8:end-4) '.mat'];
%                             %%%　Right Touchとlickの2次元マップ
%                             if length(phase2DR)>50
%                                 Drink_hst_R = zscore(histcounts(phase2DR(:,1),10, 'BinLimits', [0,1]));
%                                 Touch_hst_R = zscore(histcounts(phase2DR(:,2),10, 'BinLimits', [0,1]));
%                                 if ~isempty(find(Drink_hst_R>2.0, 1)) || ~isempty(find(Touch_hst_R>2.0, 1))
%                                     Figure2=figure();
%                                     scatterhist(phase2DR(:,1), phase2DR(:,2),'Kernel','on','Location','SouthEast','Direction','out', 'Marker', '.', 'MarkerSize', 9, 'Color', 'k')
%                                     xlim([0,1])
%                                     ylim([0,1])
%                                     saveas(Figure2, savefig)
%                                     save(savemat, 'phase2DR', 'Drink_hst_R', 'Touch_hst_R')
%                                     if isempty(strfind(SignificantNeuron_R, neuronID))%%このneuronIDが出てくるのが初めてなら。
% %                                         if ~isempty(find(Drink_hst>2.0, 1))
% %                                             Drink_modnum = Drink_modnum + 1;
% %                                             SignificantNeuron = [SignificantNeuron neuronID];
% %                                         end
% %                                         if ~isempty(find(Touch_hst>2.0, 1))
% %                                             Touch_modnum = Touch_modnum + 1;
% %                                             SignificantNeuron = [SignificantNeuron neuronID];
% %                                         end
%                                         if ~isempty(find(Drink_hst_R>2.0, 1)) && ~isempty(find(Touch_hst_R>2.0, 1))
%                                             Both_modnum_R = Both_modnum_R + 1;
%                                             SignificantNeuron_R = [SignificantNeuron_R neuronID];
%                                         end
%                                     end
%                                 end
%                             end
%                             
%                             
                            savefig = ['C:\Users\C238\phase3D_cos\' neuronID TrimStrB(end-8:end-4) '.fig'];
                            savemat = ['C:\Users\C238\phase3D_cos\' neuronID TrimStrB(end-8:end-4) '.mat'];
                            
                            %%% LeftTouch, RightTouch, Lickingの3次元マップ
%                             if length(phase3D)>50
%                                 Drink_hst = zscore(histcounts(phase3D(:,1),10, 'BinLimits', [0,1]));
%                                 LTouch_hst = zscore(histcounts(phase3D(:,2),10, 'BinLimits', [0,1]));
%                                 RTouch_hst = zscore(histcounts(phase3D(:,3),10, 'BinLimits', [0,1]));
%                                 
%                                 if ~isempty(find(Drink_hst>2.0, 1)) ||~isempty(find(LTouch_hst>2.0, 1)) || ~isempty(find(RTouch_hst>2.0, 1))
%                                     Figure3=figure();
%                                     scatter3(phase3D(:,2), phase3D(:,3), phase3D(:,1), 15,'black','o', 'filled')
%                                     hold on
%                                     grid on
%                                     box on
%                                     plot3(motorphase3D(100:1000,2), motorphase3D(100:1000,3), motorphase3D(100:1000,1))
%                                     title([neuronID TrimStrB(end-8:end-4)])
%                                     xlim([0,1])
%                                     xlabel('Left')
%                                     ylim([0,1])
%                                     ylabel('Right')
%                                     zlim([0,1])
%                                     zlabel('Lick')
%                                     saveas(Figure3, savefig)
%                                     save(savemat, 'phase3D', 'motorphase3D', 'Drink_hst', 'LTouch_hst', 'RTouch_hst')
%                                     if isempty(strfind(SignificantNeuron_3d, neuronID))%%このneuronIDが出てくるのが初めてなら。
%                                         if ~isempty(find(Drink_hst>2.0, 1)) && ~isempty(find(LTouch_hst>2.0, 1)) && ~isempty(find(RTouch_hst>2.0, 1))
%                                             All_modnum = All_modnum + 1;
%                                             SignificantNeuron_3d = [SignificantNeuron_3d neuronID];
%                                         end
%                                     end
%                                 end
%                             end
%                             
% 
% 
%                             savefig = ['C:\Users\C238\phase2D_LR\' neuronID TrimStrB(end-8:end-4) '.bmp'];
%                             %%% LeftTouch, RightTouchの 2次元マップ
%                             if length(phase3D)>50
%                                 LTouch_hst = zscore(histcounts(phase3D(:,2),10, 'BinLimits', [0,1]));
%                                 RTouch_hst = zscore(histcounts(phase3D(:,3),10, 'BinLimits', [0,1]));
%                                 
%                                 if ~isempty(find(LTouch_hst>2.0, 1)) || ~isempty(find(RTouch_hst>2.0, 1))
%                                     Figure4=figure();
%                                     scatter(phase3D(:,2), phase3D(:,3), 15,'black','o', 'filled')
%                                     hold on
%                                     grid on
%                                     box on
%                                     plot(motorphase3D(250:1000,2), motorphase3D(250:1000,3))
%                                     title([neuronID TrimStrB(end-8:end-4)])
%                                     xlim([0,1])
%                                     xlabel('Left')
%                                     ylim([0,1])
%                                     ylabel('Right')
%                                     
%                                     saveas(Figure4, savefig)
%                                 end
%                             end
                            
                            close all hidden

                        end
                    end
                end
            end
        end
    end
end
save('C:\Users\C238\phase2DL\Significant.mat', 'Both_modnum_L', 'SignificantNeuron_L')
save('C:\Users\C238\phase2DR\Significant.mat', 'Both_modnum_R', 'SignificantNeuron_R')
save('C:\Users\C238\phase3D\Significant.mat', 'All_modnum', 'SignificantNeuron_3d')



function Dataload%_pushbutton_Callback(hObject, eventdata, handles)

global dpath fname PegOffset RpegTimeArray LpegTimeArray OneTurnTime TurnMarkerTime RpegTimeArray2D LpegTimeArray2D ...
    WaterOnArray WaterOffArray WaterOnArrayOriginal WaterOffArrayOriginal SpikeNum data DrName ShowFig FigureSave modif patternValue...
    NumDrinkTurn NumDrinkTurnCum OnWaterLen OnWaterLenCum NumFloorTouchTurn NumFloorTouchTurnCum OnWater VoltAnalysis StartTime FinishTime...
    TouchTiming DetachTiming DrinkTiming DrinkOnArray OnWater RpegTouchall LpegTouchall WonTouch ...
    RpegTouchallWon RpegTouchallWoff LpegTouchallWon LpegTouchallWoff FigureSave ShowFig MedPegTimeR MedPegTimeL
%SpikeNumはDataLoadでSpikeNum=1と設定され、あとはSpikeAnalysis内で実行のたびに１ずつ増加する。
% ShowFig=0%get(handles.radiobutton_ShowFigure,'Value');
% FigureSave=get(handles.radiobutton_SaveFigure,'Value');
% patternValue=get(handles.popupmenu_pattern,'Value');
% PegOffsetCell=get(handles.popupmenu_offset,'String');
% PegOffset=str2double(PegOffsetCell(get(handles.popupmenu_offset,'Value')))
PegOffset=0;%使用しない。なくしてもいいが、Dataloadの引数になっているので注意。
[RpegTimeArray,LpegTimeArray,RpegTimeArray2D,LpegTimeArray2D,OneTurnTime TurnMarkerTime data]=DataLoad24ch(PegOffset,dpath,fname);

% MedPegTimeR(MedPegTimeR==0)=[];
% MedPegTimeL(MedPegTimeL==0)=[];

% % % % BgraR=[49,380,825,1326,1884,2436,2940,3385,3716];
% % % % BgraL=[43,372,815,1315,1870,2424,2925,3369,3703];
% % % A=int32(MedPegTimeR/OneTurnTime*10000);
% % % B=int32(MedPegTimeL/OneTurnTime*10000);
% % % if length(MedPegTimeR)==9 && length(MedPegTimeL)==9 && ...
% % %         sum(abs(A-int32([112,940,1912,3018,4273,5657,6922,8026,9138])))<300 && sum(abs(B-int32([77,907,1892,2996,4255,5630,6879,7991,9105])))<300
% % %         patternValue=11;%Bgra
% % % elseif length(MedPegTimeR)==10 && length(MedPegTimeR)==9
% % %     patternValue=12;%9-8
% % % elseif length(MedPegTimeR)==9 && length(MedPegTimeR)==10
% % %     patternValue=13;%8-9
% % % elseif length(MedPegTimeR)==12 && length(MedPegTimeL)==11 && sum(abs(MedPegTimeR-[75,487,906,1322,1738,2154,2575,2991,3412,3832,4257,4676]))<100 && sum(abs(MedPegTimeL-[68,487,903,1320,1738,2154,2571,3196,3614,4029,4454]))<100
% % %     patternValue=14;%B7-A
% % % elseif length(MedPegTimeR)==12 && length(MedPegTimeL)==13 && ...
% % %     sum(abs(MedPegTimeR-[87,435,991,1336,1754,2033,2523,3074,3355,3772,4187,4742]))<100 && sum(abs(MedPegTimeL-[104,489,869,1246,2010,2421,2628,2975,3598,3945,4366,4851,2428]))<100
% % %     patternValue=15;%C3
% % % elseif length(MedPegTimeR)==12 && length(MedPegTimeL)==12 && ...
% % %     sum(abs(MedPegTimeR-[609,887,1235,1718,2206,2345,2896,3381,3869,4287,4563,4903]))<100 && sum(abs(MedPegTimeL-[330,673,1229,1506,1994,2340,2896,3314,3942,4217,4771,4908]))<100
% % %     patternValue=16;%C7
% % % elseif length(MedPegTimeR)==9 && length(MedPegTimeL)==8 && ...
% % %     sum(abs(A-int32([783,1895,2998,4108,5213,6320,7435,8550,9665])))<100 && sum(abs(B-int32([83,1335,2575,3825,5065,6310,7560,8823])))<100
% % %     patternValue=17;%9-8
% % % elseif length(MedPegTimeR)==14 && length(MedPegTimeL)==14 && ...
% % %     sum(abs(A-int32([297,1136,1865,2682,3438,4252,5054,5828,6649,7438,8220,8944,9483,0])))<300 && sum(abs(B-int32([645,1333,2447,3001,3970,4664,5783,6617,7868,8424,9533,9810,0,0])))<300
% % %     patternValue=18;%C9+
% % % end

StartTime=data(1,2);
FinishTime=data(1,3);

% VoltAnalysis=get(handles.radiobutton_VoltageAnalysis,'Value');
VoltAnalysis=0;
RpegTouchall=[];
LpegTouchall=[];
global R_PegTouchCell L_PegTouchCell R_PegTouchTurn L_PegTouchTurn %RpegTouchall LpegTouchall

if VoltAnalysis==1
    Fig=0;
    [TouchTiming DetachTiming DrinkTiming]=VoltageAnalysis20170719(dpath,fname,Fig);
    
    DrinkOnArray=find(DrinkTiming==1)';
else
    WonTouch=0;%1のとき、WaterOnのときのTouchのみを選別。
    RightTouchData=[data(:,14),data(:,15),data(:,16),data(:,17),data(:,18),data(:,19),data(:,20),data(:,21),data(:,22),data(:,23),data(:,24),data(:,25)];
    [R_PegTouchCell,R_PegTouchTurn]=PegTouch24ch(RightTouchData);
    
    LeftTouchData=[data(:,42),data(:,43),data(:,44),data(:,45),data(:,46),data(:,47),data(:,48),data(:,49),data(:,50),data(:,51),data(:,52),data(:,53)];
    [L_PegTouchCell,L_PegTouchTurn]=PegTouch24ch(LeftTouchData);
    %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    
    %連続して複数回のタッチがあった場合、最初のものを採用。きれいなタッチが取れている場合のみ有効
    RpegTouchcell=cell(1,12);RpegTouchall=[];
    for n=1:length(R_PegTouchCell)
        if length(R_PegTouchCell{n})>0
            RpegTouchcell{n}=[RpegTouchcell{n} R_PegTouchCell{n}(1)];
        end
        for m=2:length(R_PegTouchCell{n})
            if R_PegTouchCell{n}(m)-R_PegTouchCell{n}(m-1)>OneTurnTime/2
                RpegTouchcell{n}=[RpegTouchcell{n} R_PegTouchCell{n}(m)];
            end
        end
        RpegTouchall=[RpegTouchall RpegTouchcell{n}];
    end
    RpegTouchall=sort(RpegTouchall,'ascend');
    
    %WaterOnのときのみのRpegTouchall
    if ~isempty(RpegTouchall)
        RTWon=ones(1,length(RpegTouchall));
        for k=1:length(RpegTouchall)
            if OnWater(RpegTouchall(k))==0
                RTWon(k)=0;
            end
        end
        RpegTouchallWon=RpegTouchall.*RTWon;
        RpegTouchallWon(RpegTouchallWon==0)=[];
        RpegTouchallWoff=RpegTouchall.*not(RTWon);
        RpegTouchallWoff(RpegTouchallWoff==0)=[];
    else
        RpegTouchallWon=0;
        RpegTouchallWoff=0;
    end
    
    LpegTouchcell=cell(1,12);
    for n=1:length(L_PegTouchCell)
        if ~isempty(L_PegTouchCell{n})
            LpegTouchcell{n}=[LpegTouchcell{n} L_PegTouchCell{n}(1)];
        end
        for m=2:length(L_PegTouchCell{n})
            if L_PegTouchCell{n}(m)-L_PegTouchCell{n}(m-1)>OneTurnTime/2
                LpegTouchcell{n}=[LpegTouchcell{n} L_PegTouchCell{n}(m)];
            end
        end
        LpegTouchall=[LpegTouchall LpegTouchcell{n}];
    end
    LpegTouchall=sort(LpegTouchall,'ascend');
    
    %WaterOnのときのみのLpegTouchall
    if ~isempty(LpegTouchall)
        LTWon=ones(1,length(LpegTouchall));
        for k=1:length(LpegTouchall)
            if OnWater(LpegTouchall(k))==0
                LTWon(k)=0;
            end
        end
        LpegTouchallWon=LpegTouchall.*LTWon;
        LpegTouchallWon(LpegTouchallWon==0)=[];
        LpegTouchallWoff=LpegTouchall.*not(LTWon);
        LpegTouchallWoff(LpegTouchallWoff==0)=[];
    else
        LpegTouchallWon=0;
        LpegTouchallWoff=0;
    end
    %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    DrinkOnArrayOriginal=data(:,27);
    DrinkOffArrayOriginal=data(:,41);
    
    EventName='DrinkOn';
    [DrinkOnArrayOriginal,DrinkOffArrayOriginal,DrinkOnArray,DrinkOffArray]=Modify_Events(DrinkOnArrayOriginal,DrinkOffArrayOriginal,StartTime,FinishTime,EventName);
    
    [DrinkOn_percent]=Water_percentage(DrinkOnArray,DrinkOffArray,StartTime,FinishTime);
    DrinkMark=WaterMark(DrinkOnArray, DrinkOffArray, StartTime, FinishTime, TurnMarkerTime, OneTurnTime);
end

DrinkOnRaster=raster(DrinkOnArray,TurnMarkerTime);
if VoltAnalysis==0;DrinkOffRaster=raster(DrinkOffArray,TurnMarkerTime);end

NumDrinkTurn=zeros(1,length(TurnMarkerTime)-1);
NumDrinkTurnCum=zeros(1,length(TurnMarkerTime)-1);
if ~isempty(DrinkOnRaster)
    for n=1:length(TurnMarkerTime)-1
        NumDrinkTurn(n)=sum(DrinkOnRaster(:,2)==n);
        if n>=2
            NumDrinkTurnCum(n)=NumDrinkTurnCum(n-1)+NumDrinkTurn(n);
        end
    end
end
modif=0;
% disp('loaded');

function SAVEall
global data PegOffset dpath fname PegTouchTurn SliderTouch PegTouchCell...
    RpegTouchCell LpegTouchCell RLpegTouchCell CrossVar CrossVarInv OneTurnTime DrName RpegTouchTurn LpegTouchTurn  RPegTouchAll LPegTouchAll RLPegTouchAll FTselect RefPeriod ... %FTselect=first touch or All touches
    TurnMarkerTime RpegTimeArray LpegTimeArray PtouchHistoCell_R PtouchHistoCell_L CrossVarInv_2 CrossVarInv_3 CrossVarInv_4 WaterOnArray WaterOffArray WaterOnArrayOriginal WaterOffArrayOriginal...
    RpegTimeArray2D LpegTimeArray2D RpegTimeArray2D_turn LpegTimeArray2D_turn RLpegName RLpegMedian RpegMedian LpegMedian MedPegTimeR MedPegTimeL StartTime FinishTime ...
    CovInterval_3 CoefInterval_3 SpikeArrayCell CovInterval_5 CoefInterval_5 VarMeans VarSTD Spike ...
    Prod_Int_dev_abs_Mean_3 Prod_Int_dev_abs_Var_3 Prod_Int_dev_abs_Mean_5 Prod_Int_dev_abs_Var_5 PegVar VarNextPeg...
    WaterOn_percent DrinkOnArray DrinkOffArray FloorTouchArray FloorDetachArray DrinkOn_percent FloorTouch_percent Num_SmallVar ChunkLength ChunkEnd...
    SpikeArray1 SpikeArray2 SpikeArray3 SpikeArray4 SpikeArray5 SE lengthEvent Repeat RLRphase LRLphase RLRbefore LRLbefore IntervalR IntervalL...
    RatioAlikeLRL RatioAlikeRLR RatioBlikeLRL RatioBlikeRLR StdLRLphase StdRLRphase StdLRLdiff StdRLRdiff StdIntervalRL StdRLTouchInterval WaterN MeanWaterTime...
    RpegTouchBypegCell LpegTouchBypegCell RmedianPTTM LmedianPTTM LTouchAll RTouchAll LRLpegphase RLRpegphase LRLpegTimeArray RLRpegTimeArray ...
    TurnMarkerTime_L TurnMarkerTime_R MedPegTimeL_L MedPegTimeL_R MedPegTimeR_L MedPegTimeR_R TurnMarkerTimeB TurnMarkerTimeA patternValue ...
    LTouchfromPeg StdLTouchTiming RTouchfromPeg StdRTouchTiming MeanStdTouch VarianceList...
    RpegTouchall LpegTouchall RpegTouchall LpegTouchall filename OnWater...
    NumDrinkTurn NumDrinkTurnCum OnWaterLen OnWaterLenCum NumFloorTouchTurn NumFloorTouchTurnCum fig_TouchR fig_TouchL RtouchHist LtouchHist...
    RLtouchHist SpikeUnits UnitDataUnited UnitData...
    PeakMatrix TroughMatrix SameT_peak SameT_trough...
    DifT_peak DifT_trough DiffMaxMinRpArray DiffMaxMinLpArray DiffMaxMinRArray DiffMaxMinLArray U TetrodeNum CCresultSp1Sp2 Colors SpikeCell TurnMarkerTime

%RpegMedian,LpegMedianはTouch時間のMedian
%MedPegTimeR MedPegTimeLはPeg到達時間のMedian

Sname=[DrName 'Bdata.mat'];
feval('save',Sname);%すべてのデータをmat形式で保存
% close all;

function [RpegTimeArray,LpegTimeArray,RpegTimeArray2D,LpegTimeArray2D,OneTurnTime,TurnMarkerTime data]=DataLoad24ch(PegOffset,dpath,fname)

%1A：Info（date, mouseID, sessionNo,training condition, Num.Turns,TotalTouchTime, TotalWaterOn, Num.Stops, 1-10, 11-20, 21-30, 31-40,,,)
%2B:Start time array
%3C:Stop time array
%4D:TurnTime, cumulative
%5E:OneTurnTime
%6F:cumulativeTouchTime array; fall down
%7G:WaterOnTime array
%8H:WaterOffTime array
%9I:Stop Time array
%10J:Lpeg Time array
%11K:Rpeg Time array
%12L:CumulativeTouchTime; fall down
%13M:TotalTouchTime by 10;fall down
%14N-25Y:TouchTime sensor 1-12
%28AB-39AM:DetachTime sensor 1-12
%26Z:Floor Touch sensor
%27AA:Spout Touch sensor//
%40AN:Floor Detach sensor
%41AU:Spout Detach sensor//


%clear all
% %Eventデータの読み込み
% cd 'C:\Documents and Settings\kit\デスクトップ\WR LVdata';
% %dpath='C:\Documents and Settings\kit\デスクトップ\WR LVdata\';
% [fname,dpath] = uigetfile('*.xls');
%

global data dpath fname TurnMarkerTime OneTurnTimeArray RpegTimeArray LpegTimeArray OneTurnTime...
    WaterOnArrayOriginal WaterOffArrayOriginal WaterOnArray WaterOffArray...
    RpegTimeArray2D LpegTimeArray2D RpegTimeArray2D_turn LpegTimeArray2D_turn MedPegTimeR MedPegTimeL StartTime FinishTime...
    SpikeNum WaterOn_percent DrinkOnArray DrinkOffArray FloorTouchArray FloorDetachArray DrinkOn_percent FloorTouch_percent DrName...
    fig_WaterMark fig_DrinkMark fig_FloorMark fig_WaterOn fig_DrinkOn fig_Floor FigureSave patternValue...
    TurnMarkerTime_L TurnMarkerTime_R MedPegTimeL_L MedPegTimeL_R MedPegTimeR_L MedPegTimeR_R TurnMarkerTimeB TurnMarkerTimeA...
    NumDrinkTurn NumDrinkTurnCum OnWater OnWaterLen OnWaterLenCum NumFloorTouchTurn NumFloorTouchTurnCum...
    fig_OnWater fig_DrinkMark fig_NumDrink fig_FloorMark fig_NumFloorTouch fig_WaterOnLen fig_DrinkOnCount fig_FloorTouchCount VoltAnalysis

if strfind(fname,' ')>0
    data=xlsread([dpath fname]);%'C:\Documents and Settings\kit\デスクトップ\WR LVdata\6 080811.xls');
elseif strfind(fname,'_')>0
    %     cd(dpath)
    %     A=[dpath fname];
    try
        data=load([dpath fname],'-ascii');
    catch exception
        data=load([dpath fname]);
    end
    
else
    data=xlsread([dpath fname]);%'C:\Documents and Settings\kit\デスクトップ\WR LVdata\6 080811.xls');
end
%num_pegs=12;
SpikeNum=1;

%Sessionの最初と最後を規定。複数セッションの解析のためには作り直す必要あり。
StartTime=data(1,2);
FinishTime=data(1,3);

%PegOffset: Peg　位置補正 TurnMarkerと重なったとき
RpegTimeArrayOriginal=data(:,11)-PegOffset;RpegTimeArrayOriginal(RpegTimeArrayOriginal==-PegOffset)=[];
LpegTimeArrayOriginal=data(:,10)-PegOffset;LpegTimeArrayOriginal(LpegTimeArrayOriginal==-PegOffset)=[];
RpegTimeArray=RpegTimeArrayOriginal(RpegTimeArrayOriginal>StartTime & RpegTimeArrayOriginal<FinishTime);
LpegTimeArray=LpegTimeArrayOriginal(LpegTimeArrayOriginal>StartTime & LpegTimeArrayOriginal<FinishTime);

%dataを内容ごとに分離、要素０の場合要素を削除%最終的にStartTimeとFinishTimeの間のものだけを残す。
TurnMarkerTimeA=[];TurnMarkerTimeB=[];
if patternValue==15 % RLpegがBlikeで入ったときのTurnMarkerをTurnMarkerTimeとする。ただし、そのときマウスは逆位置でAlike。
    TurnMarkerTimeOriginal=data(:,4);TurnMarkerTimeOriginal(TurnMarkerTimeOriginal==0)=[];
    TurnMarkerTime=TurnMarkerTimeOriginal(TurnMarkerTimeOriginal>StartTime & TurnMarkerTimeOriginal<=FinishTime);
    for n=1:length(TurnMarkerTime)-1
        RTime=RpegTimeArray-TurnMarkerTime(n);
        LTime=LpegTimeArray-TurnMarkerTime(n);
        if abs(min(RTime(RTime>0))-min(LTime(LTime>0)))<20
            TurnMarkerTimeA=[TurnMarkerTimeA;TurnMarkerTime(n)];
        elseif abs(max(RTime(RTime<0))-max(LTime(LTime<0)))<20
            TurnMarkerTimeB=[TurnMarkerTimeB;TurnMarkerTime(n)];
        end
    end
    OneTurnTimeArray=data(:,5);OneTurnTimeArray(find(OneTurnTimeArray==0))=[];%for n=length(OneTurnTimeArray):-1:1;if OneTurnTimeArray(n)==0;On nTimeArray(n)=[];end;end;
    OneTurnTime=median(OneTurnTimeArray)*2;
    TurnMarkerTime=TurnMarkerTimeA;
else
    TurnMarkerTimeOriginal=data(:,4);TurnMarkerTimeOriginal(TurnMarkerTimeOriginal==0)=[];
    TurnMarkerTime=TurnMarkerTimeOriginal(TurnMarkerTimeOriginal>StartTime & TurnMarkerTimeOriginal<=FinishTime);
    OneTurnTimeArray=data(:,5);OneTurnTimeArray(find(OneTurnTimeArray==0))=[];%for n=length(OneTurnTimeArray):-1:1;if OneTurnTimeArray(n)==0;On nTimeArray(n)=[];end;end;
    
    %One turnの中央値を一周の時間とする
    OneTurnTime=median(OneTurnTimeArray);
end

%WaterEventの処理　Original:記録されたそのまま　-----------------------begin
WaterOnArrayOriginal=data(:,7);
WaterOffArrayOriginal=data(:,8);

%WaterOnArrayは、最初と最後やデータ抜けなどを修正したもの。
EventName='WaterOn';
[WaterOnArrayOriginal,WaterOffArrayOriginal,WaterOnArray,WaterOffArray]=Modify_Events(WaterOnArrayOriginal,WaterOffArrayOriginal,StartTime,FinishTime,EventName);
[WaterOn_percent]=Water_percentage(WaterOnArray,WaterOffArray,StartTime,FinishTime);
WaterMarkTurn=WaterMark(WaterOnArray, WaterOffArray, StartTime, FinishTime, TurnMarkerTime, OneTurnTime);

if WaterOnArray(1)<WaterOffArray(1)
    OnWater=zeros(1,FinishTime);
else
    OnWater=ones(1,FinishTime);
end

a=1;b=1;

% if WaterOnArray(1)==1
%     OnWater(1)=1;
%     a=2;
% end

% ここでエラーが出たら上4行を操作（コメントイン or アウト）要、修正。
for n=2:length(OnWater)
    if n~=WaterOnArray(a) && n~=WaterOffArray(b)
        OnWater(n)=OnWater(n-1);
    elseif n==WaterOnArray(a)
        OnWater(n)=1;
        if a<length(WaterOnArray);a=a+1;end
    elseif n==WaterOffArray(b)
        OnWater(n)=0;
        if b<length(WaterOffArray);b=b+1;end
    end
end
length(OnWater(OnWater==1));

OnWaterLen=zeros(1,length(TurnMarkerTime)-1);
OnWaterLenCum=zeros(1,length(TurnMarkerTime)-1);
for n=1:length(TurnMarkerTime)-1
    TempOnW=OnWater(TurnMarkerTime(n):TurnMarkerTime(n+1));
    OnWaterLen(n)=sum(TempOnW(TempOnW==1));
    if n>=2
        OnWaterLenCum(n)=OnWaterLenCum(n-1)+OnWaterLen(n);
    end
end

WaterOnRaster=raster(WaterOnArray,TurnMarkerTime);
WaterOffRaster=raster(WaterOffArray,TurnMarkerTime);


%Rpeg番号
R_under=0;
R_over=0;
TM=1;
RpegTimeArray2D=[];
RpegTimeArray2D_turn=[];
pegN=1;%pegN<=12 ペグ12本のとき
for n=1:length(RpegTimeArray)
    if pegN==13&&RpegTimeArray(n)>TurnMarkerTime(TM)&&RpegTimeArray(n)+50>TurnMarkerTime(TM+1)
        RpegTimeArray2D(TM+1,1)=RpegTimeArray(n);
        RpegTimeArray2D_turn(TM+1,1)=RpegTimeArray(n)-TurnMarkerTime(TM+1);
        pegN=2;
        TM=TM+1;
    elseif TM<length(TurnMarkerTime)&RpegTimeArray(n)>=TurnMarkerTime(TM)&RpegTimeArray(n)<TurnMarkerTime(TM+1)
        RpegTimeArray2D(TM,pegN)=RpegTimeArray(n);
        RpegTimeArray2D_turn(TM,pegN)=RpegTimeArray(n)-TurnMarkerTime(TM);
        pegN=pegN+1;
    elseif TM<(length(TurnMarkerTime)-1)&RpegTimeArray(n)>=TurnMarkerTime(TM+1)
        RpegTimeArray2D(TM+1,1)=RpegTimeArray(n);
        RpegTimeArray2D_turn(TM+1,1)=RpegTimeArray(n)-TurnMarkerTime(TM+1);
        if pegN<12;R_under=R_under+1;end
        if pegN>13;R_over=R_over+1;end
        
        pegN=2;
        TM=TM+1;
    end
end
%Lpeg番号
L_under=0;
L_over=0;
TM=1;
LpegTimeArray2D=[];
LpegTimeArray2D_turn=[];
pegN=1;%pegN<=12 ペグ12本のとき
for n=1:length(LpegTimeArray)
    if pegN==13&&LpegTimeArray(n)>TurnMarkerTime(TM)&&LpegTimeArray(n)+50>TurnMarkerTime(TM+1)
        LpegTimeArray2D(TM+1,1)=LpegTimeArray(n);
        LpegTimeArray2D_turn(TM+1,1)=LpegTimeArray(n)-TurnMarkerTime(TM+1);
        pegN=2;
        TM=TM+1;
    elseif TM<length(TurnMarkerTime)&LpegTimeArray(n)>=TurnMarkerTime(TM)&LpegTimeArray(n)<TurnMarkerTime(TM+1)
        LpegTimeArray2D(TM,pegN)=LpegTimeArray(n);
        LpegTimeArray2D_turn(TM,pegN)=LpegTimeArray(n)-TurnMarkerTime(TM);
        pegN=pegN+1;
    elseif TM<(length(TurnMarkerTime)-1)&LpegTimeArray(n)>=TurnMarkerTime(TM+1)
        LpegTimeArray2D(TM+1,1)=LpegTimeArray(n);
        LpegTimeArray2D_turn(TM+1,1)=LpegTimeArray(n)-TurnMarkerTime(TM+1);
        if pegN<12;L_under=L_under+1;end
        if pegN>13;L_over=L_over+1;end
        pegN=2;
        TM=TM+1;
    end
end

% Pegのカウントミスを補正
% 抜けた部分をnanにして一つずらす
if patternValue<9
    for n=1:length(RpegTimeArray2D_turn(1,:))
        for m=1:length(RpegTimeArray2D_turn(:,1))
            A=RpegTimeArray2D_turn(:,n);
            if RpegTimeArray2D_turn(m,n)-median(A(A>0))>100
                RpegTimeArray2D_turn(m,:)=[RpegTimeArray2D_turn(m,1:n-1) nan RpegTimeArray2D_turn(m,n:end-1)];
                RpegTimeArray2D(m,:)=[RpegTimeArray2D(m,1:n-1) nan RpegTimeArray2D(m,n:end-1)];
            end
        end
    end
    
    for n=1:length(LpegTimeArray2D_turn(1,:))
        for m=1:length(LpegTimeArray2D_turn(:,1))
            A=LpegTimeArray2D_turn(:,n);
            if LpegTimeArray2D_turn(m,n)-median(A(A>0))>100
                LpegTimeArray2D_turn(m,:)=[LpegTimeArray2D_turn(m,1:n-1) nan LpegTimeArray2D_turn(m,n:end-1)];
                LpegTimeArray2D(m,:)=[LpegTimeArray2D(m,1:n-1) nan LpegTimeArray2D(m,n:end-1)];
            end
        end
    end
end


%%%%%%%%%%%%%%%%%%%%%%%%%%%% Rpeg6を抜いて右ペグ11本で測定したとき %%%%%%%%%%%%%%%%%%%%%%%%%%%%
if patternValue==8
    Ins=nan(length(RpegTimeArray2D(:,11)),1);
    RpegTimeArray2D=[RpegTimeArray2D(:,1:5) Ins RpegTimeArray2D(:,6:11)];
    RpegTimeArray2D_turn=[RpegTimeArray2D_turn(:,1:5) Ins RpegTimeArray2D_turn(:,6:11)];
end
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%%%%%%%%%%%%%%%%%%%%%%%%%%%% Rpeg6,Lpeg6を各ターンで交互に抜いて左右ペグ11.5本で測定したとき %%%%%%%%%%%%%%%%%%%%%%%%%%%%
if patternValue==9
    if length(RpegTimeArray2D(1,:))>9
        RpegTimeArray2D(:,10:length(RpegTimeArray2D(1,:)))=[];
        RpegTimeArray2D_turn(:,10:length(RpegTimeArray2D_turn(1,:)))=[];
    end
    if length(LpegTimeArray2D(1,:))>9
        LpegTimeArray2D(:,10:length(LpegTimeArray2D(1,:)))=[];
        LpegTimeArray2D_turn(:,10:length(LpegTimeArray2D_turn(1,:)))=[];
    end
    
    for n=1:length(RpegTimeArray2D)
        if RpegTimeArray2D(n,9)==0 && RpegTimeArray2D(n,5)-RpegTimeArray2D(n,4)>500
            RpegTimeArray2D(n,:)=[RpegTimeArray2D(n,1:4) nan RpegTimeArray2D(n,5:8)];
            RpegTimeArray2D_turn(n,:)=[RpegTimeArray2D_turn(n,1:4) nan RpegTimeArray2D_turn(n,5:8)];
        end
        if LpegTimeArray2D(n,9)==0 && LpegTimeArray2D(n,5)-LpegTimeArray2D(n,4)>500
            LpegTimeArray2D(n,:)=[LpegTimeArray2D(n,1:4) nan LpegTimeArray2D(n,5:8)];
            LpegTimeArray2D_turn(n,:)=[LpegTimeArray2D_turn(n,1:4) nan LpegTimeArray2D_turn(n,5:8)];
        end
    end
    % Pegのカウントミスを補正
    % 抜けた部分をnanにして一つずらす
    for n=1:length(RpegTimeArray2D_turn(1,:))
        for m=1:length(RpegTimeArray2D_turn(:,1))
            A=RpegTimeArray2D_turn(:,n);
            if RpegTimeArray2D_turn(m,n)-median(A(A>0))>100
                RpegTimeArray2D_turn(m,:)=[RpegTimeArray2D_turn(m,1:n-1) nan RpegTimeArray2D_turn(m,n:end-1)];
                RpegTimeArray2D(m,:)=[RpegTimeArray2D(m,1:n-1) nan RpegTimeArray2D(m,n:end-1)];
            end
        end
    end
    
    for n=1:length(LpegTimeArray2D_turn(1,:))
        for m=1:length(LpegTimeArray2D_turn(:,1))
            A=LpegTimeArray2D_turn(:,n);
            if LpegTimeArray2D_turn(m,n)-median(A(A>0))>100
                LpegTimeArray2D_turn(m,:)=[LpegTimeArray2D_turn(m,1:n-1) nan LpegTimeArray2D_turn(m,n:end-1)];
                LpegTimeArray2D(m,:)=[LpegTimeArray2D(m,1:n-1) nan LpegTimeArray2D(m,n:end-1)];
            end
        end
    end
    
    TurnMarkerTime_R=[];TurnMarkerTime_L=[];
    LpegTimeArray2D_turn_R=[];RpegTimeArray2D_turn_R=[];
    LpegTimeArray2D_turn_L=[];RpegTimeArray2D_turn_L=[];
    for n=1:length(TurnMarkerTime)-1
        if isnan(LpegTimeArray2D(n,5))==1 && isnan(RpegTimeArray2D(n,5))==0 %photobeam Lpegなし=Rpeg for Touchなし
            TMR=TurnMarkerTime(n);
            TurnMarkerTime_R=[TurnMarkerTime_R; TMR];
            LpegTimeArray2D_turn_R=[LpegTimeArray2D_turn_R;LpegTimeArray2D_turn(n,:)]; % Lpeg(6)=nan
            RpegTimeArray2D_turn_R=[RpegTimeArray2D_turn_R;RpegTimeArray2D_turn(n,:)];
        elseif isnan(LpegTimeArray2D(n,5))==0 && isnan(RpegTimeArray2D(n,5))==1 %photobeam Rpegなし=Lpeg for Touchなし
            TML=TurnMarkerTime(n);
            TurnMarkerTime_L=[TurnMarkerTime_L; TML];
            LpegTimeArray2D_turn_L=[LpegTimeArray2D_turn_L;LpegTimeArray2D_turn(n,:)];
            RpegTimeArray2D_turn_L=[RpegTimeArray2D_turn_L;RpegTimeArray2D_turn(n,:)]; % Rpeg(6)=nan
        end
    end
    
    
    % AA-1パターンにおいては、マウスにとって右ペグがないとき(_Rで示す)フォトビームでは左ペグがないことになる（実時間記録上において）。
    % 従って右ペグ抜きときの2D_turn（フォトビームには右ペグがあって左ペグがない）は左ペグがなかったときの2D_turnとして扱うのが妥当である。
    % つまり実際に走ったペグによる時間情報・ペグ情報を利用する。これはすべての各TurnMarkerTimeが正確にカウントされている限り有効。
    %１周のなかでRペグが来るタイミング
    MedPegTimeR_L=[];MedPegTimeR_R=[];
    for n=1:length(RpegTimeArray2D_turn(1,:))
        MedPegTimeR_L(n)=nanmedian(RpegTimeArray2D_turn_R(:,n)); % 実時間上からのあてはめ
        MedPegTimeR_R(n)=nanmedian(RpegTimeArray2D_turn_L(:,n)); % 実時間上からのあてはめ
    end
    
    %１周のなかでLペグが来るタイミング
    MedPegTimeL_L=[];MedPegTimeL_R=[];
    for n=1:length(LpegTimeArray2D_turn(1,:))
        MedPegTimeL_L(n)=nanmedian(LpegTimeArray2D_turn_R(:,n)); % 実時間上からのあてはめ
        MedPegTimeL_R(n)=nanmedian(LpegTimeArray2D_turn_L(:,n)); % 実時間上からのあてはめ
    end
end
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%


%%%%%%%%%%%%%%%%%%%%%%%%%%%% ABパターン(7peg)のとき %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% if patternValue==10
% Ins=nan(length(RpegTimeArray2D(:,9)),3);
% RpegTimeArray2D=[RpegTimeArray2D Ins];
% RpegTimeArray2D_turn=[RpegTimeArray2D_turn Ins];
% Ins=nan(length(LpegTimeArray2D(:,8)),4);
% LpegTimeArray2D=[LpegTimeArray2D Ins];
% LpegTimeArray2D_turn=[LpegTimeArray2D_turn Ins];
% end

if patternValue==15
    %Rpeg番号
    R_under=0;
    R_over=0;
    TM=1;
    RpegTimeArray2D=[];
    RpegTimeArray2D_turn=[];
    pegN=1;%pegN<=12 ペグ12本のとき
    for n=1:length(RpegTimeArray)
        if pegN==15&&RpegTimeArray(n)>TurnMarkerTimeB(TM)&&RpegTimeArray(n)+50>TurnMarkerTimeB(TM+1)
            RpegTimeArray2D(TM+1,1)=RpegTimeArray(n);
            RpegTimeArray2D_turn(TM+1,1)=RpegTimeArray(n)-TurnMarkerTimeB(TM+1);
            pegN=2;
            TM=TM+1;
        elseif TM<length(TurnMarkerTimeB)&RpegTimeArray(n)>=TurnMarkerTimeB(TM)&RpegTimeArray(n)<TurnMarkerTimeB(TM+1)
            RpegTimeArray2D(TM,pegN)=RpegTimeArray(n);
            RpegTimeArray2D_turn(TM,pegN)=RpegTimeArray(n)-TurnMarkerTimeB(TM);
            pegN=pegN+1;
        elseif TM<(length(TurnMarkerTimeB)-1)&RpegTimeArray(n)>=TurnMarkerTimeB(TM+1)
            RpegTimeArray2D(TM+1,1)=RpegTimeArray(n);
            RpegTimeArray2D_turn(TM+1,1)=RpegTimeArray(n)-TurnMarkerTimeB(TM+1);
            if pegN<14;R_under=R_under+1;end
            if pegN>14;R_over=R_over+1;end
            
            pegN=2;
            TM=TM+1;
        end
    end
    %Lpeg番号
    L_under=0;
    L_over=0;
    TM=1;
    LpegTimeArray2D=[];
    LpegTimeArray2D_turn=[];
    pegN=1;%pegN<=12 ペグ12本のとき
    for n=1:length(LpegTimeArray)
        if pegN==15&&LpegTimeArray(n)>TurnMarkerTimeB(TM)&&LpegTimeArray(n)+50>TurnMarkerTimeB(TM+1)
            LpegTimeArray2D(TM+1,1)=LpegTimeArray(n);
            LpegTimeArray2D_turn(TM+1,1)=LpegTimeArray(n)-TurnMarkerTimeB(TM+1);
            pegN=2;
            TM=TM+1;
        elseif TM<length(TurnMarkerTimeB)&LpegTimeArray(n)>=TurnMarkerTimeB(TM)&LpegTimeArray(n)<TurnMarkerTimeB(TM+1)
            LpegTimeArray2D(TM,pegN)=LpegTimeArray(n);
            LpegTimeArray2D_turn(TM,pegN)=LpegTimeArray(n)-TurnMarkerTimeB(TM);
            pegN=pegN+1;
        elseif TM<(length(TurnMarkerTimeB)-1)&LpegTimeArray(n)>=TurnMarkerTimeB(TM+1)
            LpegTimeArray2D(TM+1,1)=LpegTimeArray(n);
            LpegTimeArray2D_turn(TM+1,1)=LpegTimeArray(n)-TurnMarkerTimeB(TM+1);
            if pegN<14;L_under=L_under+1;end
            if pegN>14;L_over=L_over+1;end
            pegN=2;
            TM=TM+1;
        end
    end
    
    
    if length(RpegTimeArray2D(1,:))>14
        RpegTimeArray2D(:,15:length(RpegTimeArray2D(1,:)))=[];
        RpegTimeArray2D_turn(:,15:length(RpegTimeArray2D_turn(1,:)))=[];
    end
    if length(LpegTimeArray2D(1,:))>14
        LpegTimeArray2D(:,15:length(LpegTimeArray2D(1,:)))=[];
        LpegTimeArray2D_turn(:,15:length(LpegTimeArray2D_turn(1,:)))=[];
    end
    
    
    % Ins=nan(length(RpegTimeArray2D(:,11)),1);
    % RpegTimeArray2D=[RpegTimeArray2D(:,1:5) Ins RpegTimeArray2D(:,6:11)];
    % RpegTimeArray2D_turn=[RpegTimeArray2D_turn(:,1:5) Ins RpegTimeArray2D_turn(:,6:11)];
    % Ins=nan(length(LpegTimeArray2D(:,11)),1);
    % LpegTimeArray2D=[LpegTimeArray2D(:,1:5) Ins LpegTimeArray2D(:,6:11)];
    % LpegTimeArray2D_turn=[LpegTimeArray2D_turn(:,1:5) Ins LpegTimeArray2D_turn(:,6:11)];
    for n=1:length(RpegTimeArray2D_turn(1,:))
        for m=1:length(RpegTimeArray2D_turn(:,1))
            A=RpegTimeArray2D_turn(:,n);
            if RpegTimeArray2D_turn(m,n)-median(A(isnan(A)==0))>150
                RpegTimeArray2D_turn(m,:)=[RpegTimeArray2D_turn(m,1:n-1) nan RpegTimeArray2D_turn(m,n:end-1)];
                RpegTimeArray2D(m,:)=[RpegTimeArray2D(m,1:n-1) nan RpegTimeArray2D(m,n:end-1)];
            end
        end
    end
    
    for n=1:length(LpegTimeArray2D_turn(1,:))
        for m=1:length(LpegTimeArray2D_turn(:,1))
            A=LpegTimeArray2D_turn(:,n);
            if LpegTimeArray2D_turn(m,n)-median(A(isnan(A)==0))>150
                LpegTimeArray2D_turn(m,:)=[LpegTimeArray2D_turn(m,1:n-1) nan LpegTimeArray2D_turn(m,n:end-1)];
                LpegTimeArray2D(m,:)=[LpegTimeArray2D(m,1:n-1) nan LpegTimeArray2D(m,n:end-1)];
            end
        end
    end
end
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%% ABパターン(9,8peg)のとき %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
if patternValue==10
    
    if length(RpegTimeArray2D(1,:))>9
        RpegTimeArray2D(:,10:length(RpegTimeArray2D(1,:)))=[];
        RpegTimeArray2D_turn(:,10:length(RpegTimeArray2D_turn(1,:)))=[];
    end
    if length(LpegTimeArray2D(1,:))>9
        LpegTimeArray2D(:,10:length(LpegTimeArray2D(1,:)))=[];
        LpegTimeArray2D_turn(:,10:length(LpegTimeArray2D_turn(1,:)))=[];
    end
    % Pegのカウントミスを補正
    % 抜けた部分をnanにして一つずらす
    for n=1:length(RpegTimeArray2D_turn(1,:))
        for m=1:length(RpegTimeArray2D_turn(:,1))
            A=RpegTimeArray2D_turn(:,n);
            if RpegTimeArray2D_turn(m,n)-median(A(A>0))>100
                RpegTimeArray2D_turn(m,:)=[RpegTimeArray2D_turn(m,1:n-1) nan RpegTimeArray2D_turn(m,n:end-1)];
                RpegTimeArray2D(m,:)=[RpegTimeArray2D(m,1:n-1) nan RpegTimeArray2D(m,n:end-1)];
            end
        end
    end
    
    for n=1:length(LpegTimeArray2D_turn(1,:))
        for m=1:length(LpegTimeArray2D_turn(:,1))
            A=LpegTimeArray2D_turn(:,n);
            if LpegTimeArray2D_turn(m,n)-median(A(A>0))>100
                LpegTimeArray2D_turn(m,:)=[LpegTimeArray2D_turn(m,1:n-1) nan LpegTimeArray2D_turn(m,n:end-1)];
                LpegTimeArray2D(m,:)=[LpegTimeArray2D(m,1:n-1) nan LpegTimeArray2D(m,n:end-1)];
            end
        end
    end
end
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%




if patternValue<9
    if length(RpegTimeArray2D(1,:))>12
        RpegTimeArray2D(:,13:length(RpegTimeArray2D(1,:)))=[];
        RpegTimeArray2D_turn(:,13:length(RpegTimeArray2D_turn(1,:)))=[];
    end
    if length(LpegTimeArray2D(1,:))>12
        LpegTimeArray2D(:,13:length(LpegTimeArray2D(1,:)))=[];
        LpegTimeArray2D_turn(:,13:length(LpegTimeArray2D_turn(1,:)))=[];
    end
end

% patternValue
% if patternValue~=9
%１周のなかでRペグが来るタイミング
MedPegTimeR=[];
for n=1:length(RpegTimeArray2D_turn(1,:))
    MedPegTimeR(n)=nanmedian(RpegTimeArray2D_turn(:,n));
end
%Rペグのタイミングを適正な位置に調整
for n=1:length(MedPegTimeR)
    MedPegTimeR(n)=MedPegTimeR(n);%-OneTurnTime*0.1;
    if MedPegTimeR(n)<0;MedPegTimeR(n)=MedPegTimeR(n)+OneTurnTime;end;
end
%１周のなかでLペグが来るタイミング
MedPegTimeL=[];
for n=1:length(LpegTimeArray2D_turn(1,:))
    MedPegTimeL(n)=nanmedian(LpegTimeArray2D_turn(:,n));
end
%Lペグのタイミングを適正な位置に調整
for n=1:length(MedPegTimeL)
    MedPegTimeL(n)=MedPegTimeL(n);%-OneTurnTime*0.1;
    if MedPegTimeL(n)<0;MedPegTimeL(n)=MedPegTimeL(n)+OneTurnTime;end;
end


