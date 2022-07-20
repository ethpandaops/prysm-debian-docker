FROM gcr.io/prysmaticlabs/prysm/beacon-chain:latest as prysm-beacon-chain
FROM gcr.io/prysmaticlabs/prysm/validator:latest as prysm-validator

FROM debian:11-slim

WORKDIR /app/cmd/beacon-chain/beacon-chain.runfiles/prysm
COPY --from=prysm-beacon-chain /app/cmd/beacon-chain/beacon-chain /app/cmd/beacon-chain/beacon-chain
COPY --from=prysm-validator /app/cmd/validator/validator /app/cmd/validator/validator
ENTRYPOINT [ "/app/cmd/beacon-chain/beacon-chain" ]
