% function [xx, yy, idx] = vec_resolution(x, y, minDistance)
% idx = [];
% xx = [];
% yy = [];
% 
% x = x-min(x);
% % plot(x,y,'.')
% % axis equal
% [C,ia,ic] = unique(x);
% 
% for i=1:size(C,1)
%     id = ic == i;
%     tempx = x(id);
%     tempy = y(id);
% 
%     indices = find(id); % 获取这些点的全局索引
% 
%     ptCloud = pointCloud([tempx tempy tempx*0]);
% 
%     [labels,numClusters] = pcsegdist(ptCloud,minDistance);
% 
%     for j=1:numClusters
%         temp = ptCloud.Location(labels == j,:);
%         temp = median(temp, 1);
%         xx = [xx; temp(1)];
%         yy = [yy; temp(2)];
% 
%         % 找到当前聚类的局部索引
%         clusterIndices = find(labels == j); 
%         globalIndices = indices(clusterIndices); % 转换为全局索引
% 
%         % 使用中值点作为代表点
%         tempMedian = median([tempx(clusterIndices), tempy(clusterIndices)], 1);
% 
%         % 找到距离中值点最近的点的索引
%         [~, nearestIdx] = min(vecnorm([tempx(clusterIndices) - tempMedian(1), ...
%                                        tempy(clusterIndices) - tempMedian(2)], 2, 2));
%         idx = [idx; globalIndices(nearestIdx)]; % 保存全局索引
% 
%     end
% 
% end
% 
% % plot(xx,yy,'.')
% % axis equal
% 
% end
% 

function idx = vec_resolution(x, y, minDistance)
idx = []; % 用于存储最终选择的索引

x = x - min(x); % 将 x 平移以从 0 开始
[C, ia, ic] = unique(x); % 找到唯一的 x 值及其映射

for i = 1:size(C, 1)
    id = ic == i; % 筛选属于当前 x 值的点
    tempx = x(id);
    tempy = y(id);
    indices = find(id); % 获取这些点的全局索引

    % 创建点云用于聚类
    ptCloud = pointCloud([tempx tempy tempx * 0]);

    % 基于距离的点云聚类
    [labels, numClusters] = pcsegdist(ptCloud, minDistance);

    for j = 1:numClusters
        % 找到当前聚类的局部索引
        clusterIndices = find(labels == j); 
        globalIndices = indices(clusterIndices); % 转换为全局索引

        % 使用中值点作为代表点
        tempMedian = median([tempx(clusterIndices), tempy(clusterIndices)], 1);

        % 找到距离中值点最近的点的索引
        [~, nearestIdx] = min(vecnorm([tempx(clusterIndices) - tempMedian(1), ...
                                       tempy(clusterIndices) - tempMedian(2)], 2, 2));
        idx = [idx; globalIndices(nearestIdx)]; % 保存全局索引
    end
end

% 如果需要，可通过 idx 提取点：
% xx = x(idx);
% yy = y(idx);

% 可选的绘图部分
% plot(x(idx), y(idx), '.');
% axis equal;
end

