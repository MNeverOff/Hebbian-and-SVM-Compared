function ONEvsMANY(X, y,X2,y2, Theta1, Theta2, desired_digit, second_digit, input_layer_size, ...
    hidden_layer_size, num_labels, k, L)

MTheta2 = Theta2;

fprintf('\n Balancing data sets for SVM ...\n')
[xF,yF] = extractSet(X,y,desired_digit,9);
[x2F,y2F] = extractSet(X2,y2,desired_digit,9);

%% ================= Training SVM against 9 digits (1/10 density) =================
fprintf('\n Training with SVM type learning ...\n')
Theta2 = SVMLearn(Theta1, Theta2, input_layer_size, ...
                          hidden_layer_size, num_labels, xF, yF,k);
                      
%% ================= Prediction with SVM against 9 digits (1/10 density) =================                  
                      
pred = predictSVM(Theta1, Theta2, xF);

yP = yF == desired_digit;

fprintf('\n SVM Training Set Accuracy: %f\n', mean(double(pred == yP)) * 100);

yP = y2F == desired_digit;

pred = predictSVM(Theta1, Theta2, x2F);

fprintf('\n SVM Test Set Accuracy: %f\n', mean(double(pred == yP)) * 100);
fprintf('Program paused. Press enter to continue.\n');
pause;

%% ================= Training Hebb against 9 digits (1/10 density) =================

fprintf('\n Balancing data sets for SVM ...\n')

fprintf('\n Training with SVM type learning ...\n')
[xF,yF] = extractSet(X,y,desired_digit,second_digit);
Theta2 = HebbLearn(Theta1, Theta2, input_layer_size, ...
                          hidden_layer_size, num_labels, xF, yF,k);
                      
%% ================= Prediction with Hebb against 9 digits (1/10 density) =================                  
                      
pred = predictSVM(Theta1, Theta2, xF);

yP = yF == desired_digit;

fprintf('\n SVM Training Set Accuracy: %f\n', mean(double(pred == yP)) * 100);

[x2F,y2F] = extractSet(X2,y2,desired_digit,second_digit);

yP = y2F == desired_digit;

pred = predictSVM(Theta1, Theta2, x2F);

fprintf('\n SVM Test Set Accuracy: %f\n', mean(double(pred == yP)) * 100);
fprintf('Program paused. Press enter to continue.\n');
pause;
