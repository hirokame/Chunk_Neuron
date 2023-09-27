function Zscore_dist


% Cortex
path=['/Volumes/KIOXIA/CheetahWRLV20230323_Ctx'];
cd(path);
load('Zscore.mat')
bin = 50;

% MaxA1Rt_count=MaxA1Rt_count(find(MaxA1Rt_count));
% MaxZR_count=MaxZR_count(find(MaxZR_count));
% MaxA2Lt_count=MaxA2Lt_count(find(MaxA2Lt_count));
% MaxZL_count=MaxZL_count(find(MaxZL_count));
% MaxADon_count=MaxADon_count(find(MaxZL_count));
% MaxZ_count=MaxZ_count(find(MaxZ_count));
% ZFreq_Int_dist=ZFreq_Int_dist(find(ZFreq_Int_dist));
% ZFreq_Ph_dist=ZFreq_Ph_dist(find(ZFreq_Ph_dist));
% ZFreq_Int_dist_All=ZFreq_Int_dist_All(find(ZFreq_Int_dist_All));
% ZFreq_Ph_dist_All=ZFreq_Ph_dist_All(find(ZFreq_Ph_dist_All));
% 
% beta_dist=beta_dist(find(beta_dist));
% Rsq_dist=Rsq_dist(find(Rsq_dist));
% beta_P1_dist=beta_P1_dist(find(beta_P1_dist));
% Rsq_P1_dist=Rsq_P1_dist(find(Rsq_P1_dist)); 
% beta_dist_All=beta_dist_All(find(beta_dist_All)); 
% Rsq_dist_All=Rsq_dist_All(find(Rsq_dist_All)); 
% beta_P1_dist_All=beta_P1_dist_All(find(beta_P1_dist_All));
% Rsq_P1_dist_All=Rsq_P1_dist_All(find(Rsq_P1_dist_All));

f1 = figure;
sgtitle('Cortex Touch/lick/rhythm')
subplot(5,2,1)
histogram(MaxA1Rt_count,bin)
title('Rt spectrum')

subplot(5,2,2)
histogram(MaxZR_count,bin)
title('Rt Zscore')

subplot(5,2,3)
histogram(MaxA2Lt_count,bin)
title('Lt spectrum')

subplot(5,2,4)
histogram(MaxZL_count,bin)
title('Lt Zscore')

subplot(5,2,5)
histogram(MaxADon_count,bin)
title('Lick spectrm')

subplot(5,2,6)
histogram(MaxZ_count,bin)
title('Lick Zscore')

subplot(5,2,7)
histogram(ZFreq_Int_dist,bin)
title('Interval Zscore')

subplot(5,2,8)
histogram(ZFreq_Ph_dist,bin)
title('Phase Zscore')

subplot(5,2,9)
histogram(ZFreq_Int_dist_All,bin)
title('Interval Zscore AllCell')

subplot(5,2,10)
histogram(ZFreq_Ph_dist_All,bin)
title('Phase Zscore AllCell')

f2 = figure;
sgtitle('Cortex Repeat')
subplot(4,2,1)
histogram(beta_dist,bin)
title('Beta')

subplot(4,2,2)
histogram(Rsq_dist,bin)
title('Rsq')

subplot(4,2,3)
histogram(beta_dist_All,bin)
title('Beta AllCell')

subplot(4,2,4)
histogram(Rsq_dist_All,bin)
title('Rsq AllCell')

subplot(4,2,5)
histogram(beta_P1_dist,bin)
title('Beta(P1)')

subplot(4,2,6)
histogram(Rsq_P1_dist,bin)
title('Rsq(P1)')

subplot(4,2,7)
histogram(beta_P1_dist_All,bin)
title('Beta(P1) AllCell')

subplot(4,2,8)
histogram(Rsq_P1_dist_All,bin)
title('Rsq(P1) AllCell')

