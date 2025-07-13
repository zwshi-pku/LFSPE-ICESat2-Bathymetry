function show_vec_resolution(xxs, yys, minDistance, fit_params)
xxs = xxs-min(xxs);
id = yys>fit_params(2)-60 & yys<fit_params(2)+60;

xxs = xxs(id);
yys = yys(id);

figure('Position', [100, 100, 450, 300]);
hold on;
plot(xxs, yys, 'k.');
% plot(x11, y11, 'b.');
% plot(x2, y2, 'r.'); 
% plot(x12, y12, 'g.');

box on
xlabel('Along-track distance (m)')
ylabel('Elevation (m)')
xlim([min(xxs) max(xxs)])
% print('-dpng', '-r300', strcat(dataId, '_figure5-2.png'));


figure('Position', [100, 100, 450, 300]);
p = plot(xxs,yys,'k.', 'MarkerSize', 10)
% p.Color(4) = 0.0
% s = scatter(x,y,20,'filled','Marker','o')
% s.MarkerFaceAlpha = 0.1;
axis equal
xlabel('Along-track distance (m)')
ylabel('Elevation (m)')
xlim([870, 880])
print('-dpng', '-r300', 'figure1-2.png');
% 
figure('Position', [100, 100, 450, 300]);
idxs = vec_resolution(xxs,yys, minDistance);
xxs = xxs(idxs);
yys = yys(idxs);
p = plot(xxs,yys,'k.', 'MarkerSize', 10)
% p.Color(4) = 0.0
% s = scatter(x,y,20,'filled','Marker','o')
% s.MarkerFaceAlpha = 0.1;
axis equal
xlabel('Along-track distance (m)')
ylabel('Elevation (m)')
xlim([870, 880])
print('-dpng', '-r300', 'figure1-3.png');

