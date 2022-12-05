use AdvancedCompany;

CREATE TABLE PERSON (
  ID			CHAR(9)		NOT NULL,
  First_Name 	VARCHAR(10)	NOT NULL,
  Last_Name 	VARCHAR(20)	NOT NULL,
  Gender 		CHAR(1),
  Age 			INT,
  AddrLine_1 	VARCHAR(30)	NOT NULL,
  AddrLine_2 	VARCHAR(30),
  Phone1 		CHAR(10)	NOT NULL,
  Phone2		CHAR(10),
  PRIMARY KEY (ID)
);


CREATE TABLE POTENTIAL_EMPLOYEE (
  ID 			CHAR(9)		NOT NULL,
  App_id 		INT			NOT NULL,
  PRIMARY KEY (App_id),
  UNIQUE	(ID),
  FOREIGN KEY (ID) REFERENCES PERSON(ID)
);

CREATE TABLE DEPARTMENT (
  Dep_id 		INT			NOT NULL,
  Dep_name 		VARCHAR(20)	NOT NULL,
  PRIMARY KEY 	(Dep_id),
  UNIQUE		(Dep_name)
);

CREATE TABLE JOB (
  Job_id 		INT			NOT NULL,
  Job_descr		VARCHAR(50),
  Posted_date 	DATE,
  Dep_id		INT,
  PRIMARY KEY (Job_id),
  FOREIGN KEY (Dep_id) REFERENCES DEPARTMENT(Dep_id)
);

# Adding an attribute for the job name to the JOB table
ALTER TABLE JOB
ADD COLUMN Job_name VARCHAR(20) NOT NULL AFTER Job_id;

CREATE TABLE INTERVIEW (
  Interview_id 	INT			NOT NULL,
  Interview_time TIME,
  Job_id 		INT			NOT NULL,
  Round 		INT			NOT NULL,
  Score 		INT 		NOT NULL,	
  Avg_score 	INT	 		NOT NULL,
  Candidate_id 	INT 		NOT NULL,
  Interviewers 	VARCHAR(30),
  PRIMARY KEY (Interview_id),
  FOREIGN KEY (Candidate_id) REFERENCES POTENTIAL_EMPLOYEE(App_id),
  FOREIGN KEY (Job_id) REFERENCES JOB(Job_id)
);

ALTER TABLE INTERVIEW
RENAME COLUMN Round TO Round_;

CREATE TABLE CUSTOMER (
  Cust_id 		INT 		NOT NULL,
  ID 			CHAR(9)		NOT NULL,
  Pref_salesman VARCHAR(20),
  PRIMARY KEY (Cust_id),
  UNIQUE	(ID),
  FOREIGN KEY (ID) REFERENCES PERSON(ID)
);


CREATE TABLE SITE (
  Site_id 		INT 		NOT NULL,
  Site_name 	VARCHAR(10)	NOT NULL,
  Site_location VARCHAR(20)	NOT NULL,
  PRIMARY KEY (Site_id),
  UNIQUE	(Site_name)
);

ALTER TABLE SITE
ADD COLUMN Site_zip DECIMAL(5) NOT NULL AFTER Site_name,
DROP COLUMN Site_location;

CREATE TABLE VENDOR (
  Vendor_id 	INT 		NOT NULL,
  Vendor_name 	VARCHAR(15)	NOT NULL,
  Url 			VARCHAR(25) NOT NULL,
  Credit_rating INT,
  PRIMARY KEY (Vendor_id),
  UNIQUE	(Url)
);

CREATE TABLE PART (
  Part_id 		INT 		NOT NULL,
  Global_id 	INT 		NOT NULL,
  Part_name 	VARCHAR(15)	NOT NULL,
  Part_type 	VARCHAR(10),
  Price 		INT 		NOT NULL,
  Vendor_id 	INT 		NOT NULL,
  Dep_id 		INT 		NOT NULL,
  Site_id 		INT 		NOT NULL,
  PRIMARY KEY (Part_id),
  FOREIGN KEY (Site_id) REFERENCES SITE(Site_id),
  FOREIGN KEY (Vendor_id) REFERENCES VENDOR(Vendor_id),
  FOREIGN KEY (Dep_id) REFERENCES DEPARTMENT(Dep_id)
);

# i just realized that a part doesnt get shipped off to a site, only a product does, so we dont need Site_id for part
ALTER TABLE PART
DROP FOREIGN KEY part_ibfk_1,
DROP COLUMN Site_id;


CREATE TABLE PRODUCT (
  Prod_id 		INT 		NOT NULL,
  Dep_id 		INT 		NOT NULL,
  Prod_type 	VARCHAR(10),
  Part_quantity INT 		NOT NULL,
  Part_types 	VARCHAR(20),
  Style 		VARCHAR(10),
  List_price 	INT 		NOT NULL,
  size 			INT,
  weight		INT,
  PRIMARY KEY (Prod_id),
  FOREIGN KEY (Dep_id) REFERENCES DEPARTMENT(Dep_id)
);

ALTER TABLE PRODUCT
ADD COLUMN Prod_name VARCHAR(15) NOT NULL AFTER Prod_id;

CREATE TABLE EMPLOYEE (
  ID 			CHAR(9) 	NOT NULL,
  Emp_id 		INT 		NOT NULL,
  Title 		VARCHAR(20) NOT NULL,
  Rank_			VARCHAR(10),
  Dep_id 		INT 		NOT NULL,
  Mgr_id 		INT,
  Pay_date 		DATE,
  Amount 		INT,
  Transac_id 	INT,
  Start_time 	TIME,
  End_time 		TIME,
  PRIMARY KEY (Emp_id),
  UNIQUE 	(ID),
  FOREIGN KEY (Mgr_id) REFERENCES EMPLOYEE(Emp_id),
  FOREIGN KEY (ID) REFERENCES PERSON(ID),
  FOREIGN KEY (Dep_id) REFERENCES DEPARTMENT(Dep_id)
);

ALTER TABLE EMPLOYEE
DROP FOREIGN KEY employee_ibfk_1;

ALTER TABLE EMPLOYEE
ADD CONSTRAINT Manager FOREIGN KEY (Mgr_id) REFERENCES EMPLOYEE(Emp_id);

ALTER TABLE EMPLOYEE
RENAME COLUMN Amount TO Salary;

CREATE TABLE SALES (
  Sale_id 		INT 		NOT NULL,
  Cust_id 		INT 		NOT NULL,
  Emp_id 		INT 		NOT NULL,
  Prod_id 		INT 		NOT NULL,
  Site_id 		INT 		NOT NULL,
  sale_time 	TIME		NOT NULL,
  PRIMARY KEY (Sale_id),
  FOREIGN KEY (Prod_id) REFERENCES PRODUCT(Prod_id),
  FOREIGN KEY (Cust_id) REFERENCES CUSTOMER(Cust_id),
  FOREIGN KEY (Emp_id) REFERENCES EMPLOYEE(Emp_id),
  FOREIGN KEY (Site_id) REFERENCES SITE(Site_id)
);

ALTER TABLE SALES
MODIFY COLUMN sale_time DATETIME;

CREATE TABLE WORKS_AT (
  Emp_id 		INT 		NOT NULL,
  Site_id 		INT 		NOT NULL,
  FOREIGN KEY (Emp_id) REFERENCES EMPLOYEE(Emp_id),
  FOREIGN KEY (Site_id) REFERENCES SITE(Site_id)
);

ALTER TABLE WORKS_AT
ADD COLUMN Day DATE AFTER Site_id;











