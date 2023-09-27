function Repeat_Repeat20220316

global RpegTouchallWon LpegTouchallWon SpikeArrayWon tfile pegpatternname trimFolder2  pegpatternum ...
    LtPositiveFiringRate RtPositiveFiringRate LtPositiveFiringRateP1 RtPositiveFiringRateP1 LtStep4FiringRate RtStep4FiringRate Spikeposition Windowinterval ...
    LtStep3FiringRate RtStep3FiringRate ...
    LtRsq1 RtRsq1 Ltbeta1 Rtbeta1 LtPositive_beta_hist RtPositive_beta_hist LtPositive_R_hist RtPositive_R_hist

path='E:\CheetahWRLV20200411';
% path='E:\CheetahWRLV20230323_Ctx';
cd(path);

cellnum=0;
patternnum=0;
Touchcellnum = 0;
mod98=0;
modBgra=0;


Rtouchnum=0;
Ltouchnum=0;
LS1=ls;
LtPositive_beta_hist = [];
RtPositive_beta_hist = [];
LtPositive_R_hist = [];
RtPositive_R_hist = [];

LtpositiveFRarray1 = [];
LtpositiveFRarray2 = [];
LtpositiveFRarray3 = [];
LtpositiveFRarray4 = [];
LtpositiveFRarray5 = [];
RtpositiveFRarray1 = [];
RtpositiveFRarray2 = [];
RtpositiveFRarray3 = [];
RtpositiveFRarray4 = [];
RtpositiveFRarray5 = [];

LtpositiveFRarray1_P1 = [];
LtpositiveFRarray2_P1 = [];
LtpositiveFRarray3_P1 = [];
LtpositiveFRarray4_P1 = [];
LtpositiveFRarray5_P1 = [];
RtpositiveFRarray1_P1 = [];
RtpositiveFRarray2_P1 = [];
RtpositiveFRarray3_P1 = [];
RtpositiveFRarray4_P1 = [];
RtpositiveFRarray5_P1 = [];

LtFRarray01111 = [];
LtFRarray10111 = [];
LtFRarray11011 = [];
LtFRarray11101 = [];
LtFRarray11110 = [];
LtFR_consecutive = [];
LtFR_non_consecutive = [];

RtFRarray01111 = [];
RtFRarray10111 = [];
RtFRarray11011 = [];
RtFRarray11101 = [];
RtFRarray11110 = [];
RtFR_consecutive = [];
RtFR_non_consecutive = [];

LtFRarray00111 = [];
LtFRarray01011 = [];
LtFRarray01101 = [];
LtFRarray01110 = [];
LtFRarray10011 = [];
LtFRarray10101 = [];
LtFRarray10110 = [];
LtFRarray11001 = [];
LtFRarray11010 = [];
LtFRarray11100 = [];
Lt3FR_consecutive = [];
Lt3FR_non_consecutive = [];

RtFRarray00111 = [];
RtFRarray01011 = [];
RtFRarray01101 = [];
RtFRarray01110 = [];
RtFRarray10011 = [];
RtFRarray10101 = [];
RtFRarray10110 = [];
RtFRarray11001 = [];
RtFRarray11010 = [];
RtFRarray11100 = [];
Rt3FR_consecutive = [];
Rt3FR_non_consecutive = [];


