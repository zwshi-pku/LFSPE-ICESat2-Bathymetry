function scaled_data = scaled(x1,bin_size,count)
% bin_size = 100;
% n = 238;
n = count;

edges1 = [min(x1):bin_size:max(x1)];
figure('Position', [100, 100, 300, 220]);  
h1 = histogram(x1,edges1)
% h1 = histogram(x1)
h1.FaceColor = [0.9290 0.6940 0.1250]
h1.FaceAlpha = 0.3
xlabel('Along-track distance (m)')
ylabel('Photon Counts')
% print('-dpng', '-r300', 'figure2-1.png');

scaled_data = [];

i =1;
while true
    if i+n<length(x1)
        bin_data = x1(i:i+n-1);
    else
        bin_data = x1(i:end);
    end
    
    data_range = max(bin_data) - min(bin_data);
    scale_factor = bin_size/data_range;
    
    bin_data_scaled = (bin_data-min(bin_data))*scale_factor + min(bin_data);
    if i>1
        gap = min(bin_data_scaled) - max(scaled_data);
        bin_data_scaled = bin_data_scaled - gap + 0.0;
    end
    scaled_data = [scaled_data; bin_data_scaled];
    
    i = i+n;
    if i>length(x1)
        break;
    end
end
figure('Position', [100, 100, 300, 220]);  
edges2 = [min(scaled_data):bin_size:max(scaled_data)];
h2 = histogram(scaled_data, 'BinEdges',edges2);
h2.FaceColor = [0.9290 0.6940 0.1250]
h2.FaceAlpha = 0.3
xlabel('Along-track distance (m)')
ylabel('Photon Counts')
% print('-dpng', '-r300', 'figure2-2.png');
