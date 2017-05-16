function [feature, name] = selectFeature(matrix,clinical, n, name)
% this function selects feature from the matrix
% matrix is a value matrix
% matched_clinical is the original matched_clinical dataset
% n is the feature number to be selected
%
% it's output is a matrix with selected features

%% some feature is nan, remove them first
% temp = zeros(1,size(matrix,2));
% for i = 1: size(matrix, 2)
%     if sum(isnan(matrix(:,i))) > 0
%         temp(i) = 1;
%     end
% end
% temp = temp ==1;
% matrix = matrix(:,~temp);
% if nargin == 4
%     name=name(:,~temp);
% end

%% discretize by using mean+/-alpha*std. Here let alpha=0.5 for simplify
m = mean(matrix);
s = std(matrix);
disc_matrix = zeros(size(matrix));
for i = 1: size(matrix,2)
  disc_matrix(matrix(:, i)>=m(i)+s(i)/2, i) = 1;
  disc_matrix(matrix(:, i)<=m(i)-s(i)/2, i) = -1;
end

%% mrmr
if n < 1
    seln = floor(size(matrix,2)*n);
else
    seln = n;
end
feature_indc = mrmr_matrix(disc_matrix, clinical, seln);
feature = matrix(:,feature_indc);
if nargin == 4
    name=name(:,feature_indc);
    name = [name; num2cell(feature_indc)];
end
end