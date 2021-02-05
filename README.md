This project aims at reproducing the paper "Can issues reported at Stack Overflow questions be reproduced? An exploratory study".  
# Meta data
1. A reproduction as part of MSR course at MSR course 2020/21 at UniKo, CS Department, SoftLang team.
2. Paper title: "Can issues reported at Stack Overflow questions be reproduced? An exploratory study"
[DBLB link](https://dblp.org/rec/conf/msr/Mondal0R19.html?view=bibtex)
# Requirements
1. Hardware requirements : 
> * 4GB RAM or more
> * Any version of Windows 10 opearating system
2. Software requirements : 
> * Microsoft .NET 3.5 Framework or higher
> * MySQL workbench
> * Updated Java SE Development Kit
> * Eclipse IDE 2020/12 
> * NetBeans IDE
> * Anaconda  
# Process
**1. Data extraction** 
> * Navigate to the Stack Overflow 
  [Database dump](https://data.stackexchange.com/stackoverflow/query/936241/stack-overflow-data-dump).
> * Click on **fork query**
> * Enter the following query in the editor
```
SELECT * FROM posts WHERE Tags = '<java>'
```
> * Click on **Run query**
> * Download the CSV file by clicking on **Download CSV**

**2. Data Preprocessing**
> * Install MySQL Workbench and follow the steps given in the following link to have a clean and accurate install.
  [MySQL Workbench installation](https://dev.mysql.com/doc/workbench/en/wb-installing.html)
  > * Replace the configuration file **my.ini** in the location **"C:\ProgramData\MySQL\MySQL Server 8.0"** with the new updated file which can be downloaded from github. [Updated file](https://github.com/vinaykashyap1996/MSR/blob/master/Requirements/my.ini)
  > * Restart mysql service in services application in windows.
  > * Open the application MySQL Workbench.
  > * Create a new connection by giving a name and testing the connection in the setup connection page.
  > * Follow these required steps for the further steps to run error-free. These steps are carried as a workaround in windows OS for the existing bug in Workbench regarding import of a file from local system [Import bug](https://bugs.mysql.com/bug.php?id=91891)
  workarounds for other operating systems are also mentioned in the thread.
  ```
  - Copy the stackoverflow data dump csv file earlier downloaded from Stack Exchange to the following location.
  C:\ProgramData\MySQL\MySQL Server 8.0\Uploads
  - In the homepage of MySQL Workbench, click on Edit and  select Preferences.
  - Click on SQL Editor
  - Change the value of "DBMS connection read timeout interval(in seconds):" to "6000"
  - Click on OK.
  - Double click on your connection 
  ```
  > * Right Click in the SCHEMAS window and select create schema
.
> * Give a name for the schema and proceed further.
> * Right click on Tables in your schema and select Create Table.
> * Give a Table Name and write the following query to create a table as needed for our processing.
```
CREATE TABLE `stackoverflow`.`preprocesseddataset` (
id int,
postTypeId int,
exceptedAnswerId int,
parentId int,
creationDate date,
deletionDate date,
score int,
viewcount int,
body text,
ownerUserId int,
ownerDisplayName text,
lastEditorUserId int,
lastEditorDisplayName varchar(200),
lastEditDate date,
lastActivityDate date,
title text,
tags text,
answerCount int,
commentCount int,
favCount int,
closedDate date,
communityOwnedDate date,
contentLiencese text
);
```
```
Note 
- The above steps serve as the necessary prerequisite for MySQL Workbench and further queries.
- Change the schemaname.tablename as and how you have used when creating the same.
```
> * Open and run the SQL file. [Data Preprocessing](https://github.com/vinaykashyap1996/MSR/blob/master/Process/Data_Preprocessing.sql)
```
Note : The preprocessed dataset will now be present in the location as in the query.
```
**Alternative:** The following link contains a python file which performs preprocessing. This is an easier way developed by us to automate the process unlike the method in the paper being reproduced.
[Github link](https://github.com/vinaykashyap1996/MSR/blob/master/Process/Preprocessing.ipynb)

**3. Manual Analysis**
> * Select the Java codes available in the **preprossed_dataset.csv** file obtained from the previous process.
> * Copy these Java codes and paste in the Java IDEs such as Eclipse or NetBeans for manual analysis.
> * Compile and execute the codes one by one.
> * Categorize the reproducibility status into 6 types
```
1. Reproducible without modification
2. Reproducible with minor modifications
3. Reproducible with major modifications
4. Irreproducible
5. Inaccurate claim
6. Ill-defined issues
```
Note - The following link contains an example of the manual analysis. All the Stack overflow questions in the preprocessed dataset needs to be analysed similarly. [Example code](https://github.com/vinaykashyap1996/MSR/blob/master/Process/Example_codes.pdf)


**4. Validation:**
> * Careful observation should be made on whether the error message mentioned in the Stack Overflow questions is the same as obtained by us in our reproduction effort. 
> * The reproducibility status column in the output should be based on what modification has been done during manual analysis.

# Data
1. Input data:
> * Data dump - This is the Stack Overflow data dump of Java questions extracted from Stack Exchange API. [Data dump](https://github.com/vinaykashyap1996/MSR/blob/master/Data/Input/QueryResults.csv)
> * Preprocessed dataset - This serves as the input for our analysis. [Preprocessed dataset](https://github.com/vinaykashyap1996/MSR/blob/master/Data/Input/preprocessed_dataset.csv)
2. Output data 
> * Reproducibility status - This file contains reported issues which are classified as Reproducible without modification, Reproducible with minor modifications, Reproducible with major modifications, Irreproducible, Inaccurate claim and Ill-defined issues after manual analysis. [Output dataset](https://github.com/vinaykashyap1996/MSR/blob/master/Data/Output/MSR_Result.csv)
> * Visualization - These self explainatory graphs represent the results in a pictorial form. [Result graphs](https://github.com/vinaykashyap1996/MSR/blob/master/Data/Output/Visualization.pdf)

Doc file can be found in this link. [doc file](https://github.com/vinaykashyap1996/MSR/tree/master/Data/Doc)


Note - The graphs are constructed with the help of python, pandas, numpy and matplotlib. [Link to the python script](https://github.com/vinaykashyap1996/MSR/blob/master/Process/Msr-analysis.ipynb)

# Delta
1. Process delta :

The reproducibility of the paper can be summarized as follows.
> * We extracted the Stack Overflow data dump using the link given in the paper. [Link] The link had the query but we had to modify a little to get the required dump.
> * We were able to reproduce most of the steps for preprocessing such as selecting Java questions which had at least one line of code, which had keywords like error, warning, exception, issue, fix, problem, fail and wrong as mentioned in the paper.
> * The process of random sampling was unclear in the paper which made us select the first 400 questions from the preprocessed dataset for manual analysis. 
> * There were no SQL queries or links mentioned in the paper which would transform data dump into preprocessed dataset. We had to write queries on our own.

2. Data delta : 
> * The Stack Overflow dump we used is same as the one used in the paper.
> * In the paper, authors have analysed 400 Java questions manually. In the given timeframe we were able to execute 140 questions manually.
> * Data visualization and the conclusions derived are based on 140 questions we have manually analysed.
 
      


