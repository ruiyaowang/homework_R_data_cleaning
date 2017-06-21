One of the most exciting areas in all of data science right now is wearable computing - see for example this article . Companies like Fitbit, Nike, and Jawbone Up are racing to develop the most advanced algorithms to attract new users. The data linked to from the course website represent data collected from the accelerometers from the Samsung Galaxy S smartphone.

The data and feature introductions are included in CodeBook.md. 

The goal of this homework is to prepare tidy data that can be used for later analysis.

Data include train and test for features(X_train.txt,X_test.txt), label(y_train.txt,y_test.txt), and subject(subject_train.txt,subject_test.txt).
For X, y, and subject, train and test are first concatated to get the whole data using rbind(). 
The variable names of features are read from featurs.txt. Only mean and std columns are considered in combined X data. 
For y data, each labels are replaced with their descriptive activity names using the correspondence found in activity_labels.txt.
Finally X, y, and subject are combined together using cbind().
The combined data is group by subject and activity, mean values for all variables are summerized. This is done by using melt and dcast functions.