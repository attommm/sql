
/* 
what are the top paying data enginner jobs?
*/  

SELECT 
    job_id,
    job_title,
    job_location,
    job_schedule_type,
    salary_year_avg,
    job_posted_date,
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
;
\/*
-- The output of the query will be a list of the top 10 highest-paying Data Engineer job postings, including their job ID, title, location, schedule type, average salary, posting date, and company name.

"job_id","job_title","job_location","job_schedule_type","salary_year_avg","job_posted_date","company_name"
21321,"Data Engineer","Anywhere","Full-time","325000.0","2023-01-27 18:10:51","Engtal"
157003,"Data Engineer","Anywhere","Full-time","325000.0","2023-02-17 18:11:49","Engtal"
270455,"Data Engineer","Anywhere","Full-time","300000.0","2023-07-17 11:10:55","Durlston Partners"
230458,"Director of Engineering - Data Platform","Anywhere","Full-time","251000.0","2023-01-30 11:07:32","Twitch"
543728,"Staff Data Engineer","Anywhere","Full-time","250000.0","2023-03-28 13:11:42","Signify Technology"
561728,"Data Engineer","Anywhere","Full-time","250000.0","2023-03-24 23:32:42","AI Startup"
595768,"Principal Data Engineer","Anywhere","Full-time","250000.0","2023-02-14 15:24:07","Signify Technology"
204320,"Staff Data Engineer","Anywhere","Full-time","245000.0","2023-01-08 15:05:16","Handshake"
151972,"Principal Data Engineer (Remote)","Anywhere","Full-time","245000.0","2023-05-25 15:05:38","Movable Ink"
2446,"Data Engineering Manager","Anywhere","Full-time","242000.0","2023-12-12 15:56:17","Meta"


