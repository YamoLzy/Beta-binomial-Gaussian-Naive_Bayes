function class_prior = compute_prior(y)

n = 0;
m = length(y);

for i = 1:length(y)
    if y(i) == 1
        n = n + 1;
    end
end

class_prior = n / m;


end

