function WindowApply20200225(RorL)

global render RtouchSpikeOnUnit LtouchSpikeOnUnit RtouchSpikeOffUnit LtouchSpikeOffUnit LtNegativeSpikeOffKaisuu RtNegativeSpikeOffKaisuu ...
    RtPositiveSpikeOffKaisuu LtPositiveSpikeOffKaisuu pegpatternum pegpatternname...
    LtPositiveFiringRate LtNegativeFiringRate RtPositiveFiringRate RtNegativeFiringRate LtPositiveSpikeOnKaisuu LtNegativeSpikeOnKaisuu RtPositiveSpikeOnKaisuu RtNegativeSpikeOnKaisuu...
    LtPositiveHistogramXaxis LtNegativeHistogramXaxis RtPositiveHistogramXaxis RtNegativeHistogramXaxis...
    LtPositive_beta_hist LtNegative_beta_hist RtPositive_beta_hist RtNegative_beta_hist LtPositive_R_hist LtNegative_R_hist RtPositive_R_hist RtNegative_R_hist cellnum CellNumList...
    LtStep4FiringRate RtStep4FiringRate LtStep4SpikeOffKaisuu RtStep4SpikeOffKaisuu LtStep4HistogramXaxis RtStep4HistogramXaxis LtStep4SpikeOnKaisuu RtStep4SpikeOnKaisuu ...
    LtStep3FiringRate RtStep3FiringRate LtStep3SpikeOffKaisuu RtStep3SpikeOffKaisuu LtStep3SpikeOnKaisuu LtStep3HistogramXaxis RtStep3SpikeOnKaisuu RtStep3HistogramXaxis ...
    LtRsq1 RtRsq1 Ltbeta1 Rtbeta1
