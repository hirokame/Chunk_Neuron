function Heatmap

cd('C:\Users\C238\CheetahWRLV20220213\Heatmap')

for i=1:117;
    file = [num2str(i) 'heatmap.mat'];
    data = load(file);
    R_gt4 = data.RtPositiveFiringRateArray_gt4;
    L_gt4 = data.LtPositiveFiringRateArray_gt4;
    R_lt3 = data.RtPositiveFiringRateArray_lt3;
    L_lt3 = data.LtPositiveFiringRateArray_lt3;
    R_devide = data.RtPositiveFiringRateArray_devide;
    L_devide = data.LtPositiveFiringRateArray_devide;
    
    filename = ['value\' num2str(i) 'R_gt4'];
    csvwrite(filename, R_gt4)
    filename = ['value\' num2str(i) 'L_gt4'];
    csvwrite(filename, L_gt4)
    filename = ['value\' num2str(i) 'R_lt3'];
    csvwrite(filename, R_lt3)
    filename = ['value\' num2str(i) 'L_lt3'];
    csvwrite(filename, L_lt3)
    filename = ['value\' num2str(i) 'R_devide'];
    csvwrite(filename, R_devide)
    filename = ['value\' num2str(i) 'L_devide'];
    csvwrite(filename, L_devide)
%     h=HeatMap(R_gt4);
%     h.Colormap = 'jet';
%     h.plot
%     axis off
%     figname = [num2str(i) 'R_gt4.bmp'];
%     saveas(gcf, figname)
%     
%     Heatmap(L_gt4)
%     h.plot
%     axis off
%     figname = [num2str(i) 'L_gt4.bmp'];
%     saveas(gcf, figname)
%     
%     
%     Heatmap(R_lt3)
%     h.plot
%     axis off
%     figname = [num2str(i) 'R_lt3.bmp'];
%     saveas(gcf, figname)
%     
%     Heatmap(L_lt3)
%     h.plot
%     axis off
%     figname = [num2str(i) 'L_lt3.bmp'];
%     saveas(gcf, figname)
%     
%     Heatmap(R_devide)
%     h.plot
%     axis off
%     figname = [num2str(i) 'R_devide.bmp'];
%     saveas(gcf, figname)
% 
%     Heatmap(L_devide)
%     h.plot
%     axis off
%     figname = [num2str(i) 'L_devide.bmp'];
%     saveas(gcf, figname)
end