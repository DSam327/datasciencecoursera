library(data.table)
library(reshape2)

working_dir <- getwd()
dataset_url <- "https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip"
download.file(dataset_url, file.path(working_dir, "dataset.zip"))
unzip("dataset.zip", exdir = working_dir)
activity_labels <- fread(file.path(working_dir, "UCI HAR Dataset/activity_labels.txt"), col.names = c("ID", "Activity"))
feature_list <- fread(file.path(working_dir, "UCI HAR Dataset/features.txt"), col.names = c("ID", "Feature"))
selected_features <- grep("mean|std", feature_list$Feature)
feature_names <- feature_list[selected_features, Feature]
feature_names <- gsub("[()]", "", feature_names)
train_data <- fread(file.path(working_dir, "UCI HAR Dataset/train/X_train.txt"))[, selected_features, with = FALSE]
setnames(train_data, old = colnames(train_data), new = feature_names)
train_labels <- fread(file.path(working_dir, "UCI HAR Dataset/train/Y_train.txt"), col.names = "Activity")
train_subjects <- fread(file.path(working_dir, "UCI HAR Dataset/train/subject_train.txt"), col.names = "Subject")
train_data <- cbind(train_subjects, train_labels, train_data)
test_data <- fread(file.path(working_dir, "UCI HAR Dataset/test/X_test.txt"))[, selected_features, with = FALSE]
setnames(test_data, old = colnames(test_data), new = feature_names)
test_labels <- fread(file.path(working_dir, "UCI HAR Dataset/test/Y_test.txt"), col.names = "Activity")
test_subjects <- fread(file.path(working_dir, "UCI HAR Dataset/test/subject_test.txt"), col.names = "Subject")
test_data <- cbind(test_subjects, test_labels, test_data)
all_data <- rbind(train_data, test_data)
all_data$Activity <- factor(all_data$Activity, levels = activity_labels$ID, labels = activity_labels$Activity)
all_data$Subject <- as.factor(all_data$Subject)
reshaped_data <- melt(all_data, id.vars = c("Subject", "Activity"))
final_data <- dcast(reshaped_data, Subject + Activity ~ variable, mean)
fwrite(final_data, "tidyData.txt", quote = FALSE)
