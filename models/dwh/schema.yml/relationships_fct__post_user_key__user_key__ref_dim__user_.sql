
    
    

with child as (
    select user_key as from_field
    from "local_db"."main_dwh"."fct__post"
    where user_key is not null
),

parent as (
    select user_key as to_field
    from "local_db"."main_dwh"."dim__user"
)

select
    from_field

from child
left join parent
    on child.from_field = parent.to_field

where parent.to_field is null


