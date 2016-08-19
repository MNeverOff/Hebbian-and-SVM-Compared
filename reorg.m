function [X] = reorg(T)

% cnt=1;
% 
% for i=0:4
%     for d=0:9
%         for d2=0:9
%             for k=0:9
%                 for s=0:2
%                     if (d ~= d2)
%                         X(i+1,k+1,s+1,cnt)= T(4*d2+1,i*300+d*30+k*3+s+1);
%                         cnt= cnt+1;
%                     end
%                 end
%             end
%         end
%     end
% end

X = zeros(4,size(T,2));

for i=0:9
   for k=1:4
       T(k+4*i,1+150*i:150+150*i) = 0;
   end
end

for I=1:size(X,2)
    for k = 1:4
        X(k,I)=sum(T(k:4:40,I))/9;
    end
end