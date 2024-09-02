/*All the combinations of all the authors of same paper are taken into a temporary table named auth_pairs table*/
WITH auth_pairs(auth_id_1, auth_id_2) AS (SELECT t1.author_id AS auth_id_1, t2.author_id AS auth_id_2 FROM paper_author AS t1 JOIN paper_author AS t2 ON t1.rp_id=t2.rp_id AND t1.author_id <t2.author_id),

/*Now all those pairs of authors are taken and grouped by the ids of those pairs whose occurrence is greater than 1*/
CA(auth_id_1,auth_id_2) AS (SELECT auth_id_1, auth_id_2, COUNT(*) FROM auth_pairs GROUP BY auth_id_1, auth_id_2 HAVING count(*)>1)

/*Now these author_id's are used and joined with author table for the names of these*/
SELECT concat(a1.first_name, a1.last_name) AS name1,concat(a2.first_name,a2.last_name) AS name2 FROM ca JOIN author AS a1 ON ca.auth_id_1 = a1.author_id JOIN author AS a2 ON ca.auth_id_2 = a2.author_id;