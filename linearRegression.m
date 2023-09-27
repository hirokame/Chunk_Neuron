function linearRegression
global SpikeArray SpikeArrayWon DrinkOnArray FirstWaterOn FirstWaterOff WaterOnArrayOriginal...
       WaterOffArrayOriginal RpegTouchallWon LpegTouchallWon RpegTimeArray LpegTimeArray
   
 tbl=table(SpikeArray,DrinkOnArray,RpegTouchallWon,LpegTouchallWon,RpegTimeArray,LpegTimeArray);
 lm=fitlm(tbl,'SpikeArray~DrinkOnArray+RpegTouchallWon+LpegTouchallWon+RpegTimeArray+LpegTimeArray');