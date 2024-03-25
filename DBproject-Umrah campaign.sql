CREATE SCHEMA UmrahCampaignProject;


CREATE TABLE FOL_NNUM(
Vnumber INT(10) NOT NULL,
sex     CHAR(1) CHECK (sex IN ('M','F')),
birthDate VARCHAR(10),
CONSTRAINT FOL_NNUM_PK PRIMARY KEY (Vnumber)
);

CREATE TABLE Emp_Swork(
workStartDate           VARCHAR(10) NOT NULL,
jobTitle                VARCHAR(20) CHECK (jobTitle IN ('administrative', 'health', 'filed'))NOT NULL,
salary                  INT(5) CHECK (salary >= 1000 AND salary <=10000 OR salary=0),
CONSTRAINT Emp_Swork_Pk PRIMARY KEY(workStartDate,jobTitle)
);
  

CREATE TABLE Employee (
emID          INT(10) NOT NULL UNIQUE,
fName         VARCHAR(25),
mName         VARCHAR(25),
lName         VARCHAR(25), 
birthDate     VARCHAR(10),
sex           CHAR(1),
jobTitle      VARCHAR(20),
workStartDate VARCHAR(10),
CONSTRAINT Employee_Pk PRIMARY KEY(emID),
CONSTRAINT Employee_FK1 FOREIGN KEY (workStartDate,jobTitle) REFERENCES Emp_Swork(workStartDate,jobTitle) ON DELETE CASCADE
 );


CREATE TABLE Category(
price INT (5),
categoryNum INT(1) CHECK (categoryNum IN (1,2)) NOT NULL UNIQUE ,
roomView CHAR(1) CHECK (roomView IN ('Y','N')),
daysNum INT (1) CHECK (daysNum IN (9,6)),
CONSTRAINT Category_PK PRIMARY KEY (categoryNum)
);


CREATE TABLE Volunteer (
natID VARCHAR(10) NOT NULL,
numOfHours INT (3),
mainOrg VARCHAR(40),
emID INT (10),
CONSTRAINT Volunteer_PK PRIMARY KEY (natID),
CONSTRAINT Volunteer_FK FOREIGN KEY (emID) REFERENCES Employee(emID) ON DELETE CASCADE
);


CREATE TABLE VOL_volunteerWork(
natID VARCHAR(10) NOT NULL ,
volunteerWork VARCHAR(100) CHECK(volunteerWork IN ('paramedies','translators','organizers')) NOT NULL,
CONSTRAINT VOL_volunteerWork_PK PRIMARY KEY (natID,volunteerWork),
CONSTRAINT VOL_volunteerWork_FK FOREIGN KEY (natID) REFERENCES Volunteer(natID)
);


 CREATE TABLE Company(
contractNum             INT(3) CHECK (contractNum = 100) NOT NULL UNIQUE,
subsistence             VARCHAR(25),
transport               VARCHAR(25),
hotel                   VARCHAR(30),
contractType            VARCHAR(6) CHECK (contractType IN ('annual')),
approximateAnnualAmount INT(5) CHECK (approximateAnnualAmount >= 15000 AND approximateAnnualAmount <= 20000) ,
CONSTRAINT Company_PK PRIMARY KEY (contractNum)
);

CREATE TABLE CAT_activies(
activies VARCHAR(60) NOT NULL ,
categoryNum INT(1) NOT NULL,
CONSTRAINT CAT_activies_PK PRIMARY KEY (activies,categoryNum),
CONSTRAINT CAT_activies_FK FOREIGN KEY (categoryNum) REFERENCES Category(categoryNum)
);

CREATE TABLE Supplie (
contractNum INT(3) NOT NULL,
categoryNum INT(1) CHECK (categoryNum IN (1,2)) NOT NULL ,
CONSTRAINT Supplie_PK1 PRIMARY KEY (contractNum,categoryNum),
CONSTRAINT Supplie_FK1 FOREIGN KEY (categoryNum) REFERENCES Category(categoryNum),
CONSTRAINT Supplie_FK2 FOREIGN KEY (contractNum) REFERENCES Company(contractNum)
);


