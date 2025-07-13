function [visited, seedPoint] = growing6(x1, y1, density, idx, visited, distT, maxDensityT, angleT, lines, res, densityT, resT)
Line = [];
seedPoint = [];
% [~, maxDensityIndex] = max(density);

% 使用逻辑索引选择可以使用的 density 值及其索引
usableDensities = density(~visited);
usableIndices = find(~visited);

% 找出这些值中的最大值及其索引
[maxDensity, idxInUsable] = max(usableDensities)

% 将筛选后的索引映射回原始数组的索引
originalIndex = usableIndices(idxInUsable);

% 显示最大值及其在原始数组中的索引
disp(['最大可用密度值是: ', num2str(maxDensity), '，位于原始数组的索引位置: ', num2str(originalIndex)]);

if maxDensity<maxDensityT
    return
end

maxDensityIndex = originalIndex;

seedPoint = [x1(maxDensityIndex), y1(maxDensityIndex)];

% 初始化

% visited = false(size(x1));  % 访问标记数组
seedid = maxDensityIndex;    % 使用队列存储待处理的点索引

% hold on
% plot(x1,y1,'.')
% 区域生长
while ~isempty(seedid)
    current = seedid(1);    
    seedid(1) = [];  % 移除已处理的点
    if visited(current)
        continue;
    end

    % 同一个x坐标轴有多个点的就跳过，不作为种子点
    if sum(x1(current)==x1)>1 & sum(visited(x1(current)==x1))>1
        continue
    end
    
    % 找到当前点的所有邻居
    currentNeighbors = idx{current};
    currentNeighbors = currentNeighbors(visited(currentNeighbors)==0);

%     if round(x1(current),1) == 1452.5
%         
%         hold on
%         plot(x1(current),y1(current),'*')
%         plot(x1(currentNeighbors),y1(currentNeighbors),'^')
%         x1
%     end
    points = [x1, y1];

    bestLine = lines(current,:);
    Line = bestLine;
    
    if isempty(bestLine)
        continue
    end
    slope = bestLine(1);
    angleInRadians = atan(slope);  % 计算弧度
    angle = rad2deg(angleInRadians);  % 将弧度转换为度
    if abs(angle) > angleT
        continue
    end
    
    visited(current) = true;

%     hold on
%     plot(x1(current),y1(current),'*')
% %     plot(x1(currentNeighbors),y1(currentNeighbors),'r^')
% %     
%     theta = linspace(0,2*pi,30);
%     xx = x1(current)+30*cos(theta);
%     yy = y1(current)+30*sin(theta);
%     plot(xx,yy,'-')
%     
%     xx = x1(current)-30:x1(current)+30;
%     yy = bestLine(1)*xx+bestLine(2);
%     plot(xx,yy,'-')
%     axis equal
%     x1;

    resTt = 180;
    sid = [];
    currentNeighbors = flip(currentNeighbors);
    for neighbor = currentNeighbors        
        if density(neighbor)<densityT
            visited(neighbor) = true;
        end
%         plot(x1(neighbor),y1(neighbor),'.')
% 
%         Line = lines(neighbor,:);
%         theta = atand(abs((Line(1)-bestLine(1))/(1+Line(1)*bestLine(1))));
        t_res = res(neighbor);
        if neighbor == current
            continue
        end

        if t_res<resTt
            resTt = t_res;
            sid = neighbor;
        end
    end
    if ~isempty(sid) & resTt<1.5        
        seedid(end + 1) = sid;  % 加入队列
        visited(sid) = false;
    end
end
