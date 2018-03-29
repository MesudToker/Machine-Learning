function [values, bestFeatures] = Q4_5(features, labels)

spam = features(labels == 1,:); % extract spam mails from features matrix
ham = features(labels == 0,:); % extract ham mails from features matrix

spamCount = sum(spam(:)); % total count of occurences in spams
hamCount = sum(ham(:)); % total count of occurences in hams

hamFreq = (sum(ham) + ones(1,size(features,2)))./(hamCount + size(features,2));
spamFreq = (sum(spam) + ones(1,size(features,2)))./(spamCount + size(features,2));

probSpam = size(spam,1)/(size(spam,1)+size(ham,1));

info = mutualInfo(features,spamFreq,hamFreq,probSpam);

values = zeros(1,10);
bestFeatures = zeros(1,10);

for i=1:10
    [values(i),bestFeatures(i)] = max(info);
    info(bestFeatures(i)) = 0;
end
end
