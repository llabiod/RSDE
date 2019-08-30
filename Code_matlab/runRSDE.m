%% Run RSDE
% Matlab version : Matlab R2016b
%% loading data
data=load('jaffe_213n_676d_10c.mat');% number of clusters k=10
%data=load('COIL20_1440n_1024d_20c.mat')%number of clusters k=20
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
%clear A; clear Dr; clear  Dc;
%% run RSDE
k=10;maxiter=300;lambda=10^-9;
[B,G,M] = RSDE(W, k,lambda,maxiter);
 %%
 [tmp idx]=max(G');
 [RSDE_Performances] = ClusteringMeasure(labels, idx');
 %% data visulization on the two first componnents of the mebedding matrix B
rng default 
figure;
gscatter(B(:,1),B(:,2),labels)
title('\bfRSDE','FontSize', 20)

 %%

 