for i=1:length(LS1(:,1)) %1��ڂŌŒ�A�s�𓮂����B�e�}�E�X�ŃC�e���[�V�������񂷁B
    trimFolder=strtrim(LS1(i,:));
    if ~strcmp(trimFolder,'.') && ~strcmp(trimFolder,'..') && isempty(strfind(trimFolder,'.bmp')) && isempty(strfind(trimFolder,'.xlsx')) && isempty(strfind(trimFolder,'.fig')) &&...
            ~strcmp(trimFolder,'CCSfigure') && isempty(strfind(trimFolder,'SpikeFormAnalysis')) && isempty(strfind(trimFolder,'widthPtoT')) && ~strcmp(trimFolder,'CCSfigure-Lt') &&...
            ~strcmp(trimFolder,'CCSfigure-RLt') && ~strcmp(trimFolder,'CCSfigure-Rt') &&isempty(strfind(trimFolder,'Hirokane')) &&isempty(strfind(trimFolder,'Window')) &&isempty(strfind(trimFolder,'Chunk'))
        CDFolder=[path,'\',trimFolder]; %cd�t�H���_�ύXC:\Users\C238\Desktop\CheetahWRLV20180729Part1\trimfolder(mouseNo)
        cd(CDFolder);
        LS2=ls;
        for j=1:length(LS2(:,1))% �e�g���C�A���ŃC�e���[�V�������񂷁B
            trimFolder2=strtrim(LS2(j,:));
            if length(trimFolder2)>4 && ~strcmp(trimFolder2(end-3:end),'.mat');
                CDFolder2=[CDFolder,'\',trimFolder2];  %C:\Users\C238\Desktop\CheetahWRLV20180729Part1\119\2017-6-7_20-8-33 11901-51
                pegpattern=[];
                cd(CDFolder2)
                LS3=ls;
                for c=1:length(LS3(:,1))
                    trimLS3=strtrim(LS3(c,:));
                    if length(trimLS3)>10 && strcmp(trimLS3(end-3:end),'.mat');
                        pegpattern=[pegpattern;trimLS3]; %�y�O�p�^�[����ǂݍ���(.mat�t�@�C��)
                    end
                end
                TouchCellName=[];
                response_list=[];
                CDFolder3=[CDFolder2,'\CellCell'];%C:\Users\C238\Desktop\CheetahWRLV20180729Part1\119\2017-6-7_20-8-33 11901-51\CellCell
                cd(CDFolder3)
                LSC=ls;
                for x=1:length(LSC(:,1));
                    
                    trimCellFolder=strtrim(LSC(x,:));
                    if length(trimCellFolder)>4 && ~strcmp(trimCellFolder((end-3):end),'.mat');
                        CDFolder5=[CDFolder3,'\',trimCellFolder]; %C:\Users\C238\Desktop\CheetahWRLV20180729Part1\119\2017-6-7_20-8-33 11901-51\CellCell\Sc2_SS_01
                        cd(CDFolder5)
                        load('response.mat')
                        if ~isempty(strfind(response,'t')) && ~isempty(strfind(response, 'MSN')); %�^�b�`�ɔ�������MSN�זE������
                            TouchCellName=[TouchCellName;trimCellFolder];% �E�������̃^�b�`�ɔ�������זE�̃t�H���_�ԍ����i�[���Ă����B�e�}�E�X���Ƃ�
                            Touchcellnum = Touchcellnum+1;
                            response_list = char(response_list, response);
                            if ~isempty(strfind(response, 'mod98'))
                                mod98 = mod98+1;
                            end
                            if ~isempty(strfind(response, 'modBgra'))
                                modBgra = modBgra+1;
                            end
                        end
                    end
                end
                
                
                if ~isempty(TouchCellName);
                    for k=1:length(TouchCellName(:,1));%%�����̃^�b�`�ɔ������Ă���זE�ŉ񂵂Ă���
                        response = response_list(k+1,:);
                        SpikeArray=[];
                        tfile=[strtrim(TouchCellName(k,:)),'.t'];%% .t�t�@�C��
                        %                     SpikeArray=GetSpikeAll(CDFolder2,tfile);
                        SpikeArrayWon=[];
                        cd('C:\Users\C238\CheetahWRLV20220213\touchcellLtRt_Hirokane');
                        Complex_pattern_count = 0;
                        for d=1:length(pegpattern(:,1));%�ۑ������y�O�p�^�[�����ƂɌ��Ă���
                            if ~isempty(strfind(pegpattern(d,:),'_C'));%_C�̔z�����������
                                %                                 if Complex_pattern_count > 0;
                                %                                     continue
                                %                                 end
                                if Complex_pattern_count == 0;
                                    cellnum=cellnum+1;
                                end
                                
                                Complex_pattern_count = Complex_pattern_count + 1;
                                Foldercell=num2str(cellnum); %num2str�͐��l��
                                
                                if not(exist(Foldercell,'dir'))
                                    mkdir(Foldercell); %%1~117�̍זE�ԍ����Ƀf�B���N�g�����쐬
                                end
                                
                                %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
                                %%%%��������ABgra��98���g���āA���K�Ȏ����ƈʑ��𔭌����Ă����B
                                
                                for f=1:length(pegpattern(:,1));%�@�y�O�p�^�[�����ƂɌ��Ă���
                                    if ~isempty(strfind(pegpattern(f,:),'_98')); %�܂���98�̔z�����������
                                        
                                        CDFolder98=[CDFolder2,'\',pegpattern(f,(1:end-4))];
                                        cd(CDFolder98)
                                        file=['Bdata.mat'];
                                        load(file);
                                        SpikeArray=GetSpikeAll(CDFolder2,tfile);
                                        SpikeArray(SpikeArray<StartTime | SpikeArray>FinishTime)=[];
                                        %WaterOn�̂Ƃ��݂̂̃X�p�C�N
                                        if ~isempty(SpikeArray)
                                            SpikeWon=ones(1,length(SpikeArray));
                                            for l=1:length(SpikeArray)
                                                if OnWater(SpikeArray(l))==0
                                                    SpikeWon(l)=0;
                                                end
                                            end
                                            SpikeArrayWon=SpikeArray.*SpikeWon;
                                            SpikeArrayWon(SpikeArrayWon==0)=[];
                                            
                                        end
                                        %WaterOn�̂Ƃ��݂̂�RpegTouchall
                                        if ~isempty(RpegTouchall)
                                            RTWon=ones(1,length(RpegTouchall));
                                            for l=1:length(RpegTouchall)
                                                if OnWater(RpegTouchall(l))==0
                                                    RTWon(l)=0;
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
                                        %WaterOn�̂Ƃ��݂̂�LpegTouchall
                                        if ~isempty(LpegTouchall)
                                            LTWon=ones(1,length(LpegTouchall));
                                            for l=1:length(LpegTouchall)
                                                if OnWater(LpegTouchall(l))==0
                                                    LTWon(l)=0;
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
                                        bin1=20;
                                        phaseR=zeros(1,bin1);
                                        for g=1:length(RpegTouchallWon)-1
                                            for h=1:length(SpikeArrayWon)-1
                                                if RpegTouchallWon(g)<SpikeArrayWon(h)&&SpikeArrayWon(h)<=RpegTouchallWon(g+1);   %%�^�b�`�ԂŃX�p�C�N����������
                                                    binarrayR=linspace(RpegTouchallWon(g),RpegTouchallWon(g+1),bin1+1);     %%�^�b�`�Ԃ�bin1�̐��ɕ���
                                                    for e=1:bin1;
                                                        if binarrayR(e)<SpikeArrayWon(h)&&SpikeArrayWon(h)<=binarrayR(e+1);        %%�ǂ̃r���ŃX�p�C�N����������
                                                            phaseR(e)=phaseR(e)+1;
                                                        end
                                                    end
                                                end
                                            end
                                        end
                                        phaseL=zeros(1,bin1);
                                        for g=1:length(LpegTouchallWon)-1
                                            for h=1:length(SpikeArrayWon)-1
                                                if LpegTouchallWon(g)<SpikeArrayWon(h)&&SpikeArrayWon(h)<=LpegTouchallWon(g+1);   %%�^�b�`�ԂŃX�p�C�N����������
                                                    binarrayL=linspace(LpegTouchallWon(g),LpegTouchallWon(g+1),bin1+1);   %%�^�b�`�Ԃ�bin1�̐��ɕ���
                                                    for e=1:length(phaseL)-1
                                                        if binarrayL(e)<SpikeArrayWon(h)&&SpikeArrayWon(h)<=binarrayL(e+1);  %%�ǂ̃r���ŃX�p�C�N����������
                                                            phaseL(e)=phaseL(e)+1;
                                                        end
                                                    end
                                                end
                                            end
                                        end
                                    end
                                    %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
                                    %�����������
                                    
                                    if ~isempty(strfind(pegpattern(f,:),'_Bgra')); %����Bgra�̔z�����������
                                        CDFolderBgra=[CDFolder2,'\',pegpattern(f,(1:end-4))];
                                        cd(CDFolderBgra)
                                        file=['Bdata.mat'];
                                        load(file);
                                        SpikeArray=GetSpikeAll(CDFolder2,tfile);
                                        SpikeArray(SpikeArray<StartTime | SpikeArray>FinishTime)=[];
                                        %WaterOn�̂Ƃ��݂̂̃X�p�C�N
                                        if ~isempty(SpikeArray)
                                            SpikeWon=ones(1,length(SpikeArray));
                                            for l=1:length(SpikeArray)
                                                if OnWater(SpikeArray(l))==0
                                                    SpikeWon(l)=0;
                                                end
                                            end
                                            SpikeArrayWon=SpikeArray.*SpikeWon;
                                            SpikeArrayWon(SpikeArrayWon==0)=[];
                                            
                                        end
                                        %WaterOn�̂Ƃ��݂̂�RpegTouchall
                                        if ~isempty(RpegTouchall)
                                            RTWon=ones(1,length(RpegTouchall));
                                            for l=1:length(RpegTouchall)
                                                if OnWater(RpegTouchall(l))==0
                                                    RTWon(l)=0;
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
                                        %WaterOn�̂Ƃ��݂̂�LpegTouchall
                                        if ~isempty(LpegTouchall)
                                            LTWon=ones(1,length(LpegTouchall));
                                            for l=1:length(LpegTouchall)
                                                if OnWater(LpegTouchall(l))==0
                                                    LTWon(l)=0;
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
                                        bin2=20;
                                        intervalR=zeros(1,bin2);
                                        for g=1:length(RpegTouchallWon)-1
                                            for h=1:length(SpikeArrayWon)-1
                                                if RpegTouchallWon(g)<SpikeArrayWon(h)&&SpikeArrayWon(h)<=RpegTouchallWon(g+1);   %%�^�b�`�ԂŃX�p�C�N����������
                                                    interval = RpegTouchallWon(g+1)-RpegTouchallWon(g);
                                                    for e=1:bin2;
                                                        if 280+e*20<interval&&interval<=300+e*20;
                                                            intervalR(e)=intervalR(e)+1/(280+e*20);
                                                        end
                                                    end
                                                end
                                            end
                                        end
                                        intervalL=zeros(1,bin2);
                                        for g=1:length(LpegTouchallWon)-1
                                            for h=1:length(SpikeArrayWon)-1
                                                if LpegTouchallWon(g)<SpikeArrayWon(h)&&SpikeArrayWon(h)<=LpegTouchallWon(g+1);   %%�^�b�`�ԂŃX�p�C�N����������
                                                    interval = LpegTouchallWon(g+1)-LpegTouchallWon(g);
                                                    for e=1:bin2;
                                                        if 280+e*20<interval&&interval<=300+e*20;
                                                            intervalL(e)=intervalL(e)+1/(280+e*20);
                                                        end
                                                    end
                                                end
                                            end
                                        end
                                    end
                                end
                                % 1���̂ǂ̈ʑ��ōł����΂��₷��������
                                [MaxphR,IndexphR]=max(phaseR);
                                [MaxphL,IndexphL]=max(phaseL);
                                RphPeakIndexRatio=(IndexphR-1)/bin1;
                                LphPeakIndexRatio=(IndexphL-1)/bin1;
                                
                                [MaxintR,IndexintR]=max(intervalR);
                                [MaxintL,IndexintL]=max(intervalL);
                                RintPeak=IndexintR*20+280;
                                LintPeak=IndexintL*20+280;
                                
                                %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
                                %%%%���̃q�[�g�}�b�v��͗p��Complex pattern�̃f�[�^������
                                
                                CDFolder5=[CDFolder2,'\',pegpattern(d,(1:end-4))];
                                cd(CDFolder5)
                                file=['Bdata.mat'];
                                load(file);
                                SpikeArray=GetSpikeAll(CDFolder2,tfile);
                                SpikeArray(SpikeArray<StartTime | SpikeArray>FinishTime)=[];
                                %WaterOn�̂Ƃ��݂̂̃X�p�C�N
                                if ~isempty(SpikeArray)
                                    SpikeWon=ones(1,length(SpikeArray));
                                    for l=1:length(SpikeArray)
                                        if OnWater(SpikeArray(l))==0
                                            SpikeWon(l)=0;
                                        end
                                    end
                                    SpikeArrayWon=SpikeArray.*SpikeWon;
                                    SpikeArrayWon(SpikeArrayWon==0)=[];
                                    
                                end
                                %WaterOn�̂Ƃ��݂̂�RpegTouchall
                                if ~isempty(RpegTouchall)
                                    RTWon=ones(1,length(RpegTouchall));
                                    for l=1:length(RpegTouchall)
                                        if OnWater(RpegTouchall(l))==0
                                            RTWon(l)=0;
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
                                %WaterOn�̂Ƃ��݂̂�LpegTouchall
                                if ~isempty(LpegTouchall)
                                    LTWon=ones(1,length(LpegTouchall));
                                    for l=1:length(LpegTouchall)
                                        if OnWater(LpegTouchall(l))==0
                                            LTWon(l)=0;
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
                                pegpatternname=pegpattern(d,(end-8:end-4));
                                pegpatternum=pegpattern(d,(1:5));
                                Folder6=['C:\Users\C238\CheetahWRLV20220213\touchcellLtRt_Hirokane','\',Foldercell];
                                cd(Folder6)
                                patternnum=patternnum+1;
                                cellnum
                                %                                 pegpatternname
                                %                                 pegpatternum
                                %                                 patternnum
                                
                                %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
                                %%% for R
                                %                                 if ~ isempty(strfind(response, 'Rt'))
                                Rtouchnum=Rtouchnum+1;
                                b = IndexintR;
                                intbin=10;
                                Windowinterval=(300-intbin)+b*(intbin);
                                
                                a = IndexphR;
                                phasebin=10;
                                Spikeposition=(a-1-phasebin)*Windowinterval/phasebin;
                                
                                MovWindow20210107          %%%%%%%�E�B���h�E�𓮂���
                                WindowApply20200225
                                WindowApplyPattern1_20200228
                                
                                if Rtbeta1 > 0;
                                    RtpositiveFRarray1 = [RtpositiveFRarray1 RtPositiveFiringRate(2)];
                                    RtpositiveFRarray2 = [RtpositiveFRarray2 RtPositiveFiringRate(3)];
                                    RtpositiveFRarray3 = [RtpositiveFRarray3 RtPositiveFiringRate(4)];
                                    RtpositiveFRarray4 = [RtpositiveFRarray4 RtPositiveFiringRate(5)];
                                    RtpositiveFRarray5 = [RtpositiveFRarray5 RtPositiveFiringRate(6)];
                                    
                                    RtpositiveFRarray1_P1 = [RtpositiveFRarray1_P1 RtPositiveFiringRateP1(1)];
                                    RtpositiveFRarray2_P1 = [RtpositiveFRarray2_P1 RtPositiveFiringRateP1(2)];
                                    RtpositiveFRarray3_P1 = [RtpositiveFRarray3_P1 RtPositiveFiringRateP1(3)];
                                    RtpositiveFRarray4_P1 = [RtpositiveFRarray4_P1 RtPositiveFiringRateP1(4)];
                                    RtpositiveFRarray5_P1 = [RtpositiveFRarray5_P1 RtPositiveFiringRateP1(5)];
                                    
                                    RtFRarray01111 = [RtFRarray01111 RtStep4FiringRate(1)];
                                    RtFRarray10111 = [RtFRarray10111 RtStep4FiringRate(2)];
                                    RtFRarray11011 = [RtFRarray11011 RtStep4FiringRate(3)];
                                    RtFRarray11101 = [RtFRarray11101 RtStep4FiringRate(4)];
                                    RtFRarray11110 = [RtFRarray11110 RtStep4FiringRate(5)];
                                    
                                    RtFRarray00111 = [RtFRarray00111 RtStep3FiringRate(1)];
                                    RtFRarray01011 = [RtFRarray01011 RtStep3FiringRate(2)];
                                    RtFRarray01101 = [RtFRarray01101 RtStep3FiringRate(3)];
                                    RtFRarray01110 = [RtFRarray01110 RtStep3FiringRate(4)];
                                    RtFRarray10011 = [RtFRarray10011 RtStep3FiringRate(5)];
                                    RtFRarray10101 = [RtFRarray10101 RtStep3FiringRate(6)];
                                    RtFRarray10110 = [RtFRarray10110 RtStep3FiringRate(7)];
                                    RtFRarray11001 = [RtFRarray11001 RtStep3FiringRate(8)];
                                    RtFRarray11010 = [RtFRarray11010 RtStep3FiringRate(9)];
                                    RtFRarray11100 = [RtFRarray11100 RtStep3FiringRate(10)];
                                    
                                    RtFR_consecutive = [RtFR_consecutive (RtStep4FiringRate(1)+RtStep4FiringRate(5))/2];
                                    RtFR_non_consecutive = [RtFR_non_consecutive (RtStep4FiringRate(2)+RtStep4FiringRate(3)+RtStep4FiringRate(4))/3];
                                    
                                    Rt3FR_consecutive = [Rt3FR_consecutive (RtStep3FiringRate(1)+RtStep3FiringRate(4)+RtStep3FiringRate(10))/3];
                                    Rt3FR_non_consecutive = [Rt3FR_non_consecutive (RtStep3FiringRate(2)+RtStep3FiringRate(3)+RtStep3FiringRate(5)+RtStep3FiringRate(6)+RtStep3FiringRate(7)+RtStep3FiringRate(8)+RtStep3FiringRate(9))/7];
                                    
                                    %                                 WindowApply20220316   %�Ȃ񂩂��܂������Ȃ��̂ŕ���
                                    %                                 RtFRarray=RtPositiveFiringRate;
                                    
                                    Rt_Rsq = RtRsq1;
                                    RtPositive_beta_hist=[RtPositive_beta_hist,Rtbeta1];
                                    RtPositive_R_hist=[RtPositive_R_hist, RtRsq1];
                                    
                                    if Rt_Rsq > 0.6 && Rtbeta1 > 0 && isempty(strfind(response,'Rrep'))
                                        response = [response 'Rrep'];
                                    end
                                    filename=[num2str(patternnum),'Rt_Rsq.mat'];
                                    save(filename,'Rt_Rsq')
                                end
                                if Ltbeta1 > 0;
                                    LtpositiveFRarray1 = [LtpositiveFRarray1 LtPositiveFiringRate(2)];
                                    LtpositiveFRarray2 = [LtpositiveFRarray2 LtPositiveFiringRate(3)];
                                    LtpositiveFRarray3 = [LtpositiveFRarray3 LtPositiveFiringRate(4)];
                                    LtpositiveFRarray4 = [LtpositiveFRarray4 LtPositiveFiringRate(5)];
                                    LtpositiveFRarray5 = [LtpositiveFRarray5 LtPositiveFiringRate(6)];
                                    
                                    LtpositiveFRarray1_P1 = [LtpositiveFRarray1_P1 LtPositiveFiringRateP1(1)];
                                    LtpositiveFRarray2_P1 = [LtpositiveFRarray2_P1 LtPositiveFiringRateP1(2)];
                                    LtpositiveFRarray3_P1 = [LtpositiveFRarray3_P1 LtPositiveFiringRateP1(3)];
                                    LtpositiveFRarray4_P1 = [LtpositiveFRarray4_P1 LtPositiveFiringRateP1(4)];
                                    LtpositiveFRarray5_P1 = [LtpositiveFRarray5_P1 LtPositiveFiringRateP1(5)];
                                    
                                    LtFRarray01111 = [LtFRarray01111 LtStep4FiringRate(1)];
                                    LtFRarray10111 = [LtFRarray10111 LtStep4FiringRate(2)];
                                    LtFRarray11011 = [LtFRarray11011 LtStep4FiringRate(3)];
                                    LtFRarray11101 = [LtFRarray11101 LtStep4FiringRate(4)];
                                    LtFRarray11110 = [LtFRarray11110 LtStep4FiringRate(5)];
                                    
                                    LtFRarray00111 = [LtFRarray00111 LtStep3FiringRate(1)];
                                    LtFRarray01011 = [LtFRarray01011 LtStep3FiringRate(2)];
                                    LtFRarray01101 = [LtFRarray01101 LtStep3FiringRate(3)];
                                    LtFRarray01110 = [LtFRarray01110 LtStep3FiringRate(4)];
                                    LtFRarray10011 = [LtFRarray10011 LtStep3FiringRate(5)];
                                    LtFRarray10101 = [LtFRarray10101 LtStep3FiringRate(6)];
                                    LtFRarray10110 = [LtFRarray10110 LtStep3FiringRate(7)];
                                    LtFRarray11001 = [LtFRarray11001 LtStep3FiringRate(8)];
                                    LtFRarray11010 = [LtFRarray11010 LtStep3FiringRate(9)];
                                    LtFRarray11100 = [LtFRarray11100 LtStep3FiringRate(10)];
                                    
                                    LtFR_consecutive = [LtFR_consecutive (LtStep4FiringRate(1)+LtStep4FiringRate(5))/2];
                                    LtFR_non_consecutive = [LtFR_non_consecutive (LtStep4FiringRate(2)+LtStep4FiringRate(3)+LtStep4FiringRate(4))/3];
                                    
                                    Lt3FR_consecutive = [Lt3FR_consecutive (LtStep3FiringRate(1)+LtStep3FiringRate(4)+LtStep3FiringRate(10))/3];
                                    Lt3FR_non_consecutive = [Lt3FR_non_consecutive (LtStep3FiringRate(2)+LtStep3FiringRate(3)+LtStep3FiringRate(5)+LtStep3FiringRate(6)+LtStep3FiringRate(7)+LtStep3FiringRate(8)+LtStep3FiringRate(9))/7];
                                    
                                    
                                    
                                    %                                 WindowApply20220316 %�Ȃ񂩂��܂������Ȃ��̂ŕ���
                                    %                                 LtFRarray=LtPositiveFiringRate;
                                    Lt_Rsq = LtRsq1;
                                    LtPositive_beta_hist=[LtPositive_beta_hist,Ltbeta1];
                                    LtPositive_R_hist=[LtPositive_R_hist, LtRsq1];
                                    
                                    if Lt_Rsq > 0.6 && Ltbeta1 > 0 && isempty(strfind(response,'Lrep'))
                                        response = [response 'Lrep'];
                                    end
                                    
                                    
                                end
                                %                                 end
                                
                                %%% for L
                                %                                 if ~ isempty(strfind(response, 'Lt'))
                                Ltouchnum=Ltouchnum+1;
                                b = IndexintL;
                                intbin=10;
                                Windowinterval=(300-intbin)+b*(intbin);
                                
                                a = IndexphL;
                                phasebin=10;
                                Spikeposition=(a-1-phasebin)*Windowinterval/phasebin;
                                
                                MovWindow20210107          %%%%%%%�E�B���h�E�𓮂���
                                WindowApply20200225
                                if Ltbeta1 > 0;
                                    LtpositiveFRarray1 = [LtpositiveFRarray1 LtPositiveFiringRate(2)];
                                    LtpositiveFRarray2 = [LtpositiveFRarray2 LtPositiveFiringRate(3)];
                                    LtpositiveFRarray3 = [LtpositiveFRarray3 LtPositiveFiringRate(4)];
                                    LtpositiveFRarray4 = [LtpositiveFRarray4 LtPositiveFiringRate(5)];
                                    LtpositiveFRarray5 = [LtpositiveFRarray5 LtPositiveFiringRate(6)];
                                    
                                    LtpositiveFRarray1_P1 = [LtpositiveFRarray1_P1 LtPositiveFiringRateP1(1)];
                                    LtpositiveFRarray2_P1 = [LtpositiveFRarray2_P1 LtPositiveFiringRateP1(2)];
                                    LtpositiveFRarray3_P1 = [LtpositiveFRarray3_P1 LtPositiveFiringRateP1(3)];
                                    LtpositiveFRarray4_P1 = [LtpositiveFRarray4_P1 LtPositiveFiringRateP1(4)];
                                    LtpositiveFRarray5_P1 = [LtpositiveFRarray5_P1 LtPositiveFiringRateP1(5)];
                                    
                                    LtFRarray01111 = [LtFRarray01111 LtStep4FiringRate(1)];
                                    LtFRarray10111 = [LtFRarray10111 LtStep4FiringRate(2)];
                                    LtFRarray11011 = [LtFRarray11011 LtStep4FiringRate(3)];
                                    LtFRarray11101 = [LtFRarray11101 LtStep4FiringRate(4)];
                                    LtFRarray11110 = [LtFRarray11110 LtStep4FiringRate(5)];
                                    
                                    LtFRarray00111 = [LtFRarray00111 LtStep3FiringRate(1)];
                                    LtFRarray01011 = [LtFRarray01011 LtStep3FiringRate(2)];
                                    LtFRarray01101 = [LtFRarray01101 LtStep3FiringRate(3)];
                                    LtFRarray01110 = [LtFRarray01110 LtStep3FiringRate(4)];
                                    LtFRarray10011 = [LtFRarray10011 LtStep3FiringRate(5)];
                                    LtFRarray10101 = [LtFRarray10101 LtStep3FiringRate(6)];
                                    LtFRarray10110 = [LtFRarray10110 LtStep3FiringRate(7)];
                                    LtFRarray11001 = [LtFRarray11001 LtStep3FiringRate(8)];
                                    LtFRarray11010 = [LtFRarray11010 LtStep3FiringRate(9)];
                                    LtFRarray11100 = [LtFRarray11100 LtStep3FiringRate(10)];
                                    
                                    LtFR_consecutive = [LtFR_consecutive (LtStep4FiringRate(1)+LtStep4FiringRate(5))/2];
                                    LtFR_non_consecutive = [LtFR_non_consecutive (LtStep4FiringRate(2)+LtStep4FiringRate(3)+LtStep4FiringRate(4))/3];
                                    
                                    Lt3FR_consecutive = [Lt3FR_consecutive (LtStep3FiringRate(1)+LtStep3FiringRate(4)+LtStep3FiringRate(10))/3];
                                    Lt3FR_non_consecutive = [Lt3FR_non_consecutive (LtStep3FiringRate(2)+LtStep3FiringRate(3)+LtStep3FiringRate(5)+LtStep3FiringRate(6)+LtStep3FiringRate(7)+LtStep3FiringRate(8)+LtStep3FiringRate(9))/7];
                                    
                                    %                                 WindowApply20220316 %�Ȃ񂩂��܂������Ȃ��̂ŕ���
                                    %                                 LtFRarray=LtPositiveFiringRate;
                                    Lt_Rsq = LtRsq1;
                                    LtPositive_beta_hist=[LtPositive_beta_hist,Ltbeta1];
                                    LtPositive_R_hist=[LtPositive_R_hist, LtRsq1];
                                    
                                    if Lt_Rsq > 0.6 && Ltbeta1 > 0 && isempty(strfind(response,'Lrep'))
                                        response = [response 'Lrep'];
                                    end
                                    
                                    filename=[num2str(patternnum),'LtRsq.mat'];
                                    save(filename,'Lt_Rsq')
                                end
                                if Rtbeta1 > 0;
                                    RtpositiveFRarray1 = [RtpositiveFRarray1 RtPositiveFiringRate(2)];
                                    RtpositiveFRarray2 = [RtpositiveFRarray2 RtPositiveFiringRate(3)];
                                    RtpositiveFRarray3 = [RtpositiveFRarray3 RtPositiveFiringRate(4)];
                                    RtpositiveFRarray4 = [RtpositiveFRarray4 RtPositiveFiringRate(5)];
                                    RtpositiveFRarray5 = [RtpositiveFRarray5 RtPositiveFiringRate(6)];
                                    
                                    RtpositiveFRarray1_P1 = [RtpositiveFRarray1_P1 RtPositiveFiringRateP1(1)];
                                    RtpositiveFRarray2_P1 = [RtpositiveFRarray2_P1 RtPositiveFiringRateP1(2)];
                                    RtpositiveFRarray3_P1 = [RtpositiveFRarray3_P1 RtPositiveFiringRateP1(3)];
                                    RtpositiveFRarray4_P1 = [RtpositiveFRarray4_P1 RtPositiveFiringRateP1(4)];
                                    RtpositiveFRarray5_P1 = [RtpositiveFRarray5_P1 RtPositiveFiringRateP1(5)];
                                    
                                    RtFRarray01111 = [RtFRarray01111 RtStep4FiringRate(1)];
                                    RtFRarray10111 = [RtFRarray10111 RtStep4FiringRate(2)];
                                    RtFRarray11011 = [RtFRarray11011 RtStep4FiringRate(3)];
                                    RtFRarray11101 = [RtFRarray11101 RtStep4FiringRate(4)];
                                    RtFRarray11110 = [RtFRarray11110 RtStep4FiringRate(5)];
                                    
                                    RtFRarray00111 = [RtFRarray00111 RtStep3FiringRate(1)];
                                    RtFRarray01011 = [RtFRarray01011 RtStep3FiringRate(2)];
                                    RtFRarray01101 = [RtFRarray01101 RtStep3FiringRate(3)];
                                    RtFRarray01110 = [RtFRarray01110 RtStep3FiringRate(4)];
                                    RtFRarray10011 = [RtFRarray10011 RtStep3FiringRate(5)];
                                    RtFRarray10101 = [RtFRarray10101 RtStep3FiringRate(6)];
                                    RtFRarray10110 = [RtFRarray10110 RtStep3FiringRate(7)];
                                    RtFRarray11001 = [RtFRarray11001 RtStep3FiringRate(8)];
                                    RtFRarray11010 = [RtFRarray11010 RtStep3FiringRate(9)];
                                    RtFRarray11100 = [RtFRarray11100 RtStep3FiringRate(10)];
                                    
                                    RtFR_consecutive = [RtFR_consecutive (RtStep4FiringRate(1)+RtStep4FiringRate(5))/2];
                                    RtFR_non_consecutive = [RtFR_non_consecutive (RtStep4FiringRate(2)+RtStep4FiringRate(3)+RtStep4FiringRate(4))/3];
                                    
                                    Rt3FR_consecutive = [Rt3FR_consecutive (RtStep3FiringRate(1)+RtStep3FiringRate(4)+RtStep3FiringRate(10))/3];
                                    Rt3FR_non_consecutive = [Rt3FR_non_consecutive (RtStep3FiringRate(2)+RtStep3FiringRate(3)+RtStep3FiringRate(5)+RtStep3FiringRate(6)+RtStep3FiringRate(7)+RtStep3FiringRate(8)+RtStep3FiringRate(9))/7];
                                    
                                    
                                    %                                 WindowApply20220316   %�Ȃ񂩂��܂������Ȃ��̂ŕ���
                                    %                                 RtFRarray=RtPositiveFiringRate;
                                    
                                    Rt_Rsq = RtRsq1;
                                    RtPositive_beta_hist=[RtPositive_beta_hist,Rtbeta1];
                                    RtPositive_R_hist=[RtPositive_R_hist, RtRsq1];
                                    
                                    if Rt_Rsq > 0.6 && Rtbeta1 > 0 && isempty(strfind(response,'Rrep'))
                                        response = [response 'Rrep'];
                                    end
                                end
                                
                                %                                 end
                                save('response.mat', 'response')
                            end
                        end
                    end
                end
            end
        end
    end
end

]]



cd('C:\Users\C238\CheetahWRLV20220213')

%%% �J��Ԃ���Figure�i�A���j
figure('Name','Left repeat FR','NumberTitle','off');
data = [LtpositiveFRarray1; LtpositiveFRarray2; LtpositiveFRarray3; LtpositiveFRarray4; LtpositiveFRarray5];
x = [1 2 3 4 5];
y = mean(data,2);
SEM = std(data,0,2)./sqrt(length(data));
bar(x,y);
hold on
err = errorbar(y,SEM);
err.LineStyle = 'None';
err.Color = 'k';
hold off
saveas(gcf, 'Left_repeat_FR.bmp')
[p,~,stats] = anova1(data.')
[results,means] = multcompare(stats,'CType','bonferroni')

figure('Name','Right repeat FR','NumberTitle','off');
data = [RtpositiveFRarray1; RtpositiveFRarray2; RtpositiveFRarray3; RtpositiveFRarray4; RtpositiveFRarray5];
y = mean(data,2);
SEM = std(data,0,2)./sqrt(length(data));
bar(x,y);
hold on
err = errorbar(y,SEM);
err.LineStyle = 'None';
err.Color = 'k';
hold off
saveas(gcf, 'Right_repeat_FR.bmp')
[p,~,stats] = anova1(data.')
[results,means] = multcompare(stats,'CType','bonferroni')


%%% �J��Ԃ���Figure�i�A������Ȃ��j
figure('Name','Left repeat FR_P1','NumberTitle','off');
data = [LtpositiveFRarray1_P1; LtpositiveFRarray2_P1; LtpositiveFRarray3_P1; LtpositiveFRarray4_P1; LtpositiveFRarray5_P1];
y = mean(data,2);
SEM = std(data,0,2)./sqrt(length(data));
bar(x,y);
hold on
err = errorbar(y,SEM);
err.LineStyle = 'None';
err.Color = 'k';
hold off
saveas(gcf, 'Left_repeat_FR_P1.bmp')
[p,~,stats] = anova1(data.')
[results,means] = multcompare(stats,'CType','bonferroni')

figure('Name','Right repeat FR_P1','NumberTitle','off');
data = [RtpositiveFRarray1_P1; RtpositiveFRarray2_P1; RtpositiveFRarray3_P1; RtpositiveFRarray4_P1; RtpositiveFRarray5_P1];
y = mean(data,2);
SEM = std(data,0,2)./sqrt(length(data));
bar(x,y);
hold on
err = errorbar(y,SEM);
err.LineStyle = 'None';
err.Color = 'k';
hold off
saveas(gcf, 'Right_repeat_FR_P1.bmp')
[p,~,stats] = anova1(data.')
[results,means] = multcompare(stats,'CType','bonferroni')


%%%Window��4���Ă͂܂������̔��Εp�x��Figure
figure('Name','Right 4Step FR','NumberTitle','off');
data = [RtFRarray01111;RtFRarray10111;RtFRarray11011;RtFRarray11101;RtFRarray11110];
y = mean(data,2);
SEM = std(data,0,2)./sqrt(length(data));
bar(x,y);
hold on
err = errorbar(y,SEM);
err.LineStyle = 'None';
err.Color = 'k';
hold off
saveas(gcf, 'Right_4step_FR.bmp')
[p,~,stats] = anova1(data.')
[results,means] = multcompare(stats,'CType','bonferroni')

figure('Name','Left 4Step FR','NumberTitle','off');
data = [LtFRarray01111;LtFRarray10111;LtFRarray11011;LtFRarray11101;LtFRarray11110];
y = mean(data,2);
SEM = std(data,0,2)./sqrt(length(data));
bar(x,y);
hold on
err = errorbar(y,SEM);
err.LineStyle = 'None';
err.Color = 'k';
hold off
saveas(gcf, 'Left_4step_FR.bmp')
[p,~,stats] = anova1(data.')
[results,means] = multcompare(stats,'CType','bonferroni')



%%%Window��3���Ă͂܂������̔��Εp�x��Figure
x = [1 2 3 4 5 6 7 8 9 10];
figure('Name','Right 3Step FR','NumberTitle','off');
data = [RtFRarray00111;RtFRarray01011;RtFRarray01101;RtFRarray01110;RtFRarray10011;RtFRarray10101;RtFRarray10110;RtFRarray11001;RtFRarray11010;RtFRarray11100];
y = mean(data,2);
SEM = std(data,0,2)./sqrt(length(data));
bar(x,y);
hold on
err = errorbar(y,SEM);
err.LineStyle = 'None';
err.Color = 'k';
hold off
saveas(gcf, 'Right_3step_FR.bmp')
[p,~,stats] = anova1(data.')
[results,means] = multcompare(stats,'CType','bonferroni')

figure('Name','Left 3Step FR','NumberTitle','off');
data = [LtFRarray00111;LtFRarray01011;LtFRarray01101;LtFRarray01110;LtFRarray10011;LtFRarray10101;LtFRarray10110;LtFRarray11001;LtFRarray11010;LtFRarray11100];
y = mean(data,2);
SEM = std(data,0,2)./sqrt(length(data));
bar(x,y);
hold on
err = errorbar(y,SEM);
err.LineStyle = 'None';
err.Color = 'k';
hold off
saveas(gcf, 'Left_3step_FR.bmp')
[p,~,stats] = anova1(data.')
[results,means] = multcompare(stats,'CType','bonferroni')


%%%beta��R^2�̃q�X�g�O����
figure_betaR_hist = figure;
subplot(2,2,1)
histogram(LtPositive_beta_hist)
title('Lt beta')
subplot(2,2,2)
histogram(RtPositive_beta_hist)
title('Rt beta')
subplot(2,2,3)
histogram(LtPositive_R_hist)
title('Lt R^2')
subplot(2,2,4)
histogram(RtPositive_R_hist)
title('Rt R^2')
saveas(figure_betaR_hist, 'beta_R^2_histogram.bmp')


%%%�A���ƘA���ȊO�̔��Εp�x��r(4Step)
figure('Name','4step_comp','NumberTitle','off');
subplot(1,2,1)
data = [LtFR_consecutive; LtFR_non_consecutive];
x=[1 2];
y = mean(data,2);
SEM = std(data,0,2)./sqrt(length(data));
bar(x,y);
hold on
err = errorbar(y,SEM);
err.LineStyle = 'None';
err.Color = 'k';
hold off
[result, p] = ttest2(LtFR_consecutive, LtFR_non_consecutive)

subplot(1,2,2)
data = [RtFR_consecutive; RtFR_non_consecutive];
y = mean(data,2);
SEM = std(data,0,2)./sqrt(length(data));
bar(x,y);
hold on
err = errorbar(y,SEM);
err.LineStyle = 'None';
err.Color = 'k';
hold off
[result, p] = ttest2(RtFR_consecutive, RtFR_non_consecutive)

saveas(gcf, '4step_comp.bmp')


%%%�A���ƘA���ȊO�̔��Εp�x��r(3Step)
figure('Name','3step_comp','NumberTitle','off');
subplot(1,2,1)
data = [Lt3FR_consecutive; Lt3FR_non_consecutive];
x=[1 2];
y = mean(data,2);
SEM = std(data,0,2)./sqrt(length(data));
bar(x,y);
hold on
err = errorbar(y,SEM);
err.LineStyle = 'None';
err.Color = 'k';
hold off
[result, p] = ttest2(Lt3FR_consecutive, Lt3FR_non_consecutive)

subplot(1,2,2)
data = [Rt3FR_consecutive; Rt3FR_non_consecutive];
y = mean(data,2);
SEM = std(data,0,2)./sqrt(length(data));
bar(x,y);
hold on
err = errorbar(y,SEM);
err.LineStyle = 'None';
err.Color = 'k';
hold off
[result, p] = ttest2(Rt3FR_consecutive, Rt3FR_non_consecutive)

saveas(gcf, '3step_comp.bmp')