%%%%%%%%LtouchSpikeOnUnitのfigure作成
if ~isempty(strfind(RorL, 'L'));
    LtPositiveSpikeOnKaisuu=zeros(1,6);
    LtPositiveHistogramXaxis=zeros(1,6);  %%%%% Positiveヒストグラムを作成する際の発火頻度（初期値ゼロ）６要素（0個、どれか1つ、連続２つだけ、連続3つ、連続4つ、連続5つ）
    
    LtStep4SpikeOnKaisuu=zeros(1,5);
    LtStep4HistogramXaxis=zeros(1,5);
    
    LtStep3SpikeOnKaisuu=zeros(1,10);
    LtStep3HistogramXaxis=zeros(1,10);
    
    %%%%%%%Positive
    LtouchPositive5windowPoint=LtouchSpikeOnUnit(:,(1:6));%%%% 発火数とPositiveだけ抜き出す
    for i=1:length(LtouchPositive5windowPoint(:,1))
        if all(LtouchPositive5windowPoint(i,(2:6))==[1,1,1,1,1]);
            LtPositiveHistogramXaxis(6)=LtPositiveHistogramXaxis(6)+LtouchPositive5windowPoint(i,1); %%%%５連続で当てはまった時の発火数をどんどんたしていく
            LtPositiveSpikeOnKaisuu(6)=LtPositiveSpikeOnKaisuu(6)+1;
        end
        
        if all(LtouchPositive5windowPoint(i,(2:6))==[0,1,1,1,1]) || all(LtouchPositive5windowPoint(i,(2:6))==[1,1,1,1,0]) ;%%%%4連続で当てはまった時の発火数をどんどんたしていく
            LtPositiveHistogramXaxis(5)=LtPositiveHistogramXaxis(5)+LtouchPositive5windowPoint(i,1);
            LtPositiveSpikeOnKaisuu(5)=LtPositiveSpikeOnKaisuu(5)+1;
        end
        
        if all(LtouchPositive5windowPoint(i,(2:6))==[0,0,1,1,1]) || all(LtouchPositive5windowPoint(i,(2:6))==[0,1,1,1,0])...
                || all(LtouchPositive5windowPoint(i,(2:6))==[1,1,1,0,0]);                           %%%% 3連続で当てはまった時の発火数をどんどんたしていく
            LtPositiveHistogramXaxis(4)=LtPositiveHistogramXaxis(4)+LtouchPositive5windowPoint(i,1);
            LtPositiveSpikeOnKaisuu(4)=LtPositiveSpikeOnKaisuu(4)+1;
        end
        
        if all(LtouchPositive5windowPoint(i,(2:6))==[1,1,0,0,0]) || all(LtouchPositive5windowPoint(i,(2:6))==[0,1,1,0,0]) || all(LtouchPositive5windowPoint(i,(2:6))==[0,0,1,1,0])...
                || all(LtouchPositive5windowPoint(i,(2:6))==[0,0,0,1,1]);                           %%%% 2連続で当てはまった時の発火数をどんどんたしていく
            LtPositiveHistogramXaxis(3)=LtPositiveHistogramXaxis(3)+LtouchPositive5windowPoint(i,1);
            LtPositiveSpikeOnKaisuu(3)=LtPositiveSpikeOnKaisuu(3)+1;
        end
        
        if all(LtouchPositive5windowPoint(i,(2:6))==[1,0,0,0,0]) || all(LtouchPositive5windowPoint(i,(2:6))==[0,1,0,0,0]) || all(LtouchPositive5windowPoint(i,(2:6))==[0,0,1,0,0])...
                || all(LtouchPositive5windowPoint(i,(2:6))==[0,0,0,1,0]) || all(LtouchPositive5windowPoint(i,(2:6))==[0,0,0,0,1]);    %%%% １連続で当てはまった時の発火数をどんどんたしていく
            LtPositiveHistogramXaxis(2)=LtPositiveHistogramXaxis(2)+LtouchPositive5windowPoint(i,1);
            LtPositiveSpikeOnKaisuu(2)=LtPositiveSpikeOnKaisuu(2)+1;
        end
        
        if all(LtouchPositive5windowPoint(i,(2:6))==[0,0,0,0,0]);
            LtPositiveHistogramXaxis(1)=LtPositiveHistogramXaxis(1)+LtouchPositive5windowPoint(i,1); %%%１度も当てはまらない時の発火数をどんどんたしていく
            LtPositiveSpikeOnKaisuu(1)=LtPositiveSpikeOnKaisuu(1)+1;
        end
        
        %%%ここからStep4の解析
        if all(LtouchPositive5windowPoint(i,(2:6))==[0,1,1,1,1]);
            LtStep4HistogramXaxis(1)=LtStep4HistogramXaxis(1)+LtouchPositive5windowPoint(i,1);
            LtStep4SpikeOnKaisuu(1)=LtStep4SpikeOnKaisuu(1)+1;
        end
        if all(LtouchPositive5windowPoint(i,(2:6))==[1,0,1,1,1]);
            LtStep4HistogramXaxis(2)=LtStep4HistogramXaxis(2)+LtouchPositive5windowPoint(i,1);
            LtStep4SpikeOnKaisuu(2)=LtStep4SpikeOnKaisuu(2)+1;
        end
        if all(LtouchPositive5windowPoint(i,(2:6))==[1,1,0,1,1]);
            LtStep4HistogramXaxis(3)=LtStep4HistogramXaxis(3)+LtouchPositive5windowPoint(i,1);
            LtStep4SpikeOnKaisuu(3)=LtStep4SpikeOnKaisuu(3)+1;
        end
        if all(LtouchPositive5windowPoint(i,(2:6))==[1,1,1,0,1]);
            LtStep4HistogramXaxis(4)=LtStep4HistogramXaxis(4)+LtouchPositive5windowPoint(i,1);
            LtStep4SpikeOnKaisuu(4)=LtStep4SpikeOnKaisuu(4)+1;
        end
        if all(LtouchPositive5windowPoint(i,(2:6))==[1,1,1,1,0]);
            LtStep4HistogramXaxis(5)=LtStep4HistogramXaxis(5)+LtouchPositive5windowPoint(i,1);
            LtStep4SpikeOnKaisuu(5)=LtStep4SpikeOnKaisuu(5)+1;
        end
        
        %%%ここからStep3の解析
        if all(LtouchPositive5windowPoint(i,(2:6))==[0,0,1,1,1]);
            LtStep3HistogramXaxis(1)=LtStep3HistogramXaxis(1)+LtouchPositive5windowPoint(i,1);
            LtStep3SpikeOnKaisuu(1)=LtStep3SpikeOnKaisuu(1)+1;
        end
        if all(LtouchPositive5windowPoint(i,(2:6))==[0,1,0,1,1]);
            LtStep3HistogramXaxis(2)=LtStep3HistogramXaxis(2)+LtouchPositive5windowPoint(i,1);
            LtStep3SpikeOnKaisuu(2)=LtStep3SpikeOnKaisuu(2)+1;
        end
        if all(LtouchPositive5windowPoint(i,(2:6))==[0,1,1,0,1]);
            LtStep3HistogramXaxis(3)=LtStep3HistogramXaxis(3)+LtouchPositive5windowPoint(i,1);
            LtStep3SpikeOnKaisuu(3)=LtStep3SpikeOnKaisuu(3)+1;
        end
        if all(LtouchPositive5windowPoint(i,(2:6))==[0,1,1,1,0]);
            LtStep3HistogramXaxis(4)=LtStep3HistogramXaxis(4)+LtouchPositive5windowPoint(i,1);
            LtStep3SpikeOnKaisuu(4)=LtStep3SpikeOnKaisuu(4)+1;
        end
        if all(LtouchPositive5windowPoint(i,(2:6))==[1,0,0,1,1]);
            LtStep3HistogramXaxis(5)=LtStep3HistogramXaxis(5)+LtouchPositive5windowPoint(i,1);
            LtStep3SpikeOnKaisuu(5)=LtStep3SpikeOnKaisuu(5)+1;
        end
        if all(LtouchPositive5windowPoint(i,(2:6))==[1,0,1,0,1]);
            LtStep3HistogramXaxis(6)=LtStep3HistogramXaxis(6)+LtouchPositive5windowPoint(i,1);
            LtStep3SpikeOnKaisuu(6)=LtStep3SpikeOnKaisuu(6)+1;
        end
        if all(LtouchPositive5windowPoint(i,(2:6))==[1,0,1,1,0]);
            LtStep3HistogramXaxis(7)=LtStep3HistogramXaxis(7)+LtouchPositive5windowPoint(i,1);
            LtStep3SpikeOnKaisuu(7)=LtStep3SpikeOnKaisuu(7)+1;
        end
        if all(LtouchPositive5windowPoint(i,(2:6))==[1,1,0,0,1]);
            LtStep3HistogramXaxis(8)=LtStep3HistogramXaxis(8)+LtouchPositive5windowPoint(i,1);
            LtStep3SpikeOnKaisuu(8)=LtStep3SpikeOnKaisuu(8)+1;
        end
        if all(LtouchPositive5windowPoint(i,(2:6))==[1,1,0,1,0]);
            LtStep3HistogramXaxis(9)=LtStep3HistogramXaxis(9)+LtouchPositive5windowPoint(i,1);
            LtStep3SpikeOnKaisuu(9)=LtStep3SpikeOnKaisuu(9)+1;
        end
        if all(LtouchPositive5windowPoint(i,(2:6))==[1,1,1,0,0]);
            LtStep3HistogramXaxis(10)=LtStep3HistogramXaxis(10)+LtouchPositive5windowPoint(i,1);
            LtStep3SpikeOnKaisuu(10)=LtStep3SpikeOnKaisuu(10)+1;
        end
    end
    WindowApplySpikeOff20200225(RorL)   %%%%%SpikeOffの時の場合分けの計算
    LtPositiveFiringRate=LtPositiveHistogramXaxis./((LtPositiveSpikeOnKaisuu+LtPositiveSpikeOffKaisuu+0.00001));
    LtStep4FiringRate=LtStep4HistogramXaxis./((LtStep4SpikeOnKaisuu+LtStep4SpikeOffKaisuu+0.00001));
    LtStep3FiringRate=LtStep3HistogramXaxis./((LtStep3SpikeOnKaisuu+LtStep3SpikeOffKaisuu+0.00001));
