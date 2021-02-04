/* specifying schema */
use stackoverflow;

/* Prerequisite for the code to run error-free */
SET sql_mode = "";

/* Load the data from "QueryResults.csv" into the table "preprocesseddataset"
QueryResults.csv contains the stackoverflow data dump which is obtained from stackexchange
change the table name in the query as required
The csv file has to be in the same folder as the below mentioned path while using Windows operating system for the query to execute  */

LOAD DATA INFILE 'C:/ProgramData/MySQL/MySQL Server 8.0/Uploads/QueryResults.csv'
INTO TABLE preprocesseddataset 
FIELDS TERMINATED BY ','
ENCLOSED BY '"' LINES TERMINATED BY '\r\n';


SELECT * FROM preprocesseddataset;

/* The query extracts 400 stackoverflow questions with atleast one line of code and 
which are most likely to have an error following the methods suggested in the research paper. 
change the schema and the tablename as required 
Please select a new filename for each execution of the query as it cant be overwritten */

SELECT * FROM 
(
    SELECT 'ID','body', 'CreationDate', 'Score','AnswerCount'
    UNION ALL
    ( 
		SELECT id,body,creationDate, score, answerCount  FROM
			( 
				SELECT * FROM stackoverflow.preprocesseddataset where  
					( 
						body like '%<code>%' and 
							(
								body LIKE '%error%' or body LIKE '%warning%' or body LIKE '%issue%' or 
								body LIKE '%exception%'or body LIKE '%fix%' or body LIKE '%problem%' or 
								body LIKE '%wrong%' or body LIKE '%fail%'
							) 
						and answerCount > 0
					) 
				LIMIT 400
			) 
		AS T1 ORDER BY id ASC
	)
) resulting_set
INTO OUTFILE 'D:/preprocessed_dataset.csv'
FIELDS ENCLOSED BY '"'
TERMINATED BY ','
ESCAPED BY '"' 
LINES TERMINATED BY '\r\n';
