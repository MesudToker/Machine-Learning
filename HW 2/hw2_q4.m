% Function for Question 4

% It gives bestAccuracy, bestRate, bestTestAccuracy array as output
% output = [bestAccuracy bestRate bestTestAccuracy];
% bestAccuracy shows highest cross validation accuracy
% bestRate shows the corresponding learning rate value for bestAccuracy
% bestTestAccuracy shows the accuracy of the test data

function [output] = hw2_q4()
% Getting data from data folder
sBs = load('shuffledB.mat');
sPs = load('shuffledP.mat');

Bs = sBs.Bs;
Ps = sPs.Ps;

% 70% of the data is train data
sizeB = int32( size(Bs,1)*0.7 );
sizeP = int32( size(Ps,1)*0.7 );
train = Bs(1:sizeB,:);
train = [train;Ps(1:sizeP,:)];

% A column of ones are added to the train matrix
% That column shows the wi parameters
train = [ones(size(train,1),1) train];

% Class B is 0, Class P is 1
truetrainlabel = zeros(sizeB+sizeP,1);
truetrainlabel(sizeB+1:end,1) = ones;

% Remainder (30%) of the data is test data
test = Bs(sizeB+1:end,:);
test = [test;Ps(sizeP+1:end,:)];

% A column of ones are added to the test matrix
% That column shows the wi parameters
test = [ones(size(test,1),1) test];

truetestlabel = zeros(size(Bs,1)-sizeB+size(Ps,1)-sizeP,1);
truetestlabel(size(Bs,1) - sizeB + 1 : end, 1) = ones;

% Learning Rate
% I take the square of aNumber for the plot
% The plot will be aNumber by aNumber
aNumber = 4;
% Learning Rates
noofrate = aNumber*aNumber;
lRate = logspace(-7,-3,noofrate);

% No of Iterations
noofIter = 500;
% K fold number
kfold = 10;

accuracy = zeros(noofIter, noofrate);

% Cross Validation and Accuracy Calculations with different learning rates
% Also this for loop is for plot the ploting di?erent accuracies over number of iterations
for i=1:noofrate
    [ accuracy(:,i)] = crossValidation_4(lRate(i), kfold, train, truetrainlabel, noofIter);   %calculate the cross validation accuracy
    subplot(aNumber,aNumber,i);
    plot(accuracy(:,i));
    title(strcat('Learning rate = ', num2str(lRate(i))));
    xlabel('Iteration number');
    ylabel('Accuracy');
end

% Take the last iterations accuracy for each rate
% It is for finding the best learning rate
success = accuracy(500,:);
[bestAccuracy,index] = max(success);
bestRate = lRate(index);

w = zeros(1, size(train,2));
testAccuracies = zeros(1, noofIter);

for j=1:noofIter
    % Calculation for change in w
    deltaW = (truetrainlabel - (exp(train*w')./(1 + exp(train*w'))) )' * train;
    w = w + bestRate*deltaW;
    
    predictlabel = test * w';
    
    % predictlabel is the boundary line.
    % if predictlabel > 0 assign its label as 1
    % ow. assign its label as 0
    predictlabel (predictlabel > 0) = 1;
    predictlabel (predictlabel <= 0) = 0;
    
    %Calculation for Accuracy
    testAccuracy = ( 1-sum( abs(predictlabel - truetestlabel) ) / size(test,1) ) * 100;
    
    testAccuracies(1,j) = testAccuracy;
end

[bestTestAccuracy,~] = max(testAccuracies);

% Plot for the test accuracy over number of iterations 
% the best accuracy obtained over the test dataset
figure;
plot(testAccuracies)
title('Test Accuracy');
xlabel('Iteration number');
ylabel('Accuracy');

% output of the function
output = [bestAccuracy bestRate bestTestAccuracy];

end