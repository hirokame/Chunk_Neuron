function NosePokeDrinkAnalysis
close all
cd('C:\Users\B133_2\Desktop\NosePokeData');

for N=2:7
    
% FileName='101_180119'
% FileName=[int2str(N),'01_180119'];
FileName=[int2str(N),'_180406'];

eval(['load ',FileName,'.mat -ascii;']);
eval(['data=X',FileName,';']);

StartTime=data(1,2);
StopTime=data(1,3);

NosePokeTime=data(:,7);
NosePokeTime(NosePokeTime==0)=[];

DrinkTime=data(:,15);
DrinkTime(DrinkTime==0)=[];

% DrinkTime2=data(:,14);
% DrinkTime2(DrinkTime2==0)=[];

TaskDuration=StopTime-StartTime;
NosePokeTime=NosePokeTime-StartTime;
DrinkTime=DrinkTime-StartTime;

for n=1:length(NosePokeTime)
    NextDrink=DrinkTime-NosePokeTime(n);
    NextDrink(NextDrink<0)=[];
%     NextDrink
%     n
    if ~isempty(NextDrink)
        Delay(n)=min(NextDrink);
    end
end
FirstDrinkTime(N)=NosePokeTime(1);
figure
plot(NosePokeTime,1:length(NosePokeTime));title([FileName,', NosePokeTime']);
figure
plot(1:length(Delay),Delay);title([FileName,', Delay']);
% data(end,:)
end
FirstDrinkTime

figure
bar([FirstDrinkTime(2:4),0,FirstDrinkTime(5:7)]);


