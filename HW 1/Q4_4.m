function [predictlabels] = Q4_4(features, labels, test)

spam = features(labels == 1,:); % extract spam mails from features matrix
ham = features(labels == 0,:); % extract ham mails from features matrix

spamCount = sum(spam(:)); % total count of occurences in spams
hamCount = sum(ham(:)); % total count of occurences in hams

hamFreq = (sum(ham) + ones(1,size(features,2)))./(hamCount + size(features,2));
spamFreq = (sum(spam) + ones(1,size(features,2)))./(spamCount + size(features,2));

probSpam = size(spam,1)/(size(spam,1)+size(ham,1));

predictlabels = MAP(spamFreq, hamFreq, probSpam, test);

end
