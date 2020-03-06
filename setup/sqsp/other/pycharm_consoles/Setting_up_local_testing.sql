-- Hook up pycharm to your local instance of postgres
-- This comes in handy since you can run scripts against localhost instead of copy and pasting
-- https://www.jetbrains.com/help/pycharm/connecting-to-a-database.html#connect-to-postgresql-database
-- Set host to `localhost`
-- Set the database to your username (rburda)
-- Make sure the current schema is set to look at that database instead of public (top right of console)

-- See what schemas exist
select schema_name
from information_schema.schemata;

-- Create the schemas we will be testing in
create schema source_raw;
create schema datavault;

-- See if those newly created schemas show up. (if not, you may need to mess with the settings above)
select schema_name
from information_schema.schemata;

select * from information_schema.tables;


-- Run the following scripts (right click and run works just fine)
-- bde-airflow/docker/code/etl/billing_event_ingestion/sql/tables/stripe_events.sql
-- bde-airflow/docker/code/etl/build_datavault_tables/sql/tables/reference_tbl.sql

-- Tim B suggested running these as well but I haven't needed them yet.
-- bde-airflow/docker/code/etl/billing_event_ingestion/sql/tables/legacy_offering_dm.sql
-- bde-airflow/docker/code/etl/billing_event_ingestion/sql/tables/ripley_events.sql

-- Get data from prod to local db
--
-- If there is data already in your local copy of source_raw.stripe events then you may want to clear it out before running the following.
-- truncate source_raw.stripe_events;
--
-- From the command line
-- ssh bde-dv001.eqx.dal.corp.squarespace.net "psql datavault -c \"\copy (SELECT * FROM source_raw.stripe_events where created >= '2019-12-01' and created <= '2019-12-31') TO STDOUT\" | gzip" | gzcat | psql -c "\copy source_raw.stripe_events FROM STDIN"


-- Check if rows made it in
select max(created)
from source_raw.stripe_events;
