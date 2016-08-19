X = loadMNISTImages('t10k-images.idx3-ubyte')';
y = loadMNISTLabels('t10k-labels.idx1-ubyte');
pred = zeros(size(y));
predTable = zeros(size(y,1),10);

for i=0:9
    T1name = sprintf('S%d_%dTheta1', i,0);
    T2name = sprintf('S%d_%dTheta2', i,0);

    T1 = load('OvMS.mat',T1name);
    Theta1 = T1.(T1name);
    T2 = load('OvMS.mat',T2name);
    Theta2 = T2.(T2name);

    p = predictSVM2(Theta1,Theta2,X);

    for k=1:size(p,1)
        predTable(k,i+1) = p(k);
    end
end

cc = predTable;

for i=1:size(pred,1)
   k = find(predTable(i,:) == max(predTable(i,:)));
   r = rand(length(k),1);
   d = k(find(r == max(r)));
   pred(i) = d-1;
end

fprintf('Accuracy: %f',mean(y==pred));