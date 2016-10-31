SELECT co.course_name, s.expression, st.lastfirst, attc.att_code, att.att_comment, st.classof, to_char(att.att_date, 'MM/DD/YY')
FROM attendance att
  INNER JOIN attendance_code attc
    ON att.attendance_codeid=attc.dcid
  INNER JOIN students st
    ON att.studentid=st.dcid
  INNER JOIN cc
    ON att.ccid=cc.dcid
    INNER JOIN sections s
    ON cc.sectionid=s.id
  INNER JOIN courses co
    ON cc.course_number=co.course_number
WHERE (attc.att_code = 'EA' OR attc.att_code='CM') 
  AND (trunc(att.att_date) = trunc(sysdate)) 
  AND (att.att_comment IS NOT NULL)
ORDER BY s.expression, co.course_name, attc.att_code, st.lastfirst
