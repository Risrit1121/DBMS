CREATE TABLE auth_relation(
    auth_id1 INT,
    auth_id2 INT
);

INSERT INTO auth_relation(auth_id1,auth_id2) (SELECT pa1.author_id AS auth_id1,pa2.author_id AS auth_id2 FROM citations AS paper JOIN paper_author AS pa1 on pa1.rp_id = paper.rp_id JOIN paper_author as pa2 on pa2.rp_id = paper.citrp_id WHERE pa1.author_id!=0 and pa2.author_id!=0 and pa1.author_id != pa2.author_id);

/*
WITH Auth_names(auth_id,rp_id,Author_Name) AS (SELECT pa.author_id as auth_id,pa.rp_id as rp_id,concat(first_name,' ',last_name) as Author_name FROM Paper_Author AS pa JOIN Author AS auth on auth.author_id = pa.author_id),
*/
-- SELECT auth1.auth_id1 AS X, auth2.auth_id1 AS Y, auth2.auth_id2 AS Z FROM auth_relation AS auth1 JOIN auth_relation AS auth2 ON auth1.auth_id2=auth2.auth_id1;


/*authUnion(auth_id1, auth_id2) as (select auth_id1, auth_id2 from auth_relation union select auth_id2, auth_id1 from auth_relation)
select t1.auth_id1 X, t2.auth_id1 Y, t3.auth_id1 Z from authUnion t1, authUnion t2, authUnion t3 where t1.auth_id2 = t2.auth_id1 AND t2.auth_id2 = t3.auth_id1 AND t3.auth_id2 = t1.auth_id1 AND t1.auth_id1 < t2.auth_id1 AND t2.auth_id1 < t3.auth_id1 order by X;*/
/*
select cit1.auth_id1 as X, cit1.auth_id2 as Y, cit2.auth_id2 as Z FROM auth_relation as cit1 JOIN auth_relation as cit2 ON cit1.auth_id2 =cit2.auth_id1 AND EXISTS(SELECT 1 FROM auth_relation WHERE (cit1.auth_id1=auth_relation.auth_id1 AND cit2.auth_id2=auth_relation.auth_id2) OR (cit1.auth_id1=auth_relation.auth_id2 AND cit2.auth_id2=auth_relation.auth_id1))
;*/

SELECT auth1.auth_id1 AS X, auth2.auth_id1 AS Y, auth3.auth_id1 AS Z FROM auth_relation AS auth1 JOIN auth_relation AS auth2 ON auth1.auth_id2=auth2.auth_id1 JOIN auth_relation AS auth3 ON auth2.auth_id2=auth3.auth_id1 AND auth3.auth_id2 = auth1.auth_id1
UNION
SELECT auth1.auth_id1 AS X, auth2.auth_id1 AS Y, auth3.auth_id1 AS Z FROM auth_relation AS auth1 JOIN auth_relation AS auth2 ON auth1.auth_id2=auth2.auth_id1 JOIN auth_relation AS auth3 ON auth2.auth_id1=auth3.auth_id2 AND auth3.auth_id2 = auth1.auth_id1
UNION
SELECT auth1.auth_id1 AS X, auth2.auth_id1 AS Y, auth3.auth_id1 AS Z FROM auth_relation AS auth1 JOIN auth_relation AS auth2 ON auth1.auth_id2=auth2.auth_id1 JOIN auth_relation AS auth3 ON auth2.auth_id2=auth3.auth_id1 AND auth3.auth_id2 = auth1.auth_id1
UNION
SELECT auth1.auth_id1 AS X, auth2.auth_id1 AS Y, auth3.auth_id1 AS Z FROM auth_relation AS auth1 JOIN auth_relation AS auth2 ON auth1.auth_id2=auth2.auth_id1 JOIN auth_relation AS auth3 ON auth2.auth_id2=auth3.auth_id1 AND auth3.auth_id1 = auth1.auth_id2;


