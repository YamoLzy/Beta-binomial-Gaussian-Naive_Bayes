%clear all
clc;

%load data
load 'spamData.mat'

%data processing
xtrain = bin_transform(Xtrain);
xtest = bin_transform(Xtest);

%compute class prior
lamda = compute_prior(ytrain);

%parameters defined
m_train = length(ytrain);
m_test = length(ytest);

pred_train = zeros(m_train,1);
pred_test = zeros(m_test,1);

error_train = zeros(201,1);
error_test = zeros(201,1);

alpha = 0:0.5:100;

%training set
for k = 1:length(alpha)
    p_fl = feature_likelihood(xtrain,ytrain,alpha(k));
    
    for i = 1:m_train

        pf0_1 = p_fl(1,:) .* xtrain(i,:);
        pf0_0 = (1 - p_fl(1,:)) .* (1 - xtrain(i,:));
        pf0 = pf0_1 + pf0_0;
        py0_train = log(1-lamda) + sum(log(pf0));

        pf1_1 = p_fl(2,:) .* xtrain(i,:);
        pf1_0 = (1 - p_fl(2,:)) .* (1 - xtrain(i,:));
        pf1 = pf1_1 + pf1_0;    
        py1_train = log(lamda) + sum(log(pf1));

        if py0_train > py1_train
            pred_train(i) = 0;
        elseif py0_train < py1_train
            pred_train(i) = 1;
        end
        
    end
    
    error_train(k) = compute_error(ytrain,pred_train);
    
end
    
%test set
for k = 1:length(alpha)
    p_fl = feature_likelihood(xtrain,ytrain,alpha(k));
    
    for i = 1:m_test

        pf0_1 = p_fl(1,:) .* xtest(i,:);
        pf0_0 = (1 - p_fl(1,:)) .* (1 - xtest(i,:));
        pf0 = pf0_1 + pf0_0;
        py0_test = log(1-lamda) + sum(log(pf0));

        pf1_1 = p_fl(2,:) .* xtest(i,:);
        pf1_0 = (1 - p_fl(2,:)) .* (1 - xtest(i,:));
        pf1 = pf1_1 + pf1_0;    
        py1_test = log(lamda) + sum(log(pf1));

        if py0_test > py1_test
            pred_test(i) = 0;
        elseif py0_test < py1_test
            pred_test(i) = 1;
        end
        
    end
    
    error_test(k) = compute_error(ytest,pred_test);
    
end

%plot
plot(alpha,error_train);
hold on
plot(alpha,error_test);
grid minor
legend("Train","Test")

xlabel("Beta Parameter: Alpha");
ylabel("Training/Testing Error")
title("Error over the change of alpha")





    
    
    
    
