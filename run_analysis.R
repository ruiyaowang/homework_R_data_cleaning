library(data.table)
# combine train and test data, only X
train<-fread('train/X_train.txt',sep=" ")
test<-fread('test/X_test.txt',sep=" ")
combined<-rbind(train,test)


# read in variable names
# select only mean and std, record the variable names and corresponding column indexes
features<-fread('features.txt')
variables<-features[grep("mean\\(|std\\(",features$V2),]
colnames(variables)<-c('col_index','col_name')

# select only the indexes appearing in last step with mean and std
# then give descriptive variable names to column names
combined<-combined[,variables$col_index,with=FALSE]
colnames(combined)<-variables$col_name


# combine train and test y
train_y<-fread('train/y_train.txt',sep=" ")
test_y<-fread('test/y_test.txt',sep=" ")
combined_y<-rbind(train_y,test_y)
str(combined_y)
# change labels to descriptive labels
trans<-read.table('activity_labels.txt',row.names=1)
combined_y$V1<-trans[combined_y$V1,]
colnames(combined_y)<-'activity'

# combine subjects train and test
train_s<-fread('train/subject_train.txt',sep=" ")
test_s<-fread('test/subject_test.txt',sep=" ")
combined_s<-rbind(train_s,test_s)
colnames(combined_s)<-'subject'

# combine X,y,subjects
combine_all<-cbind(combined_s,combined_y,combined)

# use melted and dcast to group by subject and activity
melted<-melt(combine_all,id.vars = c('subject','activity'),measure.vars = names(combine_all)[3:ncol(combine_all)])
tidy<-dcast(melted,subject+activity~variable,mean)

# write the cleaned data to csv
write.table(tidy, file = "tidy_data.txt",row.names = FALSE)
