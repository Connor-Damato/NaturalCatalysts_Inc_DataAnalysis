function [vmax, km] = M3_plot_v0s_002_02(sub, v0, enzyme)
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% ENGR 132 
% Program Description 
% Function uses the x and y data for an enzyme and returns the initial
% velocity of the enzyme.
%
% Function Call
% project_function_02(time, concentration)
%
% Input Arguments
% time- the time since the start of the reaction
% concentration- the concentration of the enzyme
%
% Output Arguments
% v0 - the initial velocity of the reaction
%
% Assignment Information
%   Assignment:     M02, Problem 1
%   Team member:    Kush Gogia, kgogia@purdue.edu [repeat for each person]
%   Team ID:        002-02
%   Academic Integrity:
%     [X] We worked with one or more peers but our collaboration
%        maintained academic integrity.
%     Peers we worked with: Jack Swingle, jswingle@purdue.edu
%                           Matthew Imm, mimm@purdue.edu
%                           Connor Damato, damato@purdue.edu
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%% ____________________
%% INITIALIZATION
% get the max value of the average v0's that are passed
vmax = max(v0);

%% ____________________
%% CALCULATIONS
% perform linweaver burk linearization
inv_sub = 1 ./ sub;
inv_v0 = 1 ./ v0;

% find slope and y intercept of linearized data
coef = polyfit(inv_sub, inv_v0, 1);

% create equation of curve from linearized data
km = vmax * coef(1);
v = (vmax .* sub) ./ (sub + km);

% create title correspondig to the correct enzyme
graph_title = strcat('Enzyme', {' '}, int2str(enzyme));

%% ____________________
%% FORMATTED TEXT/FIGURE DISPLAYS
% plot the data
figure(); % original data and model plotted
plot(sub, v0, "b.", 'MarkerSize', 12);
hold on
plot(sub, v, LineStyle="-")
plot(sub, v0, LineStyle="-")
title(graph_title);
xlabel('Substrate Concentration [S]')
ylabel('Reaction Velocity [V]')
legend("data", "model", "location", "best")
grid on

%% ____________________
%% RESULTS

%% ____________________
%% ACADEMIC INTEGRITY STATEMENT
% We have not used source code obtained from any other unauthorized
% source, either modified or unmodified. Neither have we provided
% access to my code to another. The program we are submitting
% is our own original work.