costs = [671803383, 245662649, 185496306, 245691310, 141727708, 90760469, 90733807, 90710883, 55552171, 65784870, 50074422, 50307877, 50373934, 60328068, 50209165, 33889175, 34466377, 50418953, 55562284];
nClusters = 2 : 20;

plot(nClusters, costs, '-or', 'LineWidth', 1, 'MarkerSize', 10, 'MarkerEdgeColor', 'b');
xlabel('Number of clusters');
ylabel('Cost function');
title('Cost near convergence for various number of clusters');
grid on;