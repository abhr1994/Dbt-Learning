with tickets as (
    select * from AIRBYTE_DATABASE.PUBLIC.TICKETS
),
case_when_applied as (
select "ticket_id","created_at","updated_at",timediff("hour","created_at","updated_at") as timediff ,
CASE
        WHEN timediff<= 5 THEN 'block1'
        WHEN timediff >5 and timediff <= 10 THEN 'block2'
        WHEN timediff >10 and timediff <= 15 THEN 'block3'
        WHEN timediff >15 and timediff <= 25 THEN 'block4'
        WHEN timediff >25 and timediff <= 50 THEN 'block5'
        WHEN timediff >50 and timediff <= 100 THEN 'block6'
        WHEN timediff >100 and timediff <= 200 THEN 'block7'
        ELSE 'block8'
    END AS block
    from tickets where "status" = 'closed'
    ),
final as (
    select block , count(*) as "total_tickets"  from case_when_applied group by block
)
select CASE
        WHEN block = 'block1' THEN '<5'
        WHEN block = 'block2' THEN '5-10'
        WHEN block = 'block3' THEN '10-15'
        WHEN block = 'block4' THEN '15-25'
        WHEN block = 'block5' THEN '25-50'
        WHEN block = 'block6'THEN '50-100'
        WHEN block = 'block7' THEN '100-200'
        ELSE '>200'
    END AS  "ticket_resolution_in_hours", "total_tickets" from final order by block