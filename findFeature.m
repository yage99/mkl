function num = findFeature(src, dist)
    for i=1:size(dist, 2)
        if(strcmp(src, dist(i)))
            num = i
        end
    end
end