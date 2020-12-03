
-- Use the `ref` function to select from other models

select *
from {{ ref('user_id') }}
where id = 1
