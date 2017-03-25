X = loadMNISTImages('t10k-images.idx3-ubyte')';
y = loadMNISTLabels('t10k-labels.idx1-ubyte');
pred = zeros(size(y));
predTable = zeros(size(y,1),10);
load('MS');

for i=1:size(pred,1)
   k = find(predTable(i,:) == max(predTable(i,:)));
   r = rand(length(k),1);
   d = k(find(r == max(r)));
   pred(i) = d-1;
end

fprintf('Accuracy: %f',mean(y==pred));

% pr = find(pred==1); ac = find(y == 1);
% nPr = find(pred == 0); nAc = find(y == 0);
% tp = length(intersect(pr,ac)); fp = length(intersect(pr,nAc));
% fn = length(intersect(nPr,ac)); tn = length(intersect(nPr,nAc));
% precision = tp./(tp+fp); recall = tp./(tp+fn);
% acc = (tp+tn)./(tp+fp+fn+tn); f1 = (2*precision*recall)/(precision+recall);
% fprintf('\n ---- \n F1: %f Acc: %f \n', f1,acc);