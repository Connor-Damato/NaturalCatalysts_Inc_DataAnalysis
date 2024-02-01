function [v0] = M4_getVel_002_02(time, concentration)
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% ENGR 132 
% Program Description 
% Function uses the x and y data for an enzyme and returns the initial
% velocity of the enzyme.
%
% Function Call
% M4_getVel_002_02(time, concentration)
%
% Input Arguments
% time- the time since the start of the reaction
% concentration- the concentration of the enzyme
%
% Output Arguments
% v0 - the initial velocity of the reaction
%
% Assignment Information
%   Assignment:     M4, Problem 1
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
maxR2 = -1; % keeps track of highest r2 value, set to minimum
domain = 5; 
maxDomain = domain; % the time where the highest r2 is reached

% loops through and finds the domain with the highest r2 value
while (domain < length(scalConcentration) / 2)
    
    %% --- OLD --- %%
    % coefs = polyfit(scalConcentration(domain) / scalTime(domain));
    %% --- --- --- %%

    %% --- NEW --- %% (calculate slope manually to force y-int to 0)
    slope = scalConcentration(domain) / scalTime(domain);
    %% --- --- --- %%

    % finds r2 value for this domain
    predictedVals = slope * scalTime(1:domain);
    modelSSE = sum((scalConcentration(1:domain) - predictedVals) .^ 2);
    modelSST = sum((scalConcentration(1:domain) - mean(scalConcentration(1:domain))) .^2);
    rSqrd = 1 - modelSSE / modelSST;
    
    % checks if this domain has a higher r2 value
    if (rSqrd > maxR2)
        maxDomain = domain;
        maxR2 = rSqrd;
    end
    domain = domain + 1; % steps by 1 each time
end

% uses the domain with the highest r2 value and returns the slope
slope = scalConcentration(maxDomain) / scalTime(maxDomain);
v0 = slope; % the output

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