-- Challenge Bonus queries.
-- 1. (2.5 pts)
-- Retrieve all the number of backer_counts in descending order for each `cf_id` for the "live" campaigns. 
SELECT camp.cf_id
FROM campaign AS camp
WHERE camp.outcome = 'live'
ORDER BY camp.cf_id DESC;

SELECT * FROM backers;
SELECT * FROM campaign;
SELECT * FROM contacts;

-- 2. (2.5 pts)
-- Using the "backers" table confirm the results in the first query.
SELECT DISTINCT ON (b.cf_id) b.cf_id FROM backers AS b
ORDER BY b.cf_id  DESC;

-- 3. (5 pts)
-- Create a table that has the first and last name, and email address of each contact.
-- and the amount left to reach the goal for all "live" projects in descending order. 
SELECT cont.first_name, cont.last_name, cont.email,
		(camp.goal - camp.pledged) AS "Remaining Goal Amount"
INTO email_contacts_remaining_goal_amount
FROM campaign AS camp
	JOIN contacts AS cont
		ON camp.contact_id = cont.contact_id
WHERE camp.outcome = 'live'
ORDER BY "Remaining Goal Amount" DESC;

-- Check the table
SELECT * FROM email_contacts_remaining_goal_amount;

-- 4. (5 pts)
-- Create a table, "email_backers_remaining_goal_amount" that contains the email address of each backer in descending order, 
-- and has the first and last name of each backer, the cf_id, company name, description, 
-- end date of the campaign, and the remaining amount of the campaign goal as "Left of Goal". 
SELECT back.email, back.first_name, back.last_name, camp.cf_id, 
		camp.company_name, camp.description, camp.end_date, (camp.goal - camp.pledged) AS "Left of Goal"
INTO email_backers_remaining_goal_amount
FROM backers AS back
	JOIN campaign AS camp
		ON back.cf_id = camp.cf_id
WHERE camp.outcome = 'live'
ORDER BY back.email DESC;

-- Check the table
SELECT * FROM email_backers_remaining_goal_amount;

