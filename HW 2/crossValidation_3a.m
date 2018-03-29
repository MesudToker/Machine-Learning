% crossValidation_3a function
% Function for Cross Validation and Accuracy of C Calculations

% It takes C, K, traindata, label as input
% C = cost parameter
% K shows the fold parameter
% traindata is train data for k fold cross validation
% label is the true label for the train data

% It gives avg as output
% avg is the average of the accuracy of k folds for that C

function [avg] = crossValidation_3a(C, K, traindata, label)

% divide train data into K group
indices = crossvalind('Kfold', size(traindata, 1), K);

success = zeros(1,K);

% In each turn, a group is test and other is train
% Train a SVM model and calculate the accuracy
for index = 1:K
    test = (indices == index);
    train = ~test;
    svmMdl = fitcsvm(traindata(train,:), label(train,1), 'KernelFunction', 'linear', 'BoxConstraint', C);
    
    predictlabel = predict(svmMdl, traindata(test,:));
    
    CP = classperf(label(test,1), predictlabel);
    
    success(1,index) = CP.CorrectRate;
end

% mean of the accuracies of K folds for given C
avg = mean(success);

end