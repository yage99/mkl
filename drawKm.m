function [a] = drawKm(result)
    long = result(find(result(:,1) >=0),2);
    short = result(find(result(:,1) <0),2);
    
    %long = sort(long);
    %short = sort(short);
    
    ecdf(long, 'function', 'survivor');
    hold on;
    ecdf(short, 'function', 'survivor');
    
end