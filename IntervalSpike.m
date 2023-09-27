function IntervalSpike
clear all
global StartTime FinishTime 
cd C:\Users\B133_2\Desktop\2601_170620
load 2601_170620
StartTime 
FinishTime 

dpath='C:\Users\B133_2\Desktop\CheetahData\2017-6-20_21-17-32 2601-11'
cd(dpath);
SpikeArray=GetSpikeAll(dpath,'Sc7_SS_01.t');
SpikeArray
RpegTouchall