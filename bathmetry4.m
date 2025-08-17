% clc; clear; close all
% H C F E D A
if dataId == 'H' || dataId == 'C' || dataId == 'F' || dataId == 'E' || dataId == 'D' || dataId == 'A'   
    global dataId;
    [atl03, id0, name]= select_icesat2_data(dataId);

    minDistance = 0.5;
    xxs = atl03.atd(id0);
    yys = atl03.alt(id0);
    idxs = vec_resolution(xxs,yys, minDistance);
    xx = xxs(idxs);
    yy = yys(idxs);
    llh = [xx yy ones(length(xx),1)];
    dlmwrite(strcat('llt',dataId,'.txt'), llh, 'delimiter', '\t', 'precision', '%.6f');
end


% N O
if dataId == 'N' || dataId == 'O' 
    global dataId;
    % dataId = 'P';
    filename = strcat('.\data_1116\',dataId,'\data_',dataId,'.csv');
    data1 = csvread(filename, 0, 0);
    xx = data1(:,1);
    yy = data1(:,2);

    filename = strcat('.\data_1116\',dataId,'\data_',dataId,'_coordinates_new.csv');
    data2 = csvread(filename, 0, 0);

    minDistance = 0.5;
    idxs = vec_resolution(xx,yy, minDistance);
    xx = xx(idxs);
    yy = yy(idxs);
    savecsv_m(data2(:,1), data2(:,2), strcat('llt', dataId, '.csv'))

end




rng(0)

xx = xx-min(xx);

fit_params = sea_surface(xx, yy, 0.1);
id = yy>fit_params(2)-60 & yy<fit_params(2)+60;
idxs = idxs(id);
x = xx(id);
y = yy(id);


%% figure-1

figure('Position', [100, 100, 300, 220]);  
p = plot(x,y,'.','MarkerEdgeColor',[0.5 0.5 0.5])
set(gca, 'FontSize', 12)
% p.Color(4) = 0.0
% s = scatter(x,y,20,'filled','Marker','o')
% s.MarkerFaceAlpha = 0.1;
% axis equal
xlabel('Along-track distance (m)', 'FontSize', 12)
ylabel('Elevation (m)', 'FontSize', 12)
xlim([0, max(x)])
ylim([min(y), max(y)])

%% figure-2
bin_size = 100;
count = 238;
x_scaled = adjust_intervals(x,[]);



%% figure-3
idxsb = idxs;
x = x_scaled;
labels = getSeaSurface(x,y,200,0.1);
figure('Position', [100, 100, 450, 300]);
plot(x(labels~=3),y(labels~=3),'.', 'Color', [0.0, 0.45, 0.70])
hold on
plot(x(labels==3),y(labels==3),'.', 'Color', [0.90, 0.60, 0.0])
% plot(x,y,'.')
% axis equal
set(gca, 'FontSize', 12)
lgd = legend({'Above sea surface photons', 'Below seafloor photons'},'Location', 'northeast', 'FontSize', 12)
lgd.Box = 'on'; 
lgd.Color = 'white';
xlabel('Along-track distance (m)', 'FontSize', 12)
ylabel('Elevation (m)', 'FontSize', 12)
xlim([0 max(x)])
print('-dpng', '-r300', strcat(dataId, '_figure3-1.png'));

figure('Position', [100, 100, 450, 300]);
plot(x,y,'k.')
hold on
plot(x(labels==2),y(labels==2),'.', 'Color', [0.90, 0.60, 0.0])
% plot(x,y,'.')
% axis equal
set(gca, 'FontSize', 12)
lgd = legend({'Other photons', 'Sea surface photons'},'Location', 'northeast', 'FontSize', 12)
lgd.Box = 'on';
lgd.Color = 'white';
xlabel('Along-track distance (m)', 'FontSize', 12)
ylabel('Elevation (m)', 'FontSize', 12)
xlim([0 max(x)])
print('-dpng', '-r300', strcat(dataId, '_figure3-2.png'));

%% sea surface
x1 = x(labels~=3);
y1 = y(labels~=3);
idxs1 = idxs(labels~=3);

params = getParametersSeaSurface(dataId)

[density1, lines, idx, res, idnew1, slope, dists, radii, distsr1] = getdensity(x1,y1,params.radius,params.distT, params.distsrT,params.densityT, params.resT,"seasurface", [], []);
idxs11 = idxs1;
idxs1 = idxs1(idnew1);

% figure('Position', [100, 100, 450, 300]);
% plot(x1, y1, 'k.');
% hold on;
% plot(x1(idnew1), y1(idnew1), '.', 'Color', [0.0, 0.45, 0.70]); 
% set(gca, 'FontSize', 12)
% lgd = legend({'Other photons', 'Sea surface photons'},'Location', 'northeast', 'FontSize', 12)
% lgd.Box = 'on'; 
% lgd.Color = 'white'; 
% xlabel('Along-track distance (m)', 'FontSize', 12)
% ylabel('Elevation (m)', 'FontSize', 12)
% xlim([0 max(x)])
% print('-dpng', '-r300', strcat(dataId, '_figure4-1.png'));

% figure('Position', [100, 100, 450, 300]);
% scatter(x1, y1, 10, density1, 'filled');
% c = colorbar('FontSize', 12);
% % cpos = c.Position
% % c.Position = [cpos(1), cpos(2), cpos(3)*1.8, cpos(4)]
% c.Label.String = 'Point density';
% set(gca, 'FontSize', 12)
% 
% xlabel('Along-track distance (m)', 'FontSize', 12)
% ylabel('Elevation (m)', 'FontSize', 12)
% xlim([0 max(x1)])
% box on
% print('-dpng', '-r300', strcat(dataId, '_figure4-2.png'));

% figure('Position', [100, 100, 450, 300]);
% scatter(x1, y1, 10, distsr1, 'filled');
% c = colorbar('FontSize', 12);
% % cpos = c.Position
% % c.Position = [cpos(1), cpos(2), cpos(3)*1.8, cpos(4)]
% c.Label.String = 'Point distance';
% 
% set(gca, 'FontSize', 12)
% xlabel('Along-track distance (m)', 'FontSize', 12)
% ylabel('Elevation (m)', 'FontSize', 12)
% xlim([0 max(x1)])
% box on
% print('-dpng', '-r300', strcat(dataId, '_figure4-3.png'));

%% seafloor

xx = x(labels==3);
y2 = y(labels==3);
idxs2 = idxs(labels==3);

params = getParametersSeafloor(dataId)

x2 = adjust_intervals(xx, params.interval);

[density2, lines, idx, res, idnew2, slope, dists, radii, distsr2] = getdensity(x2,y2,params.radius,params.distT, params.distsrT,params.densityT, params.resT,"seafloor", params.r_min, params.r_max);
idxs22 = idxs2;
x2 = xx;
idxs2 = idxs2(idnew2);

% figure('Position', [100, 100, 450, 300]);
% plot(x2, y2, 'k.');
% hold on;
% plot(x2(idnew2), y2(idnew2), '.', 'Color', [0.90, 0.60, 0.0]); 
% set(gca, 'FontSize', 12)
% lgd = legend({'Other photons', 'Seafloor photons'},'Location', 'northeast', 'FontSize', 12)
% lgd.Box = 'on'; 
% lgd.Color = 'white'; 
% xlabel('Along-track distance (m)', 'FontSize', 12)
% ylabel('Elevation (m)', 'FontSize', 12)
% xlim([0 max(x2)])
% print('-dpng', '-r300', strcat(dataId, '_figure5-1.png'));


figure('Position', [100, 100, 450, 300]);
plot(x, y, 'k.');

hold on;
plot(x1(idnew1), y1(idnew1), '.', 'Color', [0.0, 0.45, 0.70]);
plot(x2(idnew2), y2(idnew2), '.', 'Color', [0.90, 0.60, 0.0]); 
set(gca, 'FontSize', 12)
lgd = legend({'Other photons', 'Sea surface photons', 'Seafloor photons'},'Location', 'northeast', 'FontSize', 12)
lgd.Box = 'on'; 
lgd.Color = 'white'; 
xlabel('Along-track distance (m)', 'FontSize', 12)
ylabel('Elevation (m)', 'FontSize', 12)
xlim([0 max(x)])
print('-dpng', '-r300', strcat(dataId, '_figure5-2.png'));


% figure('Position', [100, 100, 450, 300]);
% scatter([x1; x2], [y1; y2], 10, [density1; density2], 'filled');
% c = colorbar('FontSize', 12);
% % cpos = c.Position
% % c.Position = [cpos(1), cpos(2), cpos(3)*1.8, cpos(4)]
% c.Label.String = 'Point density';
% 
% set(gca, 'FontSize', 12)
% xlabel('Along-track distance (m)', 'FontSize', 12)
% ylabel('Elevation (m)', 'FontSize', 12)
% xlim([0 max([x1; x2])])
% box on
% print('-dpng', '-r300', strcat(dataId, '_figure5-5.png'));

% figure('Position', [100, 100, 450, 300]);
% scatter([x1; x2], [y1; y2], 10, [distsr1; distsr2], 'filled');
% c = colorbar('FontSize', 12);
% % cpos = c.Position
% % c.Position = [cpos(1), cpos(2), cpos(3)*1.8, cpos(4)]
% c.Label.String = 'Point distance';
% 
% set(gca, 'FontSize', 12)
% xlabel('Along-track distance (m)', 'FontSize', 12)
% ylabel('Elevation (m)', 'FontSize', 12)
% xlim([0 max([x1; x2])])
% box on
% print('-dpng', '-r300', strcat(dataId, '_figure5-6.png'));


%% Above Below
if dataId == 'M' || dataId == 'N' || dataId == 'O' || dataId == 'P'
    xx = data1(:,1);
    yy = data1(:,2);
else
    xx = xxs-min(xxs);
    yy = yys;
end

x = xx(idxsb);
y = yy(idxsb);

% figure
% scatter(x, y, 'filled'); 
% axis equal

figure('Position', [100, 100, 450, 300]);
plot(x(labels==3),y(labels==3),'.', 'Color', [0.90, 0.60, 0.0])
hold on
plot(x(labels~=3),y(labels~=3),'.', 'Color', [0.0, 0.45, 0.70])
% plot(x,y,'.')
% axis equal
% lgd = legend({'Above-water photons', 'Underwater photons'},'Location', 'northeast', 'FontSize', 12)
% lgd.Box = 'on'; 
% lgd.Color = 'white'; 
if dataId == 'C' || dataId == 'O'
    lgd = legend({'Underwater photons', 'Non-Underwater Photons'},'Location', 'northeast', 'FontSize', 12)
    lgd.Box = 'on'; 
    lgd.Color = 'white'; 
else
    lgd = legend({'Underwater photons', 'Non-Underwater Photons'},'Location', 'northwest', 'FontSize', 12)
    lgd.Box = 'on'; 
    lgd.Color = 'white'; 
end
set(gca, 'FontSize', 12)
xlabel('Along-track distance (m)', 'FontSize', 12)
ylabel('Elevation (m)', 'FontSize', 12)
xlim([0 max(x)])
print('-dpng', '-r300', strcat(dataId, '_figure3-1.png'));

len(i,5) = sum(labels==3);
len(i,6) = sum(labels~=3);

cluster = labels*0+1;
cluster(labels==3) = 2;
data = [x y cluster];
save(strcat(dataId, '_data.mat'), 'data');
csvwrite(strcat(dataId, '_data.csv'), data);


%% Sea surface Seafloor
if dataId == 'M' || dataId == 'N' || dataId == 'O' || dataId == 'P'
    xx = data1(:,1);
    yy = data1(:,2);
else
    xx = xxs-min(xxs);
    yy = yys;
end

x1 = xx(idxs1);
y1 = yy(idxs1);


id = y1<fit_params(2) + 6*fit_params(3);

x11 = x1(id);
y11 = y1(id);
x12 = x1(~id);
y12 = y1(~id);

x2 = xx(idxs2);
y2 = yy(idxs2);

mask = true(size(xx));   
mask(idxs1) = false;     
mask(idxs2) = false;    
x3 = xx(mask);
y3 = yy(mask);

figure('Position', [100, 100, 450, 300]);
hold on;
plot(xx(idxsb), yy(idxsb), 'k.');
plot(x11, y11, '.', 'Color', [0.0, 0.60, 0.50]);
plot(x2, y2, '.', 'Color', [0.90, 0.60, 0.0]); 
plot(x12, y12, '.', 'Color', [0.0, 0.45, 0.70]);

% lgd = legend({'Noise photons', 'Sea surface photons', 'Seafloor photons', 'Land surface photons'},'Location', 'northeast', 'FontSize', 12)
% lgd.Box = 'on'; 
% lgd.Color = 'white'; 
box on
set(gca, 'FontSize', 12)
xlabel('Along-track distance (m)', 'FontSize', 12)
ylabel('Elevation (m)', 'FontSize', 12)
xlim([min(xx) max(xx)])
print('-dpng', '-r300', strcat(dataId, '_figure5-2.png'));

labelss = ones(size(xx,1),1);
labelss(idxs1) = 2;
labelss(idxs2) = 3;


%% density distr
if dataId == 'M' || dataId == 'N' || dataId == 'O' || dataId == 'P'
    xx = data1(:,1);
    yy = data1(:,2);
else
    xx = xxs-min(xxs);
    yy = yys;
end

x1 = xx(idxs11);
y1 = yy(idxs11);
x2 = xx(idxs22);
y2 = yy(idxs22);

% data = [data1 data2(:,1:2) labelss];

figure('Position', [100, 100, 450, 300]);
% color = ncl_colormap('MPL_RdYlBu');
% colormap(flipud(color));
scatter([x1; x2], [y1; y2], 10, [density1; density2], 'filled');

if dataId == 'H'
    caxis([0 50])
elseif dataId == 'P'
    caxis([0 100])
else
    caxis([0 50])
end

c = colorbar('FontSize', 12);

c.Label.String = 'Point density';

set(gca, 'FontSize', 12)
xlabel('Along-track distance (m)', 'FontSize', 12)
ylabel('Elevation (m)', 'FontSize', 12)
xlim([0 max(x1)])
box on
print('-dpng', '-r300', strcat(dataId, '_figure4-2.png'));


figure('Position', [100, 100, 450, 300]);
color = ncl_colormap('MPL_RdYlBu');
colormap(flipud(color));
scatter([x1; x2], [y1; y2], 10, [distsr1; distsr2], 'filled');
caxis([0 10])
c = colorbar('FontSize', 12);
c.Label.String = 'Point-to-line distance (m)';

% ax = gca;
% axpos = ax.Position;
% c.Position(1) = c.Position(1)-0.05
% c.Position(3) = 0.8*c.Position(3);  % 改变系数0.3（设置合适的宽度） 
% ax.Position = axpos;


set(gca, 'FontSize', 12)
xlabel('Along-track distance (m)', 'FontSize', 12)
ylabel('Elevation (m)', 'FontSize', 12)
xlim([0 max(x1)])
box on

print('-dpng', '-r300', strcat(dataId, '_figure4-3.png'));




%% extraction
x11 = xx(idxs11);
y11 = yy(idxs11);
x21 = xx(idxs22);
y21 = yy(idxs22);

x12 = xx(idxs1);
y12 = yy(idxs1);
x22 = xx(idxs2);
y22 = yy(idxs2);

[~, locs] = ismember([x12 y12], [x11 y11], 'rows');
distsr_surface = distsr1(locs);

[~, locs] = ismember([x22 y22], [x21 y21], 'rows');
distsr_seafloor = distsr2(locs);

xyd1 = [x12 y12 distsr_surface];
indices1 = find_min_dist_indices(xyd1);
xyd2 = [x22 y22 distsr_seafloor];
indices2 = find_min_dist_indices(xyd2);

x1 = x12(indices1);
y1 = y12(indices1);


id = y1<fit_params(2) + 6*fit_params(3);

x11 = x1(id);
y11 = y1(id);
x12 = x1(~id);
y12 = y1(~id);

x2 = x22(indices2);
y2 = y22(indices2);

mask = true(size(xx));   
mask(idxs1) = false;     
mask(idxs2) = false;     
x3 = xx(mask);
y3 = yy(mask);

figure('Position', [100, 100, 450, 300]);
hold on;
plot(xx(idxsb), yy(idxsb), 'k.');
plot(x11, y11, '.', 'Color', [0.0, 0.60, 0.50]);
plot(x2, y2, '.', 'Color', [0.90, 0.60, 0.0]); 
plot(x12, y12, '.', 'Color', [0.0, 0.45, 0.70]);

if dataId == 'C' || dataId == 'O'
    lgd = legend({'Noise photons', 'Sea surface photons', 'Seafloor photons', 'Land surface photons'},'Location', 'northeast', 'FontSize', 12)
    lgd.Box = 'on'; 
    lgd.Color = 'white'; 
else
    lgd = legend({'Noise photons', 'Sea surface photons', 'Seafloor photons', 'Land surface photons'},'Location', 'northwest', 'FontSize', 12)
    lgd.Box = 'on'; 
    lgd.Color = 'white'; 
end

box on
set(gca, 'FontSize', 12)
xlabel('Along-track distance (m)', 'FontSize', 12)
ylabel('Elevation (m)', 'FontSize', 12)
xlim([min(xx) max(xx)])
print('-dpng', '-r300', strcat(dataId, '_figure5-2.png'));
save(strcat(dataId, '_all_variables.mat'))

global len;
temp = length(x12);
if isempty(x12)
    len(i,3) = 0;
else
    len(i,3) = length(x12);     % land
end
len(i,1) = length(x11);         % seasurface
len(i,2) = length(x2);          % seafloor
len(i,4) = length(xx(idxsb));   % all data
% axis equal


data_1 = [xx(idxsb) yy(idxsb)];
data_2 = [x11 y11];
data_3 = [x2 y2];
data_4 = [x12 y12];
% 
all_other_data = [data_2; data_3; data_4]; 

% 
[~, ia] = ismember(data_1, all_other_data, 'rows'); 

% 
filtered_data_1 = data_1(ia == 0, :); 

% results
disp(filtered_data_1);

data = [filtered_data_1;data_2;data_3;data_4];
labels = [ones(size(filtered_data_1,1),1);2*ones(size(data_2,1),1);3*ones(size(data_3,1),1);4*ones(size(data_4,1),1)];
data = [data labels];
% gscatter(data(:,1),data(:,2),data(:,3))
csvwrite(strcat(dataId, '_data_denoise.csv'), data);


%% R2
if ~ismember(dataId, {'N', 'O'})
    return
end

icesah = data2(idxs2,3);
cudemh = data2(idxs2,4);

yy = data1(:,2);
y1 = yy(idxs1);

D = mean(y1) - icesah;
icesah = icesah+0.25416*D;

[R P] = corrcoef(icesah,cudemh)
R2 = R(1,2)^2

rmse = errperf(icesah,cudemh,'rmse');
mae = errperf(icesah,cudemh,'mae');

%

figure
scatter_kde(icesah,cudemh, 'filled', 'MarkerSize', 5);
% color = ncl_colormap('NCV_bright');
% colormap(color);

f=fit(icesah,cudemh,'poly1')
hold on
minv = min([icesah; cudemh]);
maxv = max([icesah; cudemh]);
% scatter(icesah,cudemh, 15, 'filled', 'MarkerFaceAlpha', 0.5, 'MarkerEdgeAlpha', 0.5);
x = linspace(minv, maxv, 100); 
y = x; % 1:1 线，y = x
plot(x,y,'-','LineWidth',1.5,'color',[0, 0, 1])
% plot(icesah,cudemh,'.','color',[0, 0.4470, 0.7410])
plot(minv-50:maxv+50,f(minv-50:maxv+50),'-','LineWidth',1.5,'color',[0, 1, 0])
% colorbar('FontSize', 12)
xlabel('ICESat-2 Elevation (m)', 'FontSize', 12)
ylabel('CUDEM Elevation (m)', 'FontSize', 12)


xlim([minv maxv])
ylim([minv maxv])
box on
set(gca,'LineWidth',1);
set(gca, 'FontSize', 12)

set(gca,'xcolor','k');
set(gca,'ycolor','k');
set(gcf,'position',[500 500 400 300])

print('-dpng', '-r300', strcat(dataId, '_figure6-1.png'));


%%
if ~ismember(dataId, {'A'})
    return
end
show_vec_resolution(xxs, yys, minDistance, fit_params)