CREATE TABLE VISA (
VisaID INT(4) NOT NULL UNIQUE,
dateissuance INT(8),
PCR CHAR(1)CHECK (PCR IN ('Y','N')),
CONSTRAINT VISA_PK PRIMARY KEY (VisaID)
);


CREATE TABLE pilgrim  
(
nationality CHAR (25),
dateOfArrival VARCHAR (10),
passportNum VARCHAR (8),
countryOfArrival CHAR (25),
numOfIndividual INT (1) CHECK (numOfIndividual IN (1)), 
Vnumber INT (10) NOT NULL UNIQUE,
Vcountry VARCHAR (25) NOT NULL UNIQUE,
VisaID INT (4),
categoryNum INT (1) ,
CONSTRAINT pilgrim_pk PRIMARY KEY (Vnumber,Vcountry),
CONSTRAINT pilgrim_fk1 FOREIGN KEY (Vnumber) REFERENCES FOL_NNUM (Vnumber) ON DELETE CASCADE,
CONSTRAINT pilgrim_fk2 FOREIGN KEY (VisaID)  REFERENCES VISA (VisaID)ON DELETE CASCADE  ,
CONSTRAINT pilgrim_fk3 FOREIGN KEY (categoryNum) REFERENCES Category(categoryNum) ON DELETE CASCADE );



CREATE TABLE HEALTHSTATUS(
medicalInduranceNumber INT(5) NOT NULL UNIQUE ,
Vnumber                INT(10),
Vcountry               VARCHAR(25),
CONSTRAINT HEALTHSTATUS_PK  PRIMARY KEY (medicalInduranceNumber),
CONSTRAINT HEALTHSTATUS_FK1 FOREIGN KEY (Vnumber) REFERENCES  FOL_NNUM (Vnumber)ON DELETE CASCADE,
CONSTRAINT  HEALTHSTATUS_FK2 FOREIGN KEY (Vcountry) REFERENCES pilgrim (Vcountry)ON DELETE CASCADE
);

CREATE TABLE health_specialCases(
medicalInduranceNumber INT (5) NOT NULL ,
specialCases CHAR (100)NOT NULL,
CONSTRAINT health_specialCases_PK PRIMARY KEY (medicalInduranceNumber,specialCases),
CONSTRAINT health_specialCases_FK FOREIGN KEY (medicalInduranceNumber) REFERENCES HEALTHSTATUS (medicalInduranceNumber) ON DELETE CASCADE
);


CREATE TABLE FOLLOWER(
Vnumber INT(10)NOT NULL,
Vcountry VARCHAR (25)NOT NULL,
Follwer_fName VARCHAR(25)NOT NULL,
Follwer_mName VARCHAR(25)NOT NULL,
Follwer_lName VARCHAR(25)NOT NULL,
CONSTRAINT FOLLOWER_PK PRIMARY KEY (Vnumber,Vcountry,Follwer_fName,Follwer_mName,Follwer_lName),
CONSTRAINT FOLLOWER_FK1 FOREIGN KEY (Vnumber) REFERENCES FOL_NNUM (Vnumber)ON DELETE CASCADE,
CONSTRAINT FOLLOWER_FK2 FOREIGN KEY (Vcountry) REFERENCES pilgrim (Vcountry)ON DELETE CASCADE
);


CREATE TABLE HealthChronicDiseeases(
medicalInduranceNumber INT(5) NOT NULL ,
chronicDiseases VARCHAR(100)NOT NULL,
CONSTRAINT HealthChronicDiseeases_PK PRIMARY KEY(medicalInduranceNumber,chronicDiseases),
CONSTRAINT HealthChronicDiseeases_FK FOREIGN KEY (medicalInduranceNumber) REFERENCES HEALTHSTATUS(medicalInduranceNumber) ON DELETE CASCADE
);


 CREATE TABLE PI_VISA_number ( 
Vnumber       INT(10) ,
sex           CHAR(1) CHECK (sex IN ('M','F')),
lName          VARCHAR (25),
mName          VARCHAR (25) ,
fName          VARCHAR (25),
birthData      VARCHAR(10),
CONSTRAINT PI_VISA_number_Pk PRIMARY KEY(Vnumber),
CONSTRAINT PI_VISA_number_FK1 FOREIGN KEY (Vnumber) REFERENCES FOL_NNUM(Vnumber)ON DELETE CASCADE
) ;


