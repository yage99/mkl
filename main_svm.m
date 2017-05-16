% function ans = main_svm(class, orgdata)
% left = size(orgdata, 2);
% while left > 80
%     rank = SVMRFE(class, orgdata);
%     [~, indc] = sort(rank);
%     left = floor(left * 0.5)
%     orgdata = orgdata(:, indc(1:left));
% end

[~, rank_indc] = sort(rank);
result = zeros(size(class));
for ratio=10:10:100
    ratio
    [result, gamma, C] = svmclassify_local(orgdata(:, rank_indc(1:ratio)), class, indcs);
    fastAUC((class+1)/2==1, result, 1, strcat(num2str(ratio), '_svmrfe_', num2str(2^gamma), '_', num2str(2^C)));
end

% end