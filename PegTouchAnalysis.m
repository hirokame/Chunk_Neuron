function [RpegTouchCell,LpegTouchCell,RLpegTouchCell,RLpegName,RLpegMedian,RpegTouchTurn,LpegTouchTurn]=PegTouchAnalysis(PegTouchCell1,SliderTouch1,TurnMarkerTime,OneTurnTime1,RpegTimeArray2D,LpegTimeArray2D,FTselect)
%'PegTouch'��sensor�̏��𓾂������B12ch���ׂĂ�Rpeg12�{�Ɋ��蓖�Ă��Ă���Ƃ��ɂ�PegTouch�����ł��悩�����B
%�������ARL��6ch���g�p����ۂɂ́A1-6�A7-12�����蓖�Ă�K�v������B
global SliderTouch OneTurnTime RefPeriod RpegMedian LpegMedian RLpegMedian RLpegName DrName fig_touchR fig_touchL fig_touchR_TM fig_touchL_TM fig_TMpegs...
    PtouchHistoCell_R PtouchHistoCell_L WaterOn_percent RLPegTouchAll RPegTouchAll LPegTouchAll FigureSave RpegTimeArray2D LpegTimeArray2D modif...
    RpegTouchBypegCell  LpegTouchBypegCell RmedianPTTM LmedianPTTM ShowFig patternValue
%RpegMedian,LpegMedian��Touch���Ԃ�Median
%MedPegTimeR MedPegTimeL��Peg���B���Ԃ�Median

PegTouchCell=PegTouchCell1;
SliderTouch=SliderTouch1;
OneTurnTime=OneTurnTime1;

Rpegtouch1=[];Rpegtouch2=[];Rpegtouch3=[];Rpegtouch4=[];Rpegtouch5=[];Rpegtouch6=[];Rpegtouch7=[];Rpegtouch8=[];Rpegtouch9=[];Rpegtouch10=[];Rpegtouch11=[];Rpegtouch12=[];
RpegTouchCell={Rpegtouch1,Rpegtouch2,Rpegtouch3,Rpegtouch4,Rpegtouch5,Rpegtouch6,Rpegtouch7,Rpegtouch8,Rpegtouch9,Rpegtouch10,Rpegtouch11,Rpegtouch12};
Lpegtouch1=[];Lpegtouch2=[];Lpegtouch3=[];Lpegtouch4=[];Lpegtouch5=[];Lpegtouch6=[];Lpegtouch7=[];Lpegtouch8=[];Lpegtouch9=[];Lpegtouch10=[];Lpegtouch11=[];Lpegtouch12=[];
LpegTouchCell={Lpegtouch1,Lpegtouch2,Lpegtouch3,Lpegtouch4,Lpegtouch5,Lpegtouch6,Lpegtouch7,Lpegtouch8,Lpegtouch9,Lpegtouch10,Lpegtouch11,Lpegtouch12};
%SliderTouch(find(SliderTouch>0.5))=SliderTouch(find(SliderTouch>0.5))-0.5;
Rpegturn1=[];Rpegturn2=[];Rpegturn3=[];Rpegturn4=[];Rpegturn5=[];Rpegturn6=[];Rpegturn7=[];Rpegturn8=[];Rpegturn9=[];Rpegturn10=[];Rpegturn11=[];Rpegturn12=[];
RpegTouchTurn={Rpegturn1,Rpegturn2,Rpegturn3,Rpegturn4,Rpegturn5,Rpegturn6,Rpegturn7,Rpegturn8,Rpegturn9,Rpegturn10,Rpegturn11,Rpegturn12};
Lpegturn1=[];Lpegturn2=[];Lpegturn3=[];Lpegturn4=[];Lpegturn5=[];Lpegturn6=[];Lpegturn7=[];Lpegturn8=[];Lpegturn9=[];Lpegturn10=[];Lpegturn11=[];Lpegturn12=[];
LpegTouchTurn={Lpegturn1,Lpegturn2,Lpegturn3,Lpegturn4,Lpegturn5,Lpegturn6,Lpegturn7,Lpegturn8,Lpegturn9,Lpegturn10,Lpegturn11,Lpegturn12};

%�R�i�I�ʁ@���i��RefPeriod�ɂ���ĘA������FalseTouch�͂��łɏ����Ă���B
%������Q�i�ł͂܂��ASliderTouch�̂���Duration���Ԃɓ����Ă�����̂������s�b�N�A�b�v
%FirstTouch�̏ꍇ�͍ŏ��̈���������o���ASliderTouch���牓�����̂͏����B
%FTselect=1�GAll touch,FTselect=2;FirstTouch�B�i�ŏ���Touch������I���j
if FTselect==2;Duration=OneTurnTime*0.4;%All touches

    for n=1:6%PegTouchCell 1-6��Rpeg 7-12��Lpeg
        RpegTouchCell{n}=[RpegTouchCell{n};PegTouchCell{n}(((TurnMarkerTime(1)-OneTurnTime)+SliderTouch(n)*OneTurnTime<=PegTouchCell{n})&(PegTouchCell{n}<((TurnMarkerTime(1)-OneTurnTime)+SliderTouch(n)*OneTurnTime+Duration)))];
        RpegTouchCell{n+6}=[RpegTouchCell{n+6};PegTouchCell{n}(((TurnMarkerTime(1)-OneTurnTime)+SliderTouch(n)*OneTurnTime+OneTurnTime*0.5<=PegTouchCell{n})&(PegTouchCell{n}<((TurnMarkerTime(1)-OneTurnTime)+SliderTouch(n)*OneTurnTime+OneTurnTime*0.5+Duration)))];
        LpegTouchCell{n}=[LpegTouchCell{n};PegTouchCell{n+6}(((TurnMarkerTime(1)-OneTurnTime)+SliderTouch(n+6)*OneTurnTime<=PegTouchCell{n+6})&(PegTouchCell{n+6}<((TurnMarkerTime(1)-OneTurnTime)+SliderTouch(n+6)*OneTurnTime+Duration)))];
        LpegTouchCell{n+6}=[LpegTouchCell{n+6};PegTouchCell{n+6}(((TurnMarkerTime(1)-OneTurnTime)+SliderTouch(n+6)*OneTurnTime+OneTurnTime*0.5<=PegTouchCell{n+6})&(PegTouchCell{n+6}<((TurnMarkerTime(1)-OneTurnTime)+SliderTouch(n+6)*OneTurnTime+OneTurnTime*0.5+Duration)))];

        RpegTouchTurn{n}=[RpegTouchTurn{n};-TurnMarkerTime(1)+PegTouchCell{n}(((TurnMarkerTime(1)-OneTurnTime)+SliderTouch(n)*OneTurnTime<=PegTouchCell{n})&(PegTouchCell{n}<((TurnMarkerTime(1)-OneTurnTime)+SliderTouch(n)*OneTurnTime+Duration)))];
        RpegTouchTurn{n+6}=[RpegTouchTurn{n+6};-TurnMarkerTime(1)+PegTouchCell{n}(((TurnMarkerTime(1)-OneTurnTime)+SliderTouch(n)*OneTurnTime+OneTurnTime*0.5<=PegTouchCell{n})&(PegTouchCell{n}<((TurnMarkerTime(1)-OneTurnTime)+SliderTouch(n)*OneTurnTime+OneTurnTime*0.5+Duration)))];
        LpegTouchTurn{n}=[LpegTouchTurn{n};-TurnMarkerTime(1)+PegTouchCell{n+6}(((TurnMarkerTime(1)-OneTurnTime)+SliderTouch(n+6)*OneTurnTime<=PegTouchCell{n+6})&(PegTouchCell{n+6}<((TurnMarkerTime(1)-OneTurnTime)+SliderTouch(n+6)*OneTurnTime+Duration)))];
        LpegTouchTurn{n+6}=[LpegTouchTurn{n+6};-TurnMarkerTime(1)+PegTouchCell{n+6}(((TurnMarkerTime(1)-OneTurnTime)+SliderTouch(n+6)*OneTurnTime+OneTurnTime*0.5<=PegTouchCell{n+6})&(PegTouchCell{n+6}<((TurnMarkerTime(1)-OneTurnTime)+SliderTouch(n+6)*OneTurnTime+OneTurnTime*0.5+Duration)))]; 

        for m=1:(length(TurnMarkerTime))
            RpegTouchCell{n}=[RpegTouchCell{n};PegTouchCell{n}((TurnMarkerTime(m)+SliderTouch(n)*OneTurnTime<=PegTouchCell{n})&(PegTouchCell{n}<(TurnMarkerTime(m)+SliderTouch(n)*OneTurnTime+Duration)))];
            RpegTouchCell{n+6}=[RpegTouchCell{n+6};PegTouchCell{n}((TurnMarkerTime(m)+SliderTouch(n)*OneTurnTime+OneTurnTime*0.5<=PegTouchCell{n})&(PegTouchCell{n}<=(TurnMarkerTime(m)+SliderTouch(n)*OneTurnTime+OneTurnTime*0.5+Duration)))];        
            LpegTouchCell{n}=[LpegTouchCell{n};PegTouchCell{n+6}((TurnMarkerTime(m)+SliderTouch(n+6)*OneTurnTime<=PegTouchCell{n+6})&(PegTouchCell{n+6}<(TurnMarkerTime(m)+SliderTouch(n+6)*OneTurnTime+Duration)))];
            LpegTouchCell{n+6}=[LpegTouchCell{n+6};PegTouchCell{n+6}((TurnMarkerTime(m)+SliderTouch(n+6)*OneTurnTime+OneTurnTime*0.5<=PegTouchCell{n+6})&(PegTouchCell{n+6}<(TurnMarkerTime(m)+SliderTouch(n+6)*OneTurnTime+OneTurnTime*0.5+Duration)))];        

            RpegTouchTurn{n}=[RpegTouchTurn{n};-TurnMarkerTime(m)+PegTouchCell{n}((TurnMarkerTime(m)+SliderTouch(n)*OneTurnTime<=PegTouchCell{n})&(PegTouchCell{n}<(TurnMarkerTime(m)+SliderTouch(n)*OneTurnTime+Duration)))];
            RpegTouchTurn{n+6}=[RpegTouchTurn{n+6};-TurnMarkerTime(m)+PegTouchCell{n}((TurnMarkerTime(m)+SliderTouch(n)*OneTurnTime+OneTurnTime*0.5<=PegTouchCell{n})&(PegTouchCell{n}<=(TurnMarkerTime(m)+SliderTouch(n)*OneTurnTime+OneTurnTime*0.5+Duration)))];        
            LpegTouchTurn{n}=[LpegTouchTurn{n};-TurnMarkerTime(m)+PegTouchCell{n+6}((TurnMarkerTime(m)+SliderTouch(n+6)*OneTurnTime<=PegTouchCell{n+6})&(PegTouchCell{n+6}<(TurnMarkerTime(m)+SliderTouch(n+6)*OneTurnTime+Duration)))];
            LpegTouchTurn{n+6}=[LpegTouchTurn{n+6};-TurnMarkerTime(m)+PegTouchCell{n+6}((TurnMarkerTime(m)+SliderTouch(n+6)*OneTurnTime+OneTurnTime*0.5<=PegTouchCell{n+6})&(PegTouchCell{n+6}<(TurnMarkerTime(m)+SliderTouch(n+6)*OneTurnTime+OneTurnTime*0.5+Duration)))];            
        end

        RpegTouchCell{n}=[RpegTouchCell{n};PegTouchCell{n}(((TurnMarkerTime(length(TurnMarkerTime))+OneTurnTime)+SliderTouch(n)*OneTurnTime<=PegTouchCell{n})&(PegTouchCell{n}<((TurnMarkerTime(length(TurnMarkerTime))+OneTurnTime)+SliderTouch(n)*OneTurnTime+Duration)))];
        RpegTouchCell{n+6}=[RpegTouchCell{n+6};PegTouchCell{n}(((TurnMarkerTime(length(TurnMarkerTime))+OneTurnTime)+SliderTouch(n)*OneTurnTime+OneTurnTime*0.5<=PegTouchCell{n})&(PegTouchCell{n}<((TurnMarkerTime(length(TurnMarkerTime))+OneTurnTime)+SliderTouch(n)*OneTurnTime+OneTurnTime*0.5+Duration)))];
        LpegTouchCell{n}=[LpegTouchCell{n};PegTouchCell{n+6}(((TurnMarkerTime(length(TurnMarkerTime))+OneTurnTime)+SliderTouch(n+6)*OneTurnTime<=PegTouchCell{n+6})&(PegTouchCell{n+6}<((TurnMarkerTime(length(TurnMarkerTime))+OneTurnTime)+SliderTouch(n+6)*OneTurnTime+Duration)))];
        LpegTouchCell{n+6}=[LpegTouchCell{n+6};PegTouchCell{n+6}(((TurnMarkerTime(length(TurnMarkerTime))+OneTurnTime)+SliderTouch(n+6)*OneTurnTime+OneTurnTime*0.5<=PegTouchCell{n+6})&(PegTouchCell{n+6}<((TurnMarkerTime(length(TurnMarkerTime))+OneTurnTime)+SliderTouch(n+6)*OneTurnTime+OneTurnTime*0.5+Duration)))];

        RpegTouchTurn{n}=[RpegTouchTurn{n};-TurnMarkerTime(length(TurnMarkerTime))+PegTouchCell{n}(((TurnMarkerTime(length(TurnMarkerTime))+OneTurnTime)+SliderTouch(n)*OneTurnTime<=PegTouchCell{n})&(PegTouchCell{n}<((TurnMarkerTime(length(TurnMarkerTime))+OneTurnTime)+SliderTouch(n)*OneTurnTime+Duration)))];
        RpegTouchTurn{n+6}=[RpegTouchTurn{n+6};-TurnMarkerTime(length(TurnMarkerTime))+PegTouchCell{n}(((TurnMarkerTime(length(TurnMarkerTime))+OneTurnTime)+SliderTouch(n)*OneTurnTime+OneTurnTime*0.5<=PegTouchCell{n})&(PegTouchCell{n}<((TurnMarkerTime(length(TurnMarkerTime))+OneTurnTime)+SliderTouch(n)*OneTurnTime+OneTurnTime*0.5+Duration)))];
        LpegTouchTurn{n}=[LpegTouchTurn{n};-TurnMarkerTime(length(TurnMarkerTime))+PegTouchCell{n+6}(((TurnMarkerTime(length(TurnMarkerTime))+OneTurnTime)+SliderTouch(n+6)*OneTurnTime<=PegTouchCell{n+6})&(PegTouchCell{n+6}<((TurnMarkerTime(length(TurnMarkerTime))+OneTurnTime)+SliderTouch(n+6)*OneTurnTime+Duration)))];
        LpegTouchTurn{n+6}=[LpegTouchTurn{n+6};-TurnMarkerTime(length(TurnMarkerTime))+PegTouchCell{n+6}(((TurnMarkerTime(length(TurnMarkerTime))+OneTurnTime)+SliderTouch(n+6)*OneTurnTime+OneTurnTime*0.5<=PegTouchCell{n+6})&(PegTouchCell{n+6}<((TurnMarkerTime(length(TurnMarkerTime))+OneTurnTime)+SliderTouch(n+6)*OneTurnTime+OneTurnTime*0.5+Duration)))];
    end

elseif FTselect==1;Duration=OneTurnTime*0.2;%1st touch

    for n=1:6%PegTouchCell 1-6��Rpeg 7-12��Lpeg
%         RpegTouchCell{n}=[RpegTouchCell{n};min(PegTouchCell{n}(((TurnMarkerTime(1)-OneTurnTime)+SliderTouch(n)*OneTurnTime<=PegTouchCell{n})&(PegTouchCell{n}<((TurnMarkerTime(1)-OneTurnTime)+SliderTouch(n)*OneTurnTime+Duration))))];
%         RpegTouchCell{n+6}=[RpegTouchCell{n+6};min(PegTouchCell{n}(((TurnMarkerTime(1)-OneTurnTime)+SliderTouch(n)*OneTurnTime+OneTurnTime*0.5<=PegTouchCell{n})&(PegTouchCell{n}<((TurnMarkerTime(1)-OneTurnTime)+SliderTouch(n)*OneTurnTime+OneTurnTime*0.5+Duration))))];
%         LpegTouchCell{n}=[LpegTouchCell{n};min(PegTouchCell{n+6}(((TurnMarkerTime(1)-OneTurnTime)+SliderTouch(n+6)*OneTurnTime<=PegTouchCell{n+6})&(PegTouchCell{n+6}<((TurnMarkerTime(1)-OneTurnTime)+SliderTouch(n+6)*OneTurnTime+Duration))))];
%         LpegTouchCell{n+6}=[LpegTouchCell{n+6};min(PegTouchCell{n+6}(((TurnMarkerTime(1)-OneTurnTime)+SliderTouch(n+6)*OneTurnTime+OneTurnTime*0.5<=PegTouchCell{n+6})&(PegTouchCell{n+6}<((TurnMarkerTime(1)-OneTurnTime)+SliderTouch(n+6)*OneTurnTime+OneTurnTime*0.5+Duration))))];
% 
%         RpegTouchTurn{n}=[RpegTouchTurn{n};-TurnMarkerTime(1)+min(PegTouchCell{n}(((TurnMarkerTime(1)-OneTurnTime)+SliderTouch(n)*OneTurnTime<=PegTouchCell{n})&(PegTouchCell{n}<((TurnMarkerTime(1)-OneTurnTime)+SliderTouch(n)*OneTurnTime+Duration))))];
%         RpegTouchTurn{n+6}=[RpegTouchTurn{n+6};-TurnMarkerTime(1)+min(PegTouchCell{n}(((TurnMarkerTime(1)-OneTurnTime)+SliderTouch(n)*OneTurnTime+OneTurnTime*0.5<=PegTouchCell{n})&(PegTouchCell{n}<((TurnMarkerTime(1)-OneTurnTime)+SliderTouch(n)*OneTurnTime+OneTurnTime*0.5+Duration))))];
%         LpegTouchTurn{n}=[LpegTouchTurn{n};-TurnMarkerTime(1)+min(PegTouchCell{n+6}(((TurnMarkerTime(1)-OneTurnTime)+SliderTouch(n+6)*OneTurnTime<=PegTouchCell{n+6})&(PegTouchCell{n+6}<((TurnMarkerTime(1)-OneTurnTime)+SliderTouch(n+6)*OneTurnTime+Duration))))];
%         LpegTouchTurn{n+6}=[LpegTouchTurn{n+6};-TurnMarkerTime(1)+min(PegTouchCell{n+6}(((TurnMarkerTime(1)-OneTurnTime)+SliderTouch(n+6)*OneTurnTime+OneTurnTime*0.5<=PegTouchCell{n+6})&(PegTouchCell{n+6}<((TurnMarkerTime(1)-OneTurnTime)+SliderTouch(n+6)*OneTurnTime+OneTurnTime*0.5+Duration))))]; 

        for m=1:(length(TurnMarkerTime)-1)
            
            if patternValue==13 % AB�p�^�[���̏ꍇ����Ȃ̂�SliderTouch(n)*OneTurnTime�̎������w�肷��
                 RpegTouchCell{n}=[RpegTouchCell{n};min(PegTouchCell{n}((TurnMarkerTime(m)+SliderTouch(n)*OneTurnTime<=PegTouchCell{n})&(PegTouchCell{n}<(TurnMarkerTime(m)+SliderTouch(n)*OneTurnTime+Duration))))];
                 RpegTouchCell{n+6}=[RpegTouchCell{n+6};min(PegTouchCell{n}((TurnMarkerTime(m)+SliderTouch(n)*OneTurnTime+OneTurnTime*0.62<=PegTouchCell{n})&(PegTouchCell{n}<=(TurnMarkerTime(m)+SliderTouch(n)*OneTurnTime+OneTurnTime*0.62+Duration))))];        
                 LpegTouchCell{n}=[LpegTouchCell{n};min(PegTouchCell{n+6}((TurnMarkerTime(m)+SliderTouch(n+6)*OneTurnTime<=PegTouchCell{n+6})&(PegTouchCell{n+6}<(TurnMarkerTime(m)+SliderTouch(n+6)*OneTurnTime+Duration))))];
                 LpegTouchCell{n+6}=[LpegTouchCell{n+6};min(PegTouchCell{n+6}((TurnMarkerTime(m)+SliderTouch(n+6)*OneTurnTime+OneTurnTime*0.62<=PegTouchCell{n+6})&(PegTouchCell{n+6}<(TurnMarkerTime(m)+SliderTouch(n+6)*OneTurnTime+OneTurnTime*0.62+Duration))))];        

                 RpegTouchTurn{n}=[RpegTouchTurn{n};-TurnMarkerTime(m)+min(PegTouchCell{n}((TurnMarkerTime(m)+SliderTouch(n)*OneTurnTime<=PegTouchCell{n})&(PegTouchCell{n}<(TurnMarkerTime(m)+SliderTouch(n)*OneTurnTime+Duration))))];
                 %RpegTouchTurn{n}(RpegTouchTurn{n}>OneTurnTime)=RpegTouchTurn{n}(RpegTouchTurn{n}>OneTurnTime)-TurnMarkerTime(m+1)+TurnMarkerTime(m); %��̏�����������OneTurnTime�̒l�𒴂��Ă���Ƃ�������B
                 RpegTouchTurn{n+6}=[RpegTouchTurn{n+6};-TurnMarkerTime(m)+min(PegTouchCell{n}((TurnMarkerTime(m)+SliderTouch(n)*OneTurnTime+OneTurnTime*0.62<=PegTouchCell{n})&(PegTouchCell{n}<=(TurnMarkerTime(m)+SliderTouch(n)*OneTurnTime+OneTurnTime*0.62+Duration))))]; 
                 %RpegTouchTurn{n+6}(RpegTouchTurn{n+6}>OneTurnTime)=RpegTouchTurn{n+6}(RpegTouchTurn{n+6}>OneTurnTime)-TurnMarkerTime(m+1)+TurnMarkerTime(m); %��̏�����������OneTurnTime�̒l�𒴂��Ă���Ƃ�������B
                 LpegTouchTurn{n}=[LpegTouchTurn{n};-TurnMarkerTime(m)+min(PegTouchCell{n+6}((TurnMarkerTime(m)+SliderTouch(n+6)*OneTurnTime<=PegTouchCell{n+6})&(PegTouchCell{n+6}<(TurnMarkerTime(m)+SliderTouch(n+6)*OneTurnTime+Duration))))];
                 %LpegTouchTurn{n}(LpegTouchTurn{n}>OneTurnTime)=LpegTouchTurn{n}(LpegTouchTurn{n}>OneTurnTime)-TurnMarkerTime(m+1)+TurnMarkerTime(m); %��̏�����������OneTurnTime�̒l�𒴂��Ă���Ƃ�������B
                 LpegTouchTurn{n+6}=[LpegTouchTurn{n+6};-TurnMarkerTime(m)+min(PegTouchCell{n+6}((TurnMarkerTime(m)+SliderTouch(n+6)*OneTurnTime+OneTurnTime*0.62<=PegTouchCell{n+6})&(PegTouchCell{n+6}<(TurnMarkerTime(m)+SliderTouch(n+6)*OneTurnTime+OneTurnTime*0.62+Duration))))];
                 %LpegTouchTurn{n+6}(LpegTouchTurn{n+6}>OneTurnTime)=LpegTouchTu
                 %rn{n+6}(LpegTouchTurn{n+6}>OneTurnTime)-TurnMarkerTime(m+1)+TurnMarkerTime(m); %��̏�����������OneTurnTime�̒l�𒴂��Ă���Ƃ�������B
            
            elseif  patternValue==12 % StepWise pattern
              RpegTouchCell{n}=[RpegTouchCell{n};min(PegTouchCell{n}((TurnMarkerTime(m)+SliderTouch(n)*(TurnMarkerTime(m+1)-TurnMarkerTime(m))<=PegTouchCell{n})&(PegTouchCell{n}<(TurnMarkerTime(m)+SliderTouch(n)*(TurnMarkerTime(m+1)-TurnMarkerTime(m))+Duration))))];
              RpegTouchCell{n+6}=[RpegTouchCell{n+6};min(PegTouchCell{n}((TurnMarkerTime(m)+SliderTouch(n)*(TurnMarkerTime(m+1)-TurnMarkerTime(m))+(TurnMarkerTime(m+1)-TurnMarkerTime(m))*0.5<=PegTouchCell{n})&(PegTouchCell{n}<=(TurnMarkerTime(m)+SliderTouch(n)*(TurnMarkerTime(m+1)-TurnMarkerTime(m))+(TurnMarkerTime(m+1)-TurnMarkerTime(m))*0.5+Duration))))];        
              LpegTouchCell{n}=[LpegTouchCell{n};min(PegTouchCell{n+6}((TurnMarkerTime(m)+SliderTouch(n+6)*(TurnMarkerTime(m+1)-TurnMarkerTime(m))<=PegTouchCell{n+6})&(PegTouchCell{n+6}<(TurnMarkerTime(m)+SliderTouch(n+6)*(TurnMarkerTime(m+1)-TurnMarkerTime(m))+Duration))))];
              LpegTouchCell{n+6}=[LpegTouchCell{n+6};min(PegTouchCell{n+6}((TurnMarkerTime(m)+SliderTouch(n+6)*(TurnMarkerTime(m+1)-TurnMarkerTime(m))+(TurnMarkerTime(m+1)-TurnMarkerTime(m))*0.5<=PegTouchCell{n+6})&(PegTouchCell{n+6}<(TurnMarkerTime(m)+SliderTouch(n+6)*(TurnMarkerTime(m+1)-TurnMarkerTime(m))+(TurnMarkerTime(m+1)-TurnMarkerTime(m))*0.5+Duration))))];        

              RpegTouchTurn{n}=[RpegTouchTurn{n};-TurnMarkerTime(m)+min(PegTouchCell{n}((TurnMarkerTime(m)+SliderTouch(n)*(TurnMarkerTime(m+1)-TurnMarkerTime(m))<=PegTouchCell{n})&(PegTouchCell{n}<(TurnMarkerTime(m)+SliderTouch(n)*(TurnMarkerTime(m+1)-TurnMarkerTime(m))+Duration))))];
              %RpegTouchTurn{n}(RpegTouchTurn{n}>(TurnMarkerTime(m+1)-TurnMarkerTime(m)))=RpegTouchTurn{n}(RpegTouchTurn{n}>(TurnMarkerTime(m+1)-TurnMarkerTime(m)))-TurnMarkerTime(m+1)+TurnMarkerTime(m); %��̏�����������(TurnMarkerTime(m+1)-TurnMarkerTime(m))�̒l�𒴂��Ă���Ƃ�������B
              RpegTouchTurn{n+6}=[RpegTouchTurn{n+6};-TurnMarkerTime(m)+min(PegTouchCell{n}((TurnMarkerTime(m)+SliderTouch(n)*(TurnMarkerTime(m+1)-TurnMarkerTime(m))+(TurnMarkerTime(m+1)-TurnMarkerTime(m))*0.5<=PegTouchCell{n})&(PegTouchCell{n}<=(TurnMarkerTime(m)+SliderTouch(n)*(TurnMarkerTime(m+1)-TurnMarkerTime(m))+(TurnMarkerTime(m+1)-TurnMarkerTime(m))*0.5+Duration))))]; 
              %RpegTouchTurn{n+6}(RpegTouchTurn{n+6}>(TurnMarkerTime(m+1)-TurnMarkerTime(m)))=RpegTouchTurn{n+6}(RpegTouchTurn{n+6}>(TurnMarkerTime(m+1)-TurnMarkerTime(m)))-TurnMarkerTime(m+1)+TurnMarkerTime(m); %��̏�����������(TurnMarkerTime(m+1)-TurnMarkerTime(m))�̒l�𒴂��Ă���Ƃ�������B
              LpegTouchTurn{n}=[LpegTouchTurn{n};-TurnMarkerTime(m)+min(PegTouchCell{n+6}((TurnMarkerTime(m)+SliderTouch(n+6)*(TurnMarkerTime(m+1)-TurnMarkerTime(m))<=PegTouchCell{n+6})&(PegTouchCell{n+6}<(TurnMarkerTime(m)+SliderTouch(n+6)*(TurnMarkerTime(m+1)-TurnMarkerTime(m))+Duration))))];
              %LpegTouchTurn{n}(LpegTouchTurn{n}>(TurnMarkerTime(m+1)-TurnMarkerTime(m)))=LpegTouchTurn{n}(LpegTouchTurn{n}>(TurnMarkerTime(m+1)-TurnMarkerTime(m)))-TurnMarkerTime(m+1)+TurnMarkerTime(m); %��̏�����������(TurnMarkerTime(m+1)-TurnMarkerTime(m))�̒l�𒴂��Ă���Ƃ�������B
              LpegTouchTurn{n+6}=[LpegTouchTurn{n+6};-TurnMarkerTime(m)+min(PegTouchCell{n+6}((TurnMarkerTime(m)+SliderTouch(n+6)*(TurnMarkerTime(m+1)-TurnMarkerTime(m))+(TurnMarkerTime(m+1)-TurnMarkerTime(m))*0.5<=PegTouchCell{n+6})&(PegTouchCell{n+6}<(TurnMarkerTime(m)+SliderTouch(n+6)*(TurnMarkerTime(m+1)-TurnMarkerTime(m))+(TurnMarkerTime(m+1)-TurnMarkerTime(m))*0.5+Duration))))];
              %LpegTouchTurn{n+6}(LpegTouchTurn{n+6}>(TurnMarkerTime(m+1)-TurnMarkerTime(m)))=LpegTouchTu
              %rn{n+6}(LpegTouchTurn{n+6}>(TurnMarkerTime(m+1)-TurnMarkerTime(m)))-TurnMarkerTime(m+1)+TurnMarkerTime(m); %��̏�����������OneTurnTime�̒l�𒴂��Ă���Ƃ�������B
            
            elseif patternValue==3 | patternValue==4 % pattern 4 old
         
              RpegTouchCell{n}=[RpegTouchCell{n};min(PegTouchCell{n}((TurnMarkerTime(m)+SliderTouch(n)*(TurnMarkerTime(m+1)-TurnMarkerTime(m))<=PegTouchCell{n})&(PegTouchCell{n}<(TurnMarkerTime(m)+SliderTouch(n)*(TurnMarkerTime(m+1)-TurnMarkerTime(m))+Duration))))];
              RpegTouchCell{n+6}=[RpegTouchCell{n+6};min(PegTouchCell{n}((TurnMarkerTime(m)+SliderTouch(n)*(TurnMarkerTime(m+1)-TurnMarkerTime(m))+(TurnMarkerTime(m+1)-TurnMarkerTime(m))*0.5<=PegTouchCell{n})&(PegTouchCell{n}<=(TurnMarkerTime(m)+SliderTouch(n)*(TurnMarkerTime(m+1)-TurnMarkerTime(m))+(TurnMarkerTime(m+1)-TurnMarkerTime(m))*0.5+Duration))))];        
              LpegTouchCell{n}=[LpegTouchCell{n};min(PegTouchCell{n+6}((TurnMarkerTime(m)+SliderTouch(n+6)*(TurnMarkerTime(m+1)-TurnMarkerTime(m))<=PegTouchCell{n+6})&(PegTouchCell{n+6}<(TurnMarkerTime(m)+SliderTouch(n+6)*(TurnMarkerTime(m+1)-TurnMarkerTime(m))+Duration))))];
              if n==1
                  LpegTouchCell{n+6}=[LpegTouchCell{n+6};min(PegTouchCell{n+6}((TurnMarkerTime(m)+SliderTouch(n+6)*(TurnMarkerTime(m+1)-TurnMarkerTime(m))+(TurnMarkerTime(m+1)-TurnMarkerTime(m))*0.32<=PegTouchCell{n+6})&(PegTouchCell{n+6}<(TurnMarkerTime(m)+SliderTouch(n+6)*(TurnMarkerTime(m+1)-TurnMarkerTime(m))+(TurnMarkerTime(m+1)-TurnMarkerTime(m))*0.32+Duration))))];        
              elseif n==2
                  LpegTouchCell{n+6}=[LpegTouchCell{n+6};min(PegTouchCell{n+6}((TurnMarkerTime(m)+SliderTouch(n+6)*(TurnMarkerTime(m+1)-TurnMarkerTime(m))+(TurnMarkerTime(m+1)-TurnMarkerTime(m))*0.37<=PegTouchCell{n+6})&(PegTouchCell{n+6}<(TurnMarkerTime(m)+SliderTouch(n+6)*(TurnMarkerTime(m+1)-TurnMarkerTime(m))+(TurnMarkerTime(m+1)-TurnMarkerTime(m))*0.37+Duration))))];        
              elseif n==6
                  LpegTouchCell{n+6}=[LpegTouchCell{n+6};min(PegTouchCell{n+6}((TurnMarkerTime(m)+SliderTouch(n+6)*(TurnMarkerTime(m+1)-TurnMarkerTime(m))+(TurnMarkerTime(m+1)-TurnMarkerTime(m))*0.57<=PegTouchCell{n+6})&(PegTouchCell{n+6}<(TurnMarkerTime(m)+SliderTouch(n+6)*(TurnMarkerTime(m+1)-TurnMarkerTime(m))+(TurnMarkerTime(m+1)-TurnMarkerTime(m))*0.57+Duration))))];        
              else
              LpegTouchCell{n+6}=[LpegTouchCell{n+6};min(PegTouchCell{n+6}((TurnMarkerTime(m)+SliderTouch(n+6)*(TurnMarkerTime(m+1)-TurnMarkerTime(m))+(TurnMarkerTime(m+1)-TurnMarkerTime(m))*0.5<=PegTouchCell{n+6})&(PegTouchCell{n+6}<(TurnMarkerTime(m)+SliderTouch(n+6)*(TurnMarkerTime(m+1)-TurnMarkerTime(m))+(TurnMarkerTime(m+1)-TurnMarkerTime(m))*0.5+Duration))))];        
              end
              
              RpegTouchTurn{n}=[RpegTouchTurn{n};-TurnMarkerTime(m)+min(PegTouchCell{n}((TurnMarkerTime(m)+SliderTouch(n)*(TurnMarkerTime(m+1)-TurnMarkerTime(m))<=PegTouchCell{n})&(PegTouchCell{n}<(TurnMarkerTime(m)+SliderTouch(n)*(TurnMarkerTime(m+1)-TurnMarkerTime(m))+Duration))))];
              %RpegTouchTurn{n}(RpegTouchTurn{n}>(TurnMarkerTime(m+1)-TurnMarkerTime(m)))=RpegTouchTurn{n}(RpegTouchTurn{n}>(TurnMarkerTime(m+1)-TurnMarkerTime(m)))-TurnMarkerTime(m+1)+TurnMarkerTime(m); %��̏�����������(TurnMarkerTime(m+1)-TurnMarkerTime(m))�̒l�𒴂��Ă���Ƃ�������B
              RpegTouchTurn{n+6}=[RpegTouchTurn{n+6};-TurnMarkerTime(m)+min(PegTouchCell{n}((TurnMarkerTime(m)+SliderTouch(n)*(TurnMarkerTime(m+1)-TurnMarkerTime(m))+(TurnMarkerTime(m+1)-TurnMarkerTime(m))*0.5<=PegTouchCell{n})&(PegTouchCell{n}<=(TurnMarkerTime(m)+SliderTouch(n)*(TurnMarkerTime(m+1)-TurnMarkerTime(m))+(TurnMarkerTime(m+1)-TurnMarkerTime(m))*0.5+Duration))))]; 
              %RpegTouchTurn{n+6}(RpegTouchTurn{n+6}>(TurnMarkerTime(m+1)-TurnMarkerTime(m)))=RpegTouchTurn{n+6}(RpegTouchTurn{n+6}>(TurnMarkerTime(m+1)-TurnMarkerTime(m)))-TurnMarkerTime(m+1)+TurnMarkerTime(m); %��̏�����������(TurnMarkerTime(m+1)-TurnMarkerTime(m))�̒l�𒴂��Ă���Ƃ�������B
              LpegTouchTurn{n}=[LpegTouchTurn{n};-TurnMarkerTime(m)+min(PegTouchCell{n+6}((TurnMarkerTime(m)+SliderTouch(n+6)*(TurnMarkerTime(m+1)-TurnMarkerTime(m))<=PegTouchCell{n+6})&(PegTouchCell{n+6}<(TurnMarkerTime(m)+SliderTouch(n+6)*(TurnMarkerTime(m+1)-TurnMarkerTime(m))+Duration))))];
              %LpegTouchTurn{n}(LpegTouchTurn{n}>(TurnMarkerTime(m+1)-TurnMarkerTime(m)))=LpegTouchTurn{n}(LpegTouchTurn{n}>(TurnMarkerTime(m+1)-TurnMarkerTime(m)))-TurnMarkerTime(m+1)+TurnMarkerTime(m); %��̏�����������(TurnMarkerTime(m+1)-TurnMarkerTime(m))�̒l�𒴂��Ă���Ƃ�������B
              if n==1
                  LpegTouchTurn{n+6}=[LpegTouchTurn{n+6};-TurnMarkerTime(m)+min(PegTouchCell{n+6}((TurnMarkerTime(m)+SliderTouch(n+6)*(TurnMarkerTime(m+1)-TurnMarkerTime(m))+(TurnMarkerTime(m+1)-TurnMarkerTime(m))*0.32<=PegTouchCell{n+6})&(PegTouchCell{n+6}<(TurnMarkerTime(m)+SliderTouch(n+6)*(TurnMarkerTime(m+1)-TurnMarkerTime(m))+(TurnMarkerTime(m+1)-TurnMarkerTime(m))*0.32+Duration))))];
              elseif n==2
                  LpegTouchTurn{n+6}=[LpegTouchTurn{n+6};-TurnMarkerTime(m)+min(PegTouchCell{n+6}((TurnMarkerTime(m)+SliderTouch(n+6)*(TurnMarkerTime(m+1)-TurnMarkerTime(m))+(TurnMarkerTime(m+1)-TurnMarkerTime(m))*0.37<=PegTouchCell{n+6})&(PegTouchCell{n+6}<(TurnMarkerTime(m)+SliderTouch(n+6)*(TurnMarkerTime(m+1)-TurnMarkerTime(m))+(TurnMarkerTime(m+1)-TurnMarkerTime(m))*0.37+Duration))))];
              elseif n==6
                  LpegTouchTurn{n+6}=[LpegTouchTurn{n+6};-TurnMarkerTime(m)+min(PegTouchCell{n+6}((TurnMarkerTime(m)+SliderTouch(n+6)*(TurnMarkerTime(m+1)-TurnMarkerTime(m))+(TurnMarkerTime(m+1)-TurnMarkerTime(m))*0.57<=PegTouchCell{n+6})&(PegTouchCell{n+6}<(TurnMarkerTime(m)+SliderTouch(n+6)*(TurnMarkerTime(m+1)-TurnMarkerTime(m))+(TurnMarkerTime(m+1)-TurnMarkerTime(m))*0.57+Duration))))];
              else
              LpegTouchTurn{n+6}=[LpegTouchTurn{n+6};-TurnMarkerTime(m)+min(PegTouchCell{n+6}((TurnMarkerTime(m)+SliderTouch(n+6)*(TurnMarkerTime(m+1)-TurnMarkerTime(m))+(TurnMarkerTime(m+1)-TurnMarkerTime(m))*0.5<=PegTouchCell{n+6})&(PegTouchCell{n+6}<(TurnMarkerTime(m)+SliderTouch(n+6)*(TurnMarkerTime(m+1)-TurnMarkerTime(m))+(TurnMarkerTime(m+1)-TurnMarkerTime(m))*0.5+Duration))))];
              end
              %LpegTouchTurn{n+6}(LpegTouchTurn{n+6}>(TurnMarkerTime(m+1)-TurnMarkerTime(m)))=LpegTouchTu
              %rn{n+6}(LpegTouchTurn{n+6}>(TurnMarkerTime(m+1)-TurnMarkerTime(m)))-TurnMarkerTime(m+1)+TurnMarkerTime(m); %��̏�����������OneTurnTime�̒l�𒴂��Ă���Ƃ�������B
            
            else
            RpegTouchCell{n}=[RpegTouchCell{n};min(PegTouchCell{n}((TurnMarkerTime(m)+SliderTouch(n)*OneTurnTime<=PegTouchCell{n})&(PegTouchCell{n}<(TurnMarkerTime(m)+SliderTouch(n)*OneTurnTime+Duration))))];
            RpegTouchCell{n+6}=[RpegTouchCell{n+6};min(PegTouchCell{n}((TurnMarkerTime(m)+SliderTouch(n)*OneTurnTime+OneTurnTime*0.5<=PegTouchCell{n})&(PegTouchCell{n}<=(TurnMarkerTime(m)+SliderTouch(n)*OneTurnTime+OneTurnTime*0.5+Duration))))];        
            LpegTouchCell{n}=[LpegTouchCell{n};min(PegTouchCell{n+6}((TurnMarkerTime(m)+SliderTouch(n+6)*OneTurnTime<=PegTouchCell{n+6})&(PegTouchCell{n+6}<(TurnMarkerTime(m)+SliderTouch(n+6)*OneTurnTime+Duration))))];
            LpegTouchCell{n+6}=[LpegTouchCell{n+6};min(PegTouchCell{n+6}((TurnMarkerTime(m)+SliderTouch(n+6)*OneTurnTime+OneTurnTime*0.5<=PegTouchCell{n+6})&(PegTouchCell{n+6}<(TurnMarkerTime(m)+SliderTouch(n+6)*OneTurnTime+OneTurnTime*0.5+Duration))))];        

            RpegTouchTurn{n}=[RpegTouchTurn{n};-TurnMarkerTime(m)+min(PegTouchCell{n}((TurnMarkerTime(m)+SliderTouch(n)*OneTurnTime<=PegTouchCell{n})&(PegTouchCell{n}<(TurnMarkerTime(m)+SliderTouch(n)*OneTurnTime+Duration))))];
            %RpegTouchTurn{n}(RpegTouchTurn{n}>OneTurnTime)=RpegTouchTurn{n}(RpegTouchTurn{n}>OneTurnTime)-TurnMarkerTime(m+1)+TurnMarkerTime(m); %��̏�����������OneTurnTime�̒l�𒴂��Ă���Ƃ�������B
            RpegTouchTurn{n+6}=[RpegTouchTurn{n+6};-TurnMarkerTime(m)+min(PegTouchCell{n}((TurnMarkerTime(m)+SliderTouch(n)*OneTurnTime+OneTurnTime*0.5<=PegTouchCell{n})&(PegTouchCell{n}<=(TurnMarkerTime(m)+SliderTouch(n)*OneTurnTime+OneTurnTime*0.5+Duration))))]; 
            %RpegTouchTurn{n+6}(RpegTouchTurn{n+6}>OneTurnTime)=RpegTouchTurn{n+6}(RpegTouchTurn{n+6}>OneTurnTime)-TurnMarkerTime(m+1)+TurnMarkerTime(m); %��̏�����������OneTurnTime�̒l�𒴂��Ă���Ƃ�������B
            LpegTouchTurn{n}=[LpegTouchTurn{n};-TurnMarkerTime(m)+min(PegTouchCell{n+6}((TurnMarkerTime(m)+SliderTouch(n+6)*OneTurnTime<=PegTouchCell{n+6})&(PegTouchCell{n+6}<(TurnMarkerTime(m)+SliderTouch(n+6)*OneTurnTime+Duration))))];
            %LpegTouchTurn{n}(LpegTouchTurn{n}>OneTurnTime)=LpegTouchTurn{n}(LpegTouchTurn{n}>OneTurnTime)-TurnMarkerTime(m+1)+TurnMarkerTime(m); %��̏�����������OneTurnTime�̒l�𒴂��Ă���Ƃ�������B
            LpegTouchTurn{n+6}=[LpegTouchTurn{n+6};-TurnMarkerTime(m)+min(PegTouchCell{n+6}((TurnMarkerTime(m)+SliderTouch(n+6)*OneTurnTime+OneTurnTime*0.5<=PegTouchCell{n+6})&(PegTouchCell{n+6}<(TurnMarkerTime(m)+SliderTouch(n+6)*OneTurnTime+OneTurnTime*0.5+Duration))))];
            %LpegTouchTurn{n+6}(LpegTouchTurn{n+6}>OneTurnTime)=LpegTouchTurn{n+6}(LpegTouchTurn{n+6}>OneTurnTime)-TurnMarkerTime(m+1)+TurnMarkerTime(m); %��̏�����������OneTurnTime�̒l�𒴂��Ă���Ƃ�������B
            end
        end
   % length(TurnMarkerTime)
        if patternValue==10
             RpegTouchCell{n}=[RpegTouchCell{n};min(PegTouchCell{n}(((TurnMarkerTime(length(TurnMarkerTime)-1)+OneTurnTime)+SliderTouch(n)*OneTurnTime<=PegTouchCell{n})&(PegTouchCell{n}<((TurnMarkerTime(length(TurnMarkerTime)-1)+OneTurnTime)+SliderTouch(n)*OneTurnTime+Duration))))];
             RpegTouchCell{n+6}=[RpegTouchCell{n+6};min(PegTouchCell{n}(((TurnMarkerTime(length(TurnMarkerTime)-1)+OneTurnTime)+SliderTouch(n)*OneTurnTime+OneTurnTime*0.62<=PegTouchCell{n})&(PegTouchCell{n}<((TurnMarkerTime(length(TurnMarkerTime)-1)+OneTurnTime)+SliderTouch(n)*OneTurnTime+OneTurnTime*0.62+Duration))))];
             LpegTouchCell{n}=[LpegTouchCell{n};min(PegTouchCell{n+6}(((TurnMarkerTime(length(TurnMarkerTime)-1)+OneTurnTime)+SliderTouch(n+6)*OneTurnTime<=PegTouchCell{n+6})&(PegTouchCell{n+6}<((TurnMarkerTime(length(TurnMarkerTime)-1)+OneTurnTime)+SliderTouch(n+6)*OneTurnTime+Duration))))];
             LpegTouchCell{n+6}=[LpegTouchCell{n+6};min(PegTouchCell{n+6}(((TurnMarkerTime(length(TurnMarkerTime)-1)+OneTurnTime)+SliderTouch(n+6)*OneTurnTime+OneTurnTime*0.62<=PegTouchCell{n+6})&(PegTouchCell{n+6}<((TurnMarkerTime(length(TurnMarkerTime)-1)+OneTurnTime)+SliderTouch(n+6)*OneTurnTime+OneTurnTime*0.62+Duration))))];

             RpegTouchTurn{n}=[RpegTouchTurn{n};-TurnMarkerTime(length(TurnMarkerTime)-1)+min(PegTouchCell{n}(((TurnMarkerTime(length(TurnMarkerTime)-1)+OneTurnTime)+SliderTouch(n)*OneTurnTime<=PegTouchCell{n})&(PegTouchCell{n}<((TurnMarkerTime(length(TurnMarkerTime)-1)+OneTurnTime)+SliderTouch(n)*OneTurnTime+Duration))))];
             RpegTouchTurn{n+6}=[RpegTouchTurn{n+6};-TurnMarkerTime(length(TurnMarkerTime)-1)+min(PegTouchCell{n}(((TurnMarkerTime(length(TurnMarkerTime)-1)+OneTurnTime)+SliderTouch(n)*OneTurnTime+OneTurnTime*0.62<=PegTouchCell{n})&(PegTouchCell{n}<((TurnMarkerTime(length(TurnMarkerTime)-1)+OneTurnTime)+SliderTouch(n)*OneTurnTime+OneTurnTime*0.62+Duration))))];
             LpegTouchTurn{n}=[LpegTouchTurn{n};-TurnMarkerTime(length(TurnMarkerTime)-1)+min(PegTouchCell{n+6}(((TurnMarkerTime(length(TurnMarkerTime)-1)+OneTurnTime)+SliderTouch(n+6)*OneTurnTime<=PegTouchCell{n+6})&(PegTouchCell{n+6}<((TurnMarkerTime(length(TurnMarkerTime)-1)+OneTurnTime)+SliderTouch(n+6)*OneTurnTime+Duration))))];
             LpegTouchTurn{n+6}=[LpegTouchTurn{n+6};-TurnMarkerTime(length(TurnMarkerTime)-1)+min(PegTouchCell{n+6}(((TurnMarkerTime(length(TurnMarkerTime)-1)+OneTurnTime)+SliderTouch(n+6)*OneTurnTime+OneTurnTime*0.62<=PegTouchCell{n+6})&(PegTouchCell{n+6}<((TurnMarkerTime(length(TurnMarkerTime)-1)+OneTurnTime)+SliderTouch(n+6)*OneTurnTime+OneTurnTime*0.62+Duration))))];
            
        else
        RpegTouchCell{n}=[RpegTouchCell{n};min(PegTouchCell{n}(((TurnMarkerTime(length(TurnMarkerTime)-1)+OneTurnTime)+SliderTouch(n)*OneTurnTime<=PegTouchCell{n})&(PegTouchCell{n}<((TurnMarkerTime(length(TurnMarkerTime)-1)+OneTurnTime)+SliderTouch(n)*OneTurnTime+Duration))))];
        RpegTouchCell{n+6}=[RpegTouchCell{n+6};min(PegTouchCell{n}(((TurnMarkerTime(length(TurnMarkerTime)-1)+OneTurnTime)+SliderTouch(n)*OneTurnTime+OneTurnTime*0.5<=PegTouchCell{n})&(PegTouchCell{n}<((TurnMarkerTime(length(TurnMarkerTime)-1)+OneTurnTime)+SliderTouch(n)*OneTurnTime+OneTurnTime*0.5+Duration))))];
        LpegTouchCell{n}=[LpegTouchCell{n};min(PegTouchCell{n+6}(((TurnMarkerTime(length(TurnMarkerTime)-1)+OneTurnTime)+SliderTouch(n+6)*OneTurnTime<=PegTouchCell{n+6})&(PegTouchCell{n+6}<((TurnMarkerTime(length(TurnMarkerTime)-1)+OneTurnTime)+SliderTouch(n+6)*OneTurnTime+Duration))))];
        LpegTouchCell{n+6}=[LpegTouchCell{n+6};min(PegTouchCell{n+6}(((TurnMarkerTime(length(TurnMarkerTime)-1)+OneTurnTime)+SliderTouch(n+6)*OneTurnTime+OneTurnTime*0.5<=PegTouchCell{n+6})&(PegTouchCell{n+6}<((TurnMarkerTime(length(TurnMarkerTime)-1)+OneTurnTime)+SliderTouch(n+6)*OneTurnTime+OneTurnTime*0.5+Duration))))];

        RpegTouchTurn{n}=[RpegTouchTurn{n};-TurnMarkerTime(length(TurnMarkerTime)-1)+min(PegTouchCell{n}(((TurnMarkerTime(length(TurnMarkerTime)-1)+OneTurnTime)+SliderTouch(n)*OneTurnTime<=PegTouchCell{n})&(PegTouchCell{n}<((TurnMarkerTime(length(TurnMarkerTime)-1)+OneTurnTime)+SliderTouch(n)*OneTurnTime+Duration))))];
        RpegTouchTurn{n+6}=[RpegTouchTurn{n+6};-TurnMarkerTime(length(TurnMarkerTime)-1)+min(PegTouchCell{n}(((TurnMarkerTime(length(TurnMarkerTime)-1)+OneTurnTime)+SliderTouch(n)*OneTurnTime+OneTurnTime*0.5<=PegTouchCell{n})&(PegTouchCell{n}<((TurnMarkerTime(length(TurnMarkerTime)-1)+OneTurnTime)+SliderTouch(n)*OneTurnTime+OneTurnTime*0.5+Duration))))];
        LpegTouchTurn{n}=[LpegTouchTurn{n};-TurnMarkerTime(length(TurnMarkerTime)-1)+min(PegTouchCell{n+6}(((TurnMarkerTime(length(TurnMarkerTime)-1)+OneTurnTime)+SliderTouch(n+6)*OneTurnTime<=PegTouchCell{n+6})&(PegTouchCell{n+6}<((TurnMarkerTime(length(TurnMarkerTime)-1)+OneTurnTime)+SliderTouch(n+6)*OneTurnTime+Duration))))];
        LpegTouchTurn{n+6}=[LpegTouchTurn{n+6};-TurnMarkerTime(length(TurnMarkerTime)-1)+min(PegTouchCell{n+6}(((TurnMarkerTime(length(TurnMarkerTime)-1)+OneTurnTime)+SliderTouch(n+6)*OneTurnTime+OneTurnTime*0.5<=PegTouchCell{n+6})&(PegTouchCell{n+6}<((TurnMarkerTime(length(TurnMarkerTime)-1)+OneTurnTime)+SliderTouch(n+6)*OneTurnTime+OneTurnTime*0.5+Duration))))];
        end
    end

end

%��̏�����������OneTurnTime�̒l�𒴂��Ă���Ƃ�������B
for n=1:12
    RpegTouchTurn{n}(RpegTouchTurn{n}>OneTurnTime)=RpegTouchTurn{n}(RpegTouchTurn{n}>OneTurnTime)-OneTurnTime;
    LpegTouchTurn{n}(LpegTouchTurn{n}>OneTurnTime)=LpegTouchTurn{n}(LpegTouchTurn{n}>OneTurnTime)-OneTurnTime;
end

RPegTouchAll=sort([RpegTouchCell{1}; RpegTouchCell{2}; RpegTouchCell{3}; RpegTouchCell{4}; RpegTouchCell{5}; RpegTouchCell{6};...
    RpegTouchCell{7}; RpegTouchCell{8}; RpegTouchCell{9}; RpegTouchCell{10}; RpegTouchCell{11}; RpegTouchCell{12}]);
LPegTouchAll=sort([LpegTouchCell{1}; LpegTouchCell{2}; LpegTouchCell{3}; LpegTouchCell{4}; LpegTouchCell{5}; LpegTouchCell{6};...
    LpegTouchCell{7}; LpegTouchCell{8}; LpegTouchCell{9}; LpegTouchCell{10}; LpegTouchCell{11}; LpegTouchCell{12}]);
RLPegTouchAll=sort([RpegTouchCell{1}; RpegTouchCell{2}; RpegTouchCell{3}; RpegTouchCell{4}; RpegTouchCell{5}; RpegTouchCell{6};...
    RpegTouchCell{7}; RpegTouchCell{8}; RpegTouchCell{9}; RpegTouchCell{10}; RpegTouchCell{11}; RpegTouchCell{12};...
    LpegTouchCell{1}; LpegTouchCell{2}; LpegTouchCell{3}; LpegTouchCell{4}; LpegTouchCell{5}; LpegTouchCell{6};...
    LpegTouchCell{7}; LpegTouchCell{8}; LpegTouchCell{9}; LpegTouchCell{10}; LpegTouchCell{11}; LpegTouchCell{12}]);



% %�R�i�I�ʁ@���i��RefPeriod�ɂ���ĘA������FalseTouch�͂��łɏ����Ă���B
% %������R�i�ł́AFirstTouch�̏ꍇ�͍ŏ��̈���������o���ASliderTouch���牓�����̂͏����B
% %FTselect=1�GAll touch,FTselect=2;FirstTouch�B�i�ŏ���Touch������I���j
% if FTselect==2
%     for n=1:12 %length(RpegTouchTurn)
%         for m=length(RpegTouchCell{n}):-1:2
%             if RpegTouchCell{n}(m)<(RpegTouchCell{n}(m-1)+Duration);RpegTouchCell{n}(m)=[];end
%         end
%         for m=length(LpegTouchCell{n}):-1:2
%             if LpegTouchCell{n}(m)<(LpegTouchCell{n}(m-1)+Duration);LpegTouchCell{n}(m)=[];end
%         end
%     end
% end

%Peg����{���u���v�ɂ��炵��TM�Ƃ̐����������B�u1�{�ځv�̃y�O��TM���O�ɗ��Ă��܂����ꍇ�B---------------------------
%pegTimeArray2D��1�{�ڂƐ�����ꂽ�y�O���u2�{�ځv�ɒ����āA�^�b�`�Z���T�Ɛ��������Ƃ�B
%���z�C�[���ő��肳�ꂽPegPattern2�̂Ƃ��̃f�[�^�i�`2010�N11���j�͉��L��LpegTimeArray2D���P�{�����ɂ��炷�B

% if modif==0
    
%      tempArray2D=zeros(size(RpegTimeArray2D));
%      mov=1;
%      for n=1:12
%          if n-mov>0;tempArray2D(:,n)=RpegTimeArray2D(:,n-mov);
%          else tempArray2D(:,n)=RpegTimeArray2D(:,n-mov+12);
%          end
%      end
%      RpegTimeArray2D=tempArray2D;

%      tempArray2D=zeros(size(LpegTimeArray2D));
%      mov=1;
%      for n=1:12
%          if n-mov>0;tempArray2D(:,n)=LpegTimeArray2D(:,n-mov);
%          else tempArray2D(:,n)=LpegTimeArray2D(:,n-mov+12);
%          end
%      end
%      LpegTimeArray2D=tempArray2D;
%       
%      modif=1;
%  
% end
% --------------------------------------------------------------------------
%Peg����{���u�O�Ɂv���炵��TM�Ƃ̐����������B�u12�{�ځv�̃y�O��TM���O�ɗ��Ă��܂����ꍇ�B---------------------------
%pegTimeArray2D��1�{�ڂƐ�����ꂽ�y�O���u12�{�ځv�ɒ����āA�^�b�`�Z���T�Ɛ��������Ƃ�B

% % 
% if modif==0
%     
%      tempArray2D=zeros(size(RpegTimeArray2D));
%      mov=1;
%      for n=1:12
%          if n+mov<=12;tempArray2D(:,n)=RpegTimeArray2D(:,n+mov);
%          else tempArray2D(:,n)=RpegTimeArray2D(:,n+mov-12);
%          end
%      end
%      RpegTimeArray2D=tempArray2D;
% 
%      tempArray2D=zeros(size(LpegTimeArray2D));
%      mov=1;
%      for n=1:12
%          if n+mov<=12;tempArray2D(:,n)=LpegTimeArray2D(:,n+mov);
%          else tempArray2D(:,n)=LpegTimeArray2D(:,n+mov-12);
%          end
%      end
%      LpegTimeArray2D=tempArray2D;
%       
%      modif=1;
%  
% end
% -------------------------------------------------------------------------
% 

yhight=20;
%if RefPeriod<=100;yhight=50;else yhight=20;end
[fig_touchR PtouchHistoCell_R RpegTouchBypegCell]=TouchAlignByPeg(RpegTouchCell,RpegTimeArray2D,yhight);
if FigureSave==1;saveas(fig_touchR,[DrName,' ','TouchAlignRpeg.bmp']);end
[fig_touchL PtouchHistoCell_L LpegTouchBypegCell]=TouchAlignByPeg(LpegTouchCell,LpegTimeArray2D,yhight);
if FigureSave==1;saveas(fig_touchL,[DrName,' ','TouchAlignLpeg.bmp']);end

% %PtouchHistoCell_R,L��TM�ł��A���K���BTM��WaterOn_percent�ŕ␳
% for n=1:length(PtouchHistoCell_R)
%     %PTpegHistoCell��(length(TurnMarkerTime)-1)�Ŋ����Đ��K��
%     PtouchHistoCell_R{n}=PtouchHistoCell_R{n}/((length(TurnMarkerTime)-1)*WaterOn_percent*0.01);
%     PtouchHistoCell_L{n}=PtouchHistoCell_L{n}/((length(TurnMarkerTime)-1)*WaterOn_percent*0.01);
%     
%     %WaterOn_percent�ŋψ�ɕ␳���Ă��邽�߁ASum���P������ɒ����Ă��܂����Ƃ�����B�����␳�B
%     SumR=0;SumL=0;
%     SumR=sum(PtouchHistoCell_R{n});
%     SumL=sum(PtouchHistoCell_L{n});
%     while SumR>1
%         PtouchHistoCell_R{n}=PtouchHistoCell_R{n}/SumR;
%         SumR=sum(PtouchHistoCell_R{n});
%     end
%     while SumL>1
%         PtouchHistoCell_L{n}=PtouchHistoCell_L{n}/SumL;
%         SumL=sum(PtouchHistoCell_L{n});
%     end
% end



[fig_touchR_TM,PTTMHistoCell_R RmedianPTTM Rmax]=TouchAlignByTM(RpegTouchCell,TurnMarkerTime,yhight);
[fig_touchL_TM,PTTMHistoCell_L LmedianPTTM Lmax]=TouchAlignByTM(LpegTouchCell,TurnMarkerTime,yhight);
if FigureSave==1;saveas(fig_touchR_TM,[DrName,' ','touchR_TM.bmp']);end
if FigureSave==1;saveas(fig_touchL_TM,[DrName,' ','touchL_TM.bmp']);end

if ShowFig==2%�P�̂Ƃ��A�y�O�p�^�[���ƃ^�b�`��F�ʂŕ\��
    Cell_R=zeros(1,length(PTTMHistoCell_R{1}));Cell_L=zeros(1,length(PTTMHistoCell_L{1}));
    fig_TMpegs=figure;hold on
    Max=max([Rmax Lmax]);
    axis([0 ceil(OneTurnTime/10) 0 Max+2]);
    
    for n=1:12;Cell_R=Cell_R+PTTMHistoCell_R{n};end%text(RmedianPTTM(n),Max+1,'l','FontSize',18,'g');end;
    for n=1:12;Cell_L=Cell_L+PTTMHistoCell_L{n};end%text(LmedianPTTM(n),Max+2,'l','FontSize',18,'r');end;
%     for n=1:12;plot(PTTMHistoCell_R{n},'g');end%text(RmedianPTTM(n),Max+1,'l','FontSize',18,'g');end;
%     for n=1:12;plot(PTTMHistoCell_L{n},'r');end%text(LmedianPTTM(n),Max+2,'l','FontSize',18,'r');end;
    plot(Cell_R,'g');
    plot(Cell_L,'r');
    for n=1:12
        text(RmedianPTTM(n),Max+1,'l','FontSize',18,'color',[0 1 0]);
        text(LmedianPTTM(n),Max+1.5,'l','FontSize',18,'color',[1 0 0]);
    end
    
    hold off;
    if FigureSave==1;saveas(fig_TMpegs,[DrName,' ','TM_pegRL.bmp']);end
end

RpegMedian=zeros(1,12);
LpegMedian=zeros(1,12);
for n=1:12
%     RpegTouchTurn{n}(RpegTouchTurn{n}<0)=[];
%     LpegTouchTurn{n}(LpegTouchTurn{n}<0)=[];
    RpegMedian(n)=median(RpegTouchTurn{n}(RpegTouchTurn{n}>=0));%[RpegMedian median(RpegTouchCell{n})]%
    LpegMedian(n)=median(LpegTouchTurn{n}(LpegTouchTurn{n}>=0));%[LpegMedian median(LpegTouchCell{n})]%
end

%disp(TurnMarkerTime(1));
%disp(RpegTouchCell{12});
%disp(RpegTouchTurn{12});
%disp(length(RpegMedian));
%disp(length(LpegMedian));
% disp('RpegMedian=');disp(RpegMedian);
% disp('LpegMedian=');disp(LpegMedian);

%RLpegTouchCell�����Ԏ�k�ɉ����ĕ��ׂ�
%RLpegTouchCell={};%{[] [] [] [] [] [] [] [] [] [] [] [] [] [] [] [] [] [] [] [] [] [] [] []};
RLpegName=char('Rpeg1','Lpeg1','Rpeg2','Lpeg2','Rpeg3','Lpeg3','Rpeg4','Lpeg4','Rpeg5','Lpeg5','Rpeg6','Lpeg6','Rpeg7','Lpeg7','Rpeg8','Lpeg8','Rpeg9','Lpeg9','Rpeg10','Lpeg10','Rpeg11','Lpeg11','Rpeg12','Lpeg12');
RLpegMedian=[];%pegTouchCell��R,L�̏��Ō��݂ɕ��ׂ�B
for n=1:12;RLpegMedian=[RLpegMedian RpegMedian(n) LpegMedian(n)];end%PegMedian��R,L�̏��Ō��݂ɕ��ׂ�B

for n=1:24;
    if mod(n,2)==1;RLpegTouchCell{n}=RpegTouchCell{(n+1)/2};
    else RLpegTouchCell{n}=LpegTouchCell{n/2};end
end
%24�{�̃y�O�����ۂ̏��ԁiMedian)�ɕ��ёւ���B
change=1;
while change==1
    change=0;
    for n=1:length(RLpegTouchCell)-1
        %disp(RLpegMedian(n))
        if RLpegMedian(n)>RLpegMedian(n+1)
            temp=RLpegMedian(n);
            RLpegMedian(n)=RLpegMedian(n+1);
            RLpegMedian(n+1)=temp;
            temp=0;
            
            tempC=RLpegTouchCell{n};
            RLpegTouchCell{n}=RLpegTouchCell{n+1};
            RLpegTouchCell{n+1}=tempC;
            tempC=[];
            
            tempN=RLpegName(n,:);
            RLpegName(n,:)=RLpegName(n+1,:);
            RLpegName(n+1,:)=tempN;
            tempN='';
            
            change=1;
        end
    end
end
RLpegName




% disp('RLpegName='),disp(RLpegName);
% disp('RLpegMedian=');disp(RLpegMedian);
% disp('RLpegTouchCell='),disp(RLpegTouchCell);


% RLpegNum=[];
% %RLpegTouchTurn={[] [] [] [] [] [] [] [] [] [] [] [] [] [] [] [] [] [] [] [] [] [] [] []};
% for n=1:12
%     if RpegMedian(n)>LpegMedian(n)
%         RLpegTouchCell{n+n-1}=LpegTouchCell{n};
%         RLpegTouchCell{n+n}=RpegTouchCell{n};
%         RLpegNum=[RLpegNum 12+n n];
%         %RLpegNum=[RLpegNum n];
%         %RLpegTouchTurn{n+n-1}=LpegTouchTurn{n};RLpegTouchTurn{n+n}=RpegTouchTurn{n};
%     else
%         RLpegTouchCell{n+n-1}=RpegTouchCell{n};
%         RLpegTouchCell{n+n}=LpegTouchCell{n};
%         RLpegNum=[RLpegNum n 12+n];
%         %RLpegNum=[RLpegNum 12+n];
%         %RLpegTouchTurn{n+n-1}=RpegTouchTurn{n};RLpegTouchTurn{n+n}=LpegTouchTurn{n};
%     end
% end
%disp('RLpegNum=');disp(RLpegNum);
% RpegMedianAndLpegMedian=[RpegMedian LpegMedian];
% RLpegMedian=RpegMedianAndLpegMedian(RLpegNum);


%All�̍쐬�BPegTouch�̒i�K��All���쐬�����̂ŕs�v
% RPegTouchAll=zeros(1,length(PegTouchCell));
% LPegTouchAll=zeros(1,length(PegTouchCell));
% for n=1:length(PegTouchCell)
%     RPegTouchAll=[RPegTouchAll RpegTouchCell{n}];%sort([RpegTouchCell{1};PegTouch2;PegTouch3;PegTouch4;PegTouch5;PegTouch6;PegTouch7;PegTouch8;PegTouch9;PegTouch10;PegTouch11;PegTouch12]);
%     LPegTouchAll=[LPegTouchAll LpegTouchCell{n}];
%     RLPegTouchAll=[RLPegTouchAll RpegTouchCell{n}];
%     RLPegTouchAll=[RLPegTouchAll LpegTouchCell{n}];
% end
