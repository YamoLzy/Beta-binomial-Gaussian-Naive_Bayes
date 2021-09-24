function [prob] = feature_likelihood(xtrain,ytrain,alpha)

index0 = (ytrain == 0);
index1 = (ytrain == 1);

n0 = sum(index0);
n1 = sum(index1);

x0 = xtrain(index0,:);
x0_feature_total = sum(x0,1);

x1 = xtrain(index1,:);
x1_feature_total = sum(x1,1);

prob0 = (x0_feature_total + alpha) / (n0 + alpha + alpha);
prob1 = (x1_feature_total + alpha) / (n1 + alpha + alpha);

prob = [prob0;prob1];

end
