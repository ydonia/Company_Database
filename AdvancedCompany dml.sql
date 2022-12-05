
# for now, these will be the people in my database
INSERT INTO PERSON
VALUES      (156738839,'Youssef','Donia','M','21','2200 Waterview Pkwy',null,'2145173909',null),
            (456421565,'Layla','Donia','F','26','500 Ln Dive','5924 Beth Dr','2146748888',null),
            (425727667,'John','Smith','M','35','34734 cacn pk',null,'9087463498',null),
            (726768478,'Kamran','Khan','M','40','337 UTD Ln',null,'2145177906','2343432323'),
            (356568968,'Matilda','Hubcap','F','50','74734 Dr ln',null,'2143453909',null),
            (123456789,'Magd','Mak','M','54','4564 Hello Dr',null,'2145177889',null),
            (177665454,'Mona','Elaassar','F','30','3456 Wfdfr Dr',null,'2135573609',null),
            (278676786,'Just','Aguy','M','60','4499 Coit Rd',null,'2142987399',null),
            (678678678,'Mike','Fake','M','20','32 Nice Apartments',null,'2142345909',null),
            (878978687,'Bridget','Wopner','F','34','2200 Waterview Pkwy',null,'2143173679',null);
            
insert into PERSON(ID, First_name, Last_Name, AddrLine_1, Phone1)
VALUES		(948563875, 'Ali', 'Hilal', '231 Way Road', '3849503847'),
			(678909704, 'Richard', 'Burns', '334 Wall Street', '4567876539');



# these are the applicants to the company
INSERT INTO POTENTIAL_EMPLOYEE
VALUES		(878978687, 53466),
			(678678678, 66773),
			(356568968, 12453),
			(425727667, 22325);
            
# these will be the departments in the company
INSERT INTO DEPARTMENT
VALUES		(1, 'Sales'),
			(2, 'IT'),
            (3, 'Inventory'),
            (4, 'Data'),
            (5, 'QA');
            
INSERT INTO JOB
VALUES 		(12, 'Formatting Tech', 'Formatting computers to prepare them for users', null, 2),
			(145, 'Salesman', 'Selling products to customers', '2022-12-01', 1),
            (3, 'Data Analyst', null, '2022-10-05', 4);
			
            


INSERT INTO INTERVIEW(Interview_id,Job_id,Round_, Score, Avg_score, Candidate_id)
VALUES 		(4345, 12, 1, 78, 78, 22325),
			(6372, 3, 1, 65, 65, 53466),
            (6675, 12, 1, 78, 78, 12453),
            (3333, 145, 1, 80, 80, 66773);

select * from JOB;

INSERT INTO CUSTOMER(Cust_id, ID)
VALUES 		(3456, 177665454),
			(789, 278676786),
            (1239,878978687);
            
select * from customer;


INSERT INTO SITE
VALUES 		(1, 'Plano HQ', 75093),
			(2, 'Dallas HQ', 75021),
            (3, 'Austin HQ', 78393);
            
INSERT INTO VENDOR
VALUES		(1,'TI' , 'www.texasInstruments.com', null),
			(2,'Staples' , 'www.staples.com', null),
            (3,'Amazon' , 'www.amazon.com', null);




INSERT INTO PART(Part_id, Global_id, Part_name, Price, Vendor_id, Dep_id)
VALUES		(232, 2212, 'screw AA', 12, 2, 3),
			(432, 2213, 'screw BB', 10, 3, 3),
            (455, 6374, 'cpu', 400, 1, 2),
            (112, 899, 'SoC Chip', 700, 1, 2);


select * from PART;



INSERT INTO PRODUCT(Prod_id, Prod_name, Dep_id, Part_quantity, List_price)
VALUES		(123, 'Laptop', 2, 4, 900),
			(463, 'Chair', 1, 3, 42),
            (565, 'Desk', 1, 6, 150);
            


INSERT INTO EMPLOYEE(ID, Emp_id, Title, Dep_id, Mgr_id, Salary)
VALUES		(156738839, 1, 'Data Lead', 4, null, 90000),
			(456421565, 2, 'Data Intern', 4, 1, 20000),
            (425727667, 3, 'IT Specialist', 2, 4, 40000),
            (726768478, 4, 'IT Lead', 2, null, 70000),
            (123456789, 5, 'Inventory Guy', 3, null, 80000);

