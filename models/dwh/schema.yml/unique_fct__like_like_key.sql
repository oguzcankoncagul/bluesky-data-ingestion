
    
    

select
    like_key as unique_field,
    count(*) as n_records

from "local_db"."main_dwh"."fct__like"
where like_key is not null
group by like_key
having count(*) > 1


