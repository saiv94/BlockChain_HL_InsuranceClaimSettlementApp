echo "Setting up the network.."

echo "Creating channel genesis block.."

# Create the channel
#docker exec -e "CORE_PEER_LOCALMSPID=BankMSP" -e "CORE_PEER_MSPCONFIGPATH=/opt/gopath/src/github.com/hyperledger/fabric/peer/crypto/peerOrganizations/ICICILOMBARD.hibc.com/users/Admin@ICICILOMBARD.hibc.com/msp" -e "CORE_PEER_ADDRESS=peer0.ICICILOMBARD.hibc.com:7051" cli peer channel create -o orderer.hibc.com:7050 -c hibcchannel -f /etc/hyperledger/configtx/hibcchannel.tx

docker exec -e "CORE_PEER_LOCALMSPID=ICICILOMBARDMSP" -e "CORE_PEER_MSPCONFIGPATH=/opt/gopath/src/github.com/hyperledger/fabric/peer/crypto/peerOrganizations/ICICILOMBARD.hibc.com/users/Admin@ICICILOMBARD.hibc.com/msp" -e "CORE_PEER_ADDRESS=peer0.ICICILOMBARD.hibc.com:7051" cli peer channel create -o orderer.hibc.com:7050 -c hibcchannel -f ./crypto/hibcchannel.tx


sleep 5

echo "Channel genesis block created."

echo "peer0.ICICILOMBARD.hibc.com joining the channel..."
# Join peer0.ICICILOMBARD.hibc.com to the channel.
docker exec -e "CORE_PEER_LOCALMSPID=ICICILOMBARDMSP" -e "CORE_PEER_MSPCONFIGPATH=/opt/gopath/src/github.com/hyperledger/fabric/peer/crypto/peerOrganizations/ICICILOMBARD.hibc.com/users/Admin@ICICILOMBARD.hibc.com/msp" -e "CORE_PEER_ADDRESS=peer0.ICICILOMBARD.hibc.com:7051" cli peer channel join -b hibcchannel.block

echo "peer0.ICICILOMBARD.hibc.com joined the channel"

echo "peer0.TATAAIG.hibc.com joining the channel..."
# Join peer0.TATAAIG.hibc.com to the channel.
docker exec -e "CORE_PEER_LOCALMSPID=TATAAIGMSP" -e "CORE_PEER_MSPCONFIGPATH=/opt/gopath/src/github.com/hyperledger/fabric/peer/crypto/peerOrganizations/TATAAIG.hibc.com/users/Admin@TATAAIG.hibc.com/msp" -e "CORE_PEER_ADDRESS=peer0.TATAAIG.hibc.com:7051" cli peer channel join -b hibcchannel.block

echo "peer0.TATAAIG.hibc.com joined the channel"

echo "peer0.APOLLO.hibc.com joining the channel..."

# Join peer0.APOLLO.hibc.com to the channel.
docker exec -e "CORE_PEER_LOCALMSPID=APOLLOMSP" -e "CORE_PEER_MSPCONFIGPATH=/opt/gopath/src/github.com/hyperledger/fabric/peer/crypto/peerOrganizations/APOLLO.hibc.com/users/Admin@APOLLO.hibc.com/msp" -e "CORE_PEER_ADDRESS=peer0.APOLLO.hibc.com:7051" cli peer channel join -b hibcchannel.block

echo "peer0.APOLLO.hibc.com joined the channel"

echo "peer0.MEDICITI.hibc.com joining the channel..."
# Join peer0.MEDICITI.hibc.com to the channel.
docker exec -e "CORE_PEER_LOCALMSPID=MEDICITIMSP" -e "CORE_PEER_MSPCONFIGPATH=/opt/gopath/src/github.com/hyperledger/fabric/peer/crypto/peerOrganizations/MEDICITI.hibc.com/users/Admin@MEDICITI.hibc.com/msp" -e "CORE_PEER_ADDRESS=peer0.MEDICITI.hibc.com:7051" cli peer channel join -b hibcchannel.block
sleep 5

echo "peer0.MEDICITI.hibc.com joined the channel"

echo "peer0.IRDA.hibc.com joining the channel..."
# Join peer0.MEDICITI.hibc.com to the channel.
docker exec -e "CORE_PEER_LOCALMSPID=IRDAMSP" -e "CORE_PEER_MSPCONFIGPATH=/opt/gopath/src/github.com/hyperledger/fabric/peer/crypto/peerOrganizations/IRDA.hibc.com/users/Admin@IRDA.hibc.com/msp" -e "CORE_PEER_ADDRESS=peer0.IRDA.hibc.com:7051" cli peer channel join -b hibcchannel.block
sleep 5

echo "peer0.IRDA.hibc.com joined the channel"


# install chaincode
# Install code on ICICILOMBARD peer

########
echo "Installing hibc chaincode to peer0.ICICILOMBARD.hibc.com..."