f3=figure;
sgtitle("Scatter plot of two variables.")
subplot(2,2,1)
scatter(beta_dist, Rsq_dist,10,'filled')
% line([0;1],[0.9;0.9], 'Color', 'black') % Threshold for y-axis
% line([0.2;0.2],[0;1], 'Color', 'black') % Threshold for x-axis
% xBox = [0.2,0.2,1,1,0.2];
% yBox = [0.9,1,1,0.9,0.9];
% patch(xBox, yBox, 'green', 'Edgecolor', 'none', 'FaceAlpha', 0.1);
title("Scatter: Beta-Rsq")
xlabel("Beta")
ylabel("Rsq")

subplot(2,2,2)
scatter(MaxZL_count, MaxZR_count,10,'filled')
% line([0;25],[13;13], 'Color', 'black') % Threshold for y-axis
% line([12.5;12.5],[0;25], 'Color', 'black') % Threshold for x-axis
% xBox = [12.5,12.5,25,25,12.5];
% yBox = [13,25,25,13,13];
% patch(xBox, yBox, 'green', 'Edgecolor', 'none', 'FaceAlpha', 0.1);
title("z-scored power Ltouch-Rtouch")
xlabel("Ltouch")
ylabel("Rtouch")

subplot(2,2,3)
scatter(MaxZL_count, MaxZ_count,10,'filled')
% line([0;25],[11.5;11.5], 'Color', 'black') % Threshold for y-axis
% line([12.5;12.5],[0;20], 'Color', 'black') % Threshold for x-axis
% xBox = [12.5,12.5,25,25,12.5];
% yBox = [11.5,20,20,11.5,11.5];
% patch(xBox, yBox, 'green', 'Edgecolor', 'none', 'FaceAlpha', 0.1);
title("z-scored power Ltouch-Lick")
xlabel("Ltouch")
ylabel("Lick")

subplot(2,2,4)
scatter(MaxZR_count, MaxZ_count,10,'filled')
% line([0;25],[11.5;11.5], 'Color', 'black') % Threshold for y-axis
% line([13;13],[0;20], 'Color', 'black') % Threshold for x-axis
% xBox = [13,13,25,25,13];
% yBox = [11.5,20,20,11.5,11.5];
% patch(xBox, yBox, 'green', 'Edgecolor', 'none', 'FaceAlpha', 0.1);
xlabel("Rtouch")
ylabel("Lick")
title("z-scored power Rtouch-Lick")



%%%%% Striatum
path=['/Volumes/KIOXIA/CheetahWRLV20200411'];
cd(path);
load('Zscore.mat')
bin = 50;

% MaxA1Rt_count=MaxA1Rt_count(find(MaxA1Rt_count));
% MaxZR_count=MaxZR_count(find(MaxZR_count));
% MaxA2Lt_count=MaxA2Lt_count(find(MaxA2Lt_count));
% MaxZL_count=MaxZL_count(find(MaxZL_count));
% MaxADon_count=MaxADon_count(find(MaxZL_count));
% MaxZ_count=MaxZ_count(find(MaxZ_count));
% ZFreq_Int_dist=ZFreq_Int_dist(find(ZFreq_Int_dist));
% ZFreq_Ph_dist=ZFreq_Ph_dist(find(ZFreq_Ph_dist));
% ZFreq_Int_dist_All=ZFreq_Int_dist_All(find(ZFreq_Int_dist_All));
% ZFreq_Ph_dist_All=ZFreq_Ph_dist_All(find(ZFreq_Ph_dist_All));
% 
% beta_dist=beta_dist(find(beta_dist));
% Rsq_dist=Rsq_dist(find(Rsq_dist));
% beta_P1_dist=beta_P1_dist(find(beta_P1_dist));
% Rsq_P1_dist=Rsq_P1_dist(find(Rsq_P1_dist)); 
% beta_dist_All=beta_dist_All(find(beta_dist_All)); 
% Rsq_dist_All=Rsq_dist_All(find(Rsq_dist_All)); 
% beta_P1_dist_All=beta_P1_dist_All(find(beta_P1_dist_All));
% Rsq_P1_dist_All=Rsq_P1_dist_All(find(Rsq_P1_dist_All));

f4 = figure;
sgtitle('Striatum Touch/Lick/rhythm')
subplot(5,2,1)
histogram(MaxA1Rt_count,bin)
title('Rt spectrum')

subplot(5,2,2)
histogram(MaxZR_count,bin)
title('Rt Zscore')

