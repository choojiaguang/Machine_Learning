%GMM

% Clear everything
clear; clc; close ALL;

rngsetting = rng;  % save the current rng settings for reproducability
% Generate Gaussian clusters of data

% True number of clusters:
K = 4;

% Number of clusters in GMM algorithm
C = 4;

MU = zeros(K, 2);
SIGMA = zeros(2, 2, K);
X = zeros(K * 1000, 2);
for k = 1:K;
    MU(k,:) = 10*rand(1, 2);
    s = (rand(2,2) - 0.5);
    SIGMA(:,:,k) = s'*s + eye(2);
    %SIGMA(:,:,k) = eye(2);
    disp(k);
    X(1000*(k-1)+1 : 1000*k , :) = mvnrnd(MU(k,:), SIGMA(:,:,k), 1000);
end


scatter(X(:,1),X(:,2),10,'r.')
hold on
set(gca, 'color', [0 0 0])

% Fit a two-component GMM
options = statset('Display', 'final');  % display information for the algorithm
obj = fitgmdist(X, C, 'Options', options);

% Plot the fit
h = ezcontour(@(x,y)pdf(obj, [x y]), ...
    [min(X(:,1)) - 1, max(X(:,1))+1], [min(X(:,2))-1, max(X(:,2))+1]);
