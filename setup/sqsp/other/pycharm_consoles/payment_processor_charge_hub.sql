-- FPENG-2714
--
-- Run the following DDL
-- docker/code/etl/build_datavault_tables/sql/tables/payment_processor_charge_hub_tbl.sql
-- docker/code/etl/build_datavault_tables/sql/procedures/payment_processor_charge_hub_sproc.sql
select * from datavault.payment_processor_charge_hub;

-- Test the payment_processor_charge_hub sproc
--
-- Truncate the table if you are making changes to the sproc
-- truncate datavault.payment_processor_charge_hub;
--
-- The following query is from the operator file (bde-airflow/docker/code/etl/build_datavault_tables/operators/build_payment_processor_charge_hub.py)
select datavault.add_stripe_payment_processor_charge_hub('2019-12-01'::timestamptz, '2019-12-31'::timestamptz);

-- Check the results
select * from datavault.payment_processor_charge_hub;
-- where payment_processor_charge_id like 're_%';
