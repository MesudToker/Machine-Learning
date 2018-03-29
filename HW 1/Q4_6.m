function [accuracy] = Q4_6(features, trainlabels, test, trueLabel)

accuracy = zeros(1,2500);

[spamFreq,hamFreq,probSpam] = Q4pre(features, trainlabels);
mutual = mutualInfo(features, spamFreq, hamFreq, probSpam);

for i = 1:2500   
    labels = MAP(spamFreq, hamFreq, probSpam, test);
    accuracy(i) = sum(abs(trueLabel-labels));
    [~,least] = min(mutual);
    mutual(1,least) = inf;
    spamFreq(1,least) =1;
    hamFreq(1,least) =1;
    test(:,least) = 0;
end    

accuracy = 100-accuracy*100/260;
plot(accuracy)

end

