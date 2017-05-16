load simplecluster_dataset
net = patternnet(20);
net = train(net, simpleclusterInputs, simpleclusterTargets);
simpleclusterOutputs = sim(net, simpleclusterInputs);
plotroc(simpleclusterTargets, simpleclusterOutputs);