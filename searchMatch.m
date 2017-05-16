function result = searchMatch(src, dist)

result = cell(size(src, 1), size(dist, 2));
for i=1:size(src,1)
    for j=1:size(dist,1)
        if(strcmp(src(i,1), strcat(dist(j,1), '-01')))
            result(i, :) = dist(j,:);
        end
    end
end

end