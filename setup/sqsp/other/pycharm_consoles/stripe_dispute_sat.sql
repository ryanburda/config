-- Find all of the ids in ppch that are not charges or refunds
select *
from datavault.payment_processor_charge_hub
where payment_processor_charge_id not like 'ch_%' and
      payment_processor_charge_id not like 're_%';

-- See if there are any other id prefixes that are not 'dp_%' or 'du_%'
select substr(payment_processor_charge_id, 0, 3)
from datavault.payment_processor_charge_hub
where payment_processor_charge_id not like 'ch_%' and
      payment_processor_charge_id not like 're_%'
group by substr(payment_processor_charge_id,0, 3);
-- nope just those two

-- Find all of the event types that are not charges or refunds
select type
from source_raw.stripe_events
where object #>> '{data,object,id}' not like 'ch_%' and
      object #>> '{data,object,id}' not like 're_%'
group by type;
-- capability.updated
-- charge.dispute.closed
-- charge.dispute.created
-- charge.dispute.funds_reinstated
-- charge.dispute.funds_withdrawn
-- charge.dispute.updated
-- coupon.created
-- coupon.deleted
-- coupon.updated
-- customer.card.created
-- customer.card.deleted
-- customer.card.updated
-- customer.created
-- customer.source.expiring
-- customer.subscription.created
-- customer.subscription.deleted
-- customer.subscription.trial_will_end
-- customer.subscription.updated
-- customer.updated
-- file.created
-- invoice.created
-- invoice.finalized
-- invoice.marked_uncollectible
-- invoice.payment_action_required
-- invoice.payment_failed
-- invoice.payment_succeeded
-- invoice.updated
-- invoice.voided
-- invoiceitem.created
-- invoiceitem.updated
-- payment_intent.amount_capturable_updated
-- payment_intent.canceled
-- payment_intent.created
-- payment_intent.payment_failed
-- payment_intent.requires_capture
-- payment_intent.succeeded
-- payment_method.attached
-- payment_method.card_automatically_updated
-- payment_method.detached
-- radar.early_fraud_warning.created
-- radar.early_fraud_warning.updated
-- setup_intent.created
-- setup_intent.succeeded
-- tax_rate.created
-- transfer.created
-- transfer.paid


-- Too much stuff. Find all of the event types that are 'du_%' or 'dp_%'
select type
from source_raw.stripe_events
where object #>> '{data,object,id}' like 'dp_%' or
      object #>> '{data,object,id}' like 'du_%'
group by type;
-- charge.dispute.funds_withdrawn
-- charge.dispute.funds_reinstated
-- charge.dispute.updated
-- charge.dispute.closed
-- charge.dispute.created

-- Find the relevant fields from dispute objects
select *
from source_raw.stripe_events se
where se.type in ('charge.dispute.funds_withdrawn',
                  'charge.dispute.funds_reinstated',
                  'charge.dispute.updated',
                  'charge.dispute.closed',
                  'charge.dispute.created');


-- DROP or TRUNCATE the table
-- drop table datavault.stripe_dispute_sat;
-- truncate datavault.stripe_dispute_sat;
--
-- Run the DDL
-- bde-airflow/docker/code/etl/build_datavault_tables/sql/tables/stripe_dispute_sat_tbl.sql
-- bde-airflow/docker/code/etl/build_datavault_tables/sql/procedures/stripe_dispute_sat_sproc.sql
-- bde-airflow/docker/code/etl/build_datavault_tables/operators/build_stripe_dispute_sat.py
-- bde-airflow/docker/code/etl/build_datavault_tables/sql/procedures/stripe_dispute_sat_trg_sproc.sql
-- bde-airflow/docker/code/etl/build_datavault_tables/sql/triggers/stripe_dispute_sat_trg.sql
--
-- Run the function (from bde-airflow/docker/code/etl/build_datavault_tables/operators/build_stripe_dispute_sat.py)
select datavault.add_stripe_dispute_sat('2019-12-01', '2019-12-31');
--
-- Check the results
select *
from datavault.stripe_dispute_sat;
where valid_to_ts != 'infinity';

-- Debug dupe key
select *
from datavault.payment_processor_charge_hub ppch
inner join source_raw.stripe_events se
    on ppch.payment_processor_charge_id = se.object #>> '{data,object,id}'
where ppch.charge_id = '464320';


-- Looks like 'charge.dispute.funds_reinstated' and 'charge.dispute.closed' can come in in the same second.
-- Figure out which one comes first.
select fr.object #>> '{data,object,id}' as dispute_id,
       fr.created as funds_reinstated_event_created_ts,
       c.created as closed_event_created_ts
from source_raw.stripe_events fr
inner join source_raw.stripe_events c
    on fr.object #>> '{data,object,id}' = c.object #>> '{data,object,id}'
where fr.type = 'charge.dispute.funds_reinstated' and
      c.type = 'charge.dispute.closed'
order by fr.object #>> '{data,object,id}';
-- closed fires first

