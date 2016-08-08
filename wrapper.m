%% Initialization
clear; close all; clc;


%% Settings
one = true;
many = false;
svm = true;
hebb = true;
digit = 5;
iterations = 19;
correction = linspace(1.5,2.5,iterations);

HTr = zeros(10,iterations);
HTe = zeros(10,iterations);
STr = zeros(10,iterations);
STe = zeros(10,iterations);

%% Function call
[HTr,HTe,STr,STe] = start(one, many, svm, hebb, digit, iterations, HTr, HTe, STr, STe, correction);

%% Save to files
fprintf('\n Data collection finished \n');
save(date,'HTr','HTe','STr','STe');

%% Plot data
plotTables(iterations, correction)