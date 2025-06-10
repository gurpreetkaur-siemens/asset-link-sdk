# SPDX-FileCopyrightText: 2024 Siemens AG
#
# SPDX-License-Identifier: MIT

ASSET_ENDPOINT_PORT=${ASSET_ENDPOINT_PORT:-host.docker.internal:8081}
GRPC_SERVER_REGISTRY=${GRPC_SERVER_REGISTRY:-host.docker.internal:50051}

curl -L -o al-ctl_Linux_x86_64.tar.gz https://github.com/industrial-asset-hub/asset-link-sdk/releases/download/v3.4.3/al-ctl_Linux_x86_64.tar.gz
tar -xf al-ctl_Linux_x86_64.tar.gz
chmod +x al-ctl

# Check the version of the al-ctl tool
./al-ctl --version

# Discover assets on the specified endpoint

./al-ctl assets discover -e ${ASSET_ENDPOINT_PORT}

# Run the tests
./al-ctl test api -e ${ASSET_ENDPOINT_PORT} --service-name discovery

# To validate registration of asset link
./al-ctl test registration -e ${ASSET_ENDPOINT_PORT} -r ${GRPC_SERVER_REGISTRY} -f ./registry.json