function pred = compute_pred(x,w)

mu = (1 ./ (1+exp(-(x*w))));
pred = zeros(length(x),1);

for i = 1:length(x)
    
    if mu(i) > 0.5
        pred(i) = 1;
    else
        pred(i) = 0;
    end
    
end

end