CREATE TABLE PIL_email (
email      VARCHAR (30) NOT NULL,
Vcountry   VARCHAR(25) ,
Vnumber     INT(10) ,
CONSTRAINT PIL_email_Pk PRIMARY KEY (email),
CONSTRAINT PIL_email_Fk1 FOREIGN KEY (Vcountry) REFERENCES pilgrim (Vcountry)ON DELETE CASCADE,
CONSTRAINT PIL_email_Fk2 FOREIGN KEY (Vnumber) REFERENCES FOL_NNUM (Vnumber)ON DELETE CASCADE
);


CREATE TABLE PI_DateCote (
serialNumber int (1) NOT NULL,
categoryNum  Int(1) NOT NULL ,
dateOfDeparture VARCHAR(10),
CONSTRAINT PI_DateCote_PK PRIMARY KEY(categoryNum,serialNumber), 
CONSTRAINT PI_DateCote_Fk FOREIGN KEY (categoryNum) REFERENCES Category(categoryNum)ON DELETE CASCADE
);


CREATE TABLE supervision (
emID          INT(10)NOT NULL  , 
sup_emID      INT(10)NOT NULL ,
CONSTRAINT supervision_PK PRIMARY KEY (emID,sup_emID),
CONSTRAINT supervision_Fk1 FOREIGN KEY(emID) REFERENCES Employee(emID)ON DELETE CASCADE,
CONSTRAINT supervision_Fk2 FOREIGN KEY(sup_emID) REFERENCES Employee(emID)ON DELETE CASCADE
);     

CREATE TABLE Work_On(
emID          INT(10),
natID         VARCHAR(10),
categoryNum   INT(1),
CONSTRAINT Work_On_Pk  PRIMARY KEY (emID,natID,categoryNum),
CONSTRAINT Work_On_FK1 FOREIGN KEY (emID) REFERENCES Employee(emID),
CONSTRAINT Work_On_FK2 FOREIGN KEY (natID) REFERENCES Volunteer(natID),
CONSTRAINT Work_On_Fk3 FOREIGN KEY (categoryNum) REFERENCES Category (categoryNum)
);



INSERT INTO FOL_NNUM
       VALUES(658424653,'M','1-2-2003'),
             (368190075,'M','19-4-2005'),
             (124253685,'F','28-10-1986'),
             (826261916,'M','29-12-1999'),
             (114686389,'F','29-1-2002');

SELECT *
FROM FOL_NNUM;

INSERT INTO HEALTHSTATUS
       VALUES (11205,124253685,'pakistan'),
              (16682,658424653,'Kuwait'),
              (78953,826261916,'Afghan'),
              (10090,114686389,'indonesia'),
			   (34321,368190075,'Emirates');
SELECT * 
FROM HEALTHSTATUS;


INSERT INTO FOLLOWER
VALUES(658424653,'Kuwait','Hamzaa','esam','Darwesh'),
(368190075,'Emirates','samir','khaled','Alhashimi'),
(124253685,'Pakistan','janah','zayn','khan'),
(826261916,'Afghan','karim','malik','afgani'),
(114686389,'Indonesia','somiati','sojanim','gado');
    SELECT * 
    FROM FOLLOWER;

INSERT INTO Emp_Swork 
       VALUES ('1-10-2022','health',8000),
              ('1-10-2022','administrative',10000),
              ('2-10-2022','administrative',10000),
              ('2-10-2022','health',8000),
              ('1-10-2022','filed',5000),
              ('12-10-2022','health',0),
              ('17-10-2022','administrative',0),
              ('18-10-2022','health',0),
              ('11-10-2022','administrative',0),
              ('14-10-2022','filed',0);

SELECT *
FROM Emp_Swork;