end

% %%%%%%%Negative
% LtNegativeSpikeOnKaisuu=zeros(1,5);
% LtNegativeHistogramXaxis=zeros(1,5); %%%%% Negativeヒストグラムを作成する際の発火頻度（初期値ゼロ）5要素（0個、どれか1つ、連続２つだけ、連続3つ、連続4つ）
% LtouchNegative5windowPoint=[LtouchSpikeOnUnit(:,1) LtouchSpikeOnUnit(:,(7:10))];%%%% 発火数とNegativeだけ抜き出す
%
%
%
% for i=1:length(LtouchNegative5windowPoint(:,1))
%     if all(LtouchNegative5windowPoint(i,(2:5))==[-1,-1,-1,-1]);
%        LtNegativeHistogramXaxis(5)=LtNegativeHistogramXaxis(5)+LtouchNegative5windowPoint(i,1); %%%%4連続で当てはまった時の発火数をどんどんたしていく
%        LtNegativeSpikeOnKaisuu(5)=LtNegativeSpikeOnKaisuu(5)+1;
%     end
%
%     if all(LtouchNegative5windowPoint(i,(2:5))==[0,-1,-1,-1]) | all(LtouchNegative5windowPoint(i,(2:5))==[-1,-1,-1,0]) ;%%%%3連続で当てはまった時の発火数をどんどんたしていく
%        LtNegativeHistogramXaxis(4)=LtNegativeHistogramXaxis(4)+LtouchNegative5windowPoint(i,1);
%        LtNegativeSpikeOnKaisuu(4)=LtNegativeSpikeOnKaisuu(4)+1;
%     end
%
%     if all(LtouchNegative5windowPoint(i,(2:5))==[0,0,-1,-1]) | all(LtouchNegative5windowPoint(i,(2:5))==[0,-1,-1,0])...
%             | all(LtouchNegative5windowPoint(i,(2:5))==[-1,-1,0,0]);                           %%%% 2連続で当てはまった時の発火数をどんどんたしていく
%        LtNegativeHistogramXaxis(3)=LtNegativeHistogramXaxis(3)+LtouchNegative5windowPoint(i,1);
%        LtNegativeSpikeOnKaisuu(3)=LtNegativeSpikeOnKaisuu(3)+1;
%     end
%
%     if all(LtouchNegative5windowPoint(i,(2:5))==[-1,0,0,0]) | all(LtouchNegative5windowPoint(i,(2:5))==[0,-1,0,0]) | all(LtouchNegative5windowPoint(i,(2:5))==[0,0,-1,0])...
%             | all(LtouchNegative5windowPoint(i,(2:5))==[0,0,0,-1]);                           %%%% 1連続で当てはまった時の発火数をどんどんたしていく
%        LtNegativeHistogramXaxis(2)=LtNegativeHistogramXaxis(2)+LtouchNegative5windowPoint(i,1);
%        LtNegativeSpikeOnKaisuu(2)=LtNegativeSpikeOnKaisuu(2)+1;
%     end
%
%     if all(LtouchNegative5windowPoint(i,(2:5))==[0,0,0,0]);    %%%% 0連続で当てはまった時の発火数をどんどんたしていく
%        LtNegativeHistogramXaxis(1)=LtNegativeHistogramXaxis(1)+LtouchNegative5windowPoint(i,1);
%        LtNegativeSpikeOnKaisuu(1)=LtNegativeSpikeOnKaisuu(1)+1;
%     end
% end
%
%
%
%

