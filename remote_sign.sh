#!/bin/bash

./bazel-bin/hub/hub \
	--dbHost ${DB_HOST} \
	--db ${DB_NAME} \
	--dbUser ${DB_USER} \
	--dbPassword ${DB_PASSWORD} \
	--apiAddress ${IOTA_API} \
	--minWeightMagnitude ${IOTA_MIN_WEIGHT_MAGNITUDE} \
	--listenAddress 0.0.0.0:50051 \
    --signingMode remote \
    --signingProviderAddress ${IOTA_SIGNER_URL} \
    --signingServerChainCert /ssl/client.crt \
    --signingServerKeyCert /ssl/client.key \
    --signingServerSslCert /ssl/ca.crt 
	--alsologtostderr
