-- This query retrieves the top 5 skills required for remote Data Engineer positions.
-- It joins the skills_job_dim table with the job_postings_fact table to filter for remote jobs
-- and counts the occurrences of each skill. The results are then ordered by the count in descending order.

WITH remote_jobs AS (
    SELECT
        skill_id,
        COUNT(*) AS skill_count
    FROM
        skills_job_dim AS skills_to_jobs
    INNER JOIN
        job_postings_fact AS job_postings
    ON
        skills_to_jobs.job_id = job_postings.job_id
    WHERE
        job_postings.job_work_from_home = TRUE
        AND
        job_postings.job_title_short = 'Data Engineer'
    GROUP BY
        skill_id
    )

SELECT
    skills.skill_id,
    skills.skills AS skill_name,
    skill_count
FROM
    remote_jobs
INNER JOIN
    skills_dim AS skills
ON
    remote_jobs.skill_id = skills.skill_id
ORDER BY
    remote_jobs.skill_count DESC
LIMIT 10;

/*
-- The output of the query will be a table with the top 10 skills required for remote Data Engineer positions, along with their respective counts.

"skill_id","skill_name","skill_count"
0,"sql","14213"
1,"python","13893"
76,"aws","8570"
74,"azure","6997"
92,"spark","6612"
96,"airflow","4329"
80,"snowflake","4053"
4,"java","3801"
75,"databricks","3716"
98,"kafka","3391"