%%%%%% Rtouch %%%%%%%%%%
if ~isempty(strfind(RorL, 'R'))
    RtPositiveSpikeOnKaisuu=zeros(1,6);
    RtPositiveHistogramXaxis=zeros(1,6);  %%%%% Positiveヒストグラムを作成する際の発火頻度（初期値ゼロ）６要素（0個、どれか1つ、連続２つだけ、連続3つ、連続4つ、連続5つ）
    
    RtStep4SpikeOnKaisuu=zeros(1,5);
    RtStep4HistogramXaxis=zeros(1,5);
    
    RtStep3SpikeOnKaisuu=zeros(1,10);
    RtStep3HistogramXaxis=zeros(1,10);
    
    %%%%%%%Positive
    RtouchPositive5windowPoint=RtouchSpikeOnUnit(:,(1:6));%%%% 発火数とPOsitiveだけ抜き出す
    for i=1:length(RtouchPositive5windowPoint(:,1))
        if all(RtouchPositive5windowPoint(i,(2:6))==[1,1,1,1,1]);
            RtPositiveHistogramXaxis(6)=RtPositiveHistogramXaxis(6)+RtouchPositive5windowPoint(i,1); %%%%５連続で当てはまった時の発火数をどんどんたしていく
            RtPositiveSpikeOnKaisuu(6)=RtPositiveSpikeOnKaisuu(6)+1;
        end
        
        if all(RtouchPositive5windowPoint(i,(2:6))==[0,1,1,1,1]) || all(RtouchPositive5windowPoint(i,(2:6))==[1,1,1,1,0]) ;%%%%4連続で当てはまった時の発火数をどんどんたしていく
            RtPositiveHistogramXaxis(5)=RtPositiveHistogramXaxis(5)+RtouchPositive5windowPoint(i,1);
            RtPositiveSpikeOnKaisuu(5)=RtPositiveSpikeOnKaisuu(5)+1;
        end
        
        if all(RtouchPositive5windowPoint(i,(2:6))==[0,0,1,1,1]) || all(RtouchPositive5windowPoint(i,(2:6))==[0,1,1,1,0])...
                || all(RtouchPositive5windowPoint(i,(2:6))==[1,1,1,0,0]);                           %%%% 3連続で当てはまった時の発火数をどんどんたしていく
            RtPositiveHistogramXaxis(4)=RtPositiveHistogramXaxis(4)+RtouchPositive5windowPoint(i,1);
            RtPositiveSpikeOnKaisuu(4)=RtPositiveSpikeOnKaisuu(4)+1;
        end
        
        if all(RtouchPositive5windowPoint(i,(2:6))==[1,1,0,0,0]) || all(RtouchPositive5windowPoint(i,(2:6))==[0,1,1,0,0]) || all(RtouchPositive5windowPoint(i,(2:6))==[0,0,1,1,0])...
                || all(RtouchPositive5windowPoint(i,(2:6))==[0,0,0,1,1]);                           %%%% 2連続で当てはまった時の発火数をどんどんたしていく
            RtPositiveHistogramXaxis(3)=RtPositiveHistogramXaxis(3)+RtouchPositive5windowPoint(i,1);
            RtPositiveSpikeOnKaisuu(3)=RtPositiveSpikeOnKaisuu(3)+1;
        end
        
        if all(RtouchPositive5windowPoint(i,(2:6))==[1,0,0,0,0]) || all(RtouchPositive5windowPoint(i,(2:6))==[0,1,0,0,0]) || all(RtouchPositive5windowPoint(i,(2:6))==[0,0,1,0,0])...
                || all(RtouchPositive5windowPoint(i,(2:6))==[0,0,0,1,0]) || all(RtouchPositive5windowPoint(i,(2:6))==[0,0,0,0,1]);    %%%% １連続で当てはまった時の発火数をどんどんたしていく
            RtPositiveHistogramXaxis(2)=RtPositiveHistogramXaxis(2)+RtouchPositive5windowPoint(i,1);
            RtPositiveSpikeOnKaisuu(2)=RtPositiveSpikeOnKaisuu(2)+1;
        end
        
        if all(RtouchPositive5windowPoint(i,(2:6))==[0,0,0,0,0]);
            RtPositiveHistogramXaxis(1)=RtPositiveHistogramXaxis(1)+RtouchPositive5windowPoint(i,1); %%%１度も当てはまらない時の発火数をどんどんたしていく
            RtPositiveSpikeOnKaisuu(1)=RtPositiveSpikeOnKaisuu(1)+1;
        end
        
        %%%ここからStep4の解析
        if all(RtouchPositive5windowPoint(i,(2:6))==[0,1,1,1,1]);
            RtStep4HistogramXaxis(1)=RtStep4HistogramXaxis(1)+RtouchPositive5windowPoint(i,1);
            RtStep4SpikeOnKaisuu(1)=RtStep4SpikeOnKaisuu(1)+1;
        end
        if all(RtouchPositive5windowPoint(i,(2:6))==[1,0,1,1,1]);
            RtStep4HistogramXaxis(2)=RtStep4HistogramXaxis(2)+RtouchPositive5windowPoint(i,1);
            RtStep4SpikeOnKaisuu(2)=RtStep4SpikeOnKaisuu(2)+1;
        end
        if all(RtouchPositive5windowPoint(i,(2:6))==[1,1,0,1,1]);
            RtStep4HistogramXaxis(3)=RtStep4HistogramXaxis(3)+RtouchPositive5windowPoint(i,1);
            RtStep4SpikeOnKaisuu(3)=RtStep4SpikeOnKaisuu(3)+1;
        end
        if all(RtouchPositive5windowPoint(i,(2:6))==[1,1,1,0,1]);
            RtStep4HistogramXaxis(4)=RtStep4HistogramXaxis(4)+RtouchPositive5windowPoint(i,1);
            RtStep4SpikeOnKaisuu(4)=RtStep4SpikeOnKaisuu(4)+1;
        end
        if all(RtouchPositive5windowPoint(i,(2:6))==[1,1,1,1,0]);
            RtStep4HistogramXaxis(5)=RtStep4HistogramXaxis(5)+RtouchPositive5windowPoint(i,1);
            RtStep4SpikeOnKaisuu(5)=RtStep4SpikeOnKaisuu(5)+1;
        end
        
        %%%ここからStep3の解析
        if all(RtouchPositive5windowPoint(i,(2:6))==[0,0,1,1,1]);
            RtStep3HistogramXaxis(1)=RtStep3HistogramXaxis(1)+RtouchPositive5windowPoint(i,1);
            RtStep3SpikeOnKaisuu(1)=RtStep3SpikeOnKaisuu(1)+1;
        end
        if all(RtouchPositive5windowPoint(i,(2:6))==[0,1,0,1,1]);
            RtStep3HistogramXaxis(2)=RtStep3HistogramXaxis(2)+RtouchPositive5windowPoint(i,1);
            RtStep3SpikeOnKaisuu(2)=RtStep3SpikeOnKaisuu(2)+1;
        end
        if all(RtouchPositive5windowPoint(i,(2:6))==[0,1,1,0,1]);
            RtStep3HistogramXaxis(3)=RtStep3HistogramXaxis(3)+RtouchPositive5windowPoint(i,1);
            RtStep3SpikeOnKaisuu(3)=RtStep3SpikeOnKaisuu(3)+1;
        end
        if all(RtouchPositive5windowPoint(i,(2:6))==[0,1,1,1,0]);
            RtStep3HistogramXaxis(4)=RtStep3HistogramXaxis(4)+RtouchPositive5windowPoint(i,1);
            RtStep3SpikeOnKaisuu(4)=RtStep3SpikeOnKaisuu(4)+1;
        end
        if all(RtouchPositive5windowPoint(i,(2:6))==[1,0,0,1,1]);
            RtStep3HistogramXaxis(5)=RtStep3HistogramXaxis(5)+RtouchPositive5windowPoint(i,1);
            RtStep3SpikeOnKaisuu(5)=RtStep3SpikeOnKaisuu(5)+1;
        end
        if all(RtouchPositive5windowPoint(i,(2:6))==[1,0,1,0,1]);
            RtStep3HistogramXaxis(6)=RtStep3HistogramXaxis(6)+RtouchPositive5windowPoint(i,1);
            RtStep3SpikeOnKaisuu(6)=RtStep3SpikeOnKaisuu(6)+1;
        end
        if all(RtouchPositive5windowPoint(i,(2:6))==[1,0,1,1,0]);
            RtStep3HistogramXaxis(7)=RtStep3HistogramXaxis(7)+RtouchPositive5windowPoint(i,1);
            RtStep3SpikeOnKaisuu(7)=RtStep3SpikeOnKaisuu(7)+1;
        end
        if all(RtouchPositive5windowPoint(i,(2:6))==[1,1,0,0,1]);
            RtStep3HistogramXaxis(8)=RtStep3HistogramXaxis(8)+RtouchPositive5windowPoint(i,1);
            RtStep3SpikeOnKaisuu(8)=RtStep3SpikeOnKaisuu(8)+1;
        end
        if all(RtouchPositive5windowPoint(i,(2:6))==[1,1,0,1,0]);
            RtStep3HistogramXaxis(9)=RtStep3HistogramXaxis(9)+RtouchPositive5windowPoint(i,1);
            RtStep3SpikeOnKaisuu(9)=RtStep3SpikeOnKaisuu(9)+1;
        end
        if all(RtouchPositive5windowPoint(i,(2:6))==[1,1,1,0,0]);
            RtStep3HistogramXaxis(10)=RtStep3HistogramXaxis(10)+RtouchPositive5windowPoint(i,1);
            RtStep3SpikeOnKaisuu(10)=RtStep3SpikeOnKaisuu(10)+1;
        end
    end
    WindowApplySpikeOff20200225(RorL)   %%%%%SpikeOffの時の場合分けの計算
    
    RtPositiveFiringRate=RtPositiveHistogramXaxis./((RtPositiveSpikeOnKaisuu+RtPositiveSpikeOffKaisuu+0.00001));
    RtStep4FiringRate=RtStep4HistogramXaxis./((RtStep4SpikeOnKaisuu+RtStep4SpikeOffKaisuu+0.00001));
    RtStep3FiringRate=RtStep3HistogramXaxis./((RtStep3SpikeOnKaisuu+RtStep3SpikeOffKaisuu+0.00001));
