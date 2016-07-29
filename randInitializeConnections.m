function W = randInitializeConnections(L_in, L_out,r)

W = zeros(L_out, L_in);
m = L_in;
% ====================== YOUR CODE HERE ======================
% Instructions: Initialize W randomly so that we break the symmetry while
%               training the neural network.
%
% Note: The first row of W corresponds to the parameters for the bias units
%

% Randomly initialize the weights to small values
for I = 1:m
    W(:,I) = 0 + (1-0).*rand(L_out,1) <= r;
end


% =========================================================================

end