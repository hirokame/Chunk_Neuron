function lickingsearch

cd('C:\Users\C238')
if ~exist('CrossCorr', 'dir')
    mkdir('CrossCorr')
end
SaveDir = 'C:\Users\C238\CrossCorr\';
CoreDir='C:\Users\C238\CheetahWRLV20220213';

cd(CoreDir);
MouseList=ls;
for m=1:length(MouseList(:,1)) %%マウス番号
    Mouse=strtrim(MouseList(m,:));
    if ~strcmp(Mouse,'.') && ~strcmp(Mouse,'..') && isempty(strfind(Mouse,'.mat')) && isempty(strfind(Mouse,'.bmp')) && isempty(strfind(Mouse,'.fig'))...
            && isempty(strfind(Mouse,'.xlsx')) && isempty(strfind(Mouse, 'Hirokane')) && isempty(strfind(Mouse, 'Heatmap')) && isempty(strfind(Mouse, 'Chunk'))...
            && isempty(strfind(Mouse, 'CCSfigure')) && isempty(strfind(Mouse, 'touchcellLtRt'));
        cd([CoreDir '\' Mouse]);
        Daylist=ls;
        for j=1:length(Daylist(:,1))%%セッション日
            cd([CoreDir '\' Mouse]);
            Day=strtrim(Daylist(j,:));
            
            if length(Day)>2 && isdir(Day)%~strcmp(TrimStr2(end-4:end),'pptx')
                daypath=[CoreDir '\' Mouse '\' Day];
                cd([daypath '\CellCell2'])
                NeuronList = ls;
                for k = 1:length(NeuronList(:,1))
                    if ~isempty(strfind(NeuronList(k,:), 'SS'))
                        Neuron = NeuronList(k,:);
                        cd([daypath '\CellCell2\' Neuron])
%                         load('response.mat')
                        
%                         if ~isempty(strfind(response, 'DR')) || ~isempty(strfind(response, 'DL')) || ~isempty(strfind(response, 'Don')) || ~isempty(strfind(response, 'Rt')) || ~isempty(strfind(response, 'Lt'))  
                            disp(Mouse)
                            disp(Day)
                            disp(Neuron)
                            disp(response)
                            cd([daypath '\CCSFolder'])
                            fileList = ls;
                            for m = 1:length(fileList(:,1));
                                if ~isempty(strfind(fileList(m,:), Neuron)) && isempty(strfind(fileList(m,:), '89')) && isempty(strfind(fileList(m,:), 'Agra'))
                                    %%% Turnmarkerでアラインしたスパイク
                                    disp(fileList(m,end-8:end-4))
                                    figure1=figure;
                                    file = fileList(m,:);
                                    CCresultSpike = load(file, 'CCresultSpike');
                                    CrossCorr_TM = CCresultSpike.CCresultSpike;
                                    x = linspace(0,8000,1000);
                                    plot(x, CrossCorr_TM)
                                    savepass = [SaveDir Mouse Day file(1:end-4) 'TM.bmp'];
                                    saveas(figure1, savepass)
                                    
                                    %%% Rtouchでアラインしたスパイク
                                    figure2 = figure;
                                    CCresultRtouchWon = load(file, 'CCresultRtouchWon');
                                    CrossCorr_Rtouch = CCresultRtouchWon.CCresultRtouchWon;
                                    x = linspace(-2500,2500,500);
                                    plot(x, CrossCorr_Rtouch)
                                    savepass = [SaveDir Mouse Day file(1:end-4) 'Rt.bmp'];
                                    saveas(figure2, savepass)
                                    
                                    %%% Ltouchでアラインしたスパイク
                                    figure3 = figure;
                                    CCresultLtouchWon = load(file, 'CCresultLtouchWon');
                                    CrossCorr_Ltouch = CCresultLtouchWon.CCresultLtouchWon;
                                    x = linspace(-2500,2500,500);
                                    plot(x, CrossCorr_Ltouch)
                                    savepass = [SaveDir Mouse Day file(1:end-4) 'Lt.bmp'];
                                    saveas(figure3, savepass)
                                    
                                    close all hidden
                                end
                            end
                                    
                                    
                            cd([daypath '\ParameterFolder'])
                            fileList = ls;
                            for m = 1:length(fileList(:,1));
                                if ~isempty(strfind(fileList(m,:), Neuron)) && isempty(strfind(fileList(m,:), '89')) && isempty(strfind(fileList(m,:), 'Agra'))
                                    %%% Rtouchのスペクトログラム
                                    figure4 = figure;
                                    file = fileList(m,:);
                                    AmpRt = load(file, 'AmpRt');
                                    Spectrogram_Rt = AmpRt.AmpRt(1:120);
                                    x = linspace(0,12,120);
                                    plot(x, Spectrogram_Rt)
                                    savepass = [SaveDir file(1:end-4) 'AmpRt.bmp'];
                                    saveas(figure4, savepass)
                                    
                                    %%% Ltouchのスペクトログラム
                                    figure5 = figure;
                                    AmpLt = load(file, 'AmpLt');
                                    Spectrogram_Lt = AmpLt.AmpLt(1:120);
                                    x = linspace(0,12,120);
                                    plot(x, Spectrogram_Lt)
                                    savepass = [SaveDir file(1:end-4) 'AmpLt.bmp'];
                                    saveas(figure5, savepass)
                                    
                                    close all hidden
                                end
                            end
%                         end
                    end
                end
            end
        end
    end
end
