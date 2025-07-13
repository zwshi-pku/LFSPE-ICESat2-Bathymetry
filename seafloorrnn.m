function [neighbors, distances, radii] = seafloorrnn(x2, y2, r_min, r_max)

z = y2;
neighbors = cell(length(y2),1);
distances = cell(length(y2),1);

z_min = min(z);
z_max = max(z);

% radii = r_min + (r_max - r_min)*(z_max-z)/(z_max-z_min);
radii = calculateRadii(r_min, r_max, z, z_min, z_max);

for i = 1:length(y2)
    [Idx, D] = rangesearch([x2 y2], [x2(i) y2(i)],radii(i));
    neighbors{i} = Idx{1};
    distances{i} = D{1};
end
