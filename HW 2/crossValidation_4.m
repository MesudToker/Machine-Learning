% crossValidation_4 function
% Function for Cross Validation and Accuracy Calculations with different learning rates

% It takes rate, K, traindata, label, noofIter as input
% rate is learning rate
% K shows the fold parameter
% traindata is train data for k fold cross validation
% label is the true label for the train data
% noofIter shows the number of iterations

% It gives avg as output
% avg is the average of the accuracy of k folds for that learning rate

function [avg] = crossValidation_4(rate, K, traindata, label, noofIter)

% divide train data into K group
indices = crossvalind('Kfold', size(traindata, 1), K);

success = zeros(noofIter, K);

% In each turn, a group is test and other is train
% Train a SVM model and calculate the accuracy
for index = 1:K
    test = (indices == index);
    train = ~test;
    
    w = zeros(1, size(traindata,2));
    
    for j=1:noofIter
        % Calculation for change in w
        deltaW = ( label(train,1) - (exp(traindata(train,:)*w')./(1 + exp(traindata(train,:)*w'))) )' * traindata(train,:);
        w = w + rate*deltaW;
        
        predictlabel = traindata(test,:)*w';
        
        % predictlabel is the boundary line.
        % if predictlabel > 0 assign its label as 1
        % ow. assign its label as 0
        predictlabel (predictlabel > 0) = 1;
        predictlabel (predictlabel <= 0) = 0;
        
        %Calculation for Accuracy
        accuracy = ( 1-sum( abs(predictlabel - label(test,1)) ) / size(traindata(test,:),1) ) * 100;
        
        success(j,index) = accuracy;
    end
end

% mean of the accuracies of K folds for given learning rate
avg = mean(success, 2);

end