-- Run the following DDL
--
-- bde-airflow/docker/code/etl/billing_event_ingestion/sql/tables/stripe_events.sql

-- Pull data from production to local (Run in terminal)
-- truncate source_raw.stripe_balance_transactions;
-- Grab a few days before December 2019 since payouts have a 3 days lifecycle that can span a month boundary.
-- ssh bde-dv001.eqx.dal.corp.squarespace.net "psql datavault -c \"\copy (SELECT * FROM source_raw.stripe_balance_transactions where created >= '2019-11-25' and created < '2020-01-01') TO STDOUT\" | gzip" | gzcat | psql -c "\copy source_raw.stripe_balance_transactions FROM STDIN"

-- Make sure the data made it in to the local db
select *
from source_raw.stripe_balance_transactions;

-- Run the following DDL
-- bde-airflow/docker/code/etl/build_datavault_tables/sql/tables/payment_processor_transaction_hub_tbl.sql
-- bde-airflow/docker/code/etl/build_datavault_tables/sql/procedures/payment_processor_transaction_hub_sproc.sql
-- truncate datavault.payment_processor_transaction_hub;
select datavault.add_stripe_payment_processor_transaction_hub('2019-12-01', '2019-12-31');

select *
from datavault.payment_processor_transaction_hub;


-- Query for satellite
select
    sbt.id as balance_transaction_id,
    sbt.created as created_ts,
    sbt.object ->> 'currency' as currency,
    sbt.object ->> 'amount' as amount,
    sbt.object ->> 'net' as net_of_fees,
    sbt.object ->> 'fee' as fee,
    sbt.object ->> 'status' as status,
    to_timestamp((sbt.object ->> 'available_on')::bigint) as available_on,
    sbt.object ->> 'exchange_rate' as exchange_rate
from source_raw.stripe_balance_transactions sbt
where sbt.created >= '2019-12-01' and sbt.created < '2020-12-01';



-- truncate datavault.stripe_balance_transaction_sat;
-- Run the following DDL
-- bde-airflow/docker/code/etl/build_datavault_tables/sql/tables/stripe_balance_transaction_sat_tbl.sql
-- bde-airflow/docker/code/etl/build_datavault_tables/sql/procedures/stripe_transaction_sat_trg_sproc.sql
-- bde-airflow/docker/code/etl/build_datavault_tables/sql/triggers/stripe_transaction_sat_trg.sql
-- bde-airflow/docker/code/etl/build_datavault_tables/sql/procedures/stripe_balance_transactions_sat_sproc.sql
--
-- Run the query from the operator
select datavault.add_stripe_balance_transaction_sat('2019-12-01', '2019-12-31');


select *
from datavault.stripe_balance_transaction_sat;
--where valid_to_ts != 'infinity';

select *
from datavault.payment_processor_transaction_hub;

select id, count(*)
from source_raw.stripe_balance_transactions
group by id
having count(*) > 1;
