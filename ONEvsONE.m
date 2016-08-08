function [HTr,HTe,STr,STe] = ONEvsONE(svm, hebb, X, y, X2, y2, Theta1, Theta2, desired_digit, second_digit, ...
    input_layer_size, hidden_layer_size, num_labels, k,HTr,HTe,STr,STe, I, correction)

MTheta2 = Theta2;

fprintf('\n Balancing data sets ...\n');
[xF,yF] = balanceSet(X,y,desired_digit,second_digit);
[x2F,y2F] = balanceSet(X2,y2,desired_digit,second_digit);

if (svm)
%% ================= Part 7: Training SVM against 1 digit =================
fprintf('\n Training with SVM type learning ...\n');
threshold = (1*(hidden_layer_size^(1/2)))*correction(I);
Theta2 = SVMLearn(Theta1, Theta2, desired_digit, input_layer_size,...
                          hidden_layer_size, num_labels, xF, yF, k, threshold);
                      
%% =================  Prediction with SVM against 1 digit =================

pred = predictSVM(Theta1, Theta2, xF);
yP = yF == desired_digit;
acc = mean(double(pred == yP)) * 100;
fprintf('\n ---- \n SVM Training Set Accuracy: %f\n', acc);
STr(second_digit+1,I) = acc;

yP = y2F == desired_digit;
pred = predictSVM(Theta1, Theta2, x2F);
acc = mean(double(pred == yP)) * 100;
fprintf('\n SVM Test Set Accuracy: %f\n ---- \n', acc);
STe(second_digit+1,I) = acc;
% fprintf('Program paused. Press enter to continue.\n');
% pause;
end

if (hebb)
%% ================= Training Hebb against 1 digit =================
Theta2 = MTheta2;

fprintf('\n Training with Hebbian type learning ...\n')
threshold = 1*correction(I);

Theta2 = HebbLearn(Theta1, Theta2, desired_digit, input_layer_size, ...
                          hidden_layer_size, num_labels, xF, yF, k, threshold);
                      
%% ================= Prediction with Hebb against 1 digit =================                  
                      
pred = predictSVM(Theta1, Theta2, xF);
yP = yF == desired_digit;
acc = mean(double(pred == yP)) * 100;
fprintf('\n ---- \nHebbian Training Set Accuracy: %f', acc);
HTr(second_digit+1,I) = acc;

yP = y2F == desired_digit;
pred = predictSVM(Theta1, Theta2, x2F);
acc = mean(double(pred == yP)) * 100;
fprintf('\n Hebbian Test Set Accuracy: %f\n ---- \n', acc);
HTe(second_digit+1,I) = acc;
% fprintf('Program paused. Press enter to continue.\n');
% pause;
end