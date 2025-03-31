-- This query retrieves the top 10 skills for Data Engineer positions that offer work from home options, along with their average salaries.
-- It joins the job postings fact table with the skills job dimension and skills dimension to filter and aggregate the data accordingly.
-- The results are ordered by average salary in descending order, and only the top 25 skills are returned.

SELECT 
    skills,
    ROUND(AVG(salary_year_avg),0) AS avg_salary
FROM job_postings_fact
INNER JOIN skills_job_dim ON job_postings_fact.job_id = skills_job_dim.job_id
INNER JOIN skills_dim ON skills_job_dim.skill_id = skills_dim.skill_id
WHERE
    job_work_from_home = TRUE
    AND
    job_title_short = 'Data Engineer'
    AND
    salary_year_avg IS NOT NULL
GROUP BY
    skills
ORDER BY
    avg_salary DESC
LIMIT 25;   

/*
-- This SQL query retrieves the top 25 highest-paying skills for Data Engineer job postings that offer work from home options.

"skills","avg_salary"
"assembly","192500"
"mongo","182223"
"ggplot2","176250"
"rust","172819"
"clojure","170867"
"perl","169000"
"neo4j","166559"
"solidity","166250"
"graphql","162547"
"julia","160500"
"splunk","160397"
"bitbucket","160333"
"zoom","159000"
"kubernetes","158190"
"numpy","157592"
"mxnet","157500"
"fastapi","157500"
"redis","157000"
"trello","155000"
"jquery","151667"
"express","151636"
"cassandra","151282"
"unify","151000"
"kafka","150549"
"vmware","150000"
