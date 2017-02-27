clear
clc

DSmat='DSmat.txt';
RSmat='RSmat.txt';
RDmat='RDmat.txt';
DS=load(DSmat);
RS=load(RSmat);
RD=load(RDmat);

Adj=[RS,RD;RD',DS];
% color block matrix
figure(1);
image(Adj,'CDataMapping','scaled');  
colorbar;

% disease
% 624:Breast neoplasms
% 633:Hepatocellular carcinoma
% 636:Renal cell carcinoma
% 638:Squamous cell carcinoma
% 662:Colorectal neoplasms
% 706:Glioblastoma
% 721:Heart failure
% 764:Acute myeloid leukemia
% 781:Lung neoplasms
% 898:Melanoma
% 847:Ovarian neoplasms
% 849:Pancreatic neoplasms
% 866:Prostatic neoplasms
% 898:Stomach neoplasms
% 907:Urinary bladder neoplasms

index=find(Adj(624,1:577));
% index=find(Adj(633,1:577));
% index=find(Adj(636,1:577));
% index=find(Adj(638,1:577));
% index=find(Adj(662,1:577));
% index=find(Adj(706,1:577));
% index=find(Adj(721,1:577));
% index=find(Adj(764,1:577));
% index=find(Adj(781,1:577));
% index=find(Adj(798,1:577));
% index=find(Adj(847,1:577));
% index=find(Adj(849,1:577));
% index=find(Adj(866,1:577));
% index=find(Adj(898,1:577));
% index=find(Adj(907,1:577));
indices = crossvalind('Kfold', index, 5);

for k=1:1                                     %交叉验证k=5，5个包轮流作为测试集
    test = (indices == k);                    %获得test1集元素在数据集中对应的单元编号
    train = ~test;                            %train集元素的编号为非test1元素的编号
    AdjTraining=Adj;
    for i=1:length(train)
        if train(i)==0
            AdjTraining(624,i)=0;
            AdjTraining(i,624)=0;
%             AdjTraining(633,i)=0;
%             AdjTraining(i,633)=0;
%             AdjTraining(636,i)=0;
%             AdjTraining(i,636)=0;
%             AdjTraining(638,i)=0;
%             AdjTraining(i,638)=0;
%             AdjTraining(662,i)=0;
%             AdjTraining(i,662)=0;
%             AdjTraining(706,i)=0;
%             AdjTraining(i,706)=0;
%             AdjTraining(721,i)=0;
%             AdjTraining(i,721)=0;
%             AdjTraining(764,i)=0;
%             AdjTraining(i,764)=0;
%             AdjTraining(781,i)=0;
%             AdjTraining(i,781)=0;
%             AdjTraining(798,i)=0;
%             AdjTraining(i,798)=0;
%             AdjTraining(847,i)=0;
%             AdjTraining(i,847)=0;
%             AdjTraining(849,i)=0;
%             AdjTraining(i,849)=0;
%             AdjTraining(866,i)=0;
%             AdjTraining(i,866)=0;
%             AdjTraining(898,i)=0;
%             AdjTraining(i,898)=0;
%             AdjTraining(907,i)=0;
%             AdjTraining(i,907)=0;
        end
    end   

    AdjProb=Adj-AdjTraining;
    probeSize=nnz(AdjProb)/2;
    N=length(Adj);
    probMatrix=zeros(N,N);

%Set the size of perturbations and number of independent perturbations
    pertuSize=ceil(0.1*(length(find(AdjTraining==1)))/2);
    perturbations=10;
    for pertus=1:perturbations
        AdjUnpertu=AdjTraining;
        index=find(tril(AdjTraining));
        [i,j]=ind2sub(size(tril(AdjTraining)),index);
        for pp=1:pertuSize
            rand_num=ceil(length(i)*rand(1));
            select_ID1=i(rand_num);
            select_ID2=j(rand_num);
            i(rand_num)=[];
            j(rand_num)=[];
            AdjUnpertu(select_ID1,select_ID2)=0;
            AdjUnpertu(select_ID2,select_ID1)=0;
        end
        AdjUnpertu=full(AdjUnpertu);
        probMatrix=probMatrix+perturbation(AdjUnpertu,AdjTraining);
    end
 
  %calculate the precision
    indexT=find(~AdjTraining(624,1:577));
%     indexT=find(~AdjTraining(633,1:577));
%     indexT=find(~AdjTraining(636,1:577));
%     indexT=find(~AdjTraining(638,1:577));
%     indexT=find(~AdjTraining(662,1:577));
%     indexT=find(~AdjTraining(706,1:577));
%     indexT=find(~AdjTraining(721,1:577));
%     indexT=find(~AdjTraining(764,1:577));
%     indexT=find(~AdjTraining(781,1:577));
%     indexT=find(~AdjTraining(798,1:577));
%     indexT=find(~AdjTraining(847,1:577));
%     indexT=find(~AdjTraining(849,1:577));
%     indexT=find(~AdjTraining(866,1:577));
%     indexT=find(~AdjTraining(898,1:577));
%     indexT=find(~AdjTraining(907,1:577));
    [row,col]=ind2sub(size(tril(AdjTraining,-1)),indexT);
    weight=probMatrix(indexT);
    [x,y]=sort(weight);
    pre_y=[];
    for pre_x=1:100
        pre=0;
        for j=(length(y)-pre_x+1):length(y)
            if Adj(624,row(y(j)))==1
%             if Adj(633,row(y(j)))==1
%             if Adj(636,row(y(j)))==1
%             if Adj(638,row(y(j)))==1
%             if Adj(662,row(y(j)))==1
%             if Adj(706,row(y(j)))==1
%             if Adj(721,row(y(j)))==1
%             if Adj(764,row(y(j)))==1
%             if Adj(781,row(y(j)))==1   
%             if Adj(798,row(y(j)))==1 
%             if Adj(847,row(y(j)))==1 
%             if Adj(849,row(y(j)))==1 
%             if Adj(866,row(y(j)))==1 
%             if Adj(898,row(y(j)))==1 
%             if Adj(907,row(y(j)))==1 
                pre=pre+1;
            end
        end
        if mod(pre_x,10)==0
            pre_y(pre_x)=pre./pre_x;
        end
    end
    figure(2);
    bar(pre_y,5);
    xlabel('top-k');
    ylabel('precision');
    title('Breast neoplasms');
%     title('Hepatocellular carcinoma');
%     title('Renal cell carcinoma');
%     title('Squamous cell carcinoma');
%     title('Colorectal neoplasms');
%     title('Glioblastoma');
%     title('Heart failure');
%     title('Acute myeloid leukemia');
%     title('Lung neoplasms');
%     title('Melanoma');
%     title('Ovarian neoplasms');
%     title('Pancreatic neoplasms');
%     title('Prostatic neoplasms');
%     title('Stomach neoplasms');
%     title('Urinary bladder neoplasms');
    axis([0 110 0 1]);  % 设置坐标轴在指定的区间
    set(gca,'XTickLabel',{'','','top-20','','top-40','','top-60','','top-80','','top-100'}) %设置x轴所代表大时间
 
    %calculate the recall
    indexT=find(~AdjTraining(624,1:577));
%     indexT=find(~AdjTraining(633,1:577));
%     indexT=find(~AdjTraining(636,1:577));
%     indexT=find(~AdjTraining(638,1:577));
%     indexT=find(~AdjTraining(662,1:577));
%     indexT=find(~AdjTraining(706,1:577));
%     indexT=find(~AdjTraining(721,1:577));
%     indexT=find(~AdjTraining(764,1:577));
%     indexT=find(~AdjTraining(781,1:577));
%     indexT=find(~AdjTraining(798,1:577));
%     indexT=find(~AdjTraining(847,1:577));
%     indexT=find(~AdjTraining(849,1:577));
%     indexT=find(~AdjTraining(866,1:577));
%     indexT=find(~AdjTraining(898,1:577));
%     indexT=find(~AdjTraining(907,1:577));
    [row,col]=ind2sub(size(tril(AdjTraining,-1)),indexT);
    weight=probMatrix(indexT);
    [x,y]=sort(weight);
    rec_y=[];
    for rec_x=1:100
        re=0;
        for j=(length(y)-rec_x+1):length(y)
            if Adj(624,row(y(j)))==1
%             if Adj(633,row(y(j)))==1
%             if Adj(636,row(y(j)))==1
%             if Adj(638,row(y(j)))==1
%             if Adj(662,row(y(j)))==1
%             if Adj(706,row(y(j)))==1
%             if Adj(721,row(y(j)))==1
%             if Adj(764,row(y(j)))==1
%             if Adj(781,row(y(j)))==1
%             if Adj(798,row(y(j)))==1
%             if Adj(847,row(y(j)))==1
%             if Adj(849,row(y(j)))==1
%             if Adj(866,row(y(j)))==1
%             if Adj(898,row(y(j)))==1
%             if Adj(907,row(y(j)))==1
                re=re+1;
            end
        end
        if mod(rec_x,10)==0
            rec_y(rec_x)=re./probeSize;
        end
    end
    figure(3);
    bar(rec_y,5);
    xlabel('top-k')
    ylabel('recall')
    title('Breast neoplasms');
%     title('Hepatocellular carcinoma');
%     title('Renal cell carcinoma');
%     title('Squamous cell carcinoma');
%     title('Colorectal neoplasms');
%     title('Glioblastoma');
%     title('Heart failure');
%     title('Acute myeloid leukemia');
%     title('Lung neoplasms');
%     title('Melanoma');
%     title('Ovarian neoplasms');
%     title('Pancreatic neoplasms');
%     title('Prostatic neoplasms');
%     title('Stomach neoplasms');
%     title('Urinary bladder neoplasms');
    axis([0 110 0 1]);  % 设置坐标轴在指定的区间
    set(gca,'XTickLabel',{'','','top-20','','top-40','','top-60','','top-80','','top-100'}) %设置x轴所代表大时间

    %calculate the AUC score
    index1=find(tril(AdjProb,-1));
    weight1=probMatrix(index1);
    index2=find(tril(~Adj,-1));
    weight2=probMatrix(index2); 
    labels=[];
    scores=[];
    labels(1:length(weight1))=1;
    labels(end+1:end+length(weight2))=0;
    scores(1:length(weight1))=weight1;
    scores(end+1:end+length(weight2))=weight2;
    [X,Y,T,AUC] = perfcurve(labels,scores,1);
    figure(4);
    plot(X,Y);
    hold on;
    xlabel('FPR')
    ylabel('TPR')
    title('Breast neoplasms');
%     title('Hepatocellular carcinoma');
%     title('Renal cell carcinoma');
%     title('Squamous cell carcinoma');
%     title('Colorectal neoplasms');
%     title('Glioblastoma');
%     title('Heart failure');
%     title('Acute myeloid leukemia');
%     title('Lung neoplasms');
%     title('Melanoma');
%     title('Ovarian neoplasms');
%     title('Pancreatic neoplasms');
%     title('Prostatic neoplasms');
%     title('Stomach neoplasms');
%     title('Urinary bladder neoplasms');
end
