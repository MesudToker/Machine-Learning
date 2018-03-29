% Function for Question 3a

% It takes the dataPath parameter
% dataPath is the path of the folder in which HW2data.mat placed

% It gives bestAccuracy, bestC, testAccuracy array as output
% output = [bestAccuracy bestC testAccuracy];
% bestAccuracy shows highest cross validation accuracy
% bestC shows the corresponding C value of bestAccuracy
% testAccuracy shows the accuracy of the test data

function [output] = hw2_q3a(dataPath)
% Example dataPath = 
% 'C:\Users\lenovo\Desktop\MESUD\6. Semester\CS 464 Machine Learning\HW 2'

% Getting data from data folder
currPath = cd(dataPath);
data = load('HW2data.mat');
cd(currPath);

Bs = data.Bs;
Ps = data.Ps;

% To shuffle the data set
Bs = Bs(randperm(size(Bs, 1)), :);
Ps = Ps(randperm(size(Ps, 1)), :);

% Save shuffled versions of data set to workspace
save('shuffledB.mat', 'Bs');
save('shuffledP.mat', 'Ps');

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

% Cost parameter C
noofC = 11;
C = logspace(-6,2,noofC);
successOfC = zeros(1,noofC);

kfold = 10;

% Cross Validation and Accuracy of C Calculation
for i=1:noofC
    [ avg ] = crossValidation_3a(C(i), kfold, train, truetrainlabel);
    successOfC(1,i) = avg;
end

successOfC = successOfC * 100;

% Plot for accuracy vs cost parameter C
figure;
semilogx(C, successOfC);
title('Cost (C) vs Accuracy');
xlabel('Cost (C)');
ylabel('Accuracy');

% Best accuracy of all C's
[bestAccuracy, indexC] = max(successOfC);
bestC = C(1,indexC);

% Train SVM with best C
bestSVMMdl = fitcsvm(train, truetrainlabel, 'KernelFunction', 'linear', 'BoxConstraint', bestC);
% Prediction for test data
predictlabel = predict(bestSVMMdl, test);
% Accuracy of SVM model with test data
CP = classperf(truetestlabel, predictlabel);
testAccuracy = CP.CorrectRate*100;

% output of the function
output = [bestAccuracy bestC testAccuracy];

% Output of predict label of test data
file = fopen('hw2_q3a_PredictLabels.txt','w');
fprintf(file,'%d\n',predictlabel);
fclose(file);

end