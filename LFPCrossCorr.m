function [LFParray LFP_aligned]=LFPCrossCorr(LFPsamples_RunCC,CCselect,GaussSmooth,MovW,Direction,TimestampArray,duration)
%MATLABフォルダにNlx2MatCSC.mexw32とNlx2MatCSC.mexw64を入れておく。たぶんどちらか片方でよい。
%timestampsは270336ずつ増加。270msと思われる。timestampsの数ｘ512個のサンプル。
%270336/512=528. サンプリングは0.528msごと。fs=10^6/528
global OneTurnTime

Align_Base=CCselect;
% Spike_Array=(ts_spike-SpikeStartTime)*1000+StartTime;
% Spike_Array=Spike_Array(StartTime<Spike_Array&Spike_Array<FinishTime);
% Align_Base=Spike_Array;T='Spike_Array';
% LFP_aligned=zeros(length(Align_Base)-1,ceil((OneTurnTime*1000/2)/528)*2+1);d
AlignmentLength=length(Align_Base)
format short;
ValidIndex=0;

% duration=(OneTurnTime*1000)/528;

while Align_Base(end)*1000>TimestampArray(end)
    Align_Base(end)=[];
end
% LFP_aligned=[];
% LFP_aligned=zeros(Align_Base,ceil(duration/2)*2)

if Direction==1 %片方向
    LFP_aligned=zeros(Align_Base,ceil(duration));
    for n=1:length(Align_Base)
%        A=min(TimestampArray(TimestampArray>Align_Base(n).*1000));
       Index=find(TimestampArray==min(TimestampArray(TimestampArray>Align_Base(n).*1000)));
       if Index>0&&Index+ceil(duration)<length(LFPsamples_RunCC)
%           ValidIndex=[ValidIndex n];
          ValidIndex=ValidIndex+1;
%           x=LFPsamples_RunCC(Index-ceil((OneTurnTime*1000/2)/528):Index+ceil((OneTurnTime*1000/2)/528));
          LFP_aligned(length(ValidIndex),:)=LFPsamples_RunCC(Index:Index+ceil(duration)-1);
       end
    end
else
    LFP_aligned=zeros(length(Align_Base),ceil(duration/2)*2);
    for n=1:length(Align_Base)
%        A=min(TimestampArray(TimestampArray>Align_Base(n).*1000));
       Index=find(TimestampArray==min(TimestampArray(TimestampArray>Align_Base(n).*1000)));
       if Index-ceil(duration/2)>0&&Index+ceil(duration/2)<length(LFPsamples_RunCC)
%           ValidIndex=[ValidIndex n];
          ValidIndex=ValidIndex+1;
%           x=LFPsamples_RunCC(Index-ceil((OneTurnTime*1000/2)/528):Index+ceil((OneTurnTime*1000/2)/528));
          LFP_aligned(ValidIndex,:)=LFPsamples_RunCC(Index-ceil(duration/2)+1:Index+ceil(duration/2));
       end
    end
end

AlignBase01=zeros(1,length(TimestampArray));
AlignBase01(Align_Base)=1;




LFP_aligned=LFP_aligned(1:ValidIndex,:);
LFParray=mean(LFP_aligned,1);

if MovW~=0;LFParray=MovWindow(LFParray,MovW);
elseif GaussSmooth==1;LFParray=instantArray(LFParray,20);
end

% if isnan(LFPRef)==0
%     Rname=['-',LFPRef(length(LFPRef)-10:length(LFPRef)-4)];
% else Rname=nan;
% end