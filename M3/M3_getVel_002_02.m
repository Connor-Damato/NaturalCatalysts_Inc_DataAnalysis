function [v0] = M3_getVel_002_02(time, concentration)
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
%   Team member:    Connor Damato, damato0@purdue.edu [repeat for each person]
%   Team ID:        002-02
%   Academic Integrity:
%     [x] We worked with one or more peers but our collaboration
%        maintained academic integrity.
%     Peers we worked with: Jack Swingle, jswingle@purdue 
%                           Matthew Imm, mimm@purdue
%                           Kush Gogia, kgogia@purdue
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%% ____________________
%% INITIALIZATION
scalConcentration = concentration(~isnan(concentration)); % removes NaN values

scalTime = time(~isnan(time)); % removes NaN values
scalTime = scalTime(1:length(scalConcentration)); % sets length to be the same as the concentration

%% ____________________
%% CALCULATIONS
rSqrd = 0; % how to determine which is the best
maxR2 = -1; % keeps track of highest r2 value, set to minimum
domain = 5; % the stepper for the domain
coefs = -1; % initialized to -1 to make it easier to spot any erros
maxDomain = domain; % the time where the highest r2 is reached

% loops through and finds the domain with the highest r2 value
while (domain < length(scalConcentration) - 11)
    % gets the coefficients for this domain
    coefs = polyfit(scalTime(1:domain), scalConcentration(1:domain), 1);
    
    % finds r2 value for this domain
    predictedVals = coefs(1) * scalTime(1:domain) + coefs(2);
    modelSSE = sum((scalConcentration(1:domain) - predictedVals) .^ 2);
    modelSST = sum((scalConcentration(1:domain) - mean(scalConcentration(1:domain))) .^2);
    rSqrd = 1 - modelSSE / modelSST;
    
    % checks if this domain has a higher r2 value
    if (rSqrd > maxR2)
        maxDomain = domain;
        maxR2 = rSqrd;
    end
    domain = domain + 5; % steps by 5 each time
end

% uses the domain with the highest r2 value and returns the slope
coefs = polyfit(scalTime(1:maxDomain), scalConcentration(1:maxDomain), 1);
v0 = coefs(1); % the output

%% ____________________
%% FORMATTED TEXT/FIGURE DISPLAYS


%% ____________________
%% RESULTS

%% ____________________
%% ACADEMIC INTEGRITY STATEMENT
% We have not used source code obtained from any other unauthorized
% source, either modified or unmodified. Neither have we provided
% access to my code to another. The program we are submitting
% is our own original work.