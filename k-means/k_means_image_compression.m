imOld = imread('pics/minions.png');
[rows, cols, nFeatures] = size(imOld);
xs = cast(reshape(imOld, [], nFeatures), 'double');
nPts = rows * cols;
nIters = 100;
nClusters = 3;

mus = rand(nClusters, nFeatures) * 255; % stores means
mus2xs = zeros(nClusters, 1); % stores distance^2 from xs to mus
rs = zeros(nPts, 1, 'uint16'); % stores cluster number
oldCost = -1;
cost = -1; % start with invalid value
fprintf('Starting...\n');
for i = 1 : nIters
    for p = 1 : nPts
        for c = 1 : nClusters
            mus2xs(c) = sum((xs(p, :) - mus(c, :)).^2);
        end
        [~, rs(p)] = min(mus2xs);
    end
    
    sumRs = zeros(nClusters, 1);
    sumMus = zeros(nClusters, nFeatures);
    for p = 1 : nPts
        sumRs(rs(p)) = sumRs(rs(p)) + 1;
        sumMus(rs(p), :) = sumMus(rs(p), :) + xs(p, :);
    end
    for c = 1 : nClusters
        if sumRs(c) ~= 0
            mus(c, :) = sumMus(c, :) / sumRs(c);
        end
    end
    
    imCopy = zeros(nPts, nFeatures);
    for p = 1 : nPts
        imCopy(p, :) = mus(rs(p), :);
    end
    imNew = cast(reshape(imCopy, rows, cols, nFeatures), 'uint8');
    imwrite(imNew, ['pics/bla_', num2str(nClusters), '_', num2str(i), '.png']);
    
    oldCost = cost;
    cost = 0;
    for p = 1 : nPts
        cost = cost + sum((xs(p, :) - mus(rs(p), :)) .^ 2);
    end
    fprintf('Iteration %d: cost = %.6g\n', i, cost);
    
    if i > 1 && cost / oldCost > 0.999
        fprintf('Kind of converged!\n');
        imwrite(imNew, ['pics/bla_', num2str(nClusters), '.png']);
        break;
    end
end