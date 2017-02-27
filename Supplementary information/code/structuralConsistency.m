function consistVal=structuralConsistency(ATraining,A)
%Load the training network and the full network
AdjTraining=ATraining;
Adj=A;
%Size of the probe set 
probeSize=(nnz(Adj)-nnz(AdjTraining))/2;
probMatrix=perturbation(AdjTraining,Adj);
index=find(tril(~AdjTraining,-1));
[row,col]=ind2sub(size(tril(AdjTraining,-1)),index);
weight=probMatrix(index);
[x,y]=sort(weight);
consistVal=0;
for j=(length(y)-probeSize+1):length(y)
    if Adj(row(y(j)),col(y(j)))==1      
        consistVal=consistVal+1;
    end
end
consistVal=consistVal/(probeSize);
return;