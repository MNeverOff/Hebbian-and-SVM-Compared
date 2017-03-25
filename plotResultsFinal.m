function plotResultsFinal(C,p,name)
%PLOTRESULTSFINAL Summary of this function goes here
%   Detailed explanation goes here

figure('Name',name,'NumberTitle','off');
k = 1;
for i=1:3
    for j=0:4
        corr = 30*j;
        subplot(3,5,k);
        hold on;
        for l=3:4
           plot(C(l,i+corr:3:corr+30));
        end
        axis([0,10,0.8,1]);
        maxF = max(C(4,i+corr:3:corr+30));
        maxFI = find(C(4,:) == maxF);
        tit = sprintf('\nF1:%1.4f,Acc:%1.4f\n k:%f', maxF(1),C(3,maxFI(1)),p(3,maxFI(1)));
        title(tit);
        hold off;
        k=k+1;
    end
end

end

