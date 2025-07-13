function [density, lines, idx, res, idnew, slope, dists, radii, distsr] = getdensity(x1,y1,radius, distT, distsrT, densityT, resT, type, r_min, r_max)

% 创建一个KD树
Mdl = KDTreeSearcher([x1, y1]);

% 对每个点进行范围搜索
[idx, dists] = rangesearch(Mdl, [x1, y1], radius);
% density = cellfun(@length, idx);
% figure
% plot(y1,density,'.')
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
        
%         distt = dist_new{i};
%         if length(distt)>2
%             distsr(i,1) = distt(2);
%         else
%             distsr(i,1) = 100;
%         end

    else
        lines = [lines; [nan, nan]];
    end    
end
% idx = idx_new;
dists = dist_new;

% plot_points_and_lines(x1, y1, lines, radii)

% 计算每个点的邻居数量
density = cellfun(@length, idx_new);

% figure
% histogram(density)

% [LOF, reachDist, localDensity] = computeLOF([x1, y1], 8);
% LOF = max(LOF) - LOF;

res = [];
for i=1:length(dist_new)
    values = dist_new{i};
    if length(values)>1
        res(i) = values(2);
    else
        res(i) = NaN;
    end
end

% for i=1:length(dist_new)
%     values = dist_new{i};
%     if length(values)>1
%         res(i) = median(values(2:end));
%     else
%         res(i) = NaN;
%     end
% end


slope = atand(lines(:,1));
% 可以绘制散点图显示密度
% figure('Position', [100, 100, 450, 300]);
% scatter(x1, y1, 10, slope, 'filled');
% c = colorbar;
% % cpos = c.Position
% % c.Position = [cpos(1), cpos(2), cpos(3)*1.8, cpos(4)]
% c.Label.String = 'slope';
% % title('点分辨率');
% xlabel('Along-track distance (m)')
% ylabel('Elevation (m)')
% xlim([0 max(x1)])
% box on

% 可以绘制散点图显示密度
% figure('Position', [100, 100, 450, 300]);
% scatter(x1, y1, 10, res, 'filled');
% c = colorbar;
% % cpos = c.Position
% % c.Position = [cpos(1), cpos(2), cpos(3)*1.8, cpos(4)]
% c.Label.String = 'Point-to-Point Nearest Distance (m)';
% % title('点分辨率');
% xlabel('Along-track distance (m)')
% ylabel('Elevation (m)')
% xlim([0 max(x1)])
% box on
% % axis equal

figure('Position', [100, 100, 450, 300]);
scatter(x1, y1, 10, density, 'filled');
c = colorbar;
% cpos = c.Position
% c.Position = [cpos(1), cpos(2), cpos(3)*1.8, cpos(4)]
c.Label.String = 'Point density';
% title('点分辨率');
xlabel('Along-track distance (m)')
ylabel('Elevation (m)')
xlim([0 max(x1)])
box on

figure('Position', [100, 100, 450, 300]);
scatter(x1, y1, 10, distsr, 'filled');
c = colorbar;
% cpos = c.Position
% c.Position = [cpos(1), cpos(2), cpos(3)*1.8, cpos(4)]
c.Label.String = 'Point distance';
% title('点分辨率');
xlabel('Along-track distance (m)')
ylabel('Elevation (m)')
xlim([0 max(x1)])
box on

% id = density>densityT & res'<resT;
% figure('Position', [100, 100, 450, 300]);
% plot(x1(id),y1(id),'.')
% title('density>densityT & res<resT');
% xlabel('Along-track distance (m)')
% ylabel('Elevation (m)')
% xlim([0 max(x1)])
% % axis equal

% % id = density>denii;
% id = density>densityT;
% figure('Position', [100, 100, 450, 300]);
% plot(x1(id),y1(id),'.')
% xlabel('Along-track distance (m)')
% ylabel('Elevation (m)')
% xlim([0 max(x1)])
% % axis equal
% title('density>densityT');


% id = res'<resT;
% figure('Position', [100, 100, 450, 300]);
% plot(x1(id),y1(id),'.')
% xlabel('Along-track distance (m)')
% ylabel('Elevation (m)')
% xlim([0 max(x1)])
% % axis equal
% title('res<resT');
% 
% 
% id = slope<7 & slope>-7;
% figure('Position', [100, 100, 450, 300]);
% plot(x1(id),y1(id),'.')
% xlabel('Along-track distance (m)')
% ylabel('Elevation (m)')
% xlim([0 max(x1)])
% % axis equal
% title('slope<3 & slope>-0.5');

% subplot(3,2,6)
% plot(x1,y1,'.')
% title('All');
% % axis equal
% subplot(3,2,6)
% scatter(x1, y1, 30, slope, 'filled');
% colorbar;
% title('坡度');


% id = density>densityT & res'<resT;

% idnew = density>densityT ;%& abs(slope)<8;

idnew = density>densityT & distsr < distsrT;

% % z = y1;
% % z_min = min(z);
% % z_max = max(z);
% z = density;
% z_min = densityT;
% z_max = max(z);
% 
% if type == "seafloor"
%     distsrTi = calculateRadii(0.5, distsrT, z, z_min, z_max)
%     distsrTi;
%     idnew = density>densityT & distsr < distsrTi;
% else
%     idnew = density>densityT & distsr < distsrT;
% end

% z_min = min(y1);
% z_max = max(y1);
% 
% idnew((z_max-y1)>15 & density>densityT) = 1;

% res = res';
% idnew = id;
% idx_new;
% for i=1:length(idx_new)
%     index = idx_new{i};
%     if sum(id(index))>0
%         temp = y1(index);
%         sd_y = mean(temp(id(index)));    
%         
%         temp = lines(index,:);
%         temp = temp(id(index),:);
%         m = temp(1,1);
%         c = temp(1,2);
%         xx = x1(index);
%         yy = y1(index);
%         d = abs(m*xx-yy+c)/(sqrt(m*m)+1);
% %         idnew(index(d<0.5)) = 1;
%         idnew(index(density(index)>densityT*1/2 & res(index)<resT*4/2 & d<0.5)) = 1;
%     end
% end
% figure('Position', [100, 100, 450, 300]);
% plot(x1(idnew),y1(idnew),'.')
% xlabel('Along-track distance (m)')
% ylabel('Elevation (m)')
% xlim([0 max(x1)])
% % axis equal
% title('idnew');



% id = res<3;
% xx = x1(id);
% yy = y1(id);
% figure
% plot(xx,yy,'.')







