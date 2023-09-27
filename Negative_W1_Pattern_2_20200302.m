function Negative_W1_Pattern_2_20200302

path=['C:\Users\C238\Desktop\touchcellLtRt_terashita'];
cd(path);

LS=ls;
LtWFRUnitN4=[]; LtWFRUnitN3=[]; LtWFRUnitN2=[]; LtWFRUnitN1=[]; LtWFRUnitN0=[];
RtWFRUnitN4=[]; RtWFRUnitN3=[]; RtWFRUnitN2=[];  RtWFRUnitN1=[]; RtWFRUnitN0=[];  
LtW1PointN4=0; LtW1PointN3=0; LtW1PointN2=0; LtW1PointN1=0; LtW1PointN0=0;
LtW1FireN4=0; LtW1FireN3=0; LtW1FireN2=0; LtW1FireN1=0; LtW1FireN0=0; 
LtW2PointN4=0; LtW2PointN3=0; LtW2PointN2=0; LtW2PointN1=0; LtW2PointN0=0;
LtW2FireN4=0; LtW2FireN3=0; LtW2FireN2=0; LtW2FireN1=0; LtW2FireN0=0;
LtW3PointN4=0; LtW3PointN3=0; LtW3PointN2=0; LtW3PointN1=0; LtW3PointN0=0;
LtW3FireN4=0; LtW3FireN3=0; LtW3FireN2=0; LtW3FireN1=0; LtW3FireN0=0;
LtW4PointN4=0; LtW4PointN3=0; LtW4PointN2=0; LtW4PointN1=0; LtW4PointN0=0;
LtW4FireN4=0; LtW4FireN3=0; LtW4FireN2=0; LtW4FireN1=0; LtW4FireN0=0;
LtW5PointN4=0; LtW5PointN3=0; LtW5PointN2=0; LtW5PointN1=0; LtW5PointN0=0;
LtW5FireN4=0; LtW5FireN3=0; LtW5FireN2=0; LtW5FireN1=0; LtW5FireN0=0;

RtW1PointN4=0; RtW1PointN3=0; RtW1PointN2=0; RtW1PointN1=0; RtW1PointN0=0; 
RtW1FireN4=0; RtW1FireN3=0; RtW1FireN2=0; RtW1FireN1=0; RtW1FireN0=0; 
RtW2PointN4=0; RtW2PointN3=0; RtW2PointN2=0; RtW2PointN1=0; RtW2PointN0=0;
RtW2FireN4=0; RtW2FireN3=0; RtW2FireN2=0; RtW2FireN1=0; RtW2FireN0=0;
RtW3PointN4=0; RtW3PointN3=0; RtW3PointN2=0; RtW3PointN1=0; RtW3PointN0=0;
RtW3FireN4=0; RtW3FireN3=0; RtW3FireN2=0; RtW3FireN1=0; RtW3FireN0=0;
RtW4PointN4=0; RtW4PointN3=0; RtW4PointN2=0; RtW4PointN1=0; RtW4PointN0=0;
RtW4FireN4=0; RtW4FireN3=0; RtW4FireN2=0; RtW4FireN1=0; RtW4FireN0=0;
RtW5PointN4=0; RtW5PointN3=0; RtW5PointN2=0; RtW5PointN1=0; RtW5PointN0=0;
RtW5FireN4=0; RtW5FireN3=0; RtW5FireN2=0; RtW5FireN1=0; RtW5FireN0=0;

