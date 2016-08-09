function [HTr,HTe,STr,STe] = start(one,many,svm,hebb,desired_digit,iterations, ...
    HTr,HTe,STr,STe, correction)


%% Setup the parameters of model

input_layer_size  = 784;    % 28x28 Input Images of Digits
hidden_layer_size = 300;   % hidden units
num_labels = 2;             % 2 labels, n1 and n2 (isN, notN)
k = 0.001;                  % learning rate
connectivity_rate = 0.1;    % connectivity rate
% desired_digit = 5;          % digit to classify
% second_digit = 4;           % second digit to pick

%% ================ Loading and Visualizing Data ================

% Load Training Data
fprintf('Loading and Visualizing Data ...\n')

% Change the filenames if you've saved the files under different names
% On some platforms, the files might be saved as 
% train-images.idx3-ubyte / train-labels.idx1-ubyte
X = loadMNISTImages('train-images.idx3-ubyte')';
y = loadMNISTLabels('train-labels.idx1-ubyte');

% for F = 1:1
%    X = [X; X]; 
%    y = [y; y];
% end

X2 = loadMNISTImages('t10k-images.idx3-ubyte')';
y2 = loadMNISTLabels('t10k-labels.idx1-ubyte');

% Randomly select 100 data points to display
% m = size(X, 1);
% rand_indices = randperm(m);
% sel = X(rand_indices(1:100), :);
% displayData(sel);

%% ================ Initializing Pameters ================
fprintf('\n Initializing Neural Network Parameters ...\n')

Theta1 = randInitializeConnections(input_layer_size, hidden_layer_size, connectivity_rate);
Theta2 = abs(randInitializeWeights(hidden_layer_size, num_labels));

%% ================ Calling methods ================
if (one)
    for I = 1:iterations
       for second_digit = 0:9
           close all; 
           fprintf('\n Balancing data sets ...\n');
           
           [xF,yF] = balanceSet(X,y,desired_digit,second_digit);
           [x2F,y2F] = balanceSet(X2,y2,desired_digit,second_digit);
           
           [HTr,HTe,STr,STe] = ONEvsONE(svm, hebb, X, y, X2, y2, Theta1, Theta2, desired_digit, ...
               second_digit, input_layer_size, hidden_layer_size, num_labels, k, ...
               HTr, HTe, STr, STe, I, correction,xF, yF, x2F, y2F);
       end
    end
end
if (many)
    fprintf('\n Extracting data sets ...\n');
           
    [xF,yF] = extractSet(X,y,desired_digit,10);
%     [x2F,y2F] = extractSet(X2,y2,desired_digit,10);
    x2F = X2; y2F = y2;
    
    for I = 1:iterations
           close all; 
           [HTr,HTe,STr,STe] = ONEvsONE(svm, hebb, X, y, X2, y2, Theta1, Theta2, desired_digit, ...
               0, input_layer_size, hidden_layer_size, num_labels, k, ...
               HTr, HTe, STr, STe, I, correction,xF, yF, x2F, y2F);
    end
end

