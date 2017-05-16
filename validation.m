mat_train_cn = normalizemeanstd(train_cn);
mat_train_gene = normalizemeanstd(train_gene);
mat_train_meth = normalizemeanstd(train_meth);
mat_train_mirna = normalizemeanstd(train_mirna);
mat_train_age = normalizemeanstd(train_age);

train_data = [mat_train_cn, mat_train_mirna, mat_train_gene, mat_train_age, mat_train_meth];
%orgdata = mat_geneExp;
train_data(train_data >= 2) = 0;
train_data(train_data <= -2)  = 0;
train_data = normalizemeanstd(train_data);

mat_test_cn = normalizemeanstd(test_cn);
mat_test_gene = normalizemeanstd(test_gene);
mat_test_meth = normalizemeanstd(test_meth);
mat_test_mirna = normalizemeanstd(test_mirna);
mat_test_age = normalizemeanstd(test_age);

test_data = [mat_test_cn, mat_test_mirna, mat_test_gene, mat_test_age, mat_test_meth];
%orgdata = mat_geneExp;
test_data(test_data >= 2) = 0;
test_data(test_data <= -2)  = 0;
test_data = normalizemeanstd(test_data);

for i=1:size(train_data,2)
    train_data(:,sort_feature_indc(i)) = train_data(:,i);
    test_data(:,sort_feature_indc(i)) = test_data(:,i);
end

[update_result, ~] = mklclassify(train_data, train_class, test_data, test_class, 300);
fastAUC(test_class>0, update_result, 1, 'validation')