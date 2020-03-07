-- FPENG-2721
--
-- Setting up the billing_provider_payment_ref table
--
-- Run the following scripts to set up existing dependencies
-- bde-airflow/docker/code/etl/build_datavault_tables/sql/domains_types/billing_domains.sql
-- bde-airflow/docker/code/etl/build_datavault_tables/sql/tables/billing_provider_ref_tbl.sql
--
-- Test the results
select * from datavault.billing_provider_ref;
--
-- Run the payment_processor_ref_tbl DDL script
-- docker/code/etl/build_datavault_tables/sql/tables/payment_processor_ref_tbl.sql
--
-- Test the results
select * from datavault.payment_processor_ref;