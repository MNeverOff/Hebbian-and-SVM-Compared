function g = heavMax(z)
%HEAVE Compute heaviside functoon
%   g = HEAVE(z) computes the heaviside of z.

g = z >= prctile(z,90);

end
