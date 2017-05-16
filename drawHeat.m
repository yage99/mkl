function result = drawHeat(class, feature)

corrs = corr(class, feature);
[corrs, indc] = sort(corrs);
feature = feature(:,indc);
[class, indc] = sort(class);
feature = feature(indc, :);

feature(feature > 3) = 0;
feature(feature < -3) = -0;

imagesc(feature);

end