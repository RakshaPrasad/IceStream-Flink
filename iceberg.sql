-- 1. CREATE ICEBERG CATALOG
CREATE CATALOG iceberg_catalog WITH (
  'type'='iceberg',
  'catalog-type'='hadoop',
  'warehouse'='hdfs://namenode:9000/warehouse',
  'property-version'='1'
);

USE CATALOG iceberg_catalog;

-- 2. CREATE DATABASE
CREATE DATABASE IF NOT EXISTS flink_demo;

USE flink_demo;

-- 3. CREATE ICEBERG SINK TABLE
CREATE TABLE iceberg_sink (
  id BIGINT,
  name STRING,
  tax_amount INT,
  processing_time TIMESTAMP(3)
) WITH (
  'format'='parquet',
  'write.parquet.compression'='snappy'
);

-- 4. CREATE KAFKA SOURCE TABLE
CREATE TABLE kafka_source (
  id BIGINT,
  name STRING,
  tax_amount INT
) WITH (
  'connector'='kafka',
  'topic'='test-source',
  'properties.bootstrap.servers'='kafka:9092',
  'scan.startup.mode'='earliest-offset',
  'format'='json',
  'json.ignore-parse-errors'='true'
);

-- 5. INSERT JOB: KAFKA -> ICEBERG
INSERT INTO iceberg_sink 
SELECT id, name, tax_amount, CURRENT_TIMESTAMP 
FROM kafka_source;

-- 6. QUERY TO VERIFY
SELECT * FROM iceberg_sink;