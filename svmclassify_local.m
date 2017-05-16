function [bestscore, bgamma, bC] = svmclassify_local(data, class, indcs)

best = 0;
result = zeros(size(class, 1), 1);
for gamma = -15:1:3
    for C = -5:1:15
        for i=1:10
            i
            test = indcs == i;
            
            model = svmtrain(class(~test, :), data(~test, :), strcat('-g', 32, num2str(2^gamma), 32, '-c', 32, num2str(2^C)));
            result(test, :) = svmpredict(class(test, :), data(test, :), model);
        end
        
        auc = fastAUC((class+1)/2==1, result, 0);
        if best < auc
            best = auc;
            bestscore = result;
            bgamma  = gamma;
            bC = C;
        end
    end
end
end