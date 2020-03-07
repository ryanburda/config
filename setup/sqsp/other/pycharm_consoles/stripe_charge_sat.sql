-- FPENG-2714
--
-- Create the stripe_charges_sat
--
-- What event types do charges come in under?
select type
from source_raw.stripe_events
where object #>> '{data,object,object}' = 'charge'
group by type;
-- charge.captured
-- charge.expired
-- charge.failed
-- charge.refunded
-- charge.succeeded
-- charge.updated

-- How to populate datavault.stripe_charge_sat locally
--
-- Either TRUNCATE or DROP the existing table
--
-- truncate table datavault.stripe_charge_sat;
-- drop table datavault.stripe_charge_sat;
--
-- Run scripts
-- bde-airflow/docker/code/etl/build_datavault_tables/sql/tables/stripe_refund_sat_tbl.sql
-- bde-airflow/docker/code/etl/build_datavault_tables/sql/procedures/stripe_refund_sat_sproc.sql
-- bde-airflow/docker/code/etl/build_datavault_tables/operators/build_stripe_refund_sat.py
-- bde-airflow/docker/code/etl/build_datavault_tables/sql/procedures/stripe_refund_sat_trg_sproc.sql
-- bde-airflow/docker/code/etl/build_datavault_tables/sql/triggers/stripe_refund_sat_trg.sql
--
-- Populate the table
select datavault.add_stripe_charge_sat('2019-12-01'::timestamptz, '2019-12-31'::timestamptz);
-- Test result
select *
from datavault.stripe_charge_sat;
--order by charge_id;
