X = loadMNISTImages('t10k-images.idx3-ubyte')';
y = loadMNISTLabels('t10k-labels.idx1-ubyte');
pred = zeros(size(y));
predTable = zeros(size(y,1),10);

for i=0:9
    for j=i+1:9
        T1name = sprintf('H%d_%dTheta1', i,j);
        T2name = sprintf('H%d_%dTheta2', i,j);
        
        T1 = load('OvOH.mat',T1name);
        Theta1 = T1.(T1name);
        T2 = load('OvOH.mat',T2name);
        Theta2 = T2.(T2name);
        
        p = predictSVM(Theta1,Theta2,X);
        
        for k=1:size(p,1)
           if (p(k))
               predTable(k,i+1) = predTable(k,i+1)+1;
           else
               predTable(k,j+1) = predTable(k,j+1)+1;
           end
        end
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