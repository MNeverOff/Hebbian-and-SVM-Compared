function plotTables(iters,correction)

load(date);

figure;
subplot(2,2,1);
imagesc(HTr);
colormap(hot);
colorbar;
xlabel('Parameter multiplier') % x-axis label
ylabel('Numbers') % y-axis label
set(gca,'xtick',1:iters);
set(gca,'xticklabel',correction);
set(gca,'yticklabel',[0:9]);

subplot(2,2,2);
imagesc(HTe);
colormap(hot);
colorbar;
xlabel('Parameter multiplier') % x-axis label
ylabel('Numbers') % y-axis label
set(gca,'xtick',1:iters);
set(gca,'xticklabel',correction);
set(gca,'yticklabel',[0:9]);

subplot(2,2,3);
imagesc(STr);
colormap(hot);
colorbar;
xlabel('Parameter multiplier') % x-axis label
ylabel('Numbers') % y-axis label
set(gca,'xtick',1:iters);
set(gca,'xticklabel',correction);
set(gca,'yticklabel',[0:9]);

subplot(2,2,4);
imagesc(STe);
colormap(hot);
colorbar;
xlabel('Parameter multiplier') % x-axis label
ylabel('Numbers') % y-axis label
set(gca,'xtick',1:iters);
set(gca,'xticklabel',correction);
set(gca,'yticklabel',[0:9]);

end