function distance = pointToLineDistance(point, modelRANSAC)
    % Function to calculate the distance from a point to a line.
    % Inputs:
    %   point        - (1x2 vector) the point coordinates [x_0, y_0]
    %   modelRANSAC  - (1x2 vector) the coefficients of the line [slope, intercept]
    % Output:
    %   distance     - (double) the perpendicular distance from the point to the line

    % Extract the slope (a) and intercept (b) from the model
    a = modelRANSAC(1);
    b = modelRANSAC(2);
    
    % Coordinates of the point
    x0 = point(1);
    y0 = point(2);
    
    % Calculate the perpendicular distance from the point to the line
    distance = abs(a * x0 - y0 + b) / sqrt(a^2 + 1);
end
