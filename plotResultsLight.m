function plotResultsLight(C)
%PLOTRESULTSLIGHT Summary of this function goes here
%   Detailed explanation goes here

maxF = max(C(8,:)); maxA = max(C(7,:));
maxFI = find(C(8,:) == max(C(8,:)));
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

