function [WalkTimeAll]=File_search_WaterApproach
global h h2 dpath dpath2 dname

global h dpath dpath2 

dpath=uigetdir;
cd(dpath);
h2=ls;

WalkTimeAll=cell(1);M=0;
for n=1:length(h2(:,1))
    fname=strtrim(h2(n,:));
        if ~isdir(fname(1,:)) && ~strcmp(fname,'.') && ~strcmp(fname,'..') %if strcmp(fname(end-3:end),.mat)
%             dpath3=strcat(dpath2,'\',fname);
%             cd(dpath3);
%             h3=ls;
%             FileNum2=0;
%             for m=1:length(h3(:,1))
%                 Fname=strtrim(h2(n,:));
                if ~isdir(fname) && ~strcmp(fname,'.') && ~strcmp(fname,'..')

                    if ~strcmp(fname(1,end-4),'V') && strcmp(fname(1,end-2:end),'mat')
                        %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%                         FileNum2=FileNum2+1;
                        fname
                        M=M+1;
                        data=load([dpath '\' fname],'-ascii');
                        WaterOnTime=data(:,7);
                        WaterOnTime(WaterOnTime==0)=[];
                        DrinkOnArray=data(:,27);
                        DrinkOnArray(DrinkOnArray==0)=[];


                        WalkTimeAll(M)=WaterApproach(WaterOnTime,DrinkOnArray);
                        %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
                    end
                end
%             end
        end
end
% SaveName=strcat(dpath(1,end-5:end),'_',dname(1,:));
cd(dpath);%1Ç¬è„ÇÃÉtÉHÉãÉ_Ç…ï€ë∂




function WalkTime=WaterApproach(WaterOnTime,DrinkOnArray)

% dpath='C:\Users\B133_2\Desktop\2017D1RcKD\DrinkTest\170626\';
% fname='8101_170626.mat';
% data=load([dpath fname],'-ascii');

% WaterOnTime=data(:,7);
% WaterOnTime(WaterOnTime==0)=[];
% 
WaterOnTimeFirst=zeros(1,length(WaterOnTime));
WaterOnTimeFirst(1)=WaterOnTime(1);
for n=2:length(WaterOnTime)
    if WaterOnTime(n)-WaterOnTime(n-1)<10000
        WaterOnTimeFirst(n)=0;
    else
        WaterOnTimeFirst(n)=WaterOnTime(n);
    end
end
WaterOnTimeFirst(WaterOnTimeFirst==0)=[];

% DrinkOnArray=data(:,27);
% DrinkOnArray(DrinkOnArray==0)=[];

WalkTime=zeros(1,length(WaterOnTimeFirst));
for n=1:length(WaterOnTimeFirst)
    Drink=DrinkOnArray;
    Drink(Drink<WaterOnTimeFirst(n))=[];
    WalkTime(n)=Drink(1)-WaterOnTimeFirst(n);
end
% WalkTime



