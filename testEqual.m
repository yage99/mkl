function result = testEqual(matrix1, matrix2)
    for i=1:size(matrix1, 1)
        if(~strcmp(matrix1(i), matrix2(i)))
            result = 0;
            return
        end
    end
    result = 1;
end