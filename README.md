---
output:
  pdf_document: default
  html_document: default
---
# DataCleaningAssignment

This will combine and summarize the data from the phone accelerometers.
Notes:

*  The data files are assumed to be in their original format including directories and subdirectories and unzipped one directory above the script.
*  The output files are
  *  outdata.csv - All of the combined data in CSV format
  *  sumdata.csv - The mean of each column, grouped by subject and activity in CSV format
  *  sumdata.txt - The same as the fule above, but in a space delimited format as requested for the assignemnt
   

The process will:

1)  Load each of the files
1)  Load the column names from featurenames.txt, converting the names to lower case and removing punctuation
1)  Set readable names on cross reference data
1)  Join the 3 files for each set of observations
1)  Combine the two sets of data into one large data frame
1)  Create a new set of data using only the STD and MEAN columns for each measurement
1)  Create a mean of each column
1)  Write the 3 output files



