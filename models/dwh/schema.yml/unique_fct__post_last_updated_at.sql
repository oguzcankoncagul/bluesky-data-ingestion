
    
    

select
    last_updated_at as unique_field,
    count(*) as n_records

from "local_db"."main_dwh"."fct__post"
where last_updated_at is not null
group by last_updated_at
having count(*) > 1


