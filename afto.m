function [auc,sn,sp,f1, PPV, NPV] = afto(result, threshold)

tp = size(result(result(:,1)>threshold & result(:,2)>0,:),1);
fp = size(result(result(:,1)<threshold & result(:,2)>0,:),1);
tn = size(result(result(:,1)<threshold & result(:,2)<0,:),1);
fn = size(result(result(:,1)>threshold & result(:,2)<0,:),1);

auc = (tp+tn)/(tp+fp+tn+fn);
sn = tp/(tp+fn);
sp = tn/(tn+fp);
f1 = 2*tp/(2*tp+fp+fn);
PPV = tp/(tp+fp);
NPV = tn/(tn+fn);


end