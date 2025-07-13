function labels = getSeaSurface(x,y,window_size,bin_size)
fit_params_all = sea_surface(x,y,bin_size);

% labels = logical(zeros(length(x),1));
labels = [];

i = 0;
x_begin = min(x);
while x_begin<max(x)
    id = x>=x_begin & x<x_begin+window_size;
    if length(id)==0
        break;    
    end
    x_window = x(id);
    y_window = y(id);
    if length(id)<10
        x_begin = x_begin+window_size;
        continue
    end
            
    edges = [min(y_window):bin_size:max(y_window)];
    x1 = edges;
    x2 = edges;
    x1(1) = [];
    x2(end) = [];
    x0 = (x1-x2)/2+x2;

    f1 = figure('Position', [400, 100, 200, 300]);
    try
        h = histogram(y_window,edges);
    catch
        y_window;
    end
    values = h.Values;
    
    counts = h.BinCounts;
    binEdges = h.BinEdges;
    delete(h);
    b = barh(x0,counts);
    b.FaceColor = slanCL(786,10); % 设置直方图颜色
    b.FaceAlpha = 1;             % 设置透明度 (0完全透明, 1完全不透明)

    [mv, mid] = max(values); 

    
%     ylim([mean(y)-10, mean(y)+10])
    ylim([x0(mid)-8, x0(mid)+8])

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
    plot(y_fit,xx0,'b-','LineWidth',1)
    set(gca, 'FontSize', 12)
    xlabel('Photon Counts', 'FontSize', 12)
    ylabel('Elevation (m)', 'FontSize', 12)
%     xlim[]

    f2 = figure('Position', [400, 100, 220, 300]);

%     try
% %         hT = h.BinEdges(mid-5);
%         hT = fit_params(2) - 4*fit_params(3);
%     catch
%         hT = h.BinEdges(1);
%     end

%     labels(id) = y_window>hT;
    label = ones(size(y_window));

    if abs(fit_params_all(2) - fit_params(2)) > 1 || fit_params(3) > 0.5
        fit_params = fit_params_all;
    end


    %水上
    id1 = y_window > fit_params(2) + 4*fit_params(3);% & y_window < fit_params(2) + 60;
    label(id1) = 1;
    %水面
    id2 = y_window >= fit_params(2) - 4*fit_params(3) & y_window <= fit_params(2) + 4*fit_params(3);
    label(id2) = 2;
    %水下
    id3 = y_window < fit_params(2) - 4*fit_params(3);% & y_window > fit_params(2) - 60;
    label(id3) = 3;

%     if mv>10
% %         if abs(fit_params_all(2) - fit_params(2)) > 4*fit_params(3)
% %             fit_params = fit_params_all;
% %         end
%         if abs(fit_params_all(2) - fit_params(2)) > 1 || fit_params(3) > 0.5
%             fit_params = fit_params_all;
%         end
% 
% 
%         %水上
%         id1 = y_window > fit_params(2) + 4*fit_params(3);% & y_window < fit_params(2) + 60;
%         label(id1) = 1;
%         %水面
%         id2 = y_window >= fit_params(2) - 4*fit_params(3) & y_window <= fit_params(2) + 4*fit_params(3);
%         label(id2) = 2;
%         %水下
%         id3 = y_window < fit_params(2) - 4*fit_params(3);% & y_window > fit_params(2) - 60;
%         label(id3) = 3;
%     else
%         %陆地
%         label = ones(size(y_window))*4;
%     end

    labels = [labels; label];


%     id = y_window>hT;
    plot(x_window(label==1),y_window(label==1),'.', 'Color', [0.0, 0.45, 0.70])
    hold on
    plot(x_window(label==2),y_window(label==2),'.', 'Color', [0.0, 0.60, 0.50])
    plot(x_window(label==3),y_window(label==3),'.', 'Color', [0.90, 0.60, 0.0])
    plot(x_window(label==4),y_window(label==4),'k.')
%     lgd = legend({'Sea surface photon', 'Seafloor photon'},'Location', 'northeast')
%     lgd.Box = 'off'
    set(gca, 'FontSize', 12)
    xlabel('Along-track distance (m)', 'FontSize', 12)
    ylabel('Elevation (m)', 'FontSize', 12)
    ylim([x0(mid)-8, x0(mid)+8])
%     ylim([median(y)-10, median(y)+10])
    box on

    x_begin = x_begin+window_size;

    


    

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

    global dataId;
    if dataId == 'C'
        i = i+1;
        print(f1, '-dpng', '-r300', strcat('fig_histogram\', dataId, '_figure3-', num2str(i), '-', num2str(1),'.png'));
        print(f2, '-dpng', '-r300', strcat('fig_histogram\', dataId, '_figure3-', num2str(i), '-', num2str(2),'.png'));

        fit_params;
        close(f1)
        close(f2)
    end
end

% density_counts = [];
% for i=1:window_size:length(x)-window_size+1
%     window_range = x(i:i+window_size-1);
%     y_window = y(i:i+window_size-1);
%     bins = min(y_window):bin_size:max(y_window);
%     density = histcounts(y_window,bins);
%     density_counts = [density_counts, density];
%     bin_centers = (bins(1:end-1)+bins(2:end))/2;
%     figure
%     bar(bin_centers, density);
%     xlabel('Y data')
%     ylabel('Density')
%     grid on
% end






% edges = [-10:0.5:10];
% figure('Position', [100, 100, 300, 250]); 
% h = histogram(y,edges);
% [~, id] = max(h.Values);
% hT = h.BinEdges(id-1)*0.8;
% y;

end






