% Matlab codes for computing link predictability of complex networks.
% Journal reference:"Toward link predictability of complex networks", 
% Proceedings of the National Academy of Sciences, 201424644 (2015).
% by Linyuan L¨¹, Liming Pan, Tao Zhou, Yi-Cheng Zhang and H. Eugene Stanley.
% http://www.pnas.org/content/early/2015/02/05/1424644112.
% Coded by Liming Pan.

function AdjAnneal=perturbation(AdjTraining,Adj)
% perturbation(AdjTraining,Adj) returns the perturbated matrix of the original 
% adjaceny matrix.
% Inputs:  AdjTraining, the unperturbated network,
%          Adj, The unperturbated network plus the perturbations.
% Outputs: AdjAnneal, the perturbated matrix of AdjTraining.

% eigen decomposition of AdjTrainingÌØÕ÷·Ö½â
N=length(Adj);
AdjTraining=full(AdjTraining);
[v,w]=eig(AdjTraining);
eigenValues=diag(w);

% find "correct" eigenvectors for perturbation of degenerate eigenvalues 
degenSign=zeros(N,1);

%v2 and w2 are the "correct" eigenvectors and eigenvalues
v2=v;
w2=eigenValues;
AdjPertu=Adj-AdjTraining;
for l=1:N
    if degenSign(l)==0
        tempEigen=find(abs((eigenValues-eigenValues(l)))<10e-12);%???
        if length(tempEigen)>1    
            vRedun=v(1:end,tempEigen);  %???
            m=vRedun'*AdjPertu*vRedun;  %£¿£¿£¿
            m=(m+m')./2;
            m=full(m);
            [v_r,w_r]=eig(m);
            vRedun=vRedun*v_r;
            % renormalized the  new eigenvectors
            for o=1:length(m)
                vRedun(1:end,o)=vRedun(1:end,o)./norm(vRedun(1:end,o)); %£¿
            end
            v2(1:end,tempEigen)=vRedun;
            w2(tempEigen)=eigenValues(tempEigen)+diag(w_r);
            degenSign(tempEigen)=1;
        end
    end
end

% pertubate the adjacency matrix AdjTraining
AdjAnneal=v2*diag(diag(v2'*Adj*v2))*v2';
return;