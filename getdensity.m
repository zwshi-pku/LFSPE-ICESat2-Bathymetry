function [density, lines, idx, res, idnew, slope, dists, radii, distsr] = getdensity(x1,y1,radius, distT, distsrT, densityT, resT, type, r_min, r_max)

% 创建一个KD树
Mdl = KDTreeSearcher([x1, y1]);

% 对每个点进行范围搜索
[idx, dists] = rangesearch(Mdl, [x1, y1], radius);
radii = x1*0+radius;
if type == "seafloor"
    [idx, dists, radii] = seafloorrnn(x1, y1, r_min, r_max);
else
    [idx, dists] = rangesearch(Mdl, [x1, y1], radius);
end

idx_new = idx;
dist_new = dists;
points = [x1, y1];
lines = [];
for i=1:length(x1)
    pnts = points(idx_new{i},:);
    [~, id, bestLine] = p2lined(pnts(1,:),pnts, distT, [], []);
%     [~, id2, bestLine2] = ransacLineFitting(pnts(1,:),pnts, distT, [], [], 100);
    
    if size(pnts,1) > 10
        [modelRANSAC, modelInliers, inlierIdx] = fitRANSACLine(pnts, 2, distT);
        distsr(i,1) = pointToLineDistance(pnts(1,:), modelRANSAC);
    else
        distsr(i,1) = 100;
    end

    if ~isempty(id)
        idx_new{i} = idx_new{i}(id);
        dist_new{i} = dist_new{i}(id);
        lines = [lines; bestLine];
        
    else
        lines = [lines; [nan, nan]];
    end    
end

dists = dist_new;


% 计算每个点的邻居数量
density = cellfun(@length, idx_new);

res = [];
for i=1:length(dist_new)
    values = dist_new{i};
    if length(values)>1
        res(i) = values(2);
    else
        res(i) = NaN;
    end
end

slope = atand(lines(:,1));

% figure('Position', [100, 100, 450, 300]);
% scatter(x1, y1, 10, density, 'filled');
% c = colorbar;
% % cpos = c.Position
% % c.Position = [cpos(1), cpos(2), cpos(3)*1.8, cpos(4)]
% c.Label.String = 'Point density';
% % title('点分辨率');
% xlabel('Along-track distance (m)')
% ylabel('Elevation (m)')
% xlim([0 max(x1)])
% box on

% figure('Position', [100, 100, 450, 300]);
% scatter(x1, y1, 10, distsr, 'filled');
% c = colorbar;
% % cpos = c.Position
% % c.Position = [cpos(1), cpos(2), cpos(3)*1.8, cpos(4)]
% c.Label.String = 'Point distance';
% % title('点分辨率');
% xlabel('Along-track distance (m)')
% ylabel('Elevation (m)')
% xlim([0 max(x1)])
% box on


idnew = density>densityT & distsr < distsrT;









