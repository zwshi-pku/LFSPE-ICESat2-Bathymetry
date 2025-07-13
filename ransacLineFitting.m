function [bestInliers, id, bestLine] = ransacLineFitting(xy,points, distT, Line, angleT, numIterations)
x = xy(1);
y = xy(2);
id = [];
numPoints = size(points, 1);
bestInliers = [];
bestLine = [];

if numPoints < 5
    return
end

for i = 1:numIterations
    % 随机选择两个点
    indices = randperm(numPoints, 2);
%     point1 = points(indices(1), :);
    point1 = xy;
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

sum(id);
if ~isempty(Line) & ~isempty(bestLine)
    angle = calculateAngle(bestLine(1), Line(1));
    if angle>angleT
        bestLine = [];
    end
end

% if round(x,1) == 1199.1
%     hold on
%     plot(x,y,'*')
%     plot(points(:,1),points(:,2),'^')
% 
%     theta = linspace(0,2*pi,100);
%     xx = x+30*cos(theta);
%     yy = y+30*sin(theta);
%     plot(xx,yy,'-')
% 
%     xx = x-30:x+30;
%     yy = bestLine(1)*xx+bestLine(2);
%     plot(xx,yy,'-')
% 
%     x
% end

% fprintf('Best line: y = %.2fx + %.2f\n', bestLine(1), bestLine(2));
% fprintf('Number of inliers: %d\n', length(bestInliers));
%   