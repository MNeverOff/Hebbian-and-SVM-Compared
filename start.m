function [HTr,HTe,STr,STe] = start(one, many, svm, hebb, desired_digit, iterations, k, s, J, ...
                                HTr,HTe,STr,STe)


%% Setup the parameters of model

input_layer_size  = 784;    % 28x28 Input Images of Digits
hidden_layer_size = s;   % hidden units
num_labels = 2;             % 2 labels, n1 and n2 (isN, notN)
% k = 0.001;                  % learning rate
connectivity_rate = 0.1;    % connectivity rate
% desired_digit = 5;          % digit to classify
% second_digit = 4;           % second digit to pick

%% ================ Loading and Visualizing Data ================

% Load Training Data
fprintf('Loading and Visualizing Data ...\n')

% Change the filenames if you've saved the files under different names
% On some platforms, the files might be saved as 
% train-images.idx3-ubyte / train-labels.idx1-ubyte
XI = loadMNISTImages('train-images.idx3-ubyte')';
yI = loadMNISTLabels('train-labels.idx1-ubyte');

X = XI(repmat(1:size(XI,1),iterations,1),:);
y = yI(repmat(1:size(yI,1),iterations,1),:);

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
   for second_digit = 0:9
       close all; 
       fprintf('\n Balancing data sets ...\n');

       xF = X; yF = y;
%            [xF,yF] = balanceSet(X,y,desired_digit,second_digit);
%            [x2F,y2F] = balanceSet(X2,y2,desired_digit,second_digit);
       x2F = X2; y2F = y2;

       [HTr,HTe,STr,STe] = ONEvsONE(svm, hebb, X, y, X2, y2, Theta1, Theta2, desired_digit, ...
           second_digit, input_layer_size, hidden_layer_size, num_labels, k, ...
           HTr, HTe, STr, STe, J, xF, yF, x2F, y2F);
   end
   save(date,'HTr','HTe','STr','STe');
end

if (many)
    fprintf('\n Extracting data sets ...\n');
           
%     [xF,yF] = extractSet(X,y,desired_digit,10);
    xF = X; yF = y;
%     [x2F,y2F] = extractSet(X2,y2,desired_digit,10);
    x2F = X2; y2F = y2;
    
   close all; 
   [HTr,HTe,STr,STe] = ONEvsONE(svm, hebb, X, y, X2, y2, Theta1, Theta2, desired_digit, ...
       0, input_layer_size, hidden_layer_size, num_labels, k, ...
       HTr, HTe, STr, STe, J, xF, yF, x2F, y2F);
   save('OvM','HTr','HTe','STr','STe');
end

