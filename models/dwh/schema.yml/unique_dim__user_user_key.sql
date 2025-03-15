
    
    

select
    user_key as unique_field,
    count(*) as n_records

from "local_db"."main_dwh"."dim__user"
where user_key is not null
group by user_key
having count(*) > 1


