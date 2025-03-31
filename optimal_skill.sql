-- This SQL query retrieves the average salary and job count for each skill associated with Data Engineer positions that allow remote work.
-- It filters out skills that are associated with fewer than 10 job postings and sorts the results by average salary and job count.
-- The query uses INNER JOINs to combine data from the job_postings_fact, skills_job_dim, and skills_dim tables.

SELECT 
    skills_job_dim.skill_id,
    skills_dim.skills AS skill_name,
    COUNT(skills_job_dim.job_id) AS job_count,
    ROUND(AVG(job_postings_fact.salary_year_avg), 0) AS avg_salary
FROM job_postings_fact
INNER JOIN skills_job_dim 
    ON job_postings_fact.job_id = skills_job_dim.job_id
INNER JOIN skills_dim 
    ON skills_job_dim.skill_id = skills_dim.skill_id
WHERE
    job_postings_fact.job_title_short = 'Data Engineer'
    AND 
    job_postings_fact.job_work_from_home = TRUE
    AND 
    job_postings_fact.salary_year_avg IS NOT NULL
GROUP BY 
    skills_job_dim.skill_id, skills_dim.skills
HAVING
    COUNT(skills_job_dim.job_id) > 10
ORDER BY 
    avg_salary DESC,
    job_count DESC



