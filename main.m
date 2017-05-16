addpath(genpath('/home/ustc/project/yage/matlab'));

[clinical_filtered, filter] = preprossClinical(matched_clinical);

mat_cn_update = normalizemeanstd(copyNumber_matrix(filter, :));
mat_gene_update = normalizemeanstd(geneExp_matrix(filter, :));
mat_meth_update = normalizemeanstd(methylation_matrix(filter, :));
mat_mirna_update = normalizemeanstd(miRNA_matrix(filter, :));
mat_age_update = normalizemeanstd(matched_age(filter, :));

update_data = [mat_cn_update, mat_mirna_update, mat_gene_update, mat_age_update, mat_meth_update];
%orgdata = mat_geneExp;
update_data(update_data >= 2) = 0;
update_data(update_data <= -2)  = 0;
update_data = normalizemeanstd(update_data);
name = [copyNumber_title, miRNA_title, geneExp_title, {'age'}, methylation_title];
%orgdata = normalizemeanstd(orgdata);
%for ratio=125:1:135
ratio = 130;
[data, feature_name] = selectFeature(update_data, clinical_filtered(:,1), ratio, name);
class = clinical_filtered(:,1);
% 
[~, sort_feature_indc] = sort(cell2mat(feature_name(2,:)));
%sorted_feature_name = feature_name(:,sort_feature_indc);
%data = data(:, sort_feature_indc);
%class(class == 1) = 4;
%% mkl cv
result = zeros(size(class));
for i=1:10
    i
    test = indcs == i;
    [result(test, :), ~] = mklclassify(data(~test, :), class(~test, :), data(test, :), class(test, :), 300);
end
fastAUC((clinical_filtered(:,1)+1)/2==1, result, 1, strcat(num2str(ratio), '_mkl_big_h'))

%% validation
mat_cn_update = normalizemeanstd(cn_select_matrix);
mat_gene_update = normalizemeanstd(gene_select_matrix);
mat_meth_update = normalizemeanstd(meth_select_matrix);
mat_mirna_update = normalizemeanstd(mirna_select_matrix);
mat_age_update = normalizemeanstd(cell2mat(clinical_update(:,4)));

update_data = [mat_cn_update, mat_mirna_update, mat_gene_update, mat_age_update, mat_meth_update];
%orgdata = mat_geneExp;
update_data(update_data >= 2) = 0;
update_data(update_data <= -2)  = 0;
update_data = normalizemeanstd(update_data);

for i=1:size(update_data,2)
    update_data(:,sort_feature_indc(i)) = update_data(:,i);
end

update_class = clinical_select(:,1) > 2*365;
update_class = update_class * 2 - 1;
[update_result, ~] = mklclassify(data, class, update_data, update_class, 300);
fastAUC(update_class>0, update_result, 1, 'validation')

%% rearrange data
%% svm cv
% [result, gamma, C] = svmclassify_local(data, class, indcs);
% fastAUC((class+1)/2==1, result, 1, strcat(num2str(ratio), '_svm1_', num2str(2^gamma), '_', num2str(2^C)));

%end