%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% ENGR 132 
% Program Description 
%  This program calculates the Vmax and Km of 5 enzymes given a dataset of
%  2 tests for each of 10 initial substrate concentrations. 
%
% Assignment Information
%   Assignment:     M2 
%   Team member:    Jack Swingle, jswingle@purdue.edu
%   Team ID:        002-02
%
%   Academic Integrity:
%     [x] We worked with one or more peers but our collaboration
%        maintained academic integrity.
%     Peers we worked with: ; Kush Gogia, 
%   kgogia@purdue; Connor Damato, damato0@purdue.edu; Matthew Imm, 
%   mimm@purdue.edu
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%% ____________________
%% INITIALIZATION
data = readmatrix("Data_nextGen_KEtesting_allresults.csv"); % import data

initial_S = data(3, 2:end); % The row that containst the initial S values
sub = initial_S(1:10); % The [S] values that each enzyme is tested with

data(1:4, :) = []; % remove first 4 rows of NaN

time = data(:, 1); % create time vector

% Initialize vectors of 0s for optimization
v0_list = zeros(1, 100);
avg1 = zeros(1, 10);
avg2 = zeros(1, 10);
avg3 = zeros(1, 10);
avg4 = zeros(1, 10);
avg5 = zeros(1, 10);
km_list = zeros(1,5);
vmax_list = zeros(1,5);


%% ____________________
%% CALCULATIONS
% loop through all of the columns to get all 100 v0 values
for column = 2:101
    concentration = data(:, column);
    v0 = M2_getVel_002_02(time, concentration);

    v0_list(column-1) = v0;
end

% Split up v0 list into enzymes
enzyme_1 = v0_list(1:20);
enzyme_2 = v0_list(21:40);
enzyme_3 = v0_list(41:60);
enzyme_4 = v0_list(61:80);
enzyme_5 = v0_list(81:100);

% Calculate average of both tests for each enzyme
for index = 1:10
    avg1(index) = mean([enzyme_1(index), enzyme_1(index + 10)]);
    avg2(index) = mean([enzyme_2(index), enzyme_2(index + 10)]);
    avg3(index) = mean([enzyme_3(index), enzyme_3(index + 10)]);
    avg4(index) = mean([enzyme_4(index), enzyme_4(index + 10)]);
    avg5(index) = mean([enzyme_5(index), enzyme_5(index + 10)]);
end

% create cell array of average vectors to be passed to plot function
avg_v0s = {avg1, avg2, avg3, avg4, avg5}; 

%% ____________________
%% FORMATTED TEXT/FIGURE DISPLAYS
% loop through enzyme averages and plot and display Km and Vmax
for index = 1:5
    [vmax, km] = plot_v0s_002_02(sub, cell2mat(avg_v0s(index)), index);
    fprintf("Enzyme %d:\n", index)
    fprintf("  Vmax = %.4f\n", vmax)
    fprintf("  Km = %.2f\n\n", km)
end

%% ____________________
%% RESULTS
%{
main_function_002_02
Enzyme 1:
  Vmax = 0.8664
  Km = 150.82

Enzyme 2:
  Vmax = 0.7042
  Km = 301.45

Enzyme 3:
  Vmax = 1.0818
  Km = 191.87

Enzyme 4:
  Vmax = 1.3589
  Km = 272.27

Enzyme 5:
  Vmax = 1.4768
  Km = 170.35
%}

%% ____________________
%% ACADEMIC INTEGRITY STATEMENT
% We have not used source code obtained from any other unauthorized
% source, either modified or unmodified. Neither have we provided
% access to my code to another. The program we are submitting
% is our own original work.



