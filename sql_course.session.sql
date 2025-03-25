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