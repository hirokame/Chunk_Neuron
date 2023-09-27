function response_check

global CCresultDrinkOn MaxZ CCresultLtouchWon MaxZL MaxDrinkZL AmpLt CCresultRtouchWon MaxZR MaxDrinkZR AmpRt fname TrimStr dpath...
    CCresultRtouchWon2 CCresultLtouchWon2

CCRt = CCresultRtouchWon(251:750);
CCLt = CCresultLtouchWon(251:750);

CCRt2 = CCresultRtouchWon2(251:750);
CCLt2 = CCresultLtouchWon2(251:750);

cd(dpath)
if ~exist('Response', 'dir')
    mkdir('Response')
end
path = [dpath 'Response\'];
Figure = figure();

% x = linspace(-1,1,500);
% subplot(3,2,5)
% plot(x,CCresultDrinkOn)
% text = ['MaxZ=' num2str(MaxZ)];
% title(text)

x=linspace(-2.5, 2.5, 500);
subplot(3,2,1)
plot(x,CCLt2)
text = ['MaxZL=' num2str(MaxZL) 'MaxDrinkZL=' num2str(MaxDrinkZL)];
title(text)
xlim([-2.5,2.5])
ylim([0, inf])

subplot(3,2,2)
plot(x,CCRt2)
text = ['MaxZR=' num2str(MaxZR) 'MaxDrinkZR=' num2str(MaxDrinkZR)];
title(text)
xlim([-2.5,2.5])
ylim([0, inf])

x=linspace(1,12,120);
subplot(3,2,3)
plot(x,AmpLt(1:120))
subplot(3,2,4)
plot(x,AmpRt(1:120))

x=linspace(-2.5, 2.5, 500);
subplot(3,2,5)
plot(x,CCLt)
xlim([-2.5,2.5])
subplot(3,2,6)
plot(x,CCRt)
xlim([-2.5,2.5])

% x=linspace(-2.5, 2.5, 500);
% subplot(3,2,5)
% plot(x,CCLt2)
% xlim([-2.5,2.5])
% ylim([0,0.07])
% 
% subplot(3,2,6)
% plot(x,CCRt2)
% xlim([-2.5,2.5])
% ylim([0,0.07])

filename = [path fname(1:end-4),' ',TrimStr(1:end-1),'respopnse.bmp'];
saveas(Figure, filename)
close all hidden