function fit_params = sea_surface(x_window, y_window, bin_size)
fit_params = [];
labels = [];
edges = [min(y_window):bin_size:max(y_window)];
x1 = edges;
x2 = edges;
x1(1) = [];
x2(end) = [];
x0 = (x1-x2)/2+x2;

f1 = figure;
try
    h = histogram(y_window,edges);
catch
    y_window;
end
values = h.Values;

counts = h.BinCounts;
binEdges = h.BinEdges;
delete(h);
barh(x0,counts);

[mv, mid] = max(values);


gauss_model = @(params,x) params(1)*exp(-((x-params(2))/params(3)).^2);
initial_guess = [mv,x0(mid),0.1];
fit_params = lsqcurvefit(gauss_model, initial_guess, x0,values);
xx0 = min(x0):0.005:max(x0);
y_fit = gauss_model(fit_params, xx0);

%     initialGuess = [mv, x0(mid), 1, mv/2, x0(mid)-3, 1, 0];
%     model = @(coeffs, x) coeffs(1)*exp(-(x-coeffs(2)).^2/(2*coeffs(3)^2)) + ...
%         coeffs(4)*exp(-(x-coeffs(5)).^2/(2*coeffs(6)^2))+coeffs(7);
%     coefficients = lsqcurvefit(model, initialGuess, x, y);
%     y_fit = model(coefficients, x0);


hold on
%     plot(xx0,y_fit,'-','LineWidth',2)
%     ylabel('Photon Counts')
%     xlabel('Elevation (m)')
plot(y_fit,xx0,'r-','LineWidth',1)
xlabel('Photon Counts')
ylabel('Elevation (m)')
%     xlim[]

f2 = figure;

%     try
% %         hT = h.BinEdges(mid-5);
%         hT = fit_params(2) - 4*fit_params(3);
%     catch
%         hT = h.BinEdges(1);
%     end

%     labels(id) = y_window>hT;
label = ones(size(y_window));
if mv>10
    %水上
    id1 = y_window > fit_params(2) + 3*fit_params(3);
    label(id1) = 1;
    %水面
    id2 = y_window >= fit_params(2) - 3*fit_params(3) & y_window <= fit_params(2) + 3*fit_params(3);
    label(id2) = 2;
    %水下
    id3 = y_window < fit_params(2) - 3*fit_params(3);
    label(id3) = 3;
else
    %陆地
    label = ones(size(y_window))*4;
end

labels = [labels; label];


%     id = y_window>hT;
plot(x_window(label==1),y_window(label==1),'g.')
hold on
plot(x_window(label==2),y_window(label==2),'b.')
plot(x_window(label==3),y_window(label==3),'r.')
plot(x_window(label==4),y_window(label==4),'k.')
%     lgd = legend({'Sea surface photon', 'Seafloor photon'},'Location', 'northeast')
%     lgd.Box = 'off'
xlabel('Along-track distance (m)')
ylabel('Elevation (m)')
% axis equal






%     subplot(3,1,3)
%     xy_window = [x_window y_window];
%     [bestInliers, id_l, bestLine] = ransacLine(xy_window, 1.5, 100);
%     plot(x_window(id_l),y_window(id_l),'g.')
%     hold on
%     plot(x_window(~id_l),y_window(~id_l),'r.')
%
%     yy = bestLine(1)*x_window+bestLine(2);
%     plot(x_window,yy,'-')
%
%     ind = y_window > (mean(y_window(id_l))-1);

%     print(f1, '-dpng', '-r300', 'figure3-1-3.png');
%     print(f2, '-dpng', '-r300', 'figure3-2-3.png');
close(f1)
close(f2)
end