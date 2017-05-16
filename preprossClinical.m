function [clinical, filtered_bool] = preprossClinical(matched_clinical)
%index = isnan(matched_clinical(:,1));
%matched_clinical(index, 1) = matched_clinical(index, 2);
%% filter
clinical_bool = judgeClinical(matched_clinical, 2*365);
filtered_bool = ~isnan(clinical_bool);
clinical_bool = clinical_bool(filtered_bool);
clinical = [clinical_bool*2-1, matched_clinical(filtered_bool, :)];
end