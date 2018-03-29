% Function for Question 3b

% It gives bestAccuracy, bestC, bestGamma, testAccuracy array as output
% output = [bestAccuracy bestC bestGamma testAccuracy];
% bestAccuracy shows highest cross validation accuracy
% bestC shows the corresponding C value of bestAccuracy
% bestGamma shows the corresponding Gamma value of bestAccuracy
% testAccuracy shows the accuracy of the test data

function [output] = hw2_q3b()
% Getting data from the folder
sBs = load('shuffledB.mat');
sPs = load('shuffledP.mat');

Bs = sBs.Bs;
Ps = sPs.Ps;

% 70% of the data is train data
sizeB = int32( size(Bs,1)*0.7 );
sizeP = int32( size(Ps,1)*0.7 );
train = Bs(1:sizeB,:);
train = [train;Ps(1:sizeP,:)];

% Class B is 0, Class P is 1
truetrainlabel = zeros(sizeB+sizeP,1);
truetrainlabel(sizeB+1:end,1) = ones;

% Remainder (30%) of the data is test data
test = Bs(sizeB+1:end,:);
test = [test;Ps(sizeP+1:end,:)];

truetestlabel = zeros(size(Bs,1)-sizeB+size(Ps,1)-sizeP,1);
truetestlabel(size(Bs,1) - sizeB + 1 : end, 1) = ones;

% Cost parameter C and Gamma
noofC = 11;
C = logspace(-6,2,noofC);
gamma = [1/512 1/256 1/128 1/64 1/32 1/16 1/8 1/4 1/2 1 2];

accuracy = zeros(noofC, noofC);

kfold = 10;

% Cross Validation and Accuracy of C and Gamma Calculations
for i=1:noofC
    for k=1:noofC
        [ avg ] = crossValidation_3b(C(i), gamma(k), kfold, train, truetrainlabel);
        accuracy(i,k) = avg;
    end
end

accuracy = accuracy * 100;

% Surface Plot for accuracy vs parameters C and Gamma
surf(C, gamma, accuracy.');
title('Accuracy vs Cost & Gamma');
xlabel('Cost (C)');
ylabel('Gamma');
zlabel('Accuracy');
set(gca,'xScale','log','yScale','log');

% Best accuracy among all C's and Gamma's
[bestAccuracies, index] = max(accuracy);
[bestAccuracy, indexGamma] = max(bestAccuracies);

indexC = index(indexGamma);
bestC = C(indexC);
bestGamma = gamma(indexGamma);

% Train SVM with best C and best Gamma
bestSVMMdl = fitcsvm(train, truetrainlabel, 'KernelFunction', 'RBF', 'BoxConstraint', bestC, 'KernelScale', 1/(2*bestGamma)^(1/2));
% Prediction for test data
predictlabel = predict(bestSVMMdl, test);
% Accuracy of SVM model with test data
CP = classperf(truetestlabel, predictlabel);
testAccuracy = CP.CorrectRate * 100;

% output of the function
output = [bestAccuracy bestC bestGamma testAccuracy];

% Output of predict label of test data
file = fopen('hw2_q3b_PredictLabels.txt','w');
fprintf(file,'%d\n',predictlabel);
fclose(file);

end