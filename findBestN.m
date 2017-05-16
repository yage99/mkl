function n = findBestN(data, class)
    for i=10:10:200
        indc = crossValind('Kfold', size(data, 1), 10);
        result = zeros(size(data, 1), 1);
        for j=1:10
            test = indc == j;
            result(test, :) = 
    end
end