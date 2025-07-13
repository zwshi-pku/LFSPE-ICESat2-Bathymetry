function savecsv_m(lon, lat, csv_filename)

llt = [lon lat];
% Save llt as a CSV file
% Assuming llt is your original nx2 matrix
num_points = size(llt, 1);  % Get the number of rows in llt

% Calculate the interval for downsampling
if num_points > 4000
    interval = floor(num_points / 4000);
    
    % Select every nth row based on the interval
    indices = 1:interval:num_points;
    
    % Ensure exactly 5000 points are selected
    indices = indices(1:4000);
    
    % Extract the corresponding rows
    llt_reduced = llt(indices, :);
else
    % If the number of points is already less than or equal to 5000, keep it as is
    llt_reduced = llt;
end
llt = llt_reduced;
% llt_reduced now contains the reduced matrix with 5000 rows

% Convert the matrix to a table
T = array2table(llt);

% Set the column names
T.Properties.VariableNames = {'Lon', 'Lat'};

% Specify the filename
% csv_filename = 'llt.csv';

% Write the table to a CSV file with the correct column names
writetable(T, csv_filename);
T;