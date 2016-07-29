%% Initialization
clear ; close all; clc

%% Setup the parameters of model
input_layer_size  = 784;    % 28x28 Input Images of Digits
hidden_layer_size = 10000;   % hidden units
num_labels = 2;             % 2 labels, n1 and n2 (isN, notN)
backprop_iter = 1;          % regulate iterations for backprop
k = 0.001;                  % learning rate
connectivity_rate = 0.1;    % sparseness rate

%% =========== Part 1: Loading and Visualizing Data =============

% Load Training Data
fprintf('Loading and Visualizing Data ...\n')

% Change the filenames if you've saved the files under different names
% On some platforms, the files might be saved as 
% train-images.idx3-ubyte / train-labels.idx1-ubyte
X = loadMNISTImages('train-images.idx3-ubyte')';
y = loadMNISTLabels('train-labels.idx1-ubyte');

m = size(X, 1);

% % Randomly select 100 data points to display
rand_indices = randperm(m);
sel = X(rand_indices(1:100), :);
displayData(sel);

%% ================ Part 6: Re-Initializing Pameters ================
fprintf('\n Initializing Neural Network Parameters ...\n')

MTheta1 = randInitializeConnections(input_layer_size, hidden_layer_size,connectivity_rate);
MTheta2 = abs(randInitializeWeights(hidden_layer_size, num_labels));
Theta1 = MTheta1;
Theta2 = MTheta2;

%% ================= Part 7: Training SVM against 1 digit =================

desired_digit = 5;        % digit to classify
second_digit = 7;         % second digit to pick

fprintf('\n Balancing data sets for SVM ...\n')

X = loadMNISTImages('train-images.idx3-ubyte')';
y = loadMNISTLabels('train-labels.idx1-ubyte');

fprintf('\n Training with SVM type learning ...\n')
[xF,yF] = balanceSet(X,y,desired_digit,second_digit);
Theta2 = SVMLearn(Theta1, Theta2, input_layer_size, ...
                          hidden_layer_size, num_labels, xF, yF,k);
                      
%% ================= Part 8: Prediction with SVM against 1 digit =================                  
                      
pred = predictSVM(Theta1, Theta2, xF);

yP = yF == desired_digit;

fprintf('\n ---- \n SVM Training Set Accuracy: %f\n', mean(double(pred == yP)) * 100);

X2 = loadMNISTImages('t10k-images.idx3-ubyte')';
y2 = loadMNISTLabels('t10k-labels.idx1-ubyte');

[x2F,y2F] = balanceSet(X2,y2,desired_digit,second_digit);

yP = y2F == desired_digit;

pred = predictSVM(Theta1, Theta2, x2F);

fprintf('\n SVM Test Set Accuracy: %f\n ---- \n', mean(double(pred == yP)) * 100);
fprintf('Program paused. Press enter to continue.\n');
pause;

% %% ================= Part 10: Training SVM against 9 digits (1/10 density) =================
% 
% fprintf('\n Balancing data sets for SVM ...\n')
% 
% X = loadMNISTImages('train-images.idx3-ubyte')';
% y = loadMNISTLabels('train-labels.idx1-ubyte');
% 
% fprintf('\n Training with SVM type learning ...\n')
% [xF,yF] = extractSet(X,y,5,9);
% Theta2 = SVMLearn(Theta1, Theta2, input_layer_size, ...
%                           hidden_layer_size, num_labels, xF, yF);
%                       
% %% ================= Part 11: Prediction with SVM against 9 digits (1/10 density) =================                  
%                       
% pred = predictSVM(Theta1, Theta2, xF);
% 
% yP = yF == 5;
% 
% fprintf('\n SVM Training Set Accuracy: %f\n', mean(double(pred == yP)) * 100);
% 
% X2 = loadMNISTImages('t10k-images.idx3-ubyte')';
% y2 = loadMNISTLabels('t10k-labels.idx1-ubyte');
% 
% [x2F,y2F] = extractSet(X2,y2,5,9);
% 
% yP = y2F == 5;
% 
% pred = predictSVM(Theta1, Theta2, x2F);
% 
% fprintf('\n SVM Test Set Accuracy: %f\n', mean(double(pred == yP)) * 100);
% fprintf('Program paused. Press enter to continue.\n');
% pause;

%% ================= Training Hebb against 1 digit =================

Theta1 = MTheta1;
Theta2 = MTheta2;

desired_digit = 5;        % digit to classify
second_digit = 7;         % second digit to pick

fprintf('\n Balancing data sets for Hebbian ...\n')

X = loadMNISTImages('train-images.idx3-ubyte')';
y = loadMNISTLabels('train-labels.idx1-ubyte');

fprintf('\n Training with Hebbian type learning ...\n')
[xF,yF] = balanceSet(X,y,desired_digit,second_digit);
Theta2 = HebbLearn(Theta1, Theta2, input_layer_size, ...
                          hidden_layer_size, num_labels, xF, yF,k);
                      
%% ================= Prediction with Hebb against 1 digit =================                  
                      
pred = predictSVM(Theta1, Theta2, xF);

yP = yF == desired_digit;

fprintf('\n ---- \nHebbian Training Set Accuracy: %f', mean(double(pred == yP)) * 100);

X2 = loadMNISTImages('t10k-images.idx3-ubyte')';
y2 = loadMNISTLabels('t10k-labels.idx1-ubyte');

[x2F,y2F] = balanceSet(X2,y2,desired_digit,second_digit);

yP = y2F == desired_digit;

pred = predictSVM(Theta1, Theta2, x2F);

fprintf('\n Hebbian Test Set Accuracy: %f\n ---- \n', mean(double(pred == yP)) * 100);
fprintf('Program paused. Press enter to continue.\n');
pause;