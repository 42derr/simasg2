DROP TABLE IF EXISTS students_eval;
DROP TABLE IF EXISTS tmp_subjects;

CREATE TABLE students_eval (
    student_number INT,
    subjects ARRAY<STRUCT<subject_code:STRING, evaluation:INT>>
)
ROW FORMAT DELIMITED
FIELDS TERMINATED BY ','
COLLECTION ITEMS TERMINATED BY ';'
MAP KEYS TERMINATED BY ':'
STORED AS TEXTFILE;

CREATE TABLE tmp_subjects (
    student_number INT,
    subject_code STRING,
    evaluation INT
);

INSERT INTO tmp_subjects VALUES
(1111,'CSIT111',1),
(1111,'CSIT121',23),
(1111,'CSIT101',50),
(1111,'CSIT235',99),
(1111,'ISIT312',2),
(1112,'CSIT101',56),
(1112,'CSIT111',78),
(1112,'CSIT115',10),
(1112,'ISIT312',5),
(1113,'CSIT121',76),
(1113,'CSIT235',87),
(1113,'ISIT312',49),
(1114,'CSIT111',50),
(1114,'ISIT312',45),
(1115,'ISIT115',67),
(1115,'CSCI235',45),
(1115,'CSIT127',56);

INSERT INTO students_eval
SELECT student_number,
       collect_list(named_struct('subject_code', subject_code, 'evaluation', evaluation))
FROM tmp_subjects
GROUP BY student_number;

SELECT * FROM students_eval;
