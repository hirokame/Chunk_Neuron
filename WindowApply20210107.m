function WindowApply20210107

global RtouchSpikeOnUnit LtouchSpikeOnUnit LtPositiveSpikeOnKaisuu RtPositiveSpikeOnKaisuu LtPositiveHistogramXaxis RtPositiveHistogramXaxis...
    LtPositiveFiringRate RtPositiveFiringRate LtPositiveSpikeOffKaisuu RtPositiveSpikeOffKaisuu


%%%%%%%%LtouchSpikeOnUnitのfigure作成
LtPositiveSpikeOnKaisuu=zeros(1,2);
LtPositiveHistogramXaxis=zeros(1,2);  %%%%% Positiveヒストグラムを作成する際の発火頻度（初期値ゼロ）2要素（それ以下、連続３つ以上）

%%%%%%%Positive
LtouchPositive5windowPoint=LtouchSpikeOnUnit(:,(1:6));%%%% 発火数とPositiveだけ抜き出す
for i=1:length(LtouchPositive5windowPoint(:,1))
    if all(LtouchPositive5windowPoint(i,(2:6))==[1,1,1,1,1]);
       LtPositiveHistogramXaxis(2)=LtPositiveHistogramXaxis(2)+LtouchPositive5windowPoint(i,1); %%%%５連続で当てはまった時の発火数をどんどんたしていく
       LtPositiveSpikeOnKaisuu(2)=LtPositiveSpikeOnKaisuu(2)+1;
    end
    
    if all(LtouchPositive5windowPoint(i,(2:6))==[0,1,1,1,1]) | all(LtouchPositive5windowPoint(i,(2:6))==[1,1,1,1,0]) ;%%%%4連続で当てはまった時の発火数をどんどんたしていく
       LtPositiveHistogramXaxis(2)=LtPositiveHistogramXaxis(2)+LtouchPositive5windowPoint(i,1); 
       LtPositiveSpikeOnKaisuu(2)=LtPositiveSpikeOnKaisuu(2)+1;
    end
    
    if all(LtouchPositive5windowPoint(i,(2:6))==[0,0,1,1,1])| all(LtouchPositive5windowPoint(i,(2:6))==[0,1,1,1,0])...
            | all(LtouchPositive5windowPoint(i,(2:6))==[1,1,1,0,0]);                           %%%% 3連続で当てはまった時の発火数をどんどんたしていく
       LtPositiveHistogramXaxis(1)=LtPositiveHistogramXaxis(1)+LtouchPositive5windowPoint(i,1); 
       LtPositiveSpikeOnKaisuu(1)=LtPositiveSpikeOnKaisuu(1)+1;
    end
    
    if all(LtouchPositive5windowPoint(i,(2:6))==[1,1,0,0,0]) | all(LtouchPositive5windowPoint(i,(2:6))==[0,1,1,0,0]) | all(LtouchPositive5windowPoint(i,(2:6))==[0,0,1,1,0])...
            | all(LtouchPositive5windowPoint(i,(2:6))==[0,0,0,1,1]);                           %%%% 2連続で当てはまった時の発火数をどんどんたしていく
       LtPositiveHistogramXaxis(1)=LtPositiveHistogramXaxis(1)+LtouchPositive5windowPoint(i,1); 
       LtPositiveSpikeOnKaisuu(1)=LtPositiveSpikeOnKaisuu(1)+1;
    end
    
    if all(LtouchPositive5windowPoint(i,(2:6))==[1,0,0,0,0]) | all(LtouchPositive5windowPoint(i,(2:6))==[0,1,0,0,0]) | all(LtouchPositive5windowPoint(i,(2:6))==[0,0,1,0,0])...
            | all(LtouchPositive5windowPoint(i,(2:6))==[0,0,0,1,0]) | all(LtouchPositive5windowPoint(i,(2:6))==[0,0,0,0,1]);    %%%% １連続で当てはまった時の発火数をどんどんたしていく
       LtPositiveHistogramXaxis(1)=LtPositiveHistogramXaxis(1)+LtouchPositive5windowPoint(i,1); 
       LtPositiveSpikeOnKaisuu(1)=LtPositiveSpikeOnKaisuu(1)+1;
    end
    
    if all(LtouchPositive5windowPoint(i,(2:6))==[0,0,0,0,0]);
       LtPositiveHistogramXaxis(1)=LtPositiveHistogramXaxis(1)+LtouchPositive5windowPoint(i,1); %%%１度も当てはまらない時の発火数をどんどんたしていく
       LtPositiveSpikeOnKaisuu(1)=LtPositiveSpikeOnKaisuu(1)+1;
    end
