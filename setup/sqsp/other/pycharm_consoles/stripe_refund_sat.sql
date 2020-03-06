-- FPENG-2714
--
-- Create the stripe_refund_sat table
--
-- Look through the hub to see what refund events came in.
select *
from datavault.payment_processor_charge_hub
where payment_processor_charge_id like 're_%';

-- Break out the refund lines
select refund_item ->> 'id', *
from source_raw.stripe_events se,
     jsonb_array_elements(se.object #> '{data,object,refunds,data}') as refund_item(object);

-- Use the query above and join back to the hub
select refund_item ->> 'id', *
from source_raw.stripe_events se,
     jsonb_array_elements(se.object #> '{data,object,refunds,data}') as refund_item(object)
join datavault.payment_processor_charge_hub ppch
    on ppch.payment_processor_charge_id = refund_item.object ->> 'id'
where se.type IN ('charge.refunded', 'charge.refund.updated');


-- Run the following DDL
-- bde-airflow/docker/code/etl/build_datavault_tables/sql/tables/stripe_refund_sat_tbl.sql
-- bde-airflow/docker/code/etl/build_datavault_tables/sql/procedures/stripe_refund_sat_sproc.sql
-- bde-airflow/docker/code/etl/build_datavault_tables/operators/build_stripe_refund_sat.py
-- bde-airflow/docker/code/etl/build_datavault_tables/sql/procedures/stripe_refund_sat_trg_sproc.sql
-- bde-airflow/docker/code/etl/build_datavault_tables/sql/triggers/stripe_refund_sat_trg.sql

-- DROP or TRUNCATE the table
-- drop table datavault.stripe_refund_sat;
-- truncate datavault.stripe_refund_sat;

-- Populate the table
select datavault.add_stripe_refund_sat('2019-12-01', '2019-12-31');

select *
from datavault.stripe_refund_sat;
where refund_id = 2253529;

-- Debug issues
select *
from datavault.payment_processor_charge_hub
where charge_id = 2253529;

select *
from source_raw.stripe_events se,
     jsonb_array_elements(se.object #> '{data,object,refunds,data}') as refund_item(object)
where refund_item ->> 'id' = 're_GRPxL1LXarJRNr';


select *
from source_raw.stripe_events
where id IN ('evt_GRPxwBOiLSMkUU', 'evt_GRPx0yhmfBRGLf', 'evt_GRY42sbND1E4jK');
