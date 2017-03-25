function plotResultsFinal2(C,p,name)
%PLOTRESULTSFINAL Summary of this function goes here
%   Detailed explanation goes here

figure('Name',name,'NumberTitle','off');
k = 1;
kA = [0.000001 0.000003 0.00001 0.00003 0.0001 0.0003 0.001 0.003 0.01 0.03];
for i=1:3
    corr = 30*0;
    subplot(1,3,k);
    hold on;
    for l=3:4
       plot(C(l,i+corr:3:corr+30));
    end
    axis([0,10,0.8,1]);
    maxF = max(C(4,i+corr:3:corr+30));
    maxFI = find(C(4,:) == maxF);
    tit = sprintf('\nF1:%1.4f,Acc:%1.4f\n k:%f', maxF(1),C(3,maxFI(1)),p(3,maxFI(1)));
    set(gca,'xtick',1:10);
    title(tit);
    hold off;
    k=k+1;
end

end

