function MakeMultimerProb20160830

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

% Matching=1000000;%���ʑ̔�r�� M4
Matching=1000;%���ʑ̔�r�� M3
% Matching=10000;%���ʑ̔�r�� M2

%��`�q�����l���@1:�d���Ȃ��Amonoallele�A2:biallel�A�E�E�E�A-1:�d���L��
Repeat=1;

Multimer=1;
Neurons=10000;
Genes=50;
Exp=5;

ExpMatrix1=[1 2 3 4 5;1 6 7 8 9];
ExpMatrix2=[1 2 3 4 5;1 2 7 8 9];
ExpMatrix3=[1 2 3 4 5;1 2 3 8 9];
ExpMatrix4=[1 2 3 4 5;1 2 3 4 9];
ExpMatrix5=[1 2 3 4 5;1 2 3 4 5];

NumConnection=zeros(Exp,Matching);
for n=1:5
    eval(['ExpMatrix=ExpMatrix',int2str(n)]);
    for m=1:100000
        [n m]
        Multimer1=[];
        for k=1:Multimer
            Multimer1=[Multimer1;ExpMatrix(1,ceil(rand(1,Matching)*Exp))];
%             Multimer1=[ExpMatrix(1,ceil(rand(1,Matching)*Exp));ExpMatrix(1,ceil(rand(1,Matching)*Exp));ExpMatrix(1,ceil(rand(1,Matching)*Exp));ExpMatrix(1,ceil(rand(1,Matching)*Exp))];
        end
        Multimer1=sort(Multimer1,1,'ascend');

        Multimer2=[];
        for k=1:Multimer
            Multimer2=[Multimer2;ExpMatrix(2,ceil(rand(1,Matching)*Exp))];%;ExpMatrix(2,ceil(rand(1,Matching)*Exp));ExpMatrix(2,ceil(rand(1,Matching)*Exp));ExpMatrix(2,ceil(rand(1,Matching)*Exp))];
        end
        Multimer2=sort(Multimer2,1,'ascend');


        Sum=sum(abs(Multimer1- Multimer2),1);
        A=length(Sum(Sum==0));

        NumConnection(n,m)=length(Sum(Sum==0));
    end
end

SaveName=strcat('MultimerConProb11M',num2str(Multimer),'_E',num2str(Exp),'_R',num2str(Repeat),'_Match',num2str(Matching));
save(SaveName,'NumConnection');
