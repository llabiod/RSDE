%% RSDE based rotation
%% Objective: min||W-BM^T||+ \lambda||B-GQ|| st. B^TB=I, Q^tQ=I, G \in {0,1}^nxk


function [B,G,M] = RSDE(W, k,lambda,maxiter)

%%

[nn mm]=size(W);
%% Initialization
B=rand(nn,k);
M=rand(nn,k);
Q=eye(k,k);
%lambda=0;

for i=1:maxiter
    %update G

    G = calculateG(B, Q, 0, 1);
    
    %updsate B

    AB = W*M+lambda*G*Q ;
    [LB, bb, RB] = svds(AB, k);
    %[iddx,dd]=sort(bb);
    B = LB * RB'; 
   %update M
     M=W'*B;
 
    %update Q
    
    AQ = G'*B ;
    [LQ, qq, RQ] = svds(AQ, k);    
    Q = LQ * RQ';
    
    %   update Q as a centroid for RSDE-KM variante
    % Q=pinv(G'*G)*G'*B;
    % Q = inv(G'*G+eps*eye(k))*G'*B;
     
end

function G1 = calculateG(F, H, a, BQ)

[n,class_num] = size(F);

T = zeros(n,class_num);
for i = 1:class_num
    te = F - ones(n,1)*H(i,:);
    aa = sum(te.*te,2);
    T(:,i) = aa;
end;
T = T - a*2*BQ;
[temp idx] = min(T,[],2);
G1 = zeros(n,class_num);
for i = 1:n
    G1(i,idx(i)) = 1;
end;


  