rm -R crypto-config/*

./bin/cryptogen generate --config=crypto-config.yaml

rm config/*

./bin/configtxgen -profile HIBCOrgOrdererGenesis -outputBlock ./config/genesis.block

./bin/configtxgen -profile HIBCOrgChannel -outputCreateChannelTx ./config/hibcchannel.tx -channelID hibcchannel
