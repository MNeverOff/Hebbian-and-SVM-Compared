function [Theta2] = SVMLearn(Theta1, Theta2, ...
                                   input_layer_size, ...
                                   hidden_layer_size, ...
                                   num_labels, ...
                                   X, y,k)

% Valuable initialisations
m = size(X, 1);
isFive = y == 5;
topLimit = 1;
lowLimit = -1;

%tracking vars
hit_percents = zeros(1,m);
w1pc = 0; w1mc = 0; w2pc = 0; w2mc = 0;
w1p = 0; w1m = 0; w2p = 0; w2m = 0;
% ====================== Actual implementation ======================

% Changing y-vector from numeric reprsentation to "wheter 5 or not" matrix
% (m x 2)

% vectorised 4 later
% a1 = [ones(m,1) X];
% z2 = a1*Theta1';
% a2 = [ones(m,1) heav(z2)];
% z3 = a2*Theta2';
% a3 = sigmoid(z3);

figure;
displayData(X(1:100,:));
L = zeros(hidden_layer_size, m);

for I = 1:m
%     a1 = [1 X(I,:)];
    a1 = X(I,:);
    z2 = a1*Theta1';
%     a2 = [1 heavMax(z2)];
    a2 = heavMax(z2);
    z3 = a2*Theta2';
%     a3 = (z3(1) - z3(2));
    a3 = find(z3 == max(z3)) == 1;
    
    iF = isFive(I);
    hit_percents(I) = mean(a2);
    delta = k;
    
    if (mod(I,1000) == 0)
        fprintf('\n ANN progress: %d digits', I);
    end
    
    for N = 1:size(a2,2)
        if (a2(N))
           L(N,I) = 1; 
        end
        if (a2(N) && iF && a3)
            Theta2(1,N) = Theta2(1,N)+delta;
            w1pc = w1pc+1;
            w1p = w1p + delta;
        elseif (a2(N) && iF && ~a3)
            Theta2(2,N) = Theta2(2,N)-delta;
            w2mc = w2mc+1;
            w2m = w2m + delta;

        elseif (a2(N) && ~iF && a3)
            Theta2(1,N) = Theta2(1,N)-delta;
            w1mc = w1mc+1;
            w1m = w1m + delta;
        elseif (a2(N) && ~iF && ~a3)
            Theta2(2,N) = Theta2(2,N)+delta;
            w2pc = w2pc+1;
            w2p = w2p + delta;
        end
    end
    
    Theta2(1,:) = max(min(Theta2(1,:),topLimit),lowLimit);
    Theta2(2,:) = max(min(Theta2(2,:),topLimit),lowLimit);
end

% -------------------------------------------------------------

% active_threshold = 0.15;
% activeNeurons = sum(mean(L,2) >= active_threshold);
% activeIndexes = find(mean(L,2) >= active_threshold);
% %Replace L with Lactive
% Lactive = zeros(activeNeurons,size(L,2));
% for K=1:activeNeurons
%     if (mean(L(K,:)) >= active_threshold)
%        Lactive(K,:) = L(K,:);
%     end
%     K = K-1;
% end
Lactive = L;

% Histogramm of active ("decicion-making") neurons
figure;
five=find(y == 5);
nf= find(y==7);

five=find(y == 5);
nf= find(y==7);
score=(sum(Lactive(:,five),2)-sum(Lactive(:,nf),2))./(sum(Lactive,2)+1);
hist(score)

% Theta1 hits
[A B]=sort(Lactive(:,1),1);
figure;
C= Lactive(B,:);
imagesc(C(:,1:25))
set(gca,'xticklabel',y);
set(gca,'xtick',1:25);

% score-weight "Five" matrix
figure;
title('Weight/Score for Positive');
scatter(Theta2(1,:),score)
xlabel('Weights') % x-axis label
ylabel('Scores') % y-axis label

% score-weight "Not-Five" matrix
figure;
title('Weight/Score for Negative');
scatter(Theta2(2,:),score)
xlabel('Weights') % x-axis label
ylabel('Scores') % y-axis label

%tracking
fprintf('\n Average neuron hit percent: %f', mean(hit_percents));
fprintf('\n Added to w1 in total: %f (%d)', w1p,w1pc);
fprintf('\n Substracted from w1 in total: %f (%d)', w1m, w1mc);
fprintf('\n Added to w2 in total: %f (%d)', w2p, w2pc);
fprintf('\n Substracted from w2 in total: %f (%d)', w2m, w2mc);

% =========================================================================

end
