function y = bin_transform(x)

y = x;

for i = 1:length(y)
    for j = 1:57
        
        if y(i,j) > 0
            y(i,j) = 1;
        elseif y(i,j) <= 0 
            y(i,j) = 0;
        end
        
    end
end

end
