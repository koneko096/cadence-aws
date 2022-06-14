# Cadence AWS Infra

Proof of concept of running Cadence workflow on AWS using Keyspace Cassandra

## Requirement

- AWS Account
- Terraform >= 1.2.0
- Cassandra CLI (to setup schema manually)

## Steps

1. Configure AWS credentials (by default in `$HOME/.aws/credentials`)

2. Provision infra using this repo

   ```
   terraform apply
   ```

3. Setup schema using guide below (`auto-setup` doesn't work on Keyspace due to lack of CQL supports)

   https://cadenceworkflow.io/docs/operation-guide/maintain/#how-to-apply-db-schema-changes

4. Register domain

   https://cadenceworkflow.io/docs/cli/#domain-operation-examples

5. (Optional) Setup archival providers

   https://cadenceworkflow.io/docs/concepts/archival/#configuring-archival