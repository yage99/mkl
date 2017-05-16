c_old = zeros(length(clinical_name), 1);
c_new = zeros(length(clinical_new), 1);
for i=1:length(clinical_name)
    for j=1:length(clinical_new)
        if(strcmp(clinical_name{i}, clinical_new{j}) == 1)
            c_old(i) = 1;
            c_new(j) = 1;
            break
        end
    end
end
