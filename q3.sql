
/*Since we divied the author names into first name and last name we need a table which contain the combined names
Auth_names is that table*/

WITH Auth_names(auth_id,rp_id,Author_Name) AS (SELECT pa.author_id as auth_id,pa.rp_id as rp_id,concat(first_name,' ',last_name) as Author_name FROM Paper_Author AS pa JOIN Author AS auth on auth.author_id = pa.author_id),

/* Here, we make a new table where it contains the rp_id and the second level of papers that cite the paper */

 Cit_paper(citrp_id,rp_id) AS (SELECT cit2.citrp_id as citrp_id,cit1.rp_id as rp_id from citations as cit1 join citations as cit2 on cit1.citrp_id = cit2.rp_id),

/*Now we have a separate row for each author we need to combine them into a single string we do that using string_arr() function we store this data in Auth_List Table*/

  Auth_List(rp_id,Auth_List) AS (SELECT rp_id,string_agg(Author_Name,', ') AS Auth_List FROM Auth_Names group by rp_id),

/* Now we join this Auht_list table and citations table on rp_id and citrp_id becuase we need the details of the research papers */

  Cit_Auth(rp_id,citrp_id,rplist,citrplist) AS (SELECT paper.rp_id AS rp_id,paper.citrp_id AS citrp_id, auth.auth_list AS rplist,auth1.auth_list AS citrplist from Cit_paper AS paper JOIN Auth_List AS auth ON paper.rp_id = auth.rp_id JOIN Auth_List AS auth1 ON paper.citrp_id = auth1.rp_id)


 /*And now we finally join this Cit_Auth and research_paper table so we can get the details of venue,year etc into our table and finally we select them and get our output*/


  SELECT auth.citrp_id AS citedrp_id, paper1.Title AS cited_Title, paper1.Publication_Year AS cited_year, paper1.Conference_Name AS cited_Conference,auth.citrplist AS cited_Authors, 
  auth.rp_id AS citingrp_id, paper2.Title AS citing_Title, paper2.Publication_Year AS citing_year, paper2.Conference_Name AS citing_Conference,auth.rplist AS citing_Authors
   FROM Cit_Auth AS auth JOIN Research_Paper AS paper1 ON paper1.rp_id = auth.citrp_id JOIN Research_Paper AS paper2 ON paper2.rp_id = auth.rp_id;