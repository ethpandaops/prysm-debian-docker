ARG beacon_tag=:latest
ARG beacon=gcr.io/prysmaticlabs/prysm/beacon-chain
ARG validator_tag=:latest
ARG validator=gcr.io/prysmaticlabs/prysm/validator

FROM $beacon$beacon_tag as prysm-beacon-chain
FROM $validator$validator_tag as prysm-validator

FROM debian:11-slim

WORKDIR /app/cmd/beacon-chain/beacon-chain.runfiles/prysm
COPY --from=prysm-beacon-chain /app/cmd/beacon-chain/beacon-chain /app/cmd/beacon-chain/beacon-chain
COPY --from=prysm-validator /app/cmd/validator/validator /app/cmd/validator/validator
RUN apt-get update && apt-get install -y ca-certificates && update-ca-certificates
ENTRYPOINT [ "/app/cmd/beacon-chain/beacon-chain" ]