end

%%%%%% Rtouch %%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%RtouchSpikeOnUnitのfigure作成
RtPositiveSpikeOnKaisuu=zeros(1,2);
RtPositiveHistogramXaxis=zeros(1,2);  %%%%% Positiveヒストグラムを作成する際の発火頻度（初期値ゼロ）２要素（連続２つ以下。連続３つ以上）

%%%%%%%Positive
RtouchPositive5windowPoint=RtouchSpikeOnUnit(:,(1:6));%%%% 発火数とPositiveだけ抜き出す
for i=1:length(RtouchPositive5windowPoint(:,1))
    if all(RtouchPositive5windowPoint(i,(2:6))==[1,1,1,1,1]);
       RtPositiveHistogramXaxis(2)=RtPositiveHistogramXaxis(2)+RtouchPositive5windowPoint(i,1); %%%%５連続で当てはまった時の発火数をどんどんたしていく
       RtPositiveSpikeOnKaisuu(2)=RtPositiveSpikeOnKaisuu(2)+1;
    end
    
    if all(RtouchPositive5windowPoint(i,(2:6))==[0,1,1,1,1]) | all(RtouchPositive5windowPoint(i,(2:6))==[1,1,1,1,0]) ;%%%%4連続で当てはまった時の発火数をどんどんたしていく
       RtPositiveHistogramXaxis(2)=RtPositiveHistogramXaxis(2)+RtouchPositive5windowPoint(i,1); 
       RtPositiveSpikeOnKaisuu(2)=RtPositiveSpikeOnKaisuu(2)+1;
    end
    
    if all(RtouchPositive5windowPoint(i,(2:6))==[0,0,1,1,1]) | all(RtouchPositive5windowPoint(i,(2:6))==[0,1,1,1,0])...
            | all(RtouchPositive5windowPoint(i,(2:6))==[1,1,1,0,0]);                           %%%% 3連続で当てはまった時の発火数をどんどんたしていく
       RtPositiveHistogramXaxis(1)=RtPositiveHistogramXaxis(1)+RtouchPositive5windowPoint(i,1); 
       RtPositiveSpikeOnKaisuu(1)=RtPositiveSpikeOnKaisuu(1)+1;
    end
    
    if all(RtouchPositive5windowPoint(i,(2:6))==[1,1,0,0,0]) | all(RtouchPositive5windowPoint(i,(2:6))==[0,1,1,0,0]) | all(RtouchPositive5windowPoint(i,(2:6))==[0,0,1,1,0])...
            | all(RtouchPositive5windowPoint(i,(2:6))==[0,0,0,1,1]);                           %%%% 2連続で当てはまった時の発火数をどんどんたしていく
       RtPositiveHistogramXaxis(1)=RtPositiveHistogramXaxis(1)+RtouchPositive5windowPoint(i,1); 
       RtPositiveSpikeOnKaisuu(1)=RtPositiveSpikeOnKaisuu(1)+1;
    end
    
    if all(RtouchPositive5windowPoint(i,(2:6))==[1,0,0,0,0]) | all(RtouchPositive5windowPoint(i,(2:6))==[0,1,0,0,0]) | all(RtouchPositive5windowPoint(i,(2:6))==[0,0,1,0,0])...
            | all(RtouchPositive5windowPoint(i,(2:6))==[0,0,0,1,0]) | all(RtouchPositive5windowPoint(i,(2:6))==[0,0,0,0,1]);    %%%% １連続で当てはまった時の発火数をどんどんたしていく
       RtPositiveHistogramXaxis(1)=RtPositiveHistogramXaxis(1)+RtouchPositive5windowPoint(1); 
       RtPositiveSpikeOnKaisuu(1)=RtPositiveSpikeOnKaisuu(1)+1;
    end
    
    if all(RtouchPositive5windowPoint(i,(2:6))==[0,0,0,0,0]);
       RtPositiveHistogramXaxis(1)=RtPositiveHistogramXaxis(1)+RtouchPositive5windowPoint(i,1); %%%１度も当てはまらない時の発火数をどんどんたしていく
       RtPositiveSpikeOnKaisuu(1)=RtPositiveSpikeOnKaisuu(1)+1;
    end
end

WindowApplySpikeOff20210107

LtPositiveFiringRate=LtPositiveHistogramXaxis./((LtPositiveSpikeOnKaisuu+LtPositiveSpikeOffKaisuu)*10);
RtPositiveFiringRate=RtPositiveHistogramXaxis./((RtPositiveSpikeOnKaisuu+RtPositiveSpikeOffKaisuu)*10);

