/*Since we divied the author names into first name and last name we need a table which contain the combined names
Auth_names is that table*/

with authors(rp_id,auth_id,name) as (select rp_id, paper_author.author_id as auth_id,concat(first_name,' ',last_name) as name from paper_author inner join author on paper_author.author_id = author.author_id order by rp_id),

/*Now we have a separate row for each author we need to combine them into a single string we do that using string_arr() function we store this data in Auth_List Table*/

author_names(rp_id,names) as (select rp_id,string_agg(name,',') as names from authors group by rp_id),

/*Now we join this Auht_list table and citations table on citrp_id becuase we need the details of papers that are cited by a particualr paper*/


cit_auths(rp_id,cit_id,names) as (select citations.rp_id,citations.citrp_id,names from citations inner join author_names on citations.citrp_id = author_names.rp_id)

 /*And now we finally join this Cit_Auth and research_paper table so we can get the details of venue,year etc into our table and finally we select them and get our output*/


select cit_auths.rp_id AS Citing_Id, cit_id AS Cited_Id,title,names AS Author_Names,publication_year,Conference_name from research_paper inner join cit_auths on research_paper.rp_id = cit_auths.cit_id order by cit_auths.rp_id;