end


% %%%%%%%Negative
% RtNegativeSpikeOnKaisuu=zeros(1,5);
% RtNegativeHistogramXaxis=zeros(1,5); %%%%% Negativeヒストグラムを作成する際の発火頻度（初期値ゼロ）5要素（0個、どれか1つ、連続２つだけ、連続3つ、連続4つ）
% RtouchNegative5windowPoint=[RtouchSpikeOnUnit(:,1) RtouchSpikeOnUnit(:,(7:10))];%%%% 発火数とNegativeだけ抜き出す
%
%
%
% for i=1:length(RtouchNegative5windowPoint(:,1))
%     if all(RtouchNegative5windowPoint(i,(2:5))==[-1,-1,-1,-1]);
%        RtNegativeHistogramXaxis(5)=RtNegativeHistogramXaxis(5)+RtouchNegative5windowPoint(i,1); %%%%4連続で当てはまった時の発火数をどんどんたしていく
%        RtNegativeSpikeOnKaisuu(5)=RtNegativeSpikeOnKaisuu(5)+1;
%     end
%
%     if all(RtouchNegative5windowPoint(i,(2:5))==[0,-1,-1,-1]) | all(RtouchNegative5windowPoint(i,(2:5))==[-1,-1,-1,0]) ;%%%%3連続で当てはまった時の発火数をどんどんたしていく
%        RtNegativeHistogramXaxis(4)=RtNegativeHistogramXaxis(4)+RtouchNegative5windowPoint(i,1);
%        RtNegativeSpikeOnKaisuu(4)=RtNegativeSpikeOnKaisuu(4)+1;
%     end
%
%     if all(RtouchNegative5windowPoint(i,(2:5))==[0,0,-1,-1]) | all(RtouchNegative5windowPoint(i,(2:5))==[0,-1,-1,0])...
%             | all(RtouchNegative5windowPoint(i,(2:5))==[-1,-1,0,0]);                           %%%% 2連続で当てはまった時の発火数をどんどんたしていく
%        RtNegativeHistogramXaxis(3)=RtNegativeHistogramXaxis(3)+RtouchNegative5windowPoint(i,1);
%        RtNegativeSpikeOnKaisuu(3)=RtNegativeSpikeOnKaisuu(3)+1;
%     end
%
%     if all(RtouchNegative5windowPoint(i,(2:5))==[-1,0,0,0]) | all(RtouchNegative5windowPoint(i,(2:5))==[0,-1,0,0]) | all(RtouchNegative5windowPoint(i,(2:5))==[0,0,-1,0])...
%             | all(RtouchNegative5windowPoint(i,(2:5))==[0,0,0,-1]);                           %%%% 1連続で当てはまった時の発火数をどんどんたしていく
%        RtNegativeHistogramXaxis(2)=RtNegativeHistogramXaxis(2)+RtouchNegative5windowPoint(i,1);
%        RtNegativeSpikeOnKaisuu(2)=RtNegativeSpikeOnKaisuu(2)+1;
%     end
%
%     if all(RtouchNegative5windowPoint(i,(2:5))==[0,0,0,0]);    %%%% 0連続で当てはまった時の発火数をどんどんたしていく
%        RtNegativeHistogramXaxis(1)=RtNegativeHistogramXaxis(1)+RtouchNegative5windowPoint(i,1);
%        RtNegativeSpikeOnKaisuu(1)=RtNegativeSpikeOnKaisuu(1)+1;
%     end
% end

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%スパイクが当てはまった時のPositiveウィンドのfigure
% FRfigure=figure;
% subplot(2,2,1)

