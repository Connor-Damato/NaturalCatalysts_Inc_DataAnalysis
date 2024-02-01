function [vmax, km] = M4_plot_v0s_002_02(sub, v0, enzyme)
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% ENGR 132 
% Program Description 
% Function uses the x and y data for an enzyme and returns the initial
% velocity of the enzyme.
%
% Function Call
% M4_plot_v0s_002_02(time, concentration, enzyme)
%
% Input Arguments
% time- the time since the start of the reaction
% concentration- the concentration of the enzyme
% %%REMOVED%% enzyme - the index of the enzyme &&REMOVED&&
%
% Output Arguments
% v0 - the initial velocity of the reaction
%
% Assignment Information
%   Assignment:     M4, Problem 1
%   Team member:    Jack Swingle, jswingle@purdue.edu 
%   Team ID:        002-02
%   Academic Integrity:
%     [X] We worked with one or more peers but our collaboration
%        maintained academic integrity.
%        Peers we worked with: Kush Gogia, kgogia@purdue.edu 
%                           Matthew Imm, mimm@purdue.edu
%                           Connor Damato, damato0@purdue.edu
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%% ____________________
%% INITIALIZATION

%% --- OLD --- %%
% get the max value of the average v0's that are passed
% vmax = max(v0);
%% --- --- --- %%

%% ____________________
%% CALCULATIONS
%% --- OLD --- %%
%{
inv_sub = 1 ./ sub;
inv_v0 = 1 ./ v0;

coef = polyfit(inv_sub, inv_v0, 1);

km = vmax * coef(1);
v = (vmax .* sub) ./ (sub + km);
%}
%% --- --- --- %%

%% --- NEW --- %% (This calculates Vmax and Km using Eadie-Hofstee linearization)
y_lin = v0;
x_lin = v0 ./ sub;

coef = polyfit(x_lin, y_lin, 1);

vmax = coef(2);
km = -coef(1);

v = (vmax * sub) ./ (km + sub);
%% --- --- --- %%

%% ____________________
%% FORMATTED TEXT/FIGURE DISPLAYS
graph_title = strcat('Enzyme', {' '}, int2str(enzyme));

figure(); % original data and model plotted
plot(sub, v0, "b.", 'MarkerSize', 12);
hold on
plot(sub, v, "k-");
title(append(graph_title,' Michealis-Menten Plot'));
xlabel('Substrate Concentration (uM)');
ylabel('Initial Velocity (uM/s)');
legend("data", "model", "location", "best");
grid on
hold off 

%% ____________________
%% RESULTS

%% ____________________
%% ACADEMIC INTEGRITY STATEMENT
% We have not used source code obtained from any other unauthorized
% source, either modified or unmodified. Neither have we provided
% access to my code to another. The program we are submitting
% is our own original work.