function result = drawSurvival(result, threshold)
figure
[f, x] = ecdf(result(result(:,1)>threshold,3), 'frequency', ones(sum(result(:,1)>threshold), 1));
stairs(x, 1-f);
hold on
[f, x] = ecdf(result(result(:,1)<=threshold,3), 'frequency', ones(sum(result(:,1) <= threshold), 1));
stairs(x, 1-f);
end