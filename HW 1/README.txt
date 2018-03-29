Ömer Mesud TOKER
21302479
CS 464 - 2
HW 1

To run my code, datapath of the folder of input txt files is needed. The other paremeters are the input txt. files. 

My code creates, creates 8 output txt. files which are

accuracies : shows accuracies for each question

Q4_3predict_labels : shows the predicted labels for question 4.3
Q4_4predict_labels : shows the predicted labels for question 4.4
Q4_5top10_features_mutual_info : shows the top 10 best features for mutual information which is quesiton 4.5
Q4_6accuracy : shows the accuracies as a function of removed number of features which is quesiton 4.6

Q5_1means&variances : shows means and variances of each cancer types which is question 5.1
Q5_2test_confusion_table : shows the confusion table of test data for question 5.2
Q5_2train_confusion_table : shows the confusion table of train data for question 5.2

You can run my code as in the below example.

main('D:\Users\omer.toker-ug\Desktop\New folder\hw1_data', 'question4-train-features.txt', 'question4-train-labels.txt','question4-test-features.txt','question4-test-labels.txt','question5-train.txt','question5-test.txt')