%LtPositiveFiringRate=LtPositiveFiringRate/mean(LtPositiveFiringRate);
% bar(LtPositiveFiringRate); %%%%%発火頻度に直す
% title('SpikeOnPositiveFiringRateLt')
% %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% %%%%%%%%%%%%%LtNegativeウィンドウに当てはまった発火頻度を表示
% subplot(2,2,2)
% LtNegativeFiringRate=LtNegativeHistogramXaxis./((LtNegativeSpikeOnKaisuu+LtNegativeSpikeOffKaisuu)*10);
% LtNegativeFiringRate=LtNegativeFiringRate/mean(LtNegativeFiringRate);
% bar(LtNegativeFiringRate); %%%%%発火頻度に直す
% title('SpikeOnNegativeFiringRateLt')
%
% %%%%%%%%%%%%%%%%%%%%%%%%%%%%%スパイクが当てはまった時のPositiveウィンドのfigure
% subplot(2,2,3)

%RtPositiveFiringRate=RtPositiveFiringRate/mean(RtPositiveFiringRate);
% bar(RtPositiveFiringRate); %%%%%発火頻度に直す
% title('SpikeOnPositiveFiringRateRt')
% %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%
% subplot(2,2,4)
% RtNegativeFiringRate=RtNegativeHistogramXaxis./((RtNegativeSpikeOnKaisuu+RtNegativeSpikeOffKaisuu)*10);
% RtNegativeFiringRate=RtNegativeFiringRate/mean(RtNegativeFiringRate);
% bar(RtNegativeFiringRate); %%%%%発火頻度に直す
% title('SpikeOnNegativeFiringRateRt')
%
% %%%%%%%%figの保存%%%%%%%%%%%%%%%%%%
% figname=[pegpatternum,pegpatternname,'FRfigureRtLt.bmp'];
% saveas(FRfigure,figname);
%
% %%ここからは最小二乗回帰とその決定係数をプロット
% %%%%%%%%%%%%%%%%%%%%%%%%%%%%%スパイクが当てはまった時のPositiveウィンドのfigure
if ~isempty(strfind(RorL, 'L'));
    x=[1 2 3 4 5];
    y=LtPositiveFiringRate(2:6);
    y=y/mean(y);
    beta=polyfit(x,y,1);
    Ltbeta0=beta(2);
    Ltbeta1=beta(1); %% こっちが傾き
    yCalc=Ltbeta1*x+Ltbeta0;
    LtRsq1=1-sum((y-yCalc).^2)/sum((y-mean(y)).^2); %% 決定係数
    if render==1;
        FRfigure_wR=figure;
        scatter(x,y); %%%%%発火頻度に直す
        hold on
        plot(x,yCalc)
        title('SpikeOnPositiveFiringRateLt_withRegression')
    end
