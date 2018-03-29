function [info] = mutualInfo(features, spamFreq, hamFreq, probSpam)

info = zeros(1,size(features,2));

wordProb = (sum(features)+ones(1,size(features,2)))./(sum(features(:))+size(features,2));

info = info + (spamFreq*probSpam) .* log2((spamFreq*probSpam)./(probSpam*wordProb));   % F = 1, C = 1
info = info + ((1-spamFreq)*probSpam) .* log2(((1-spamFreq)*probSpam)./(probSpam*(1-wordProb))); % F = 0, C = 1

info = info + (hamFreq*(1-probSpam)) .* log2((hamFreq*(1-probSpam))./((1-probSpam)*wordProb));   % F = 1, C = 0
info = info + ((1-hamFreq)*(1-probSpam)) .* log2(((1-hamFreq)*(1-probSpam))./((1-probSpam)*(1-wordProb)));  % F = 0, C = 0

end