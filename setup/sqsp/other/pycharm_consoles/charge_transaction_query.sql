-- Places where hubs and sats are sourced from
select *
from source_raw.stripe_events;

select *
from source_raw.stripe_balance_transactions;

-- Charge hub and sats
select *
from datavault.payment_processor_charge_hub;

select *
from datavault.stripe_charge_sat
where amount_refunded > 0;

select *
from datavault.stripe_dispute_sat;

select *
from datavault.stripe_refund_sat;

-- Transaction hub and sats
select *
from datavault.payment_processor_transaction_hub;

select *
from datavault.stripe_balance_transaction_sat;

-- Link between charges and transactions
select *
from datavault.payment_processor_charge_transaction_lnk;


select
    ppc_hub.charge_id,
    ppc_hub.payment_processor_charge_id,
    ppt_hub.transaction_id,
    ppt_hub.payment_processor_transaction_id,
    ppct_lnk.charge_transaction_lnk_id,
    sc_sat.customer as charge_customer,
    sc_sat.type as charge_type,
    sc_sat.currency as charge_currency,
    sc_sat.amount as charge_amount,
    sc_sat.amount_refunded as charge_amount_refunded,
    sc_sat.status as charge_status,
    sd_sat.dispute_id as dispute_dispute_id,
    sd_sat.type as dispute_type,
    sd_sat.currency as dispute_currency,
    sd_sat.amount as dispute_amount,
    sd_sat.status as dispute_status,
    sr_sat.type as refund_type,
    sr_sat.currency as refund_currency,
    sr_sat.amount as refund_amount,
    sr_sat.status as refund_status,
    bt_sat.currency as bt_currency,
    bt_sat.amount as bt_amount,
    bt_sat.net_of_fees as bt_net_of_fees,
    bt_sat.fee as bt_fee,
    bt_sat.status as bt_status,
    bt_sat.available_on as bt_available_on
from datavault.payment_processor_charge_hub ppc_hub
left outer join datavault.payment_processor_charge_transaction_lnk ppct_lnk using(charge_id)
left outer join datavault.payment_processor_transaction_hub ppt_hub using(transaction_id)
left outer join datavault.stripe_charge_sat sc_sat using(charge_id)
left outer join datavault.stripe_dispute_sat sd_sat on ppc_hub.charge_id = sd_sat.dispute_id
left outer join datavault.stripe_refund_sat sr_sat on ppc_hub.charge_id = sr_sat.refund_id
left outer join datavault.stripe_balance_transaction_sat bt_sat on bt_sat.balance_transaction_id = ppt_hub.transaction_id
where
    charge_transaction_lnk_id is not null and sc_sat.type != 'charge.failed' and
    (sc_sat.valid_from_ts <= now() or sc_sat.valid_from_ts is null) and
    (sc_sat.valid_to_ts > now() or sc_sat.valid_to_ts is null) and
    (sd_sat.valid_from_ts <= now() or sd_sat.valid_from_ts is null) and
    (sd_sat.valid_to_ts > now() or sd_sat.valid_to_ts is null) and
    (sr_sat.valid_from_ts <= now() or sr_sat.valid_from_ts is null) and
    (sr_sat.valid_to_ts > now() or sr_sat.valid_to_ts is null) and
    (bt_sat.valid_from_ts <= now() or bt_sat.valid_from_ts is null) and
    (bt_sat.valid_to_ts > now() or bt_sat.valid_to_ts is null);


select count(*)
from datavault.payment_processor_charge_hub ppc_hub
left outer join datavault.payment_processor_charge_transaction_lnk ppct_lnk using(charge_id)
left outer join datavault.payment_processor_transaction_hub ppt_hub using(transaction_id)
left outer join datavault.stripe_charge_sat sc_sat using(charge_id)
left outer join datavault.stripe_dispute_sat sd_sat on ppc_hub.charge_id = sd_sat.dispute_id
left outer join datavault.stripe_refund_sat sr_sat on ppc_hub.charge_id = sr_sat.refund_id
left outer join datavault.stripe_balance_transaction_sat bt_sat on bt_sat.balance_transaction_id = ppt_hub.transaction_id
where
    charge_transaction_lnk_id is not null and -- and sc_sat.type != 'charge.failed' and
    (sc_sat.valid_from_ts <= now() or sc_sat.valid_from_ts is null) and
    (sc_sat.valid_to_ts > now() or sc_sat.valid_to_ts is null) and
    (sd_sat.valid_from_ts <= now() or sd_sat.valid_from_ts is null) and
    (sd_sat.valid_to_ts > now() or sd_sat.valid_to_ts is null) and
    (sr_sat.valid_from_ts <= now() or sr_sat.valid_from_ts is null) and
    (sr_sat.valid_to_ts > now() or sr_sat.valid_to_ts is null) and
    (bt_sat.valid_from_ts <= now() or bt_sat.valid_from_ts is null) and
    (bt_sat.valid_to_ts > now() or bt_sat.valid_to_ts is null);


with amounts as (
    select ppc_hub.charge_id,
           ppc_hub.payment_processor_charge_id,
           ppt_hub.transaction_id,
           ppt_hub.payment_processor_transaction_id,
           ppct_lnk.charge_transaction_lnk_id,
           coalesce(sc_sat.amount - sc_sat.amount_refunded, sd_sat.amount, sr_sat.amount, 0)/100.0 as amount,
           coalesce(sc_sat.event_ts, sd_sat.event_ts, sr_sat.event_ts, null)                       as event_ts,
           coalesce(sc_sat.type, sd_sat.type, sr_sat.type, null)                                   as type,
           coalesce(sc_sat.currency, sd_sat.currency, sr_sat.currency, null)                       as currency,
           coalesce(sc_sat.status, sd_sat.status, sr_sat.status, null)                             as status,
           bt_sat.currency                                                                         as bt_cur,
           (bt_sat.amount/100.0)                                                                   as bt_amount,
           (bt_sat.net_of_fees/100.0)                                                              as bt_net_of_fees,
           (bt_sat.fee/100.0)                                                                      as bt_fees,
           bt_sat.status                                                                           as bt_status,
           bt_sat.available_on                                                                     as bt_available_on
    from datavault.payment_processor_charge_hub ppc_hub
    inner join datavault.payment_processor_charge_transaction_lnk ppct_lnk using (charge_id)
    inner join datavault.payment_processor_transaction_hub ppt_hub using (transaction_id)
    left outer join datavault.stripe_charge_sat sc_sat using (charge_id)
    left outer join datavault.stripe_dispute_sat sd_sat on ppc_hub.charge_id = sd_sat.dispute_id
    left outer join datavault.stripe_refund_sat sr_sat on ppc_hub.charge_id = sr_sat.refund_id
    left outer join datavault.stripe_balance_transaction_sat bt_sat on bt_sat.balance_transaction_id = ppt_hub.transaction_id
    where (sc_sat.valid_from_ts <= now() and sc_sat.valid_to_ts >= now() or sc_sat.valid_to_ts is null) and
          (sd_sat.valid_from_ts <= now() and sd_sat.valid_to_ts >= now() or sd_sat.valid_to_ts is null) and
          (sr_sat.valid_from_ts <= now() and sr_sat.valid_to_ts >= now() or sr_sat.valid_to_ts is null) and
          (bt_sat.valid_from_ts <= now() and bt_sat.valid_to_ts >= now() or bt_sat.valid_to_ts is null)
)
select sum(amount) as amount, sum(bt_net_of_fees) net_of_fees
from amounts;


select distinct(type)
from source_raw.stripe_balance_transactions;