end
% %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% %%%%%%%%%%%%%LtNegativeウィンドウに当てはまった発火頻度を表示
% subplot(2,2,2)
% x=[0 1 2 3 4];
% y=LtNegativeFiringRate;
% beta=polyfit(x,y,1);
% beta0=beta(2);
% beta1=beta(1);
% yCalc=beta1*x+beta0;
% Rsq1=1-sum((y-yCalc).^2)/sum((y-mean(y)).^2);
% scatter(x,y); %%%%%発火頻度に直す
% hold on
% plot(x,yCalc)
% str=['R=',num2str(Rsq1)];
% title('SpikeOnNegativeFiringRateLt_withRegression')
% LtNegative_beta_hist=[LtNegative_beta_hist,beta1];
% LtNegative_R_hist=[LtNegative_R_hist,Rsq1];
% %%%%%%%%%%%%%%%%%%%%%%%%%%%%%スパイクが当てはまった時のPositiveウィンドのfigure
if ~isempty(strfind(RorL, 'R'));
    x=[1 2 3 4 5];
    y=RtPositiveFiringRate(2:6);
    y=y/mean(y);
    beta=polyfit(x,y,1);
    Rtbeta0=beta(2);
    Rtbeta1=beta(1);
    yCalc=Rtbeta1*x+Rtbeta0;
    RtRsq1=1-sum((y-yCalc).^2)/sum((y-mean(y)).^2);
    if render==1;
        scatter(x,y);
        hold on
        plot(x,yCalc)
        title('SpikeOnPositiveFiringRateRt_withRegression')
        
        %     figname=[num2str(cellnum) 'FRfigureRtLt_wR.bmp'];
        %     saveas(FRfigure_wR, figname);
    end
end
%
% subplot(2,2,4)
% x=[0 1 2 3 4];
% y=RtNegativeFiringRate;
% beta=polyfit(x,y,1);
% beta0=beta(2);
% beta1=beta(1);
% yCalc=beta1*x+beta0;
% Rsq1=1-sum((y-yCalc).^2)/sum((y-mean(y)).^2);
% scatter(x,y);
% hold on
% plot(x,yCalc)
% str=['R=',num2str(Rsq1)];
% title('SpikeOnNegativeFiringRateRt_withRegression')
% RtNegative_beta_hist=[RtNegative_beta_hist,beta1];
% RtNegative_R_hist=[RtNegative_R_hist,Rsq1];
%
% %%%%%%%%%%%%%%%%%%%%%%%
% CellNumList=[CellNumList,cellnum]
%
% %%%%%%%%figの保存%%%%%%%%%%%%%%%%%%

close all hidden


