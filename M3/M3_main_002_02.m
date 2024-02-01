%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% ENGR 132 
% Program Description 
%  This program calculates the Vmax and Km of 5 enzymes given a dataset of
%  2 tests for each of 10 initial substrate concentrations. 
%
% Assignment Information
%   Assignment:     M2 
%   Team member:    Connor Damato, damato0@purdue.edu
%   Team ID:        002-02
%
%   Academic Integrity:
%     [x] We worked with one or more peers but our collaboration
%        maintained academic integrity.
%     Peers we worked with: ; Kush Gogia, 
%   kgogia@purdue; Jack Swingle, jswingle@purdue.edu; Matthew Imm, 
%   mimm@purdue.edu
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%% ____________________
%% INITIALIZATION
data = readmatrix("Data_nextGen_KEtesting_allresults.csv"); % import data
sampleV0 = [0.025, 0.0049, 0.099, 0.176, 0.329, 0.563, 0.874, 1.192, 1.361, 1.603];

data(1:4, :) = []; % remove first 4 rows of NaN

time = data(:, 1); % create time vector

% Initialize vectors of 0s for optimization
v0_list = zeros(1, 10);


%% ____________________
%% CALCULATIONS
% loop through all of the columns to get all v0 values
for column = 2:11
    concentration = data(:, column);
    v0 = M2_getVel_002_02(time, concentration);

    v0_list(column-1) = v0;
    
    tangent = time(1:length(concentration)) .* v0;
    lengthTangent = length(find(tangent < max(concentration)));
    titleString = strcat("Concentration of Enzymes Test ", int2str(column - 1));

    figure(column-1)
    grid on
    hold on
    plot(time(1:length(concentration)), concentration)
    plot(time(1:lengthTangent), tangent(1:lengthTangent), LineStyle="--")
    xlabel("Time (s)")
    ylabel("Concentration (ppm)")
    title(titleString)
    legend("Concentration Data", "Initial Velocity", Location="southeast")
    hold off
end


%% ____________________
%% FORMATTED TEXT/FIGURE DISPLAYS
plot_v0s_002_02(sub, sampleV0, 1);

%% ____________________
%% RESULTS

%% ____________________
%% ACADEMIC INTEGRITY STATEMENT
% We have not used source code obtained from any other unauthorized
% source, either modified or unmodified. Neither have we provided
% access to my code to another. The program we are submitting
% is our own original work.