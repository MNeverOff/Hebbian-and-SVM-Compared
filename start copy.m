%% Initialization
clear ; close all; clc

%% Setup the parameters of model
input_layer_size  = 784;  % 28x28 Input Images of Digits
hidden_layer_size = 1000;   % ?idden units
num_labels = 2;           % 2 labels, n1 and n2 (isN, notN)
backprop_iter = 1;        % regulate iterations for backprop

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

%% ================ Part 2: Initializing Pameters ================
fprintf('\n Initializing Neural Network Parameters ...\n')

Theta1 = randInitializeWeights(input_layer_size, hidden_layer_size);
Theta2 = randInitializeWeights(hidden_layer_size, num_labels);

% Unroll parameters
nn_params = [Theta1(:) ; Theta2(:)];


%% =============== Part 3: Checking backprop ===============

fprintf('\nChecking Backpropagation (w/ Regularization) ... \n')

%  Check gradients by running checkNNGradients
lambda = 10;
checkNNGradients(lambda);

% Also output the costFunction debugging values
debug_J  = backpropCF(nn_params, input_layer_size, ...
                          hidden_layer_size, num_labels, X, y, lambda);

fprintf('Program paused. Press enter to continue.\n');
%pause;


%% =================== Part 4: Training Backprop ===================
%  Using use "fmincg", which is a function which works similarly to "fminunc".
%  Advanced optimizers are able to train our cost functions efficiently as
%  provided with the gradient computations.

fprintf('\nTraining Neural Network... \n')

options = optimset('MaxIter', backprop_iter);
lambda = 10;

costFunction = @(p) backpropCF(p, ...
                               input_layer_size, ...
                               hidden_layer_size, ...
                               num_labels, X, y, lambda);

[nn_params, cost] = fmincg(costFunction, nn_params, options);

% Obtain Theta1 and Theta2 back from nn_params
Theta1 = reshape(nn_params(1:hidden_layer_size * (input_layer_size + 1)), ...
                 hidden_layer_size, (input_layer_size + 1));

Theta2 = reshape(nn_params((1 + (hidden_layer_size * (input_layer_size + 1))):end), ...
                 num_labels, (hidden_layer_size + 1));

fprintf('Program paused. Press enter to continue.\n');
%pause;

%% ================= Part 5: Using backprop =================

pred = predict(Theta1, Theta2, X);

yP = y == 5;

fprintf('\n Backprop Training Set Accuracy: %f\n', mean(double(pred == yP)) * 100);

X2 = loadMNISTImages('t10k-images.idx3-ubyte')';
y2 = loadMNISTLabels('t10k-labels.idx1-ubyte');

yP = y2 == 5;

pred = predict(Theta1, Theta2, X2);

fprintf('\n Backprop Test Set Accuracy: %f\n', mean(double(pred == yP)) * 100);
fprintf('Program paused. Press enter to continue.\n');
pause;

%% ================ Part 6: Re-Initializing Pameters ================
fprintf('\n Re-Initializing Neural Network Parameters ...\n')

Theta1 = randInitializeConnections(input_layer_size, hidden_layer_size);
Theta2 = abs(randInitializeWeights(hidden_layer_size, num_labels));

%% ================= Part 7: Training SVM against 1 digit =================

desired_digit = 5;        % digit to classify
second_digit = 3;         % second digit to pick

fprintf('\n Balancing data sets for SVM ...\n')

X = loadMNISTImages('train-images.idx3-ubyte')';
y = loadMNISTLabels('train-labels.idx1-ubyte');

fprintf('\n Training with SVM type learning ...\n')
[xF,yF] = balanceSet(X,y,desired_digit,second_digit);
Theta2 = SVMLearn(Theta1, Theta2, input_layer_size, ...
                          hidden_layer_size, num_labels, xF, yF);
                      
%% ================= Part 8: Prediction with SVM against 1 digit =================                  
                      
pred = predictSVM(Theta1, Theta2, xF);

yP = yF == desired_digit;

fprintf('\n SVM Training Set Accuracy: %f\n', mean(double(pred == yP)) * 100);

X2 = loadMNISTImages('t10k-images.idx3-ubyte')';
y2 = loadMNISTLabels('t10k-labels.idx1-ubyte');

[x2F,y2F] = balanceSet(X2,y2,desired_digit,second_digit);

yP = y2F == desired_digit;

pred = predictSVM(Theta1, Theta2, x2F);

fprintf('\n SVM Test Set Accuracy: %f\n', mean(double(pred == yP)) * 100);
fprintf('Program paused. Press enter to continue.\n');
pause;

%% ================ Part 9: Re-Initializing Pameters ================
fprintf('\n Re-Initializing Neural Network Parameters ...\n')

Theta1 = randInitializeConnections(input_layer_size, hidden_layer_size);
Theta2 = abs(randInitializeWeights(hidden_layer_size, num_labels));


%% ================= Part 10: Training SVM against 9 digits (1/10 density) =================

fprintf('\n Balancing data sets for SVM ...\n')

X = loadMNISTImages('train-images.idx3-ubyte')';
y = loadMNISTLabels('train-labels.idx1-ubyte');

fprintf('\n Training with SVM type learning ...\n')
[xF,yF] = extractSet(X,y,5,9);
Theta2 = SVMLearn(Theta1, Theta2, input_layer_size, ...
                          hidden_layer_size, num_labels, xF, yF);
                      
%% ================= Part 11: Prediction with SVM against 9 digits (1/10 density) =================                  
                      
pred = predictSVM(Theta1, Theta2, xF);

yP = yF == 5;

fprintf('\n SVM Training Set Accuracy: %f\n', mean(double(pred == yP)) * 100);

X2 = loadMNISTImages('t10k-images.idx3-ubyte')';
y2 = loadMNISTLabels('t10k-labels.idx1-ubyte');

[x2F,y2F] = extractSet(X2,y2,5,9);

yP = y2F == 5;

pred = predictSVM(Theta1, Theta2, x2F);

fprintf('\n SVM Test Set Accuracy: %f\n', mean(double(pred == yP)) * 100);
fprintf('Program paused. Press enter to continue.\n');
pause;

%% ================= Part 9: Training Hebb ================= 
% 
% fprintf('\n Balancing data sets for Hebb ...\n')
% 
% X = loadMNISTImages('train-images.idx3-ubyte')';
% y = loadMNISTLabels('train-labels.idx1-ubyte');
% 
% fprintf('\n Training with Hebbian type learning ...\n')
% [xF,yF] = balanceSet(X,y,5,1);
% Theta2 = HebbLearn(Theta1, Theta2, input_layer_size, ...
%                           hidden_layer_size, num_labels, xF, yF);