function [bestInliers, id, bestLine] = ransacLine(points, distT, numIterations)
bestInliers = [];
id = [];
bestLine = [];

numPoints = size(points, 1);
if numPoints < 5
    return
end

for i = 1:numIterations
    % 随机选择两个点
    indices = randperm(numPoints, 2);
    point1 = points(indices(1), :);
    point2 = points(indices(2), :);

    % 计算直线参数
    if point1(1) == point2(1) % 避免除以0
        continue;
    end
    slope = (point2(2) - point1(2)) / (point2(1) - point1(1));
    intercept = point1(2) - slope * point1(1);

    % 计算所有点到直线的距离
    distances = abs(slope * points(:, 1) - points(:, 2) + intercept) / sqrt(slope^2 + 1);

    % 确定内点
    inliers = find(distances < distT);
    id = distances < distT;

    % 检查是否是最好的模型
    if length(inliers) > length(bestInliers)
        bestInliers = inliers;
        bestLine = [slope, intercept];
    end
end