subplot(5,2,3)
histogram(MaxA2Lt_count,bin)
title('Lt spectrum')

subplot(5,2,4)
histogram(MaxZL_count,bin)
title('Lt Zscore')

subplot(5,2,5)
histogram(MaxADon_count,bin)
title('Lick spectrm')

subplot(5,2,6)
histogram(MaxZ_count,bin)
title('Lick Zscore')

subplot(5,2,7)
histogram(ZFreq_Int_dist,bin)
title('Interval Zscore')

subplot(5,2,8)
histogram(ZFreq_Ph_dist,bin)
title('Phase Zscore')

subplot(5,2,9)
histogram(ZFreq_Int_dist_All,bin)
title('Interval Zscore AllCell')

subplot(5,2,10)
histogram(ZFreq_Ph_dist_All,bin)
title('Phase Zscore AllCell')

f5 = figure;
sgtitle('Striatum Repeat')
subplot(4,2,1)
histogram(beta_dist,bin)
title('Beta')

subplot(4,2,2)
histogram(Rsq_dist,bin)
title('Rsq')

subplot(4,2,3)
histogram(beta_dist_All,bin)
title('Beta AllCell')

subplot(4,2,4)
histogram(Rsq_dist_All,bin)
title('Rsq AllCell')

subplot(4,2,5)
histogram(beta_P1_dist,bin)
title('Beta(P1)')

subplot(4,2,6)
histogram(Rsq_P1_dist,bin)
title('Rsq(P1)')

subplot(4,2,7)
histogram(beta_P1_dist_All,bin)
title('Beta(P1) AllCell')

subplot(4,2,8)
histogram(Rsq_P1_dist_All,bin)
title('Rsq(P1) AllCell')

f6=figure;
sgtitle("Scatter plot of two variables.")
subplot(2,2,1)
scatter(beta_dist, Rsq_dist,10,'filled')
line([0;1],[0.9;0.9], 'Color', 'black') % Threshold for y-axis
line([0.2;0.2],[0;1], 'Color', 'black') % Threshold for x-axis
% xBox = [0.2,0.2,1,1,0.2];
% yBox = [0.9,1,1,0.9,0.9];
% patch(xBox, yBox, 'green', 'Edgecolor', 'none', 'FaceAlpha', 0.1);
title("Scatter: Beta-Rsq")
xlabel("Beta")
ylabel("Rsq")

subplot(2,2,2)
scatter(MaxZL_count, MaxZR_count,10,'filled')
% line([0;25],[17;17], 'Color', 'black') % Threshold for y-axis
% line([17.5;17.5],[0;25], 'Color', 'black') % Threshold for x-axis
% xBox = [17.5,17.5,25,25,17.5];
% yBox = [17,25,25,17,17];
% patch(xBox, yBox, 'green', 'Edgecolor', 'none', 'FaceAlpha', 0.1);
title("z-scored power Ltouch-Rtouch")
xlabel("Ltouch")
ylabel("Rtouch")

subplot(2,2,3)
scatter(MaxZL_count, MaxZ_count,10,'filled')
% line([0;25],[11.5;11.5], 'Color', 'black') % Threshold for y-axis
% line([17.5;17.5],[0;20], 'Color', 'black') % Threshold for x-axis
% xBox = [17.5,17.5,25,25,17.5];
% yBox = [11.5,20,20,11.5,11.5];
% patch(xBox, yBox, 'green', 'Edgecolor', 'none', 'FaceAlpha', 0.1);
title("z-scored power Ltouch-Lick")
xlabel("Ltouch")
ylabel("Lick")

subplot(2,2,4)
scatter(MaxZR_count, MaxZ_count,10,'filled')
% line([0;25],[11.5;11.5], 'Color', 'black') % Threshold for y-axis
% line([17;17],[0;20], 'Color', 'black') % Threshold for x-axis
% xBox = [17,17,25,25,17];
% yBox = [11.5,20,20,11.5,11.5];
% patch(xBox, yBox, 'green', 'Edgecolor', 'none', 'FaceAlpha', 0.1);
xlabel("Rtouch")
ylabel("Lick")
title("z-scored power Rtouch-Lick")
