# Senior Data Engineering - Take home task

Objective: Construct a local data pipeline consuming [Bluesky](https://bsky.app/) event streams.

### Quickstart

- Install Python dependencies: `pip install -r requirements`
- Run `./bluesky | ./handle-stream`
  - This will create a new local DuckDB instance `dev.duckdb` if one doesn't already exist
  - Events will stream into the DuckDB `events` table
- Run `watch -n 30 ./periodic`
  - This will execute the dbt models & the `run_export` script which produces the output CSVs


### Overview

This pipeline uses DuckDB as the choice of local DB and dbt for any ELT operations. The database itself is structured in accordance with medallion architecture guidelines:
  - Bronze: raw landing table for events
  - Silver: normalised fact & dimension tables
  - Gold: aggregated mart tables for metric reporting

The dbt configuration includes some fundamental data modelling practices & basic data quality tests. 
  


### Trade-offs

Some key features have been left out and are to-do for future productionisation:
  - The input data stream and the `periodic` export script cannot be run at the same time. This was my first time using DuckDB (good learning exercise!) and discovered that concurrency locks are applied at the DB-level, not the table level. 
    - In order to get around this, I attempted to implement a "lake db" -> "analytics db" architecture to be able to support both event streaming & CSV export threads concurrently, but quickly approached the time limit before getting this to work. 
    - In theory dbt supports attaching one DuckDB instance to another so this idea seemed the most feasible.
    - Also trialled a "lake db" -> parquet file -> "analytics db" architecture but felt like too many moving parts.
    - This should not be a problem in commercial analytical DBs where lockss are applied on a per-table basis.
  - More bespoke data quality checks can be added to `dbt/tests/` to implement tests for custom business logic
  - CI/CD can be implemented to run `dbt compile` and `dbt test` commands for unit/integration testing.
  - Auto formatting/linting can be implemented.
  - Further dbt macros can be implemented to minimise boilerplate SQL code e.g. around `last_updated_at` fields.
  - ELT pipeline run metadata could be implemented for full E2E data lineage.
  - All data/mart modelling should be fully documented in production.