INSERT INTO Employee 
VALUES (1004927721,'Mohammed','Saleh','AlQahtani','9-8-1993','M','health','1-10-2022'), 
       (1007553192,'Sarah','Abdullah','AlQurashi','14-5-1997','F','administrative','1-10-2022'),
       (1002002823,'Jawad','Moayad','AlHothali','9-10-1995','M','administrative','2-10-2022'),
       (1004456791,'Kholoud','Mohammed','Ali','10-12-1992','F','health','2-10-2022'),
       (1002718911,'Said','Nasser','AlSaeedi','12-12-1989','M','filed','1-10-2022'),
       (710322598,'Walaa','Ahmed','AlHussaini','12-12-2002','F','health','12-10-2022'),
       (210309218,'Taif','Mohammed','AlQahtani','17-5-2001','M','administrative','17-10-2022'),
       (410287311,'Aryaf','Fahad','AlObaidi','18-10-2000','F','health','18-10-2022'),
       (500987321,'Ahmed','Khaled','AlFahmi','11-12-1994','M','administrative','11-10-2022'),
       (500567902,'Jamil','Mohammed','AlKuhaili','14-5-1997','M','filed'  ,'14-10-2022');
       
SELECT *
FROM Employee;

INSERT INTO Category
       VALUES (15000,1,'Y',9),
            (10000,2,'N',6);  
              
              SELECT *
              FROM Category ;
              

 INSERT INTO Volunteer
       VALUES ('1103225980',75,'King Adbullah Hospital',710322598),
              ('1103092187',65,'Umm Alqura University',210309218),
              ('1102873111',100,'King Adbullah Hospital',410287311),
              ('1009873210',90,'Wady Makkah Company',500987321),
              ('1005679021',80,'Umm Alqura University',500567902);
SELECT *
FROM Volunteer;

INSERT INTO VOL_volunteerWork
       VALUES  ('1103225980','paramedies'),
               ('1103092187','translators'),
               ('1103092187','organizers'),
               ('1102873111','paramedies'),
               ('1009873210','organizers'),
               ('1005679021','organizers'),
               ('1005679021','paramedies');

SELECT *
FROM VOL_volunteerWork;

INSERT INTO COMPANY
VALUES (100,'Almarayi','Saptco','Rafels','annual',17000);

SELECT *
FROM COMPANY;

INSERT INTO CAT_activies
VALUES ('zamzam well',1),
	   ('visit Al Madinah',2),
       ('sacred house towers',1),
       ('prophet Mohammad museum',2);
 
SELECT *
FROM CAT_activies;

INSERT INTO Supplie
VALUES(100,1),
      (100,2);
      
SELECT *
FROM Supplie;

INSERT INTO VISA
  VALUES (1001,1419-12-20,'Y'),
         (1002,1423-5-19,'Y'),
		 (1003,1400-10-3,'Y'),
         (1004,1430-8-28,'Y'),
		 (1005,1440-4-30,'Y'); 
     
SELECT *
FROM VISA;

INSERT INTO supervision 
VALUES (1007553192,1004927721),
       (1002002823,1004456791),
       (1002002823,1002718911);
       
SELECT *
FROM supervision; 

INSERT INTO pilgrim 
VALUES
('Pakistani','2022-10-26','P71534','Pakistan',1 ,124253685 ,'Pakistan',1001,2), 
('Egypt' ,'2022-10-24' ,'EQ415','Kuwait',1 ,658424653 ,'Kuwait' ,1002,2) ,
('Afghan','2022-10-26','AF958241','Afghan',1 ,826261916 ,'Afghan',1003,1) , 
('Indonesian','2022-10-21','INDO7254','Indonesia',1,114686389,'Indonesia',1004,1), 
('Jordanian','2022-10-20','J176254','Emirates',1 ,368190075,'Emirates',1005,1);
 
SELECT *
FROM pilgrim; 

INSERT INTO  PI_DateCote
values (1,'2','26-10-2022'),
(2,'2','24-10-2022'),
(3,'1','26-10-2022'),
(4,'1','21-10-2022'),
(5,'1','20-10-2022');

SELECT *
FROM PI_DateCote;

INSERT INTO HealthChronicDiseeases 
       VALUES (11205,'high blood'),
              (16682,'asthma'),
              (78953,'diabetes '),
			  (10090,'high blood'),
              (34321,'cancer');
