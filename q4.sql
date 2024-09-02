/*To store the top 20 cited papers and their count, a temporary table is used named mostCited using WITH statement*/

with mostCited(rp_id, count) as (select citrp_id, count(*) as rp_id from citations group by citrp_id order by count(*) desc limit 20),

/*Top 20 papers' authors names are taken into a table named authors by joining their first_name and last_name using concat function*/
authors(rp_id,auth_id,name) as (select paper_author.rp_id as rp_id, paper_author.author_id as auth_id,concat(first_name,' ',last_name) as name from mostCited as MC, paper_author inner join author on paper_author.author_id = author.author_id WHERE paper_author.rp_id = MC.rp_id order by rp_id),

/*Authors names selected in authors table are grouped by research paper index using a delimiter ','*/
author_names(rp_id,names) as (select rp_id,string_agg(name,',') as names from authors group by rp_id)


/*Final select statement joining researchpaper table, author_names table and mostCited table of top 20 cited papers*/
select RP.rp_id,RP.title,AN.names AS Author_Names,RP.publication_year, RP.conference_name,RP.abstract, MC.count from research_paper as RP, author_names as AN,mostCited as MC where rp.rp_id = an.rp_id AND RP.rp_id = MC.rp_id;