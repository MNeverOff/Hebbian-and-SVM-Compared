function [xB,yB] = extractSet(X,y,digit1,rate)
%HEAVE Compute heaviside functoon
%   g = HEAVE(z) computes the heaviside of z.
input_layer_size = size(X,2);

yF = [];
k = 1;
for I=1:size(y,1)
   if (y(I) == digit1)
        yF = [yF; y(I)];
        k = k - 1;
   elseif (k == rate)
        yF = [yF; y(I)];
        k = 0;
   end
   k = k + 1;
end

num = size(yF,1);
xF = zeros(num,input_layer_size);

k = 0;
j = 1;
for I=1:size(y,1)
    if (y(I) == digit1)
        xF(j,:) = X(I,:);
        j = j+1;
    elseif (k == rate)
        xF(j,:) = X(I,:);
        j = j+1;
        k = 0;
    end
    k = k + 1;
end

xB = xF; yB = yF;

end