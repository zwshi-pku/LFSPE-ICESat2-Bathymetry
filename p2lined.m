function [nums, id, bestLine, res] = p2lined(xy,points, distT, Line, angleT)
bestLine = [];

x = xy(1);
y = xy(2);
% 对于每个旋转角度
nums = [];
numsMax = -inf;
% 从 -90 度到 90 度，每隔 30 度
i = 1;
for angle = -45:0.5:45
    % 计算新的斜率
    theta = deg2rad(angle);
    slope = tan(theta);

    % 计算截距
    intercept = y - slope * x;

    % 计算每个点到新直线的距离
    distances = abs(slope * points(:,1) - points(:,2) + intercept) / sqrt(slope^2 + 1);
    
    % 显示结果
%     nums(i,1) = sum(distances<distT & points(:,1)>x);
    nums(i,1) = sum(distances<distT);
    nums(i,2) = angle;

    if nums(i,1)>numsMax
        bestLine = [slope, intercept];
        numsMax = nums(i,1);
        id = distances<distT;
%         id = distances<distT & points(:,1)>x;
    end

    i = i+1;
end
sum(id);
if ~isempty(Line) & ~isempty(bestLine)
    angle = calculateAngle(bestLine(1), Line(1));
    if angle>angleT
        bestLine = [];
    end
end
% if round(x,1) == 1452.5
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
%     axis equal
%     x
% end


