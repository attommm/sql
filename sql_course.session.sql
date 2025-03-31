CREATE TABLE job_applied (
    job_id INT,
    application_sent_date DATE,
    custim_resume BOOLEAN,
    resume_file_name VARCHAR(225),
    cover_letter_sent BOOLEAN,
    cover_letter_file_name VARCHAR(255),
    status VARCHAR(50)
); 

SELECT *
FROM job_applied;

ALTER TABLE job_applied
    RENAME COLUMN custim_resume to custom_resume;

INSERT INTO job_applied
VALUES 
    (1, '2024-02-01', true, 'resume_01.pdf', true, 'cover_letter_01.pdf', 'submitted'),
    (2, '2024-02-02', false, 'resume_02.pdf', false, NULL, 'interview scheduled'),
    (3, '2024-02-03',true,'resume_o3.pdf',true, 'cover_letter_03.pdf', 'ghosted'),
    (4, '2024-02-04', true, 'resume_04.pdf', false, NULL, 'submitted'),
    (5, '2024-02-05', false, 'resume_o5.pdf', true, 'cover_letter_05.pdf', 'rejected')
;

UPDATE job_applied
SET resume_file_name = 'resume_05.pdf'
WHERE job_id = 5;

ALTER TABLE job_applied
ADD contact VARCHAR(50);

UPDATE  job_applied
SET     contact = 'Erlich Bachman'
WHERE   job_id = 1;

UPDATE  job_applied
SET     contact = 'Dinesh Chugtai'
WHERE   job_id = 2;

UPDATE  job_applied
SET     contact = 'Bertram Gilfoyle'
WHERE   job_id =3;

UPDATE  job_applied
SET     contact = 'Jian Yang'
WHERE   job_id = 4;

UPDATE  job_applied
SET     contact = 'Big Head'
WHERE   job_id =5;

ALTER TABLE job_applied
RENAME COLUMN contact TO contact_name;

ALTER TABLE job_applied
ALTER COLUMN contact_name TYPE TEXT;

ALTER TABLE job_applied
DROP COLUMN contact_name;

DROP TABLE job_applied;

SELECT *  FROM company_dim
LIMIT 20
;

SELECT
    count(job_id) AS number_of_jobs,
    CASE
        WHEN job_location = 'Anywhere' THEN 'Remote'
        WHEN job_location = 'NY' THEN 'Local'
        ELSE 'Onsite'
    END AS location_category
FROM 
    job_postings_fact
GROUP BY
    location_category    
;

SELECT *
FROM ( 
    SELECT *
    FROM job_postings_fact
    WHERE EXTRACT(MONTH from job_posted_date ) = 1
) as january_jobs;

WITH january_jobs AS (
    SELECT *
    FROM job_postings_fact
    WHERE EXTRACT(MONTH FROM job_posted_date) = 1
)

SELECT *
FROM january_jobs;

SELECT
    name 
FROM 
    company_dim
WHERE 
    company_id IN (
        SELECT 
            company_id
        FROM
            job_postings_fact
        WHERE
            job_no_degree_mention = TRUE
);


SELECT *
from company_dim;

WITH 
    jobs 
as 
(
    SELECT
        company_id,
        count(*) as count_job_list
    FROM
        job_postings_fact
    GROUP BY
        company_id)

SELECT 
    company_dim.name AS company_name,
    jobs.count_job_list    
FROM
    company_dim
LEFT JOIN
    jobs
ON
    company_dim.company_id = jobs.company_id
;


WITH skill_count AS (
    SELECT 
        skills_job_dim.skill_id as skill_id,
        count(*) as counts
    FROM
        skills_job_dim
    INNER JOIN
        job_postings_fact
    ON
        skills_job_dim.job_id = job_postings_fact.job_id
    WHERE
        job_postings_fact.job_work_from_home = TRUE
    GROUP BY
        skills_job_dim.skill_id
)

SELECT    
    skill_count.skill_id AS skill_id,
    skills_dim.skills AS skill_name,
    skill_count.counts As posting_count
FROM
    skill_count 
INNER JOIN
    skills_dim
ON 
    skill_count.skill_id = skills_dim.skill_id
ORDER BY
    posting_count
    DESC
LIMIT
    5;

select *
from job_postings_fact;

select *
from
(SELECT 
    job_title_short,
    company_id,
    job_location,
    salary_year_avg
FROM
    january_jobs

UNION
SELECT 
    job_title_short,
    company_id,
    job_location,
    salary_year_avg
FROM
    february_jobs

UNION
SELECT 
    job_title_short,
    company_id,
    job_location,
    salary_year_avg
FROM
    march_jobs)

WHERE 
    salary_year_avg > 70000    
    ;

SELECT
    quarter1_job_postings.job_title_short,
    quarter1_job_postings.job_location,
    quarter1_job_postings.job_via,
    quarter1_job_postings.job_posted_date::DATE,
    quarter1_job_postings.salary_year_avg
FROM (
    SELECT *
    FROM january_jobs
    UNION ALL
    SELECT *
    FROM february_jobs
    UNION ALL
    SELECT *
    FROM march_jobs
) AS quarter1_job_postings

WHERE 
    quarter1_job_postings.salary_year_avg > 70000
AND
    quarter1_job_postings.job_title_short = 'Data Analyst'
ORDER BY
    quarter1_job_postings.salary_year_avg 
    