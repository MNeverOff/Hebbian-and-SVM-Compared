function [ T ] = processDataTable( T, p )
%PROCESSDATATABLE Summary of this function goes here
%   Detailed explanation goes here

T(5,:) = (T(1,:)./(T(1,:)+T(2,:)));                             % Precision
T(6,:) = (T(1,:)./(T(1,:)+T(3,:)));                             % Recall
T(7,:) = (T(1,:) + T(4,:))./(T(1,:)+T(2,:)+T(3,:)+T(4,:));% Accuracy
T(8,:) = 2.*(T(6,:).*T(7,:))./(T(6,:)+T(7,:));                % F1
C = zeros(size(T,1),size(T,2)/10);

for J=1:size(T,1)
    for I=0:9
        corr = 150*I;
        Temp(I+1,:) = T(J,1+corr:150+corr);
    end
    C(J,:) = mean(Temp);
end

maxF = max(C(8,:)); maxA = max(C(7,:));
maxFI = find(C(8,:) == max(C(8,:)));
fprintf('\n SVM Test F1: %f, accuracy: %f (max is %f) \n Parameters: I:%d k:%d S:%d', maxF,C(7,maxFI),maxA,p(2,maxFI),p(3,maxFI),p(4,maxFI));
tit = sprintf('\n F1: %f, Acc: %f (Max: %f) at %d', maxF,C(7,maxFI),maxA,maxFI);

figure;
title(tit);
xlabel('Parameters');
yyaxis left;
plot(C(7,:));
ylabel('Accuracy');
yyaxis right;
plot(C(8,:))
ylabel('F1 Score');
hold on;
linex = [maxFI,maxFI];
liney = [0,1];
plot(linex,liney,'MarkerFaceColor',[1,1,1]);
hold off;
end