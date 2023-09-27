function MakeMultimerNet_Group20150318

%���������100000��Ƃ����ʑ̔�r�����āA���̃y�A�����������m�����Z�o�����@

% %�z���̕��@�@C
% %���ݔF���̉񐔂Ŏw�肷��ꍇ�AC=0�A�זE�y�A������̉񐔂�Matching�Ŏw��B
% %���������w�肷��ꍇ�AC=1�A�{����Connections�Ŏw��B���d�ӂ����ׂăJ�E���g����B
% %�����זE�̊������w�肷��ꍇ�AC=2�A������Percent�Ŏw��B���d�ӂ�1�Ƃ��ăJ�E���g����B
% % C=2;

%Connections��Percent���ȉ��̐��l�ɂȂ�����l�b�g���[�N��ۑ�
% Connections=[100 200];%[500 1000 1500 2000];%
% Cnct=1;
% Percent=[1 2];%[5 10 15 20];%
% Prc=1;

Matching=1000000;%���ʑ̔�r�� 

%��`�q�����l���@1:�d���Ȃ��Amonoallele�A2:biallel�A�E�E�E�A-1:�d���L��
Repeat=-1;

Multimer=4;
Neurons=1000;
Genes=50;
Exp=10;

ExpMatrix=zeros(Neurons,Exp);
for m=1:Neurons
    GeneRepeat=ones(1,Genes).*Repeat;
    %Expression choose genes 
    ExpGene=zeros(1,Exp);
    for n=1:Exp
        N=ceil(rand*Genes);
        if Repeat==-1
            ExpGene(n)=N;
        elseif Repeat~=-1
            while GeneRepeat(N)==0
                N=ceil(rand*Genes);
            end
            ExpGene(n)=N;
            GeneRepeat(N)=GeneRepeat(N)-1;              
        end
    end
    ExpMatrix(m,:)=sort(ExpGene,'ascend');
end
ExpMatrix

Matrix=zeros(Neurons,Neurons);
for n=1:Neurons
    Multimer1=[ExpMatrix(n,ceil(rand(1,Matching)*Exp));ExpMatrix(n,ceil(rand(1,Matching)*Exp));ExpMatrix(n,ceil(rand(1,Matching)*Exp));ExpMatrix(n,ceil(rand(1,Matching)*Exp))];
    Multimer1=sort(Multimer1,1,'ascend');
    for m=1:Neurons
        [n m]
        if n~=m
            Multimer2=[ExpMatrix(m,ceil(rand(1,Matching)*Exp));ExpMatrix(m,ceil(rand(1,Matching)*Exp));ExpMatrix(m,ceil(rand(1,Matching)*Exp));ExpMatrix(m,ceil(rand(1,Matching)*Exp))];
            Multimer2=sort(Multimer2,1,'ascend');
            
%             M1=Multimer1(:);
%             M2=Multimer2(:);
%             MM=M1-M2;
%             Len0=length(MM(MM==0));
%             MP1=Len0/(Matching*4);
%             ProbMatrixMP4(n,m)=MP1^4*Matching;            

            Sum=sum(abs(Multimer1- Multimer2),1);
            Matrix(n,m)=length(Sum(Sum==0));
        end
    end
end
CnxMatrix=Matrix;
ProbMatrix=Matrix/sum(sum(Matrix));

SaveName=strcat('Group_CnxMatrix5_M',num2str(Multimer),'_N',num2str(Neurons),'_G',num2str(Genes),'_E',num2str(Exp),'_R',num2str(Repeat),'_Match',num2str(Matching));
save(SaveName,'ExpMatrix','ProbMatrix','CnxMatrix');


% Match=zeros(Neurons,Neurons);
% Multimer1=zeros(1,Multimer);
% Multimer2=zeros(1,Multimer);
% 
% % if C==1
%     Conn=0;P=0;
%     while Conn<Connections(end) && P<Percent(end)
%         NeuronPair=ceil(rand(1,2)*Neurons);
%         if NeuronPair(1)~=NeuronPair(2)
%             for p=1:Multimer
%                 Multimer1(p)=ExpMatrix(NeuronPair(1),ceil(rand*Exp));
%                 Multimer2(p)=ExpMatrix(NeuronPair(2),ceil(rand*Exp));
%             end
%             Multimer1=sort(Multimer1,'ascend');  
%             Multimer2=sort(Multimer2,'ascend'); 
%             if Multimer1==Multimer2
%                 Match(NeuronPair(1),NeuronPair(2))=Match(NeuronPair(1),NeuronPair(2))+1;
%                 Conn=Conn+1
%                 
%                 MM=Match+Match';%�����������v���Ė����O���t�ɁB
%                 MM(MM>0)=1;%���d�ӂ��P�ƃJ�E���g
%                 P=sum(sum((MM)))/(Neurons*Neurons-Neurons)*100
%                 
%                 if Conn==Connections(Cnct)
%                     SaveName=strcat('RepeatGroup_C',num2str(Multimer),'_N',num2str(Neurons),'_G',num2str(Genes),'_E',num2str(Exp),'_R',num2str(Repeat),'_Con',num2str(Connections(Cnct)));
%                     save(SaveName,'ExpMatrix','Match','Conn','Percent');
%                     Cnct=Cnct+1;
%                 end
%                 if Prc<=length(Percent) && P>=Percent(Prc) 
%                     SaveName=strcat('RepeatGroup_P',num2str(Multimer),'_N',num2str(Neurons),'_G',num2str(Genes),'_E',num2str(Exp),'_R',num2str(Repeat),'_Per',num2str(Percent(Prc)));
%                     save(SaveName,'ExpMatrix','Match','Conn','Percent');
%                     Prc=Prc+1;
%                 end
%             end    
%         end
%     end
% end
%     SumConn=sum(sum(Match))
%     SaveName=strcat('RepeatGroup_C',num2str(Multimer),'_N',num2str(Neurons),'_G',num2str(Genes),'_E',num2str(Exp),'_R',num2str(Repeat),'_Con',num2str(Connections));
%         save(SaveName,'ExpMatrix','Match');
%         
% elseif C==2
%     P=0;
%     while P<Percent
%         NeuronPair=ceil(rand(1,2)*Neurons);
%         if NeuronPair(1)~=NeuronPair(2)
%             for p=1:Multimer
%                 Multimer1(p)=ExpMatrix(NeuronPair(1),ceil(rand*Exp));
%                 Multimer2(p)=ExpMatrix(NeuronPair(2),ceil(rand*Exp));
%             end
%             Multimer1=sort(Multimer1,'ascend');  
%             Multimer2=sort(Multimer2,'ascend'); 
%             if Multimer1==Multimer2
%                 Match(NeuronPair(1),NeuronPair(2))=Match(NeuronPair(1),NeuronPair(2))+1;
%                 MM=Match+Match';%�����������v���Ė����O���t�ɁB
%                 MM(MM>0)=1;%���d�ӂ��P�ƃJ�E���g
%                 P=sum(sum((MM)))/(Neurons*Neurons-Neurons)*100
%             end    
%         end
%     end
%     SumConn=sum(sum(Match))
% %     Conn
%     SaveName=strcat('RepeatGroup_P',num2str(Multimer),'_N',num2str(Neurons),'_G',num2str(Genes),'_E',num2str(Exp),'_R',num2str(Repeat),'_Per',num2str(Percent(Prc)));
%     save(SaveName,'ExpMatrix','Match');
%         
% elseif C==0
% %     NtoM=zeros(1,Neurons*Neurons-Neurons);s=1;
% %     MtoN=zeros(1,Neurons*Neurons-Neurons);t=1;
%     for n=1:Neurons
%         n
%         for m=1:Neurons
%             m
% %             if n>m
%                 for k=1:Matching
%                     for p=1:Multimer
%                         Multimer1(p)=ExpMatrix(n,ceil(rand*Exp));
%                         Multimer2(p)=ExpMatrix(m,ceil(rand*Exp));
%                     end
%                     Multimer1=sort(Multimer1,'ascend');  
%                     Multimer2=sort(Multimer2,'ascend'); 
%                     if Multimer1==Multimer2
%                         Match(n,m)=Match(n,m)+1;
%                     end                
%                 end
% %                 NtoM(s)=Match(n,m);s=s+1;
% %             elseif n<m
% %                 for k=1:Matching
% %                     for p=1:Multimer
% %                         Multimer1(p)=ExpMatrix(n,ceil(rand*Exp));
% %                         Multimer2(p)=ExpMatrix(m,ceil(rand*Exp));
% %                     end
% %                     Multimer1=sort(Multimer1,'ascend');  
% %                     Multimer2=sort(Multimer2,'ascend'); 
% %                     if Multimer1==Multimer2
% %                         Match(n,m)=Match(n,m)+1;
% %                     end                
% %                 end
% %                 MtoN(t)=Match(n,m);t=t+1;
% %             end
%         end
%     end
%     Match
%     SaveName=strcat('RepeatGroup_M',num2str(Multimer),'_N',num2str(Neurons),'_G',num2str(Genes),'_E',num2str(Exp),'_R',num2str(Repeat),'_M',num2str(Matching));
%         save(SaveName,'ExpMatrix','Match');
% end
% 
% 
% % figure
% % hist(NtoM,100);
% % figure
% % hist(MtoN,100);


                    

