Ömer Mesud TOKER
21302479
CS 464 - 2
HW 2

For the homework I have 6 .m files.

For question 3a 
hw2_q3a.m and crossValidation_3a.m

For question 3b 
hw2_q3b.m and crossValidation_3b.m

For question 4
hw2_q4.m and crossValidation_4.m

First, please run hw2_q3a.m by giving the path of path of the folder in which HW2data.mat placed
It can be run like in the below example:
hw2_q3a('C:\Users\lenovo\Desktop\MESUD\6. Semester\CS 464 Machine Learning\HW 2');

While it is running, it creates shuffled versions of data set to workspace
I save shuffled Bs in shuffledB.mat and shuffled Ps in shuffledP.mat.

It gives bestAccuracy, bestC, testAccuracy array as output.
bestAccuracy shows highest cross validation accuracy
bestC shows the corresponding C value of bestAccuracy
testAccuracy shows the accuracy of the test data

For hw2_q3b.m and hw2_q4.m, there is no need to give the path parameter since they use the saved data (shuffledB.mat and shuffledP.mat).
They are run just typing their names. 
Ex1: hw2_q3b.m
Ex2: hw2_q4.m

hw2_q3b.m gives bestAccuracy, bestC, bestGamma, testAccuracy array as output
bestAccuracy shows highest cross validation accuracy
bestC shows the corresponding C value of bestAccuracy
bestGamma shows the corresponding Gamma value of bestAccuracy
testAccuracy shows the accuracy of the test data

hw2_q4.m gives bestAccuracy, bestRate, bestTestAccuracy array as output
output = [bestAccuracy bestRate bestTestAccuracy];
bestAccuracy shows highest cross validation accuracy
bestRate shows the corresponding learning rate value for bestAccuracy
bestTestAccuracy shows the accuracy of the test data

For quesiton 3a and 3b, I give the hw2_q3a_PredictLabels.txt and hw2_q3b_PredictLabels.txt as outputs.
They show the predict lables for decision values of test set respectively for question 3a and question 3b.
They are included in the zip file.

hw2_report.pdf is the report for the homework which includes answers for quesitons 1 and 2.
Moreover, it has the statistics and plots for questions 3 and 4 as desired in for the homework.

For more information about functions and matlab codes, you can look at informative comments on the scripts.
For all .m files, there are header comments and in-code-comments for explaining the code.

In the zip file I also included the shuffledB.mat and shuffledP.mat files in case of necessity. 

And lastly, I did not use any library, so there is no need for usage of library for my codes.
