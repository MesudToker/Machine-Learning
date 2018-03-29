function [] = main(dataPath, question4_train_feature, question4_train_label, question4_test_feature, question4_test_label, question5_train, question5_test)

codeFolder = cd(dataPath); % goes to data folder

% importing datas
Q4feature = importdata(question4_train_feature); 
Q4label = importdata(question4_train_label);
Q4test = importdata(question4_test_feature);
Q4truelabel = importdata(question4_test_label);
Q5train = importdata(question5_train);
Q5test = importdata(question5_test);

cd(codeFolder); % come back code folder

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

% question 4.3
q4_3predictlabels = Q4_3 (Q4feature, Q4label, Q4test);
q4_3accuracy = 100-sum(abs(q4_3predictlabels-Q4truelabel))*100/size(Q4test,1);

my_file = fopen('Q4_3predict_labels.txt','w');
fprintf(my_file,'%d\n',q4_3predictlabels);
fclose(my_file) ;

% question 4.4
q4_4predictlabels = Q4_4 (Q4feature, Q4label, Q4test);
q4_4accuracy = 100-sum(abs(q4_4predictlabels-Q4truelabel))*100/size(Q4test,1);

my_file = fopen('Q4_4predict_labels.txt','w');
fprintf(my_file,'%d\n',q4_4predictlabels);
fclose(my_file) ;

% question 4.5
[values , bestFeatures] = Q4_5(Q4feature, Q4label);
output = [values ; bestFeatures];

my_file = fopen('Q4_5top10_features_mutual_info.txt','w');
fprintf(my_file,'%6s %12s\n','values','index');
fprintf(my_file,'%6.4f %12d\n', output);
fclose(my_file) ;

% question 4.6
q4_6accuracy = Q4_6(Q4feature, Q4label, Q4test, Q4truelabel);

my_file = fopen('Q4_6accuracy.txt','w');
fprintf(my_file,'%d\n', q4_6accuracy);
fclose(my_file) ;

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

% question 5
[meanout1, meanout2, meanout3, varout1, varout2, varout3, testconfusionTable, trainconfusionTable, predictAccuracy] = Q5(Q5train, Q5test);

my_file = fopen('Q5_1means&variances.txt','w');
fprintf(my_file,' means of cancer1 = Kidney Cancer\n' );
fprintf(my_file,'%f %f %f %f %f' , meanout1);
fprintf(my_file,'\n\n means of cancer2 = Breast Cancer\n' );
fprintf(my_file,'%f %f %f %f %f' , meanout2);
fprintf(my_file,'\n\n means of cancer3 = Colon Cancer\n' );
fprintf(my_file,'%f %f %f %f %f' , meanout3);

fprintf(my_file,'\n\n\n variences of cancer1 = Kidney Cancer\n' );
fprintf(my_file,'%f %f %f %f %f' , varout1);
fprintf(my_file,'\n\n variences of cancer2 = Breast Cancer\n' );
fprintf(my_file,'%f %f %f %f %f' , varout2);
fprintf(my_file,'\n\n variences of cancer3 = Colon Cancer\n' );
fprintf(my_file,'%f %f %f %f %f' , varout3);
fclose(my_file);

my_file = fopen('Q5_2test_confusion_table.txt','w');
fprintf(my_file,'%d %d %d\n', testconfusionTable);
fclose(my_file) ;

my_file = fopen('Q5_2train_confusion_table.txt','w');
fprintf(my_file,'%d %d %d\n', trainconfusionTable);
fclose(my_file) ;

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

% accuracies file for all question
my_file = fopen('accuries.txt','w');

fprintf(my_file,'accuracy of Q4.3:  ');
fprintf(my_file,'%f',q4_3accuracy);

fprintf(my_file,'\naccuracy of Q4.4:  ');
fprintf(my_file,'%f',q4_4accuracy);

fprintf(my_file,'\naccuracy of Q5.2 for test data:  ');
fprintf(my_file,'%f',predictAccuracy(1,1));

fprintf(my_file,'\naccuracy of Q5.2 for train data:  ');
fprintf(my_file,'%f',predictAccuracy(1,2));

fclose(my_file) ;

end