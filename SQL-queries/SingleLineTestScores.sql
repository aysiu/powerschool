--example of finding HSPT subscores for 9th graders and putting the subscores on one line per student
--delimited by semi-colon and with a colon between the subscore name and the actual score
SELECT stu.lastfirst, 
  (SELECT LISTAGG(ts.name || ': ' || sts.NumScore, '; ') WITHIN GROUP (ORDER BY ts.sortorder)
    FROM StudentTest st
      INNER JOIN StudentTestScore sts ON sts.StudentTestID=st.ID AND sts.StudentID=st.StudentID
      INNER JOIN TestScore ts ON sts.TestScoreID=ts.ID
      INNER JOIN Test t ON ts.TestID=t.ID
    WHERE t.name='HSPT' AND st.studentID=stu.dcid) "HSPT Scores"
FROM students stu
WHERE stu.enroll_status=0
  AND stu.grade_level=9
ORDER BY "HSPT Scores", stu.grade_level, stu.lastfirst
