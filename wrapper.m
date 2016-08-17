function [] = wrapper(J)
%% Initialization
%%clear; 
close all; clc;

dA = [0:9];
iA = [1:5];             %1 is done in 10s, so this is 15x multiplier
kA = [0.000001 0.000003 0.00001 0.00003 0.0001 0.0003 0.001 0.003 0.01 0.03];
sA = [100 300 1000];    %100 is done in 10s, so this is x+3x+10x = 14x multiplier

p = zeros(4,size(dA,2)*size(iA,2)*size(kA,2)*size(sA,2));
i = 1;

for Q=1:size(iA,2)
    for W=1:size(dA,2)
        for E=1:size(kA,2)
           for R=1:size(sA,2)
              p(1:1,i) = dA(W);
              p(2:2,i) = iA(Q);
              p(3:3,i) = kA(E);
              p(4:4,i) = sA(R);
              i = i+1;
           end
        end
    end
end

%% Settings
one = true;
many = false;
svm = true;
hebb = true;

digit = p(1:1,J);
iterations = p(2:2,J);
k = p(3:3,J);
s = p(4:4,J);
HTr = zeros(40,iterations);
HTe = zeros(40,iterations);
STr = zeros(40,iterations);
STe = zeros(40,iterations);

%% Function call
[HTr,HTe,STr,STe] = start(one, many, svm, hebb, digit, iterations, k, s, J, HTr, HTe, STr, STe);

%% Save to files
fprintf('\n Data collection finished \n');


%% Plot data
% plotTables(iterations, correction)