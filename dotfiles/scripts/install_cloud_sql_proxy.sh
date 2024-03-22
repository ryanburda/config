#!/bin/zsh
brew install --cask google-cloud-sdk

CPU=$(sysctl -n machdep.cpu.brand_string)
CLOUD_SQL_PROXY_PATH=/usr/local/bin
if [[ $CPU =~ ^Apple ]]; then
    (cd $CLOUD_SQL_PROXY_PATH && curl -o cloud-sql-proxy https://storage.googleapis.com/cloud-sql-connectors/cloud-sql-proxy/v2.10.1/cloud-sql-proxy.darwin.arm64 && chmod +x cloud-sql-proxy)
elif [[ $CPU =~ ^Intel ]]; then
    (cd $CLOUD_SQL_PROXY_PATH && curl -o cloud-sql-proxy https://storage.googleapis.com/cloud-sql-connectors/cloud-sql-proxy/v2.10.1/cloud-sql-proxy.darwin.amd64 && chmod +x cloud-sql-proxy)
else
    echo "WARNING: could not determine which cloud-sql-proxy version to install."
fi
