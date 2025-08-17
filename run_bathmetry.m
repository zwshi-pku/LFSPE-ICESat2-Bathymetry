clc; clear; close all;

% ========================================================
% Program Entry Point: Batch Processing of Multiple Datasets
% --------------------------------------------------------
% Define the dataset IDs to process using a cell array.
% By default, it processes datasets H, C, F, E, D, and A.
% To switch to another set (e.g., N and O), modify the lines below:
%   ids = {'N', 'O'};  % Default datasets
%   ids = {'H', 'C', 'F', 'E', 'D', 'A'};                     % Alternative datasets
% 📦 Dataset Download
% Due to the large size of the dataset, it is not hosted directly in this repository.
% You can download the full dataset used in this study from the following link:
% 
% 🔗 https://drive.google.com/drive/folders/1RTBe8tc0kQiUXllJGJ4sMKz0Mpm5O1TD?usp=drive_link
% 
% The dataset includes:
% 'H', 'C', 'F', 'E', 'D', 'A'
% ATL03 photon data used in experiments
% --------------------------------------------------------
% For each dataset, a global variable 'dataId' is assigned
% and passed to the subroutine 'bathmetry4.m'.
% The script assumes 'bathmetry4' uses `global dataId` to access it.
% The variable 'len' stores the results from each dataset.
% ========================================================

% === Select datasets to process (comment/uncomment as needed) ===
ids = {'N', 'O'};     % Default datasets
% ids = {'H', 'C', 'F', 'E', 'D', 'A'};                      % Optional: other datasets

% === Global variables ===
global dataId;     % Current dataset ID (used in bathmetry4)
global len;        % Result storage for each dataset
len = zeros(8, 6); % Preallocate result matrix (example size)

% === Process each dataset in a loop ===
for i = 1:length(ids)
    dataId = ids{i}; 
    fprintf('Running for dataId = %s\n', dataId);
    bathmetry4;  % Process current dataset

    % Clear all variables except globals and loop state
    clearvars -except ids dataId i len;
    close all;  % Close all figure windows
end
