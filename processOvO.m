function processOvM()
%PROCESSOVM Summary of this function goes here
%   Detailed explanation goes here

load('OvO.mat');

dA = [0:9];
iA = [1:5];             %1 is done in 10s, so this is 15x multiplier
kA = [0.000001 0.000003 0.00001 0.00003 0.0001 0.0003 0.001 0.003 0.01 0.03];
sA = [100 300 1000];    %100 is done in 10s, so this is x+3x+10x = 14x multiplier

p = zeros(4,size(dA,2)*size(iA,2)*size(kA,2)*size(sA,2));
i = 1;

for Q=1:size(iA,2)
    for W=1:size(dA,2)
        for E=1:size(kA,2)
           for R=1:size(sA,2)
              p(1:1,i) = dA(W);
              p(2:2,i) = iA(Q);
              p(3:3,i) = kA(E);
              p(4:4,i) = sA(R);
              i = i+1;
           end
        end
    end
end

processDataTable(STr,p);
processDataTable(STe,p);
processDataTable(HTr,p);
processDataTable(HTe,p);

% max(STe(5,:))
% max(STe(8,:))
% find(STe(5,:) == max(STe(5,:)))
% find(STe(5,:) == max(STe(5,751:900)))
% find(STe(8,:) == max(STe(8,751:900)))
% help reshape
% S = reshape(STe,150,80)
% pR = reshape(p,150,40)
% help reshape
% pR = reshape(p.',150,[])
% pR = reshape(p.',150,[])'
% S = reshape(STe.',150,[])'
% max(STe(41:48,:))
% max(mean(STe(41:48,:)))
% mean(S(41:48,:))
% max(mean(S(41:48,:)))
% find(mean(S(41:48,:) == max(mean(S(41:48,:)))))
% OvM.mat
% find(mean(S(41:48,:)) == max(mean(S(41:48,:))))
% find(mean(S(71:78,:)) == max(mean(S(71:78,:))))
% max(mean(S(41:48,:)))
% max(mean(S(41:48,140:150)))
% find(mean(S(41:48,:) == max(mean(S(41:48,:)))))
% mean(S(41:48,140:150))
% mean(S(41:47,140:150))
% max(mean(S(41:47,140:150)))
% max(mean(S(41:48,:)))
% max(mean(S(71:77,:)))
% find(S == max(mean(S(71:77,:))))
% find(S(71:77,:) == max(mean(S(71:77,:))))
% find(mean(S(71:77,:) )== max(mean(S(71:77,:))))
% find(pR(31,:)==300)
% t = find(pR(31,:)==300)
% s(t)
% S(t)
% S(t,:)
% S(:,t)
% St = s(:,t)
% St = S(:,t)
% max(mean(St(41:48,:)))
% find(mean(St(41:48,:) )== max(mean(St(41:48,:))))

end

