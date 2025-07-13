function [modelRANSAC, modelInliers, inlierIdx] = fitRANSACLine(points, sampleSize, maxDistance)
    % Function to fit a line to data points using RANSAC and return the model.
    % Inputs:
    %   points      - (Nx2 matrix) the data points [x, y]
    %   sampleSize  - (int) number of points to sample per trial
    %   maxDistance - (double) maximum allowable distance for inliers
    % Outputs:
    %   modelRANSAC  - (1x2 vector) coefficients of the RANSAC fitted line [slope, intercept]
    %   modelInliers - (1x2 vector) coefficients of the line fitted using inliers [slope, intercept]
    %   inlierIdx    - (logical array) indices of inlier points

    % Define the fit function using polyfit.
    fitLineFcn = @(points) polyfit(points(:,1), points(:,2), 1);

    % Define the distance function to classify each point as an inlier or outlier
    % based on the maxDistance threshold.
    distLineFcn = @(model, points) (points(:,2) - polyval(model, points(:,1))).^2;

    % Use RANSAC to find the best-fitting line model and inliers.
    [modelRANSAC, inlierIdx] = ransac(points, fitLineFcn, distLineFcn, sampleSize, maxDistance);

    % Fit a line to the inliers.
    modelInliers = polyfit(points(inlierIdx, 1), points(inlierIdx, 2), 1);

    % Plot the inlier points and fitted line
    inlierPts = points(inlierIdx, :);
    x = [min(inlierPts(:, 1)) max(inlierPts(:, 1))];
    y = modelInliers(1) * x + modelInliers(2);
%     figure
%     plot(x, y, 'g-');
%     hold on;
%     plot(points(:,1), points(:,2), 'bo'); % Plot all points
%     plot(inlierPts(:,1), inlierPts(:,2), 'ro'); % Highlight inliers
%     hold off;
%     title('RANSAC Line Fitting');
%     xlabel('X');
%     ylabel('Y');
%     legend('Fitted Line', 'All Points', 'Inliers');
end
