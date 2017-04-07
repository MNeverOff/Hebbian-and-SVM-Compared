function [] = wrapper()
%% Initialization
%%clear; 
close all; clc;
J = 1;
addpath(genpath('Data/'));
addpath(genpath('Functions/'));
addpath(genpath('Inputs/'));
addpath(genpath('Utilities/'));

%% Settings
one = false;
many = true;
svm = false;
hebb = true;

digit = 1;
iterations = 1;
k = 0.003;
s = 1000;
HTr = zeros(40,iterations); % Hebb training
HTe = zeros(40,iterations); % Hebb test
STr = zeros(40,iterations); % SVM training
STe = zeros(40,iterations); % SVM test

%% Function call
[HTr,HTe,STr,STe] = start(one, many, svm, hebb, digit, iterations, k, s, J, HTr, HTe, STr, STe);

%% Save to files
fprintf('\n Data collection finished \n');

%% Plot data
% plotTables(iterations, correction)