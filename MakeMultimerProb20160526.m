function MakeMultimerProb20160526

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

Matching=100000;%���ʑ̔�r�� 

%��`�q�����l���@1:�d���Ȃ��Amonoallele�A2:biallel�A�E�E�E�A-1:�d���L��
Repeat=1;

Multimer=4;
Neurons=2;
Genes=50;
Exp=10;

ExpMatrix1=[1 2 3 4 5 6 7 8 9 10;1 12 13 14 15 16 17 18 19 20];
ExpMatrix2=[1 2 3 4 5 6 7 8 9 10;1 2 13 14 15 16 17 18 19 20];
ExpMatrix3=[1 2 3 4 5 6 7 8 9 10;1 2 3 14 15 16 17 18 19 20];
ExpMatrix4=[1 2 3 4 5 6 7 8 9 10;1 2 3 4 15 16 17 18 19 20];
ExpMatrix5=[1 2 3 4 5 6 7 8 9 10;1 2 3 4 5 16 17 18 19 20];
ExpMatrix6=[1 2 3 4 5 6 7 8 9 10;1 2 3 4 5 6 17 18 19 20];
ExpMatrix7=[1 2 3 4 5 6 7 8 9 10;1 2 3 4 5 6 7 18 19 20];
ExpMatrix8=[1 2 3 4 5 6 7 8 9 10;1 2 3 4 5 6 7 8 19 20];
ExpMatrix9=[1 2 3 4 5 6 7 8 9 10;1 2 3 4 5 6 7 8 9 20];
ExpMatrix10=[1 2 3 4 5 6 7 8 9 10;1 2 3 4 5 6 7 8 9 10];

NumConnection=zeros(Exp,Matching);
for n=6
    eval(['ExpMatrix=ExpMatrix',int2str(n)]);
    for m=1:100000
        [n m]
        Multimer1=[ExpMatrix(1,ceil(rand(1,Matching)*Exp));ExpMatrix(1,ceil(rand(1,Matching)*Exp));ExpMatrix(1,ceil(rand(1,Matching)*Exp));ExpMatrix(1,ceil(rand(1,Matching)*Exp))];
        Multimer1=sort(Multimer1,1,'ascend');

        Multimer2=[ExpMatrix(2,ceil(rand(1,Matching)*Exp));ExpMatrix(2,ceil(rand(1,Matching)*Exp));ExpMatrix(2,ceil(rand(1,Matching)*Exp));ExpMatrix(2,ceil(rand(1,Matching)*Exp))];
        Multimer2=sort(Multimer2,1,'ascend');


        Sum=sum(abs(Multimer1- Multimer2),1);
        A=length(Sum(Sum==0));

        NumConnection(n,m)=length(Sum(Sum==0));
    end
end

SaveName=strcat('MultimerConProb',int2str(n),'M',num2str(Multimer),'_E',num2str(Exp),'_R',num2str(Repeat),'_Match',num2str(Matching));
save(SaveName,'NumConnection');
