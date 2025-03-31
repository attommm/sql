-- This SQL query retrieves the top 10 highest-paying skills for Data Engineer job postings in the Anywhere location. 
-- It first selects the top 10 job postings based on salary and then retrieves the distinct skills associated with those job postings.
-- The query uses Common Table Expressions (CTEs) to first filter and order the job postings, and then joins with the skills_job_dim and skills_dim tables to get the relevant skills.

WITH top_jobs AS (
    SELECT 
        job_id,
        job_title,
        salary_year_avg,
        name AS company_name
    FROM 
        job_postings_fact
    LEFT JOIN
        company_dim
    ON
        job_postings_fact.company_id = company_dim.company_id
    WHERE
        job_title_short = 'Data Engineer'
        AND
        job_location = 'Anywhere'
        AND
        salary_year_avg IS NOT NULL
    ORDER BY
        salary_year_avg DESC
    LIMIT 10
)

SELECT 
    DISTINCT(skills_dim.skills)
FROM 
    top_jobs
INNER JOIN
    skills_job_dim
ON
    top_jobs.job_id = skills_job_dim.job_id
INNER JOIN
    skills_dim
ON
    skills_job_dim.skill_id = skills_dim.skill_id
;

/*
-- The output of the query will be a list of distinct skills associated with the top 10 highest-paying Data Engineer job postings.

"skills"
"aws"
"azure"
"databricks"
"gcp"
"go"
"hadoop"
"java"
"kafka"
"keras"
"kubernetes"
"nosql"
"numpy"
"pandas"
"perl"
"pyspark"
"python"
"pytorch"
"r"
"scala"
"spark"
"sql"
"tensorflow"
