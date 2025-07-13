function params = getParametersSeafloor(dataId)
    % getParameters: Returns configuration parameters based on dataId
    % Input:
    %   dataId - Character specifying the configuration set (e.g., 'A', 'B', 'C')
    % Output:
    %   params - Structure containing configuration parameters

    % Initialize default parameters
    params = struct('radius', [], 'resT', [], 'angleT', [], 'maxDensityT', [], ...
                    'r_min', [], 'r_max', [], 'distT', [], 'distsrT', [], 'densityT', []);
                
    switch dataId
        case 'A'
            params.radius = 30;
            params.resT = 2.5;
            params.angleT = 10;
            params.maxDensityT = 20;
            params.r_min = 20;
            params.r_max = 50;
            params.distT = 1.5;
            params.distsrT = 7;
            params.densityT = 26;
            params.interval = 1.0;


        case 'C'
            params.radius = 30;
            params.resT = 2.5;
            params.angleT = 10;
            params.maxDensityT = 20;
            params.r_min = 20;
            params.r_max = 50;
            params.distT = 1.5;
            params.distsrT = 3;
            params.densityT = 37;
            params.interval = 0.7;

        case 'D'
            params.radius = 30;
            params.resT = 2.5;
            params.angleT = 10;
            params.maxDensityT = 20;
            params.r_min = 20;
            params.r_max = 50;
            params.distT = 1.5;
            params.distsrT = 1;
            params.densityT = 37;
            params.interval = 0.7;

        case 'E'
            params.radius = 30;
            params.resT = 2.5;
            params.angleT = 10;
            params.maxDensityT = 20;
            params.r_min = 20;
            params.r_max = 50;
            params.distT = 1.5;
            params.distsrT = 1;
            params.densityT = 20;
            params.interval = 0.5;

        case 'F'
            params.radius = 30;
            params.resT = 2.5;
            params.angleT = 10;
            params.maxDensityT = 20;
            params.r_min = 20;
            params.r_max = 50;
            params.distT = 1.5;
            params.distsrT = 3;
            params.densityT = 35;
            params.interval = 0.7;

        case 'H'
            params.radius = 30;
            params.resT = 2.5;
            params.angleT = 10;
            params.maxDensityT = 20;
            params.r_min = 20;
            params.r_max = 50;
            params.distT = 1.5;
            params.distsrT = 1;
            params.densityT = 20;
            params.interval = 0.5;


        case 'N'
            params.radius = 30;
            params.resT = 2.5;
            params.angleT = 10;
            params.maxDensityT = 20;
            params.r_min = 20;
            params.r_max = 50;
            params.distT = 1.5;
            params.distsrT = 1;
            params.densityT = 25;
            params.interval = 0.7;

        case 'O'
            params.radius = 30;
            params.resT = 2.5;
            params.angleT = 10;
            params.maxDensityT = 20;
            params.r_min = 20;
            params.r_max = 50;
            params.distT = 1.5;
            params.distsrT = 1;
            params.densityT = 30;
            params.interval = 0.5;

        otherwise

            error('Invalid choice. Please select a valid dataId.');
    end
end
