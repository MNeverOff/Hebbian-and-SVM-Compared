function p = universalPredict(Theta1, Theta2, X)
%PREDICT Predict the label of an input given a trained neural network
%   p = PREDICT(Theta1, Theta2, X) outputs the predicted label of X given the
%   trained weights of a neural network (Theta1, Theta2)

% Useful values
m = size(X, 1);
num_labels = size(Theta2, 1);

p = zeros(size(X));

h1 = heav(X * Theta1');
% h1 = X;
h2 = (h1 * Theta2');
p = h2(:,1) >= h2(:,2);
% =========================================================================

end