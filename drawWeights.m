function [x] = drawWeights(weight)
    for i=1:10
        x = reshape(weight(i,:),13,5);
        subplot(2,5,i);
        imagesc(1-x);
        set(gca,'ytick',[]);
    end
end