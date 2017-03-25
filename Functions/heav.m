function g = heav(z)
%HEAVE Compute heaviside functoon
%   g = HEAVE(z) computes the heaviside of z.

t = prctile(z',90)';
m = size(t,1);

dummy = ones(size(z));
t2 = zeros(size(z));

for j = 1 : m
  t2(j,:) = t(j) .* dummy(j,:);
end

g = z >= t2;

end
