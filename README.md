README file for 'Getting and Cleaning data' course project

For additional information about this project, see the original README.txt file.

This submission contains the following files:

README.md file:
List and description of all files.

CodeBook.md file:
Lists input files, output files and explains the new variable names.

Script file run_analysis.R. This files does:
1. Downloads and unzips the data.
2. Extracts only the measurements on the mean and standard deviation for each measurement.
3. Uses descriptive activity names to name the activities in the data set.
4. Saves the resulting data.frame as 'meansAndStandardDeviationsOnly.csv'
5. From the data set in step 4, creates a second, independent tidy data set with the average of each variable for each activity and each subject, which was saved as 'meansAndStandardDeviationsOnlyAverageForEachSubject.csv'.

Output files generated with run_analysis.R:
meansAndStandardDeviationsOnly.csv
meansAndStandardDeviationsOnlyAverageForEachSubject.csv

