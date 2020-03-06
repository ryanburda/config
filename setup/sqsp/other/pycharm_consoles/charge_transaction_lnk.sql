-- Make sure the charge hub, transaction hub, and all associated satellites are populated.

-- Run the following DDL
-- bde-airflow/docker/code/etl/build_datavault_tables/sql/tables/payment_processor_charge_transaction_lnk_tbl.sql
--
-- Go through the tables that are involved in this lnk table query
--
select *
from datavault.payment_processor_transaction_hub;

select *
from datavault.payment_processor_charge_hub;

select *
from source_raw.stripe_events;

select *
from source_raw.stripe_balance_transactions;


-- Start with payment_processor_charge_hub
-- Join to stripe_events on '{data,object,balance_transaction}'
-- Join to balance transactions
select
    ppr.payment_processor_nm as record_source,
    ppch.charge_id as charge_id,
    ppch.payment_processor_charge_hash_key as charge_hash_key,
    ppth.transaction_id as transaction_id,
    ppth.payment_processor_transaction_hash_key as transaction_hash_key
from datavault.payment_processor_charge_hub ppch
join source_raw.stripe_events se
    on ppch.payment_processor_charge_id = se.object #>> '{data,object,id}'
join datavault.payment_processor_transaction_hub ppth
    on se.object #>> '{data,object,balance_transaction}' = ppth.payment_processor_transaction_id,
datavault.payment_processor_ref ppr
where se.created >= '2019-12-04' and se.created < '2019-12-05' and
      ppr.payment_processor_nm = 'stripe';


-- The first 3 days of charges fail to join to their corresponding balance transaction due to the fact that
-- payouts have a 3 day lifecycle.

-- drop table datavault.payment_processor_charge_transaction_lnk;
-- truncate datavault.payment_processor_charge_transaction_lnk;
select datavault.add_to_payment_processor_charge_transaction_lnk('2019-12-01', '2019-12-31');

select *
from datavault.payment_processor_charge_transaction_lnk;

