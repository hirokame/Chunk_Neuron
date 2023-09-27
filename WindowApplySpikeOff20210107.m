function WindowApplySpikeOff20210107

global RtouchSpikeOffUnit LtouchSpikeOffUnit LtNegativeSpikeOffKaisuu RtNegativeSpikeOffKaisuu RtPositiveSpikeOffKaisuu LtPositiveSpikeOffKaisuu

%%%%%%%%LtouchSpikeffUnitの場合分け
LtPositiveSpikeOffKaisuu=zeros(1,2);
LtPositiveHistogramXaxis=zeros(1,2);  %%%%% Positiveヒストグラムを作成する際の発火頻度（初期値ゼロ）２要素（連続２つ以下、連続3つ以上）

%%%%%%%Positive
LtouchPositive5windowPoint=LtouchSpikeOffUnit(:,(1:5));%%%% Positiveだけ抜き出す
for i=1:length(LtouchPositive5windowPoint(:,1))
    if all(LtouchPositive5windowPoint(i,(1:5))==[1,1,1,1,1]);                                    %%%%５連続で当てはまった時の発火数をどんどんたしていく
       LtPositiveSpikeOffKaisuu(2)=LtPositiveSpikeOffKaisuu(2)+1;
    end
    
    if all(LtouchPositive5windowPoint(i,(1:5))==[0,1,1,1,1]) | all(LtouchPositive5windowPoint(i,(1:5))==[1,1,1,1,0]) ;%%%%4連続で当てはまった時の発火数をどんどんたしていく
       
       LtPositiveSpikeOffKaisuu(2)=LtPositiveSpikeOffKaisuu(2)+1;
    end
    
    if all(LtouchPositive5windowPoint(i,(1:5))==[0,0,1,1,1]) | all(LtouchPositive5windowPoint(i,(1:5))==[0,1,1,1,0])...
            | all(LtouchPositive5windowPoint(i,(1:5))==[1,1,1,0,0]);                           %%%% 3連続で当てはまった時の発火数をどんどんたしていく
       LtPositiveSpikeOffKaisuu(1)=LtPositiveSpikeOffKaisuu(1)+1;
    end
    
    if all(LtouchPositive5windowPoint(i,(1:5))==[1,1,0,0,0]) | all(LtouchPositive5windowPoint(i,(1:5))==[0,1,1,0,0]) | all(LtouchPositive5windowPoint(i,(1:5))==[0,0,1,1,0])...
            | all(LtouchPositive5windowPoint(i,(1:5))==[0,0,0,1,1]);                           %%%% 2連続で当てはまった時の発火数をどんどんたしていく
       LtPositiveSpikeOffKaisuu(1)=LtPositiveSpikeOffKaisuu(1)+1;
    end
    
    if all(LtouchPositive5windowPoint(i,(1:5))==[1,0,0,0,0]) | all(LtouchPositive5windowPoint(i,(1:5))==[0,1,0,0,0]) | all(LtouchPositive5windowPoint(i,(1:5))==[0,0,1,0,0])...
            | all(LtouchPositive5windowPoint(i,(1:5))==[0,0,0,1,0]) | all(LtouchPositive5windowPoint(i,(1:5))==[0,0,0,0,1]);    %%%% １連続で当てはまった時の発火数をどんどんたしていく
       LtPositiveSpikeOffKaisuu(1)=LtPositiveSpikeOffKaisuu(1)+1;
    end
    
    if all(LtouchPositive5windowPoint(i,(1:5))==[0,0,0,0,0]);                         %%%１度も当てはまらない時の発火数をどんどんたしていく
       LtPositiveSpikeOffKaisuu(1)=LtPositiveSpikeOffKaisuu(1)+1;
    end
end


%%%%%% Rtouch %%%%%%%%%%
RtPositiveSpikeOffKaisuu=zeros(1,2);  %%%%% Positiveヒストグラムを作成する際の発火頻度（初期値ゼロ）2要素（連続２つ以下、連続3つ以上）

%%%%%%%Positive
RtouchPositive5windowPoint=RtouchSpikeOffUnit(:,(1:5));%%%% 発火数とPOsitiveだけ抜き出す
for i=1:length(RtouchPositive5windowPoint(:,1))
    if all(RtouchPositive5windowPoint(i,(1:5))==[1,1,1,1,1]);                           %%%%５連続で当てはまった時の発火数をどんどんたしていく
       RtPositiveSpikeOffKaisuu(2)=RtPositiveSpikeOffKaisuu(2)+1;
    end
    
    if all(RtouchPositive5windowPoint(i,(1:5))==[0,1,1,1,1]) | all(RtouchPositive5windowPoint(i,(1:5))==[1,1,1,1,0]) ;%%%%4連続で当てはまった時の発火数をどんどんたしていく
       RtPositiveSpikeOffKaisuu(2)=RtPositiveSpikeOffKaisuu(2)+1;
    end
    
    if all(RtouchPositive5windowPoint(i,(1:5))==[0,0,1,1,1]) | all(RtouchPositive5windowPoint(i,(1:5))==[0,1,1,1,0])...
            | all(RtouchPositive5windowPoint(i,(1:5))==[1,1,1,0,0]);                           %%%% 3連続で当てはまった時の発火数をどんどんたしていく
       RtPositiveSpikeOffKaisuu(1)=RtPositiveSpikeOffKaisuu(1)+1;
    end
    
    if all(RtouchPositive5windowPoint(i,(1:5))==[1,1,0,0,0]) | all(RtouchPositive5windowPoint(i,(1:5))==[0,1,1,0,0]) | all(RtouchPositive5windowPoint(i,(1:5))==[0,0,1,1,0])...
            | all(RtouchPositive5windowPoint(i,(1:5))==[0,0,0,1,1]);                           %%%% 2連続で当てはまった時の発火数をどんどんたしていく
       RtPositiveSpikeOffKaisuu(1)=RtPositiveSpikeOffKaisuu(1)+1;
    end
    
    if all(RtouchPositive5windowPoint(i,(1:5))==[1,0,0,0,0]) | all(RtouchPositive5windowPoint(i,(1:5))==[0,1,0,0,0]) | all(RtouchPositive5windowPoint(i,(1:5))==[0,0,1,0,0])...
            | all(RtouchPositive5windowPoint(i,(1:5))==[0,0,0,1,0]) | all(RtouchPositive5windowPoint(i,(1:5))==[0,0,0,0,1]);    %%%% １連続で当てはまった時の発火数をどんどんたしていく
       RtPositiveSpikeOffKaisuu(1)=RtPositiveSpikeOffKaisuu(1)+1;
    end
    
    if all(RtouchPositive5windowPoint(i,(1:5))==[0,0,0,0,0]);                                  %%%１度も当てはまらない時の発火数をどんどんたしていく
       RtPositiveSpikeOffKaisuu(1)=RtPositiveSpikeOffKaisuu(1)+1;
    end
end