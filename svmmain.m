addpath(genpath('/home/ustc/project/yage/matlab'));

[clinical_filtered, filter] = preprossClinical(matched_clinical);

mat_copyNumber = normalizemeanstd(copyNumber_matrix(filter, :));
mat_geneExp = normalizemeanstd(geneExp_matrix(filter, :));
mat_methylation = normalizemeanstd(methylation_matrix(filter, :));
mat_miRNA = normalizemeanstd(miRNA_matrix(filter, :));
mat_age = normalizemeanstd(matched_age(filter, :));

orgdata = [mat_copyNumber, mat_geneExp, mat_methylation, mat_miRNA, mat_age];
for ratio=10:10:150
    ratio
%mat_copyNumber = selectFeature(copyNumber_matrix(filter, :), clinical_filtered, ratio);
%mat_geneExp = selectFeature(geneExp_matrix(filter, :), clinical_filtered,  ratio);
%mat_methylation = selectFeature(methylation_matrix(filter, :), clinical_filtered,  ratio);
%mat_miRNA = selectFeature(miRNA_matrix(filter, :), clinical_filtered, ratio);

%mat_copyNumber = normalizemeanstd(mat_copyNumber);
%mat_geneExp = normalizemeanstd(mat_geneExp);
%m%at_methylation = normalizemeanstd(mat_methylation);
%mat_miRNA = normalizemeanstd(mat_miRNA);



data = selectFeature(orgdata, clinical_filtered, ratio);
data = normalizemeanstd(data);
class = clinical_filtered;

auc_mat = cell(4,1);
for gamma = -15:1:3
    for C = -5:1:15
        result = zeros(size(class));
        for i=1:10
            
            test = indcs == i;
            %result(test, :) = mklclassify(data(~test, :), class(~test, :), data(test, :), class(test, :));
            fold_data = data(~test, :);
            fold_class = class(~test, :);
            fold_test = data(test, :);
            fold_test_class = class(test, :);

            model = svmtrain(fold_class, fold_data, strcat('-q -g', 32, num2str(2^gamma), 32, '-c', 32, num2str(2^C)));
            result(test,:) = svmpredict(fold_test_class, fold_test, model, '-q');
        end
        auc = fastAUC((class+1)/2==1, result-min(min(result)),0);
        auc_mat = [auc_mat,[{2^gamma}; {2^C}; {auc};{result}]];
    end
end

[~, auc_indc] = sort(cell2mat(auc_mat(3,:)), 'descend');
result = cell2mat(auc_mat(4,auc_indc(1)));
name = strcat(num2str(ratio), '_svm_add_norm', strcat('-g', 32, num2str(cell2mat(auc_mat(1, auc_indc(1)))), 32, '-c', 32, num2str(cell2mat(auc_mat(2, auc_indc(1))))));
fastAUC((class+1)/2==1, result-min(min(result)), 1, name)

end