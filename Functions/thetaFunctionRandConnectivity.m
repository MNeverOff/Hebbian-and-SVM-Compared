function [Theta] = thetaFunctionRandConnectivity(sizes, r)
%THETAFUNCTION Summary of this function goes here
%   Detailed explanation goes here

%RANDINITIALIZECONNECTIONS
%RANDINITIALIZEWEIGHTS

r = 0.1;
Theta = createCellArray(size(sizes,2)-1, [0,0]);

for I = 1:size(sizes,2)-1 % each layer but the last
    if I == 1
        W = zeros(sizes(I), sizes(I+1));
        for J = 1:sizes(I)
            W(J,:) = 0 + (1-0).*rand(1, sizes(I+1)) <= r;
            Theta{I} = W;
        end
    else
        epsilon_init = 0.12;
        W = abs(rand(sizes(I),sizes(I+1)) * 2 * epsilon_init - epsilon_init);
        Theta{I} = W;
    end
end

end

