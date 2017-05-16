function [result] = sortMyMatrix(matrix)
    [~, indc] = sort(matrix(2:end, 1));
    indc = indc + 1;
    indc = [1; indc];
    result = matrix(indc, :);
end