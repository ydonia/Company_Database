# 1. return teh ID and Name of interviewers for Hellen Cole's interview. job_id is going to be 1111 instead of 11111

SELECT I.Interviewers 
	FROM INTERVIEW I, POTENTIAL_EMPLOYEE PE, PERSON P
WHERE I.Candidate_id = PE.App_id
	AND I.Job_id = 1111
    AND PE.ID IN (SELECT P.ID 
	FROM PERSON
WHERE P.First_name = 'Hellen'
	AND P.Last_name = 'Cole');
    
# 2. Return the ID of all jobs posted by department "Marketing". instead of 2011, im doing 2021
SELECT J.Job_id, D.Dep_name
	FROM JOB J, DEPARTMENT D
WHERE D.Dep_id = J.Dep_id
	AND D.Dep_name = 'Marketing';
    
# 3. Return the ID and the name of employees that have no supervisees
select P.First_name, P.Last_name
	from PERSON P, EMPLOYEE A
where P.ID = A.ID
	and not exists (select * 
						from EMPLOYEE B 
					where B.Mgr_id = A.Emp_id);


# 4. Return the ID and location of marketing sites which have no sale records during March 2011
SELECT S.Site_id, S.Site_zip
	FROM SITE S, SALES Sa
    WHERE S.Site_id = Sa.Site_id
		AND S.Site_id IN (SELECT Site_id
						FROM SALES
                        WHERE NOT MONTH(sale_time) = 3
							AND NOT YEAR(sale_time) = 2011);
                            
# 5. return the job id and name which does not hire a person one month after posted 
select Job_id, Job_name, Job_descr
	from JOB
where month(Posted_date) <= month(now())-1;

# 6. return the name and id of salemen that sold product over $200
select P.First_name, E.Emp_id
	from PERSON P, EMPLOYEE E
WHERE P.ID = E.ID
	AND E.Emp_id in (select E.Emp_id
						from EMPLOYEE E, PRODUCT Pr, SALES S
					where Pr.List_price > 200
						and Pr.Prod_id = S.Prod_id
                        and E.Emp_id = S.Emp_id);
                        
select * from sales;


# 7. return the departments id and name which has no job post during 2011-1-1 2011-2-1
select D.Dep_id, D.Dep_name 
	from DEPARTMENT D, JOB J
WHERE D.Dep_id = J.Dep_id
	and J.Posted_date != '2011-1-1'
	and J.Posted_date != '2011-2-1';
    
# 8. get teh Id and name and dep id of the existing employees who apply to job id 12. doing 12 instead of 12345
select E.Emp_id, P.First_name, P.Last_name
	FROM PERSON P, EMPLOYEE E, POTENTIAL_EMPLOYEE PE
where P.ID = E.ID
	AND P.ID = PE.ID
    AND PE.App_id IN (select PE.App_id
						from INTERVIEW I
						where I.Job_id = 12
                        and PE.App_id = I.Candidate_id);
                        
# 9. return the seller who sold the most items
select E.Emp_id, P.First_name, P.Last_name, count(Prod_id)
	from PERSON P, EMPLOYEE E, SALES
where P.ID = E.ID
	and E.Emp_id = SALES.Emp_id 
    group by Sales.Emp_id
    order by count(Prod_id) desc
    limit 1;
    
    
    (select Emp_id, count(Prod_id)
									from SALES 
								group by Emp_id
                                order by count(Prod_id) desc;

    
# 10. return product whose net profit is highest in the company
select p.Prod_name, sum(p.List_price - (p.part_quantity * pa.price)) as profit
	from product p, sales s, part pa
where p.Prod_id = s.Prod_id
group by prod_name
order by profit;


# 11. get name and id of employee who worked in dep 4
# my database does not track the history of what departments an employee has worked for, and an employee can work for one
# department at a time only, so it is impossible to get this query from the database
select P.First_name, P.Last_name
	FROM PERSON P, EMPLOYEE E
where P.ID = E.Emp_id
	and E.Dep_id = 4;
    
# 12. get the name and email address of the interviewee who is selected. i will do phone number instead of address

select P.First_name, P.Last_name, P.Phone1
	from PERSON P, POTENTIAL_EMPLOYEE PE
where P.ID = PE.ID
	and PE.App_id in (select App_id
						from POTENTIAL_EMPLOYEE, INTERVIEW
					where App_id = Candidate_id
						and Round_ >= 5
						and Avg_score >= 70);
					
                    
# 13. name and phone numbers of all people who got accepted to all their jobs
select DISTINCT P.First_name, P.Last_name, P.Phone1
	from PERSON P, POTENTIAL_EMPLOYEE PE, INTERVIEW
where P.ID = PE.ID
	and (PE.App_id,4) in (select App_id, count(Round_)
						from POTENTIAL_EMPLOYEE, INTERVIEW
					where App_id = Candidate_id
						and Avg_score >= 70
                        group by App_id
                        order by count(Round_) desc);
                        
                        
# 14. return employee name and id who has the highest average monthly salary
select P.First_name, P.Last_name, E.Emp_id
	from PERSON P, EMPLOYEE E
where P.ID = E.ID
	and E.Salary in (select max(Salary)
						from EMPLOYEE);
                        
                        
# 15. ID and name of vendor who supplies a part that has name 'Cup' and price is lowest
# my part entity does not have a weight column, only product does, so cannot find weight. was not in specifications
select V.Vendor_id, V.Vendor_name
	from VENDOR V, PART P 
where V.Vendor_id = P.Vendor_id
	and (P.Global_id,P.Price) = (select Global_id, min(Price)
									from PART
								where Part_name = 'cup'
								group by Global_id);
                        
                        