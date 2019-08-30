# RSDE : Regularized Spectral Data Embedding

RSDE (an Matlab package), Matlab version : Matlab R2016b

# Usage Example: learning embedding B and clustering G from the Jaffe dataset

## %%The Jaffe dataset is avaible in folder "Data" of the RSDE repository

% loading data

data=load('jaffe_213n_676d_10c.mat'); % number of clusters k=10

X=data.X;

labels=data.y;

%% normalizing data

X = NormalizeFea(X,1);

%% constructing graph similarity

options.NeighborMode = 'KNN'; 

options.WeightMode = 'HeatKernel';  %Cosine, HeatKernel, Binary

options.k =5;

options.t =1;
 
 W = constructW(X,options);

% graph normalization
 
 A=W;
 
 Dr = diag(sum(A,1).^(-.5));
 
 Dc = diag(sum(A,2).^(-.5));
 
 W = Dr*A*Dc;

%% Obtaining B, G and M

k=10;maxiter=300;lambda=10^-9;

[B,G,M] = RSDE(W, k,lambda,maxiter);

%% Clustering performances

[tmp idx]=max(G');
 
[RSDE_Performances] = ClusteringMeasure(labels, idx');

 %% Data visualization on the two first componnents of the embedding matrix B

rng default 

figure;

gscatter(B(:,1),B(:,2),labels)

title('\bfRSDE','FontSize', 20)

-----------------------------------------------------------------------------------------------------------
# Authors

Lazhar Labiod and  Mohamed Nadif

Department of Computer Science, LIPADE,  Paris University

# Contact
 
lazhar.labiod@parisdescartes.fr