SELECT *
FROM HealthChronicDiseeases;

INSERT INTO health_specialCases
       VALUES (11205 , 'physical disability'),
			  (16682 , 'none' ),
              (78953 , 'musculoskeletal' ),
              (10090 , 'genetic disorders'),
              (34321 , 'none');

SELECT *
FROM health_specialCases;

INSERT INTO PI_VISA_number
values ( 1242536853,'M','Khan','Raja','Mohammed',' 19-04-1990'),
        (658424653,'F','Darwesh','Mostafa','Radawa ','09-05-1985'),
        (826261916,'M','Afgani','Nasseer','Khalad','17-01-1992'),
        (1146863896,'F','Agus','Andri','Shams','23-05-1994'),
        (3681900752,'M','Alhashimi','Abdullah','Khaled','15-07-1985');

SELECT *
FROM PI_VISA_number;

INSERT INTO PIL_email 
   values ('moham199@gmail.com','Pakistan',1242536853),
          ('radwa19@gmail.com','Kuwait',658424653),
          ('Khal1992@gmail.com','Afghan',826261916),
          ('shan10@gmail.com','Indonesia',1146863896),
          ('khalid18@gmail.com','Emirates',3681900752);


SELECT *
FROM PIL_email;

INSERT INTO Work_On 
      VALUES ( 1004927721 , 1103225980 , 1),
			 ( 1007553192, 1103092187 ,2 ),
             ( 1002002823, 1102873111 , 2),
              ( 1004456791, 1009873210 , 1),
              ( 1002718911 , 1005679021, 1 );

SELECT *
FROM Work_On;

SELECT categoryNum, COUNT(nationalitY) AS Number_Of_Pilgrims, COUNT(numOfIndividual) AS Number_Of_Individual
FROM pilgrim
GROUP BY categoryNum;


SELECT volunteerWork AS Taif_VolunteerWork
FROM vol_volunteerwork
WHERE natID IN ( SELECT natID 
                 FROM Volunteer 
				 WHERE emID IN ( SELECT emID 
                                FROM Employee 
                                WHERE fName='Taif'));
                 
SELECT Follwer_fName,Follwer_mName,Follwer_lName 
FROM FOLLOWER 
order BY Follwer_fName ASC;

SELECT *
FROM pilgrim
ORDER BY  dateOfArrival , categoryNum ASC ;


SELECT dateOfArrival , Vnumber , Vcountry 
FROM pilgrim 
WHERE dateOfArrival IN ('2022-10-26');

SELECT  COUNT(sex) AS number_of_female
FROM  FOL_NNUM
WHERE sex IN ('F')
GROUP BY   sex ;
           
SELECT categoryNum
FROM category
WHERE price > 12000;

UPDATE Emp_Swork
SET  salary=salary+1500
WHERE salary=0;

SELECT workStartDate,jobTitle, salary AS Salary_OR_BonusFor_volunteer
FROM Emp_Swork;

UPDATE FOLLOWER
SET Follwer_fName='Ahmaed'
WHERE Follwer_fName ='Hamzaa';

SELECT * 
FROM FOLLOWER;

DELETE FROM CAT_activies
WHERE activies='visit Al Madinah';

SELECT *
FROM CAT_activies;

SELECT categoryNum, COUNT(activies) AS Number_Of_Activities
FROM CAT_activies
GROUP BY categoryNum
HAVING categoryNum=2;


SELECT nationality,numOfIndividual,passportNum,dateOfArrival,p.Vnumber,sex As sex_Of_Individual
FROM pilgrim p,FOL_NNUM f
WHERE p.Vnumber=f.Vnumber;

UPDATE CAT_activies 
SET activies='The Beautiful Names of Allah Exhibition'
WHERE activies='sacred house towers';

SELECT *
FROM CAT_activies;

SELECT  mainOrg, numOfHours
FROM    Volunteer
WHERE   numOfHours > (SELECT AVG(numOfHours) FROM  Volunteer);

DELETE FROM supervision
WHERE sup_emID = 1004456791;

SELECT *
FROM supervision;


