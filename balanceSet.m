function [xB,yB] = balanceSet(X,y,digit1,digit2)
%HEAVE Compute heaviside functoon
%   g = HEAVE(z) computes the heaviside of z.
input_layer_size = size(X,2); 

yF = [];
for I=1:size(y,1)
   if (y(I) == digit1 || y(I) == digit2)
      yF = [yF; y(I)];
   end
end

num = size(yF,1);
xF = zeros(num,input_layer_size);

j = 1;
for I=1:size(y,1)
   if (y(I) == digit1 || y(I) == digit2)
      xF(j,:) = X(I,:);
      j = j+1;
   end
end

xB = xF; yB = yF;

end