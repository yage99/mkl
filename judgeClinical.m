function result = judgeClinical(clinical, threshold)
result = zeros(size(clinical,1),1);

for i=1:size(clinical,1)
    if(isnan(clinical(i,1)))
        if(isnan(clinical(i,2)))
            result(i) = NaN;
        elseif(clinical(i,2) > threshold)
            result(i) = 1;
        else
            result(i) = NaN;
        end
    elseif clinical(i,1) > threshold
        result(i) = 1;
    end
end

end