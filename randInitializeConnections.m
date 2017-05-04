function W = randInitializeConnections(L_in, L_out,r)
%RANDINITIALIZECONNECTIONS Randomly initialize the connections of a layer with L_in
%incoming connections and L_out outgoing connections
%   W = RANDINITIALIZEWEIGHTS(L_in, L_out) randomly initializes the weights 
%   of a layer with L_in incoming connections and L_out outgoing 
%   connections. 

W = zeros(L_out, L_in);
m = L_in;

% Randomly initialize the weights to small values
for I = 1:m
    W(:,I) = 0 + (1-0).*rand(L_out,1) <= r;
end

end