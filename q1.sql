
/*Since we divied the author names into first name and last name we need a table which contain the combined names
Auth_names is that table*/

WITH Auth_names(auth_id,rp_id,Author_Name) AS (SELECT pa.author_id as auth_id,pa.rp_id as rp_id,concat(first_name,' ',last_name) as Author_name FROM Paper_Author AS pa JOIN Author AS auth on auth.author_id = pa.author_id),

/*Now we have a separate row for each author we need to combine them into a single string we do that using string_arr() function we store this data in Auth_List Table*/


 Auth_List(rp_id,Auth_List) AS (SELECT rp_id,string_agg(Author_Name,', ') AS Auth_List FROM Auth_Names group by rp_id),

/*Now we join this Auht_list table and citations table on rp_id becuase we need the details of papers that cite a particualr paper*/

 Cit_Auth(rp_id,citrp_id,list) AS (SELECT paper.rp_id AS rp_id,paper.citrp_id AS citrp_id, auth.auth_list AS list from citations AS paper JOIN Auth_List AS auth ON paper.rp_id = auth.rp_id)

 /*And now we finally join this Cit_Auth and research_paper table so we can get the details of venue,year etc into our table and finally we select them and get our output*/


SELECT paper.citrp_id AS Cited_Id,rp.RP_id AS Citing_Id,rp.Title, rp.Publication_Year AS year,paper.list AS Author_Names, rp.Conference_Name AS Venue FROM Research_Paper AS rp JOIN Cit_Auth AS paper ON rp.RP_id = paper.rp_id ORDER BY paper.citrp_id;
