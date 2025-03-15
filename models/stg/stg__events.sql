

select
    timestamp,
    action,
    path,
    repo,
    json_extract_string(record, '$.uri') as uri,
    json_extract_string(record, '$.text') as text,
    json_extract_string(record, '$.langs') as langs
from "local_db"."main_landing"."events"