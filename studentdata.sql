/*In order to import the data that I cleaned, I first want to create a table to insert it into*/
/*Firstly I will create a sequence - that will act as the student's id numbers as this was omitted from the original file, this Student ID will act as the Primary Key for the data.*/
CREATE SEQUENCE studentid_seq START WITH 1;
/*Next I will create the table for StudentData*/
CREATE TABLE StudentData (
    StudentID INT PRIMARY KEY DEFAULT nextval('studentid_seq'),
    CertificationCourse VARCHAR(255), 
    Gender VARCHAR(10), 
    Department VARCHAR(255), 
    HeightCM Numeric,
    WeightKG Numeric,
    "10thMark" Numeric,
    "12thMark" Numeric,
    CollegeMark Numeric,
    Hobbies VARCHAR(255), 
    DailyStudyTime VARCHAR(50), 
    PreferredStudyTime VARCHAR(50), 
    ExpectedSalary INT,
    DoYouLikeYourDegree VARCHAR(50), 
    WillingnessForCareerBasedOnDegree VARCHAR(10), 
    DailySocialMediaUse VARCHAR(255),
    CommuteTime VARCHAR(50), 
    StressLevel VARCHAR(50),
    FinancialStatus VARCHAR(50), 
    PartTimeJob VARCHAR(10) 
);

COPY StudentData(CertificationCourse, Gender, Department, HeightCM, WeightKG, "10thMark", "12thMark", CollegeMark, Hobbies, DailyStudyTime, PreferredStudyTime, ExpectedSalary, DoYouLikeYourDegree, WillingnessForCareerBasedOnDegree, DailySocialMediaUse, CommuteTime, StressLevel, FinancialStatus, PartTimeJob)
FROM 'C:\Users\Public\Public4SQL\cleanedstudentdata.csv'
DELIMITER ','
CSV HEADER;
/*Lets Makes sure it came through - it did :)*/
SELECT * FROM StudentData;

/*Ok, now lets try some basic SQL Functions*/

/*Which Department has the most students?*/
SELECT Department, COUNT(*) AS TotalStudents
FROM StudentData
GROUP BY Department
ORDER BY TotalStudents DESC
LIMIT 1;
/*The department with the most students is BCA with 132*/

/*What's the average College Grade amongst students?*/
SELECT AVG(CollegeMark) AS AverageCollegeGrade
FROM StudentData;
/*The average grade is around 70.7%*/

/*What's the average height amongst females?*/
SELECT AVG(HeightCM) AS AverageHeight
FROM StudentData
WHERE Gender = 'Female';
/*The average height is around 150.3cm*/

/*Who tends to be happier with their degree, Males or Females?*/
SELECT Gender, 
       AVG(CASE WHEN DoYouLikeYourDegree = 'Yes' THEN 1 ELSE 0 END) AS HappinessRate
FROM StudentData
GROUP BY Gender;
/*We can see Females tend to be happier with their degree, however it's only a 1% difference, generally both are happy*/

/*Does the highest graded student have the highest expected salary?*/
SELECT CollegeMark, ExpectedSalary
FROM StudentData
ORDER BY CollegeMark DESC, ExpectedSalary DESC
LIMIT 1;
/*We can see that they do not*/

/*What grade does the student with highest expected salary have, and what department are they in?*/
SELECT CollegeMark, ExpectedSalary, Department
FROM StudentData
ORDER BY ExpectedSalary DESC, CollegeMark DESC
LIMIT 1;
/*We see that the student with the highest expected salary got 58%, and is in BCA*/

/*For fun, let's check if the seven lowest college grades add up to be more than the top students grade of 100*/
SELECT SUM(CollegeMark) AS SumOfLowestGrades
FROM (
    SELECT CollegeMark
    FROM StudentData
    ORDER BY CollegeMark
    LIMIT 7
) AS LowestSevenGrades;
/*We can see this isn't the case, the lowest seven students only got 85.5*/

/*Let's see if having a part-time job indicates a bad or awful stress level*/
SELECT PartTimeJob, StressLevel, COUNT(*) AS StressLevelCount
FROM StudentData
WHERE PartTimeJob = 'Yes'
GROUP BY PartTimeJob, StressLevel;
/*As we can see the majority of people with part-time jobs have a good or fabulous stress level*/

/*What are the most popular hobbies?*/
SELECT Hobbies, COUNT(*) AS HobbyCount
FROM StudentData
GROUP BY Hobbies
ORDER BY HobbyCount DESC;
/*Sports is the most popular hobby*/

/*What is the average expected salary per department, for males and for females*/
SELECT Department, Gender, AVG(ExpectedSalary) AS AvgSalary
FROM StudentData
GROUP BY Department, Gender;
/*We can see there are massive variances and discrepencies in each except for commerce where they expect to earn around the same*/ 