for i=1:length(LS(:,1))
    TrimFolder=strtrim(LS(i,:));
    if ~strcmp(TrimFolder,'.') && ~strcmp(TrimFolder,'..') && isempty(strfind(TrimFolder,'.mat')) && isempty(strfind(TrimFolder,'.bmp'));
       CdFolder=[path,'\',TrimFolder];
       cd(CdFolder);
       LS1=ls;
       for j=1:length(LS1(:,1))
           TrimFolder2=strtrim(LS1(j,:));
           if length(TrimFolder2)>22 && strcmp(TrimFolder2(end-21:end),'SpikeOnOffRtLtUnit.mat');
               load(TrimFolder2);
               LtouchUnit=[LtouchSpikeOnUnit;[zeros(length(LtouchSpikeOffUnit(:,1)),1) LtouchSpikeOffUnit]]; %%%% SpikeOffUnitÇÃëOóÒÇ…î≠âŒêîóÒÇí«â¡ÇµÇƒSpikeOnUnitÇ∆òAåãÅBSpikeOfféûÇÃî≠âŒêîÇÉ[ÉçÇ…ê›íË
%                LtouchUnitPositive= LtouchUnit(:,[1:6]);                                         
               RtouchUnit=[RtouchSpikeOnUnit;[zeros(length(RtouchSpikeOffUnit(:,1)),1) RtouchSpikeOffUnit]];
%                RtouchUnitPositive= RtouchUnit(:,[1:6]);
              
               
               %Ltouch
               for x=1:length(LtouchUnit(:,1));
                   IndexNegativeNum=find( LtouchUnit(x,[7:10])==-1);
                   
                   %%%%NegativeÇ…4Ç¬
                   if length(IndexNegativeNum)==4;
                   if LtouchUnit(x,[2:6])==[1,0,0,0,0];
                      LtW1PointN4=LtW1PointN4+1;
                      LtW1FireN4=LtW1FireN4+LtouchUnit(x,1);
                   end
                   
                    if LtouchUnit(x,[2:6])==[0,1,0,0,0];
                      LtW2PointN4=LtW2PointN4+1;
                      LtW2FireN4=LtW2FireN4+LtouchUnit(x,1);
                    end
                   
                   if LtouchUnit(x,[2:6])==[0,0,1,0,0];
                      LtW3PointN4=LtW3PointN4+1;
                      LtW3FireN4=LtW3FireN4+LtouchUnit(x,1);
                   end
                   
                    if LtouchUnit(x,[2:6])==[0,0,0,1,0];
                      LtW4PointN4=LtW4PointN4+1;
                      LtW4FireN4=LtW4FireN4+LtouchUnit(x,1);
                    end
                   if LtouchUnit(x,[2:6])==[0,0,0,0,1];
                      LtW5PointN4=LtW5PointN4+1;
                      LtW5FireN4=LtW5FireN4+LtouchUnit(x,1);
                   end
                   end
                   
                   %%%%%%NegativeÇ…ÇRÇ¬
                   if length(IndexNegativeNum)==3;
                   if LtouchUnit(x,[2:6])==[1,0,0,0,0];
                      LtW1PointN3=LtW1PointN3+1;
                      LtW1FireN3=LtW1FireN3+LtouchUnit(x,1);
                   end
                   
                    if LtouchUnit(x,[2:6])==[0,1,0,0,0];
                      LtW2PointN3=LtW2PointN3+1;
                      LtW2FireN3=LtW2FireN3+LtouchUnit(x,1);
                    end
                   
                   if LtouchUnit(x,[2:6])==[0,0,1,0,0];
                      LtW3PointN3=LtW3PointN3+1;
                      LtW3FireN3=LtW3FireN3+LtouchUnit(x,1);
                   end
                   
                    if LtouchUnit(x,[2:6])==[0,0,0,1,0];
                      LtW4PointN3=LtW4PointN3+1;
                      LtW4FireN3=LtW4FireN3+LtouchUnit(x,1);
                    end
                   if LtouchUnit(x,[2:6])==[0,0,0,0,1];
                      LtW5PointN3=LtW5PointN3+1;
                      LtW5FireN3=LtW5FireN3+LtouchUnit(x,1);
                   end
                   end
                   
                   %%%%%%NegativeÇ…2Ç¬
                   if length(IndexNegativeNum)==2;
                   if LtouchUnit(x,[2:6])==[1,0,0,0,0];
                      LtW1PointN2=LtW1PointN2+1;
                      LtW1FireN2=LtW1FireN2+LtouchUnit(x,1);
                   end
                   
                    if LtouchUnit(x,[2:6])==[0,1,0,0,0];
                      LtW2PointN2=LtW2PointN2+1;
                      LtW2FireN2=LtW2FireN2+LtouchUnit(x,1);
                    end
                   
                   if LtouchUnit(x,[2:6])==[0,0,1,0,0];
                      LtW3PointN2=LtW3PointN2+1;
                      LtW3FireN2=LtW3FireN2+LtouchUnit(x,1);
                   end
                   
                    if LtouchUnit(x,[2:6])==[0,0,0,1,0];
                      LtW4PointN2=LtW4PointN2+1;
                      LtW4FireN2=LtW4FireN2+LtouchUnit(x,1);
                    end
                   if LtouchUnit(x,[2:6])==[0,0,0,0,1];
                      LtW5PointN2=LtW5PointN2+1;
                      LtW5FireN2=LtW5FireN2+LtouchUnit(x,1);
                   end
                   end
                   
                  %%%%%%%NegativeÇ…ÇPÇ¬
                  if length(IndexNegativeNum)==1;
                   if LtouchUnit(x,[2:6])==[1,0,0,0,0];
                      LtW1PointN1=LtW1PointN1+1;
                      LtW1FireN1=LtW1FireN1+LtouchUnit(x,1);
                   end
                   
                    if LtouchUnit(x,[2:6])==[0,1,0,0,0];
                      LtW2PointN1=LtW2PointN1+1;
                      LtW2FireN1=LtW2FireN1+LtouchUnit(x,1);
                    end
                   
                   if LtouchUnit(x,[2:6])==[0,0,1,0,0];
                      LtW3PointN1=LtW3PointN1+1;
                      LtW3FireN1=LtW3FireN1+LtouchUnit(x,1);
                   end
                   
                    if LtouchUnit(x,[2:6])==[0,0,0,1,0];
                      LtW4PointN1=LtW4PointN1+1;
                      LtW4FireN1=LtW4FireN1+LtouchUnit(x,1);
                    end
                   if LtouchUnit(x,[2:6])==[0,0,0,0,1];
                      LtW5PointN1=LtW5PointN1+1;
                      LtW5FireN1=LtW5FireN1+LtouchUnit(x,1);
                   end
                  end
                   
                  %%%%%NegativeÇ…ÇOÇ¬
                  if length(IndexNegativeNum)==0;
                   if LtouchUnit(x,[2:6])==[1,0,0,0,0];
                      LtW1PointN0=LtW1PointN0+1;
                      LtW1FireN0=LtW1FireN0+LtouchUnit(x,1);
                   end
                   
                    if LtouchUnit(x,[2:6])==[0,1,0,0,0];
                      LtW2PointN0=LtW2PointN0+1;
                      LtW2FireN0=LtW2FireN0+LtouchUnit(x,1);
                    end
                   
                   if LtouchUnit(x,[2:6])==[0,0,1,0,0];
                      LtW3PointN0=LtW3PointN0+1;
                      LtW3FireN0=LtW3FireN0+LtouchUnit(x,1);
                   end
                   
                    if LtouchUnit(x,[2:6])==[0,0,0,1,0];
                      LtW4PointN0=LtW4PointN0+1;
                      LtW4FireN0=LtW4FireN0+LtouchUnit(x,1);
                    end
                   if LtouchUnit(x,[2:6])==[0,0,0,0,1];
                      LtW5PointN0=LtW5PointN0+1;
                      LtW5FireN0=LtW5FireN0+LtouchUnit(x,1);
                   end
                   end
               end
               
               LtWFRN4=[LtW1FireN4/(LtW1PointN4*10),LtW2FireN4/(LtW2PointN4*10),LtW3FireN4/(LtW3PointN4*10),LtW4FireN4/(LtW4PointN4*10),LtW5FireN4/(LtW5PointN4*10)];
               LtWFRN3=[LtW1FireN3/(LtW1PointN3*10),LtW2FireN3/(LtW2PointN3*10),LtW3FireN3/(LtW3PointN3*10),LtW4FireN3/(LtW4PointN3*10),LtW5FireN3/(LtW5PointN3*10)];
               LtWFRN2=[LtW1FireN2/(LtW1PointN2*10),LtW2FireN2/(LtW2PointN2*10),LtW3FireN2/(LtW3PointN2*10),LtW4FireN2/(LtW4PointN2*10),LtW5FireN2/(LtW5PointN2*10)];
               LtWFRN1=[LtW1FireN1/(LtW1PointN1*10),LtW2FireN1/(LtW2PointN1*10),LtW3FireN1/(LtW3PointN1*10),LtW4FireN1/(LtW4PointN1*10),LtW5FireN1/(LtW5PointN1*10)];
               LtWFRN0=[LtW1FireN0/(LtW1PointN0*10),LtW2FireN0/(LtW2PointN0*10),LtW3FireN0/(LtW3PointN0*10),LtW4FireN0/(LtW4PointN0*10),LtW5FireN0/(LtW5PointN0*10)];
               
               %Rtouch
                for x=1:length(RtouchUnit(:,1));
                   IndexNegativeNum=find( RtouchUnit(x,[7:10])==-1);
                   
                   %%%%NegativeÇ…4Ç¬
                   if length(IndexNegativeNum)==4;
                   if RtouchUnit(x,[2:6])==[1,0,0,0,0];
                      RtW1PointN4=RtW1PointN4+1;
                      RtW1FireN4=RtW1FireN4+RtouchUnit(x,1);
                   end
                   
                    if RtouchUnit(x,[2:6])==[0,1,0,0,0];
                      RtW2PointN4=RtW2PointN4+1;
                      RtW2FireN4=RtW2FireN4+RtouchUnit(x,1);
                    end
                   
                   if RtouchUnit(x,[2:6])==[0,0,1,0,0];
                      RtW3PointN4=RtW3PointN4+1;
                      RtW3FireN4=RtW3FireN4+RtouchUnit(x,1);
                   end
                   
                    if RtouchUnit(x,[2:6])==[0,0,0,1,0];
                      RtW4PointN4=RtW4PointN4+1;
                      RtW4FireN4=RtW4FireN4+RtouchUnit(x,1);
                    end
                   if RtouchUnit(x,[2:6])==[0,0,0,0,1];
                      RtW5PointN4=RtW5PointN4+1;
                      RtW5FireN4=RtW5FireN4+RtouchUnit(x,1);
                   end
                   end
                   
                   %%%%%%NegativeÇ…ÇRÇ¬
                   if length(IndexNegativeNum)==3;
                   if RtouchUnit(x,[2:6])==[1,0,0,0,0];
                      RtW1PointN3=RtW1PointN3+1;
                      RtW1FireN3=RtW1FireN3+RtouchUnit(x,1);
                   end
                   
                    if RtouchUnit(x,[2:6])==[0,1,0,0,0];
                      RtW2PointN3=RtW2PointN3+1;
                      RtW2FireN3=RtW2FireN3+RtouchUnit(x,1);
                    end
                   
                   if RtouchUnit(x,[2:6])==[0,0,1,0,0];
                      RtW3PointN3=RtW3PointN3+1;
                      RtW3FireN3=RtW3FireN3+RtouchUnit(x,1);
                   end
                   
                    if RtouchUnit(x,[2:6])==[0,0,0,1,0];
                      RtW4PointN3=RtW4PointN3+1;
                      RtW4FireN3=RtW4FireN3+RtouchUnit(x,1);
                    end
                   if RtouchUnit(x,[2:6])==[0,0,0,0,1];
                      RtW5PointN3=RtW5PointN3+1;
                      RtW5FireN3=RtW5FireN3+RtouchUnit(x,1);
                   end
                   end
                   
                   %%%%%%NegativeÇ…2Ç¬
                   if length(IndexNegativeNum)==2;
                   if RtouchUnit(x,[2:6])==[1,0,0,0,0];
                      RtW1PointN2=RtW1PointN2+1;
                      RtW1FireN2=RtW1FireN2+RtouchUnit(x,1);
                   end
                   
                    if RtouchUnit(x,[2:6])==[0,1,0,0,0];
                      RtW2PointN2=RtW2PointN2+1;
                      RtW2FireN2=RtW2FireN2+RtouchUnit(x,1);
                    end
                   
                   if RtouchUnit(x,[2:6])==[0,0,1,0,0];
                      RtW3PointN2=RtW3PointN2+1;
                      RtW3FireN2=RtW3FireN2+RtouchUnit(x,1);
                   end
                   
                    if RtouchUnit(x,[2:6])==[0,0,0,1,0];
                      RtW4PointN2=RtW4PointN2+1;
                      RtW4FireN2=RtW4FireN2+RtouchUnit(x,1);
                    end
                   if RtouchUnit(x,[2:6])==[0,0,0,0,1];
                      RtW5PointN2=RtW5PointN2+1;
                      RtW5FireN2=RtW5FireN2+RtouchUnit(x,1);
                   end
                   end
                   
                  %%%%%%%NegativeÇ…ÇPÇ¬
                  if length(IndexNegativeNum)==1;
                   if RtouchUnit(x,[2:6])==[1,0,0,0,0];
                      RtW1PointN1=RtW1PointN1+1;
                      RtW1FireN1=RtW1FireN1+RtouchUnit(x,1);
                   end
                   
                    if RtouchUnit(x,[2:6])==[0,1,0,0,0];
                      RtW2PointN1=RtW2PointN1+1;
                      RtW2FireN1=RtW2FireN1+RtouchUnit(x,1);
                    end
                   
                   if RtouchUnit(x,[2:6])==[0,0,1,0,0];
                      RtW3PointN1=RtW3PointN1+1;
                      RtW3FireN1=RtW3FireN1+RtouchUnit(x,1);
                   end
                   
                    if RtouchUnit(x,[2:6])==[0,0,0,1,0];
                      RtW4PointN1=RtW4PointN1+1;
                      RtW4FireN1=RtW4FireN1+RtouchUnit(x,1);
                    end
                   if RtouchUnit(x,[2:6])==[0,0,0,0,1];
                      RtW5PointN1=RtW5PointN1+1;
                      RtW5FireN1=RtW5FireN1+RtouchUnit(x,1);
                   end
                  end
                   
                  %%%%%NegativeÇ…ÇOÇ¬
                  if length(IndexNegativeNum)==0;
                   if RtouchUnit(x,[2:6])==[1,0,0,0,0];
                      RtW1PointN0=RtW1PointN0+1;
                      RtW1FireN0=RtW1FireN0+RtouchUnit(x,1);
                   end
                   
                    if RtouchUnit(x,[2:6])==[0,1,0,0,0];
                      RtW2PointN0=RtW2PointN0+1;
                      RtW2FireN0=RtW2FireN0+RtouchUnit(x,1);
                    end
                   
                   if RtouchUnit(x,[2:6])==[0,0,1,0,0];
                      RtW3PointN0=RtW3PointN0+1;
                      RtW3FireN0=RtW3FireN0+RtouchUnit(x,1);
                   end
                   
                    if RtouchUnit(x,[2:6])==[0,0,0,1,0];
                      RtW4PointN0=RtW4PointN0+1;
                      RtW4FireN0=RtW4FireN0+RtouchUnit(x,1);
                    end
                   if RtouchUnit(x,[2:6])==[0,0,0,0,1];
                      RtW5PointN0=RtW5PointN0+1;
                      RtW5FireN0=RtW5FireN0+RtouchUnit(x,1);
                   end
                   end
               end
               
               RtWFRN4=[RtW1FireN4/(LtW1PointN4*10),RtW2FireN4/(RtW2PointN4*10),RtW3FireN4/(RtW3PointN4*10),RtW4FireN4/(RtW4PointN4*10),RtW5FireN4/(RtW5PointN4*10)];
               RtWFRN3=[RtW1FireN3/(RtW1PointN3*10),RtW2FireN3/(RtW2PointN3*10),RtW3FireN3/(RtW3PointN3*10),RtW4FireN3/(RtW4PointN3*10),RtW5FireN3/(RtW5PointN3*10)];
               RtWFRN2=[RtW1FireN2/(RtW1PointN2*10),RtW2FireN2/(RtW2PointN2*10),RtW3FireN2/(RtW3PointN2*10),RtW4FireN2/(RtW4PointN2*10),RtW5FireN2/(RtW5PointN2*10)];
               RtWFRN1=[RtW1FireN1/(RtW1PointN1*10),RtW2FireN1/(LtW2PointN1*10),RtW3FireN1/(RtW3PointN1*10),RtW4FireN1/(LtW4PointN1*10),RtW5FireN1/(RtW5PointN1*10)];
               RtWFRN0=[RtW1FireN0/(RtW1PointN0*10),RtW2FireN0/(RtW2PointN0*10),RtW3FireN0/(LtW3PointN0*10),RtW4FireN0/(RtW4PointN0*10),RtW5FireN0/(RtW5PointN0*10)];
               
               
               
                LtWFRUnitN4=[LtWFRUnitN4;LtWFRN4]; LtWFRUnitN3=[LtWFRUnitN3;LtWFRN3]; LtWFRUnitN2=[LtWFRUnitN2;LtWFRN2]; LtWFRUnitN1=[LtWFRUnitN1;LtWFRN1]; LtWFRUnitN0=[LtWFRUnitN0;LtWFRN0];
                RtWFRUnitN4=[RtWFRUnitN4;RtWFRN4]; RtWFRUnitN3=[RtWFRUnitN3;RtWFRN3]; RtWFRUnitN2=[RtWFRUnitN2;RtWFRN2]; RtWFRUnitN1=[RtWFRUnitN1;RtWFRN1]; RtWFRUnitN0=[RtWFRUnitN0;RtWFRN0];
           end
           
           
       end
    end
end

%%%% N4
MeanLtWFRUnitN4=[];
StdLtWFRUnitN4=[];
for i=1:length(LtWFRUnitN4(1,:))
    MeanLtWFRUnitN4=[MeanLtWFRUnitN4 nanmean(LtWFRUnitN4(:,i))];
    StdLtWFRUnitN4=[StdLtWFRUnitN4 nanstd(LtWFRUnitN4(:,i))];
end

MeanRtWFRUnitN4=[];
StdRtWFRUnitN4=[];
for i=1:length(RtWFRUnitN4(1,:))
    MeanRtWFRUnitN4=[MeanRtWFRUnitN4 nanmean(RtWFRUnitN4(:,i))];
    StdRtWFRUnitN4=[StdRtWFRUnitN4 nanstd(RtWFRUnitN4(:,i))];
end



%%%N3
MeanLtWFRUnitN3=[];
StdLtWFRUnitN3=[];
for i=1:length(LtWFRUnitN3(1,:))
    MeanLtWFRUnitN3=[MeanLtWFRUnitN3 nanmean(LtWFRUnitN3(:,i))];
    StdLtWFRUnitN3=[StdLtWFRUnitN3 nanstd(LtWFRUnitN3(:,i))];
end

MeanRtWFRUnitN3=[];
StdRtWFRUnitN3=[];
for i=1:length(RtWFRUnitN3(1,:))
    MeanRtWFRUnitN3=[MeanRtWFRUnitN3 nanmean(RtWFRUnitN3(:,i))];
    StdRtWFRUnitN3=[StdRtWFRUnitN3 nanstd(RtWFRUnitN3(:,i))];
end


%%%%%N2
MeanLtWFRUnitN2=[];
StdLtWFRUnitN2=[];
for i=1:length(LtWFRUnitN2(1,:))
    MeanLtWFRUnitN2=[MeanLtWFRUnitN2 nanmean(LtWFRUnitN2(:,i))];
    StdLtWFRUnitN2=[StdLtWFRUnitN2 nanstd(LtWFRUnitN2(:,i))];
end

MeanRtWFRUnitN2=[];
StdRtWFRUnitN2=[];
for i=1:length(RtWFRUnitN2(1,:))
    MeanRtWFRUnitN2=[MeanRtWFRUnitN2 nanmean(RtWFRUnitN2(:,i))];
    StdRtWFRUnitN2=[StdRtWFRUnitN2 nanstd(RtWFRUnitN2(:,i))];
end



%%%%%N1
MeanLtWFRUnitN1=[];
StdLtWFRUnitN1=[];
for i=1:length(LtWFRUnitN1(1,:))
    MeanLtWFRUnitN1=[MeanLtWFRUnitN1 nanmean(LtWFRUnitN1(:,i))];
    StdLtWFRUnitN1=[StdLtWFRUnitN1 nanstd(LtWFRUnitN1(:,i))];
end

MeanRtWFRUnitN1=[];
StdRtWFRUnitN1=[];
for i=1:length(RtWFRUnitN1(1,:))
    MeanRtWFRUnitN1=[MeanRtWFRUnitN1 nanmean(RtWFRUnitN1(:,i))];
    StdRtWFRUnitN1=[StdRtWFRUnitN1 nanstd(RtWFRUnitN1(:,i))];
end


%%%%%%N0
MeanLtWFRUnitN0=[];
StdLtWFRUnitN0=[];
for i=1:length(LtWFRUnitN0(1,:))
    MeanLtWFRUnitN0=[MeanLtWFRUnitN0 nanmean(LtWFRUnitN0(:,i))];
    StdLtWFRUnitN0=[StdLtWFRUnitN0 nanstd(LtWFRUnitN0(:,i))];
end

MeanRtWFRUnitN0=[];
StdRtWFRUnitN0=[];
for i=1:length(RtWFRUnitN0(1,:))
    MeanRtWFRUnitN0=[MeanRtWFRUnitN0 nanmean(RtWFRUnitN0(:,i))];
    StdRtWFRUnitN0=[StdRtWFRUnitN0 nanstd(RtWFRUnitN0(:,i))];
end





x=1:5;
LtW1FRUnitNegative=figure
subplot(5,1,1);
bar(x,MeanLtWFRUnitN4,0.5);hold on
errorbar(x,MeanLtWFRUnitN4,StdLtWFRUnitN4,'o','MarkerSize',0.2);
title('MeanLtWFRUnitN4')

subplot(5,1,2);
bar(x,MeanLtWFRUnitN3,0.5);hold on
errorbar(x,MeanLtWFRUnitN3,StdLtWFRUnitN3,'o','MarkerSize',0.2);
title('MeanLtWFRUnitN3')

subplot(5,1,3);
bar(x,MeanLtWFRUnitN2,0.5);hold on
errorbar(x,MeanLtWFRUnitN2,StdLtWFRUnitN2,'o','MarkerSize',0.2);
title('MeanLtWFRUnitN2')

subplot(5,1,4);
bar(x,MeanLtWFRUnitN1,0.5);hold on
errorbar(x,MeanLtWFRUnitN1,StdLtWFRUnitN1,'o','MarkerSize',0.2);
title('MeanLtWFRUnitN1')

subplot(5,1,5);
bar(x,MeanLtWFRUnitN0,0.5);hold on
errorbar(x,MeanLtWFRUnitN0,StdLtWFRUnitN0,'o','MarkerSize',0.2);
title('MeanLtWFRUnitN0')


RtW1FRUnitNegative=figure;
subplot(5,1,1);
bar(x,MeanRtWFRUnitN4,0.5);hold on
errorbar(x,MeanRtWFRUnitN4,StdRtWFRUnitN4,'o','MarkerSize',0.2);
title('MeanRtWFRUnitN4')

subplot(5,1,2);
bar(x,MeanRtWFRUnitN3,0.5);hold on
errorbar(x,MeanRtWFRUnitN3,StdRtWFRUnitN3,'o','MarkerSize',0.2);
title('MeanRtWFRUnitN3')

subplot(5,1,3);
bar(x,MeanRtWFRUnitN2,0.5);hold on
errorbar(x,MeanRtWFRUnitN2,StdRtWFRUnitN2,'o','MarkerSize',0.2);
title('MeanRtWFRUnitN2')

subplot(5,1,4);
bar(x,MeanRtWFRUnitN1,0.5);hold on
errorbar(x,MeanRtWFRUnitN1,StdRtWFRUnitN1,'o','MarkerSize',0.2);
title('MeanRtWFRUnitN1')

subplot(5,1,5);
bar(x,MeanRtWFRUnitN0,0.5);hold on
errorbar(x,MeanRtWFRUnitN0,StdRtWFRUnitN0,'o','MarkerSize',0.2);
title('MeanRtWFRUnitN0')

figname1=['LtFR_W1_Pattern2_Negative.bmp'];
figname2=['RtFR_W1_Pattern2_Negative.bmp'];
cd(path)
saveas(LtW1FRUnitNegative,figname1);
saveas(RtW1FRUnitNegative,figname2);
