
[clinical_filtered, filter] = preprossClinical(matched_clinical);

mat_copyNumber = normalizemeanstd(cn_matrix(filter, :));
mat_geneExp = normalizemeanstd(gene_matrix(filter, :));
mat_methylation = normalizemeanstd(meth_matrix(filter, :));
mat_miRNA = normalizemeanstd(mirna_matrix(filter, :));
mat_age = normalizemeanstd(matched_age(filter, :));

orgdata = [mat_copyNumber, mat_miRNA, mat_geneExp, mat_age, mat_methylation];
%orgdata = mat_geneExp;
orgdata(orgdata >= 2) = 0;
orgdata(orgdata <= -2)  = 0;
orgdata = normalizemeanstd(orgdata);
%name = [copyNumber_title, miRNA_title, geneExp_title, {'age'}, methylation_title];
%orgdata = normalizemeanstd(orgdata);
%for ratio=125:1:135
%ratio = 130;
%[data, feature_name] = selectFeature(orgdata, clinical_filtered(:,1), ratio, name);
%class = clinical_filtered(:,1);
% 
% [~, sort_feature_indc] = sort(cell2mat(feature_name(2,:)));
% sorted_feature_name = feature_name(:,sort_feature_indc);
% data = data(:, sort_feature_indc);
%class(class == 1) = 4;
%% mkl cv
result = zeros(size(class));
[result(test, :), ~] = mklclassify(data(~test, :), class(~test, :), data(test, :), class(test, :), 300);
fastAUC((clinical_filtered(:,1)+1)/2==1, result, 1, strcat(num2str(ratio), '_mkl_big_h'))