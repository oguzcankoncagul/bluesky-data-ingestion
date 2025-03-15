
    
    

select
    post_key as unique_field,
    count(*) as n_records

from "local_db"."main_dwh"."fct__post"
where post_key is not null
group by post_key
having count(*) > 1


