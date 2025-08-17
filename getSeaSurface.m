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
    
    hold on

    plot(y_fit,xx0,'b-','LineWidth',1)
    set(gca, 'FontSize', 12)
    xlabel('Photon Counts', 'FontSize', 12)
    ylabel('Elevation (m)', 'FontSize', 12)
%     xlim[]

    f2 = figure('Position', [400, 100, 220, 300]);

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

    labels = [labels; label];

    plot(x_window(label==1),y_window(label==1),'.', 'Color', [0.0, 0.45, 0.70])
    hold on
    plot(x_window(label==2),y_window(label==2),'.', 'Color', [0.0, 0.60, 0.50])
    plot(x_window(label==3),y_window(label==3),'.', 'Color', [0.90, 0.60, 0.0])
    plot(x_window(label==4),y_window(label==4),'k.')
    set(gca, 'FontSize', 12)
    xlabel('Along-track distance (m)', 'FontSize', 12)
    ylabel('Elevation (m)', 'FontSize', 12)
    ylim([x0(mid)-8, x0(mid)+8])
    box on

    x_begin = x_begin+window_size;
    
    global dataId;
%     if dataId == 'C'
%         i = i+1;
%         print(f1, '-dpng', '-r300', strcat('fig_histogram\', dataId, '_figure3-', num2str(i), '-', num2str(1),'.png'));
%         print(f2, '-dpng', '-r300', strcat('fig_histogram\', dataId, '_figure3-', num2str(i), '-', num2str(2),'.png'));
% 
%         fit_params;
%         close(f1)
%         close(f2)
%     end
    close all
end

end






