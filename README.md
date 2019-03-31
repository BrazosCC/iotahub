# link_iota_hub

This project is for building a Docker image that runs an IOTA Hub.

https://docs.iota.org/docs/hub/0.1/introduction/overview

The Hub connects to an IOTA node's API port and exposes a port for gRPC API for payment processing.

Production deployments that use MariaDB replication may run into the following problem:
http://wiki.ispirer.com/sqlways/troubleshooting-guide/mysql/import/binary-logging

For those on Amazon RDS this can be resolved by defining a parameter group as shown here:
https://aws.amazon.com/premiumsupport/knowledge-center/rds-mysql-functions/
