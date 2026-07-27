# IceStream-Flink

Real-time streaming pipeline using Apache Flink + Kafka + Apache Iceberg

## Project Details
This project demonstrates streaming data from Kafka into Iceberg tables using Flink SQL.

## Screenshots

### 1. Docker Containers Running
`docker ps` output showing Kafka, Zookeeper, Flink, MinIO
![docker ps](docs/docker-ps.png)

### 2. Flink Lib Jars
Jars folder with Iceberg and Kafka connectors
![jars](docs/jars.png)

## Tech Stack
- Apache Flink 1.17.1
- Apache Kafka + Zookeeper
- Apache Iceberg 1.4.3  
- MinIO S3
- Docker Compose

## Files
- `docker-compose.yml` : Kafka, Zookeeper, Flink, MinIO setup
- `iceberg.sql` : All Flink SQL commands for source, sink and queries
- `jars/` : Required Flink Iceberg and Hadoop jars

## How to Run
1. Start services: `docker compose up -d`
2. Open Flink SQL: `docker exec -it jobmanager ./bin/sql-client.sh`
3. Execute all SQL from `iceberg.sql`

## Key Fix
Fixed Kafka `advertised.listeners=kafka:9092` for internal Docker networking.

Author: Raksha Prasad
