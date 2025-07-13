function indices = find_min_dist_indices(xyd)
unique_x = unique(xyd(:, 1));

indices = [];

for i = 1:length(unique_x)
    x_val = unique_x(i);
    rows = find(xyd(:, 1) == x_val);
    [~, min_idx] = min(xyd(rows, 3));
    indices = [indices; rows(min_idx)];
end
end
