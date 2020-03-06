-- Pull data from production to local (Run in terminal)
-- truncate source_raw.stripe_payout_transaction_map;
-- ssh bde-dv001.eqx.dal.corp.squarespace.net "psql datavault -c \"\copy (SELECT * FROM source_raw.stripe_payout_transaction_map where payout_status_event_dt >= '2019-11-25' and payout_status_event_dt < '2020-01-01') TO STDOUT\" | gzip" | gzcat | psql -c "\copy source_raw.stripe_payout_transaction_map FROM STDIN"
-- ssh bde-dv001.eqx.dal.corp.squarespace.net "psql datavault -c \"\copy (SELECT * FROM source_raw.stripe_events where created >= '2019-11-15' and created < '2020-01-01' and type IN ('transfer.created', 'transfer_paid')) TO STDOUT\" | gzip" | gzcat | psql -c "\copy source_raw.stripe_events FROM STDIN"
-- See if rows made it into the table
select *
from source_raw.stripe_payout_transaction_map;

select *
from source_raw.stripe_balance_transactions
where (object ->> 'type' = 'transfer');


select (sum((object ->> 'net')::bigint)/100)::decimal
from source_raw.stripe_balance_transactions
where (object ->> 'type' = 'transfer');

-- Run the query from the operator
-- truncate datavault.payment_processor_payout_hub;
select datavault.add_stripe_payment_processor_payout_hub('2019-12-01', '2019-12-31');

select *
from datavault.payment_processor_payout_hub;

select *
from source_raw.stripe_events
where type like '%transfer%';

-- Satellite
-- Run the following DDL
-- bde-airflow/docker/code/etl/build_datavault_tables/sql/tables/stripe_payout_sat_tbl.sql
-- bde-airflow/docker/code/etl/build_datavault_tables/sql/procedures/stripe_payout_sat_sproc.sql
--
-- Add to the sat
-- truncate datavault.stripe_payout_sat;
select datavault.add_stripe_payout_sat('2019-12-01', '2019-12-31');

select *
from datavault.stripe_payout_sat;

select *
from source_raw.stripe_balance_transactions;

select *
from source_raw.stripe_payout_transaction_map;
