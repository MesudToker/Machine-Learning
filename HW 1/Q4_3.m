function [predictlabels] = Q4_3 (features, labels, test)

spam = features(labels == 1,:); % extract spam mails from features matrix
ham = features(labels == 0,:); % extract ham mails from features matrix

spamCount = sum(spam(:)); % total count of occurences in spams
hamCount = sum(ham(:)); % total count of occurences in hams

hamFreq = sum(ham)./hamCount; 
spamFreq = sum(spam)./spamCount;

probSpam = size(spam,1)/(size(spam,1)+size(ham,1));

rows = size(test,1);
predictlabels = zeros(rows,1);

for i = 1:rows
    spamFreq1 =  test(i,:).*log(spamFreq);
    spamFreq1(isnan(spamFreq1)) = 0;
    spamProb = log(probSpam) + sum(spamFreq1);
    
    hamFreq1 =  test(i,:).*log(hamFreq);
    hamFreq1(isnan(hamFreq1)) = 0;
    hamProb = log(1-probSpam) + sum(hamFreq1);
    
    if(spamProb > hamProb)
        predictlabels(i) = 1;
    end
end
end
