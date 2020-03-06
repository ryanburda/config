-- Run the following DDL
-- docker/code/etl/build_datavault_tables/sql/tables/payment_processor_payout_transaction_lnk_tbl.sql

select *
from datavault.payment_processor_transaction_hub ppth;

select se.object #>> '{data,object,balance_transaction}', *
from source_raw.stripe_events se;

select se.object #>> '{data,object,source}', *
from source_raw.stripe_events se;

select *
from source_raw.stripe_balance_transactions;



select
    ppr.payment_processor_nm as record_source,
    ppph.payout_id as payout_id,
    ppph.payment_processor_payout_hash_key as payout_hash_key,
    ppth.transaction_id as transaction_id,
    ppth.payment_processor_transaction_hash_key as transaction_hash_key
from datavault.payment_processor_transaction_hub ppth
join source_raw.stripe_balance_transactions sbt
    on ppth.payment_processor_transaction_id = sbt.object ->> 'id'
join datavault.payment_processor_payout_hub ppph
    on sbt.object #>> '{data,object,balance_transaction}' = ppph.payment_processor_payout_id,
datavault.payment_processor_ref ppr
where sbt.created >= '2019-12-01' and sbt.created < '2019-12-31' and
      ppr.payment_processor_nm = 'stripe'
limit 1;



select
    ppth.transaction_id as transaction_id,
    ppth.payment_processor_transaction_hash_key as transaction_hash_key
from datavault.payment_processor_transaction_hub ppth
join source_raw.stripe_balance_transactions sbt
    on ppth.payment_processor_transaction_id = sbt.object ->> 'id'
join datavault.payment_processor_payout_hub ppph
    on sbt.object #>> '{data,object,balance_transaction}' = ppph.payment_processor_payout_id,
