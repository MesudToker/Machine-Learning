function [meanout1, meanout2, meanout3, varout1, varout2, varout3, testconfusionTable, trainconfusionTable, predictAccuracy] = Q5(train, test)

features = train(:,1:end-1);
labels = train(:,end);

testFeature = test(:,1:end-1);
testLabel = test(:,end);

predictlabels = zeros(size(test,1),1);

cancer1 = features(labels == 1,:);
cancer2 = features(labels == 2,:);
cancer3 = features(labels == 3,:);

probcancer1 = size(cancer1,1) / size(train,1);
probcancer2 = size(cancer2,1) / size(train,1);
probcancer3 = size(cancer3,1) / size(train,1);

meanout1 = mean(cancer1);
meanout2 = mean(cancer2);
meanout3 = mean(cancer3);

mean1 = repmat(meanout1,size(test,1),1); 
mean2 = repmat(meanout2,size(test,1),1);
mean3 = repmat(meanout3,size(test,1),1);

varout1 = var(cancer1);
varout2 = var(cancer2);
varout3 = var(cancer3);

var1 = repmat(varout1,size(test,1),1); 
var2 = repmat(varout2,size(test,1),1);  
var3 = repmat(varout3,size(test,1),1); 

cancer1prob = sum((-1*(testFeature-mean1).^2)./(2*var1),2) + sum(log(1./sqrt(2*pi*var1)),2) + log(probcancer1);
cancer2prob = sum((-1*(testFeature-mean2).^2)./(2*var2),2) + sum(log(1./sqrt(2*pi*var2)),2) + log(probcancer2);
cancer3prob = sum((-1*(testFeature-mean3).^2)./(2*var3),2) + sum(log(1./sqrt(2*pi*var3)),2) + log(probcancer3);

for i=1:size(testLabel,1) 
   [a, predictlabels(i)] = max([cancer1prob(i) cancer2prob(i) cancer3prob(i)]);
end

testconfusionTable = zeros(3);

for i=1:size(testLabel,1)
    k = testLabel(i,1);
    l = predictlabels(i,1);
    testconfusionTable(k,l) = testconfusionTable(k,l) + 1;
end

wrongPredict = size(labels,1) - testconfusionTable(1,1) - testconfusionTable(2,2) - testconfusionTable(3,3);
predictAccuracy(1,1) = (100 - wrongPredict/size(labels,1)*100);

mean1 = repmat(meanout1,size(train,1),1); 
mean2 = repmat(meanout2,size(train,1),1);
mean3 = repmat(meanout3,size(train,1),1);

var1 = repmat(varout1,size(train,1),1); 
var2 = repmat(varout2,size(train,1),1);  
var3 = repmat(varout3,size(train,1),1); 

cancer1prob = sum((-1*(features-mean1).^2)./(2*var1),2) + sum(log(1./sqrt(2*pi*var1)),2) + log(probcancer1);
cancer2prob = sum((-1*(features-mean2).^2)./(2*var2),2) + sum(log(1./sqrt(2*pi*var2)),2) + log(probcancer2);
cancer3prob = sum((-1*(features-mean3).^2)./(2*var3),2) + sum(log(1./sqrt(2*pi*var3)),2) + log(probcancer3);

for i=1:size(labels,1)
   [a, predictlabels(i)] = max([cancer1prob(i) cancer2prob(i) cancer3prob(i)]) ;
end

trainconfusionTable = zeros(3);

for i=1:size(labels,1)
    k = labels(i,1);
    l = predictlabels(i,1);
    trainconfusionTable(k,l) = trainconfusionTable(k,l) + 1;
end

wrongPredict = size(labels,1) - trainconfusionTable(1,1) - trainconfusionTable(2,2) - trainconfusionTable(3,3);
predictAccuracy(1,2) = (100 - wrongPredict/size(labels,1)*100);

trainconfusionTable = trainconfusionTable.';
testconfusionTable = testconfusionTable.';

end
