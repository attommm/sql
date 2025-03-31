-- This query retrieves the top 10 skills required for Data Engineer jobs that are work from home.
-- It joins the job postings fact table with the skills job dimension and skills dimension to count the number of job postings for each skill.

SELECT 
    skills,
    COUNT(skills_job_dim.job_id) AS job_count
FROM job_postings_fact
INNER JOIN skills_job_dim ON job_postings_fact.job_id = skills_job_dim.job_id
INNER JOIN skills_dim ON skills_job_dim.skill_id = skills_dim.skill_id
WHERE
    job_title_short = 'Data Engineer'
    AND
    job_work_from_home = TRUE
GROUP BY
    skills
ORDER BY
    job_count DESC
LIMIT 10;

/*

"skills","job_count"
"sql","14213"
"python","13893"
"aws","8570"
"azure","6997"
"spark","6612"
"airflow","4329"
"snowflake","4053"
"java","3801"
"databricks","3716"
"kafka","3391"

