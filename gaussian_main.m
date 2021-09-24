clc;

%load data
load 'spamData.mat'

%data preprocessing
xtrain = log_transform(Xtrain);
xtest = log_transform(Xtest);

%compute class prior
lamda = compute_prior(ytrain);

%compute mean and std
index0 = (ytrain == 0);
index1 = (ytrain == 1);
x0 = xtrain(index0,:);
x1 = xtrain(index1,:);

mean0 = mean(x0,1);
std0 = std(x0,1);

mean1 = mean(x1,1);
std1 = std(x1,1);

%parameters defined
pred_train = zeros(length(ytrain),1);
pred_test = zeros(length(ytest),1);

%training set
for i = 1:length(ytrain)
    
    pf0 = normpdf(xtrain(i,:),mean0,std0);
    py0 = log(1-lamda) + sum(log(pf0));
    
    pf1 = normpdf(xtrain(i,:),mean1,std1);
    py1 = log(lamda) + sum(log(pf1));
    
    if py0 > py1
        pred_train(i) = 0;
    elseif py0 < py1
        pred_train(i) = 1;
    end
    
end

error_train = compute_error(ytrain,pred_train);
    
%testing set
for i = 1:length(ytest)
    
    pf0 = normpdf(xtest(i,:),mean0,std0);
    py0 = log(1-lamda) + sum(log(pf0));
    
    pf1 = normpdf(xtest(i,:),mean1,std1);
    py1 = log(lamda) + sum(log(pf1));
    
    if py0 > py1
        pred_test(i) = 0;
    elseif py0 < py1
        pred_test(i) = 1;
    end
    
end

error_test = compute_error(ytest,pred_test);






