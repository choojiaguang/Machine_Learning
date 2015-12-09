%GMM

% Clear everything
clear; clc; close ALL;

rngsetting = rng;  % save the current rng settings for reproducability
% Generate Gaussian clusters of data

% True number of clusters:
K = 30;

% Number of clusters in GMM algorithm
C = 5;
 
MU = zeros(K, 2);
SIGMA = zeros(2, 2, K);
X = zeros(K * 1000, 2);
for k = 1:K;
    MU(k,:) = 2*K*(rand(1, 2)-0.5);
    s = (rand(2,2) - 0.5);
    SIGMA(:,:,k) = 0.5*K*(s'*s + eye(2));
    %SIGMA(:,:,k) = eye(2);
    X(1000*(k-1)+1 : 1000*k , :) = mvnrnd(MU(k,:), SIGMA(:,:,k), 1000);
end

figure('units','normalized','position',[.1 .1 .8 .8]);
scatter(X(:,1),X(:,2),10,'r.')
hold on
set(gca, 'color', [0 0 0])

% Fit a two-component GMM
options = statset('Display', 'iter','MaxIter',50*C);  % display information for the algorithm
obj = fitgmdist(X, C, 'Options', options);

% Plot the fit
h = ezcontour(@(x,y)pdf(obj, [x y]), ...
    [min(X(:,1)) - 1, max(X(:,1))+1], [min(X(:,2))-1, max(X(:,2))+1]);
centroids = obj.mu;
plot(centroids(:,1),centroids(:,2),'g*','MarkerSize',12);
legend('fitted centroid');
xlabel('Feature 1','FontSize',16);
ylabel('Feature 2','FontSize',16);
title(['Gaussian Mixture Model with K = ',num2str(C),...
    '  (generated using ', num2str(K),' MVGs)'],'FontSize',20);