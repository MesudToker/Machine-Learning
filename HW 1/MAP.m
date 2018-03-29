function labels = MAP(spamFreq, hamFreq, probSpam, test)

rows = size(test,1);
labels = zeros(rows,1);

for i = 1:rows
    spamFreq1 =  test(i,:).*log(spamFreq);
    spamProb = log(probSpam) + sum(spamFreq1);
    
    hamFreq1 =  test(i,:).*log(hamFreq);
    hamProb = log(1-probSpam) + sum(hamFreq1);
     
    if(spamProb > hamProb)
        labels(i) = 1;
    end
end
end