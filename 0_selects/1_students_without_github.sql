SELECT id, name, email, cohort_id 
FROM students 
WHERE github IS NULL 
ORDER BY cohort_id;


/* 
  COMMAND TERMINAL에서 부르는 법
  1. BootcampX 위치에서 psql 실행
  2. \c bootcampx 실행해서 db 연결하기
  3. \i 0_selects/1_students_without_github.sql 입력해서 해당 폴더의 파일에 명령어 수행하기

*/