docker exec -e "CORE_PEER_LOCALMSPID=ICICILOMBARDMSP" -e "CORE_PEER_MSPCONFIGPATH=/opt/gopath/src/github.com/hyperledger/fabric/peer/crypto/peerOrganizations/ICICILOMBARD.hibc.com/users/Admin@ICICILOMBARD.hibc.com/msp" -e "CORE_PEER_ADDRESS=peer0.ICICILOMBARD.hibc.com:7051" cli peer chaincode install -n hibccc -v 1.3 -p github.com/hibc/go/ -l golang

echo "Installed hibc chaincode to peer0.ICICILOMBARD.hibc.com"

########
echo "Installing hibc chaincode to peer0.TATAAIG.hibc.com..."

docker exec -e "CORE_PEER_LOCALMSPID=TATAAIGMSP" -e "CORE_PEER_MSPCONFIGPATH=/opt/gopath/src/github.com/hyperledger/fabric/peer/crypto/peerOrganizations/TATAAIG.hibc.com/users/Admin@TATAAIG.hibc.com/msp" -e "CORE_PEER_ADDRESS=peer0.TATAAIG.hibc.com:7051" cli peer chaincode install -n hibccc -v 1.3 -p github.com/hibc/go/ -l golang

echo "Installed hibc chaincode to peer0.TATAAIG.hibc.com"
########
echo "Installing hibc chaincode to peer0.IRDA.hibc.com..."

docker exec -e "CORE_PEER_LOCALMSPID=IRDAMSP" -e "CORE_PEER_MSPCONFIGPATH=/opt/gopath/src/github.com/hyperledger/fabric/peer/crypto/peerOrganizations/IRDA.hibc.com/users/Admin@IRDA.hibc.com/msp" -e "CORE_PEER_ADDRESS=peer0.IRDA.hibc.com:7051" cli peer chaincode install -n hibccc -v 1.3 -p github.com/hibc/go/ -l golang

echo "Installed hibc chaincode to peer0.IRDA.hibc.com"

#######

echo "Installing hibc chaincode to peer0.APOLLO.hibc.com...."

# Install code on APOLLO peer
docker exec -e "CORE_PEER_LOCALMSPID=APOLLOMSP" -e "CORE_PEER_MSPCONFIGPATH=/opt/gopath/src/github.com/hyperledger/fabric/peer/crypto/peerOrganizations/APOLLO.hibc.com/users/Admin@APOLLO.hibc.com/msp" -e "CORE_PEER_ADDRESS=peer0.APOLLO.hibc.com:7051" cli peer chaincode install -n hibccc -v 1.3 -p github.com/hibc/go/ -l golang

echo "Installed hibc chaincode to peer0.APOLLO.hibc.com"

######

echo "Installing hibc chaincode to peer0.MEDICITI.hibc.com..."
# Install code on MEDICITI peer
docker exec -e "CORE_PEER_LOCALMSPID=MEDICITIMSP" -e "CORE_PEER_MSPCONFIGPATH=/opt/gopath/src/github.com/hyperledger/fabric/peer/crypto/peerOrganizations/MEDICITI.hibc.com/users/Admin@MEDICITI.hibc.com/msp" -e "CORE_PEER_ADDRESS=peer0.MEDICITI.hibc.com:7051" cli peer chaincode install -n hibccc -v 1.3 -p github.com/hibc/go/ -l golang

echo "Installed hibc chaincode to peer0.MEDICITI.hibc.com"

#######

sleep 5

echo "Instantiating hibc chaincode.."

#docker exec -e "CORE_PEER_LOCALMSPID=BankMSP" -e "CORE_PEER_MSPCONFIGPATH=/opt/gopath/src/github.com/hyperledger/fabric/peer/crypto/peerOrganizations/ICICILOMBARD.hibc.com/users/Admin@ICICILOMBARD.hibc.com/msp" -e "CORE_PEER_ADDRESS=peer0.ICICILOMBARD.hibc.com:7051" cli peer chaincode instantiate -o orderer.hibc.com:7050 -C hibcchannel -n hibccc -l golang -v 1.3 -c '{"Args":["init"]}' -P "OR ('BankMSP.member','BuyerMSP.member','SellerMSP.member')"

docker exec -e "CORE_PEER_LOCALMSPID=ICICILOMBARDMSP" -e "CORE_PEER_MSPCONFIGPATH=/opt/gopath/src/github.com/hyperledger/fabric/peer/crypto/peerOrganizations/ICICILOMBARD.hibc.com/users/Admin@ICICILOMBARD.hibc.com/msp" -e "CORE_PEER_ADDRESS=peer0.ICICILOMBARD.hibc.com:7051" cli peer chaincode instantiate -o orderer.hibc.com:7050 -C hibcchannel -n hibccc -l golang -v 1.3 -c '{"Args":["init"]}'

echo "Instantiated hibc chaincode."

echo "Following is the docker network....."

docker ps
