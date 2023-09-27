function [FR CV CORR]=CalcCVCorr(OutMatrix, Neurons)
Len=1000;
OutMatrix=OutMatrix(:,4001:5000);
        FR=(1000/(Len/5))*sum(sum(OutMatrix))/Neurons;%Hz
        
        CVn=zeros(1,Neurons);
        for n=1:Neurons
            F=OutMatrix(n,:);
            idx=find(F==1);
            ISI=diff(idx);
            ISI=ISI/5000;%•b’PˆÊ‚É
            CVn(n)=sqrt(var(ISI))/mean(ISI);
%             OMB(n,:)=sum(reshape(F,10,500));
            OMB(n,:)=sum(reshape(F,10,Len/10));%2ms’PˆÊ‚Å
        end
        CV=mean(CVn);
        
%         [Ent OutMs NotOutMs]=MakeEnt(Neurons,Len,OutMatrix);
%         [EntOMB OutOMB NotOMB]=MakeEnt(Neurons,Len/10,OMB);
        
        Corr=zeros(1,Neurons/2);
        Corr0=zeros(1,Neurons/2);
%         ConnValue=zeros(1,Neurons/2);
%         MI=zeros(1,Neurons/2);
%         MIomb=zeros(1,Neurons/2);
%         crr=0;
        for n=1:Neurons/2
%             if CnxMatrixAll(2*n-1,2*n)==0 && CnxMatrixAll(2*n,2*n-1)==0
%                 crr=crr+1;
                C=cov(OMB(2*n-1,:),OMB(2*n,:));
                c=sqrt(C(1,1)*C(2,2));
                if c==0
                    Corr(n)=0;
                    Corr0(n)=0; 
                else
                    Corr(n)=abs(C(1,2))/sqrt(C(1,1)*C(2,2));
                    Corr0(n)=C(1,2)/sqrt(C(1,1)*C(2,2));                    
                end
%                 ConnValue(n)=CnxMatrixAll(2*n-1,2*n) + CnxMatrixAll(2*n,2*n-1);
 
%             end
%             if crr==100;break;end
%                 Ent1=Ent(2*n-1);Ent2=Ent(2*n);
%                 OutMs1=OutMs(2*n-1,:);OutMs2=OutMs(2*n,:);
%                 NotOutMs1=NotOutMs(2*n-1,:);NotOutMs2=NotOutMs(2*n,:);
%                 [MI(n)]=CalcMI(OutMs1,OutMs2,NotOutMs1,NotOutMs2,Ent1,Ent2,Len);
                
%                 EntOMB1=EntOMB(2*n-1);EntOMB2=EntOMB(2*n);
%                 OutOMB1=OutOMB(2*n-1,:);OutOMB2=OutOMB(2*n,:);
%                 NotOMB1=NotOMB(2*n-1,:);NotOMB2=NotOMB(2*n,:);
%                 [MIomb(n)]=CalcMI(OutOMB1,OutOMB2,NotOMB1,NotOMB2,EntOMB1,EntOMB2,500);

        end
%         if crr<100;Corr(crr+1)=100;end
        
%         id0=find(ConnValue==0);
%         id1=find(ConnValue>0);
        
        CORR=mean(Corr);
%         MeanMI(N,R)=mean(MI);
%         MeanMIomb(N,R)=mean(MIomb);
        
%         ConnValueAll(N,R,:)=ConnValue;
% % %         CorrAll(N,R,:)=Corr;
% % %         Corr0All(N,R,:)=Corr0;
% % %         MIall(N,R,:)=MI;
% % %         MIombAll(N,R,:)=MIomb;
%         CORR0(N,R)=mean(Corr(id0));
%         CORR1(N,R)=mean(Corr(id1));
        
%         figure
%         image(OutMatrix*255);colormap gray;
%         zoom xon
%         clear OutMatrix
%         eval(['clear OutMatrixN',int2str(N),'R',int2str(R),';']);
        
%         end
%         
%     end