INSERT INTO EMPLOYEE(ID, Emp_id, Title, Dep_id, Salary)
VALUES		(948563875, 6, 'Telecom Scammer', 1, 20000),
			(678909704, 7, 'Saleman', 1, 25000);

select * from employee;
            
INSERT INTO SALES 
VALUES 		(1, 3456, 6, 123, 2, '2022-12-2 10:26:33'),
			(2, 1239, 7, 463, 1, '2014-3-3 11:15:54'),
            (3, 789, 7, 463, 1, '2011-3-6 12:35:11'),
            (4, 789, 6, 565, 3, '2011-3-22 6:34:14');
            
-- DELETE FROM SALES
-- WHERE Sale_id = 1
-- or Sale_id = 2
-- or Sale_id = 3
-- or Sale_id = 4


select * from sales;

INSERT INTO WORKS_AT(Emp_id, Site_id)
VALUES 		(6, 2),
			(7, 1),
            (6, 3),
            (2, 2),
            (1, 1), 
            (4, 3),
            (3, 3),
            (5, 2);

select * from WORKS_AT;

-- UPDATE EMPLOYEE 
-- SET
-- 	Start_time


# CREATING VIEWS FOR THE DATABASE

# 1) if you are asking to get the average salary from all the months since the employee has worked at this company, i cannot do that, 
# because to do that i would have had to store all the salaries of the employee each month, and my database just does not 
# have that feature.
CREATE VIEW View1 AS
SELECT
	P.First_name,
    P.Last_name,
	avg(E.Salary),
    E.Emp_id
FROM EMPLOYEE E, PERSON P
	WHERE P.ID = E.ID;

# 2) 
CREATE VIEW View2 AS
SELECT
	count(I.Round_), I.Candidate_id, Score
FROM INTERVIEW I
	WHERE I.Score > 60
GROUP by I.Candidate_id;


# 3) 
CREATE VIEW View3 AS
SELECT
	count(*)
FROM SALES S, PRODUCT Pr
	WHERE Pr.Prod_id = S.Prod_id
GROUP by Pr.Prod_type;

# 4)
CREATE VIEW View4 AS 
SELECT (Pa.Price * Pr.Part_quantity)
FROM PRODUCT Pr, PART Pa
	WHERE Pa.Part_type = Pr.Part_types
GROUP by Pr.Prod_id;
    
	
# adding data for the fetch statements for the project
insert into JOB(Job_id, Job_name)
values 		(1111, 'Intern');

insert into PERSON(ID, First_name, Last_name, AddrLine_1, Phone1)
values 		(987362965, 'Hellen', 'Cole', 'Random Addr', '2345678906');


insert into POTENTIAL_EMPLOYEE
values		(987362965, 93843);

insert into INTERVIEW(Interview_id, Job_id, Round_, Score, Avg_score,Candidate_id, Interviewers)
values		(2367, 1111, 1, 32, 32, 93843, 'John Smith');

insert into DEPARTMENT
VALUES		(6, 'Marketing');

select * from department;

insert into JOB(Job_id, Job_name, Posted_date, Dep_id)
values 		(56, 'Marketer', '2021-1-4', 6),
			(34, 'Market Analyst', '2021-1-22', 6);

select * from site;
select * from job;
select * from interview;
UPDATE JOB
SET
	Dep_id = 3
where Job_id = 1111;

select * from sales;
select * from product;
select * from part;

insert into sales
values 		(5, 789, 6, 123, 3, '2022-12-04 13:12:33');

update part 
set Price = 60
where Part_id = 455;


insert into interview(Interview_id, Job_id, Round_, Score, Avg_score, Candidate_id)
values 		(9675, 12, 2, 62, 68, 12453),
			(9677, 12, 3, 70, 70, 12453),
            (9680, 12, 4, 80, 73, 12453),
            (9686, 12, 5, 64, 70, 12453);

select * from POTENTIAL_EMPLOYEE;

select * from Vendor;

insert into part
values 		(4579, 123, 'cup', null, 10, 3, 1),
			(9865, 123, 'cup', null, 13, 2, 1);

select * from part;
select * from product;

update part
set
	Part_type = 3
where 
	Part_id = 4579
	or Part_id = 9865;
    
update product
set
	Part_quantity = 2
    where 
    Prod_id = 565;