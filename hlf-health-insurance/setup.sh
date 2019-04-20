echo "Setting up the network.."

echo "Creating channel genesis block.."

# Create the channel
#docker exec -e "CORE_PEER_LOCALMSPID=BankMSP" -e "CORE_PEER_MSPCONFIGPATH=/opt/gopath/src/github.com/hyperledger/fabric/peer/crypto/peerOrganizations/insurer.hibc.com/users/Admin@insurer.hibc.com/msp" -e "CORE_PEER_ADDRESS=peer0.insurer.hibc.com:7051" cli peer channel create -o orderer.hibc.com:7050 -c hibcchannel -f /etc/hyperledger/configtx/hibcchannel.tx

docker exec -e "CORE_PEER_LOCALMSPID=insurerMSP" -e "CORE_PEER_MSPCONFIGPATH=/opt/gopath/src/github.com/hyperledger/fabric/peer/crypto/peerOrganizations/insurer.hibc.com/users/Admin@insurer.hibc.com/msp" -e "CORE_PEER_ADDRESS=peer0.insurer.hibc.com:7051" cli peer channel create -o orderer.hibc.com:7050 -c hibcchannel -f ./crypto/hibcchannel.tx


sleep 5

echo "Channel genesis block created."

echo "peer0.insurer.hibc.com joining the channel..."
# Join peer0.insurer.hibc.com to the channel.
docker exec -e "CORE_PEER_LOCALMSPID=insurerMSP" -e "CORE_PEER_MSPCONFIGPATH=/opt/gopath/src/github.com/hyperledger/fabric/peer/crypto/peerOrganizations/insurer.hibc.com/users/Admin@insurer.hibc.com/msp" -e "CORE_PEER_ADDRESS=peer0.insurer.hibc.com:7051" cli peer channel join -b hibcchannel.block

echo "peer0.insurer.hibc.com joined the channel"

echo "peer0.patient.hibc.com joining the channel..."

# Join peer0.patient.hibc.com to the channel.
docker exec -e "CORE_PEER_LOCALMSPID=patientMSP" -e "CORE_PEER_MSPCONFIGPATH=/opt/gopath/src/github.com/hyperledger/fabric/peer/crypto/peerOrganizations/patient.hibc.com/users/Admin@patient.hibc.com/msp" -e "CORE_PEER_ADDRESS=peer0.patient.hibc.com:7051" cli peer channel join -b hibcchannel.block

echo "peer0.patient.hibc.com joined the channel"

echo "peer0.hospital.hibc.com joining the channel..."
# Join peer0.hospital.hibc.com to the channel.
docker exec -e "CORE_PEER_LOCALMSPID=hospitalMSP" -e "CORE_PEER_MSPCONFIGPATH=/opt/gopath/src/github.com/hyperledger/fabric/peer/crypto/peerOrganizations/hospital.hibc.com/users/Admin@hospital.hibc.com/msp" -e "CORE_PEER_ADDRESS=peer0.hospital.hibc.com:7051" cli peer channel join -b hibcchannel.block
sleep 5

echo "peer0.hospital.hibc.com joined the channel"

echo "Installing hibc chaincode to peer0.insurer.hibc.com..."

# install chaincode
# Install code on insurer peer
docker exec -e "CORE_PEER_LOCALMSPID=insurerMSP" -e "CORE_PEER_MSPCONFIGPATH=/opt/gopath/src/github.com/hyperledger/fabric/peer/crypto/peerOrganizations/insurer.hibc.com/users/Admin@insurer.hibc.com/msp" -e "CORE_PEER_ADDRESS=peer0.insurer.hibc.com:7051" cli peer chaincode install -n hibccc -v 1.2 -p github.com/hibc/go/ -l golang

echo "Installed hibc chaincode to peer0.insurer.hibc.com"

echo "Installing hibc chaincode to peer0.patient.hibc.com...."

# Install code on patient peer
docker exec -e "CORE_PEER_LOCALMSPID=patientMSP" -e "CORE_PEER_MSPCONFIGPATH=/opt/gopath/src/github.com/hyperledger/fabric/peer/crypto/peerOrganizations/patient.hibc.com/users/Admin@patient.hibc.com/msp" -e "CORE_PEER_ADDRESS=peer0.patient.hibc.com:7051" cli peer chaincode install -n hibccc -v 1.2 -p github.com/hibc/go/ -l golang

echo "Installed hibc chaincode to peer0.patient.hibc.com"

echo "Installing hibc chaincode to peer0.hospital.hibc.com..."
# Install code on hospital peer
docker exec -e "CORE_PEER_LOCALMSPID=hospitalMSP" -e "CORE_PEER_MSPCONFIGPATH=/opt/gopath/src/github.com/hyperledger/fabric/peer/crypto/peerOrganizations/hospital.hibc.com/users/Admin@hospital.hibc.com/msp" -e "CORE_PEER_ADDRESS=peer0.hospital.hibc.com:7051" cli peer chaincode install -n hibccc -v 1.2 -p github.com/hibc/go/ -l golang

sleep 5

echo "Installed hibc chaincode to peer0.patient.hibc.com"

echo "Instantiating hibc chaincode.."

#docker exec -e "CORE_PEER_LOCALMSPID=BankMSP" -e "CORE_PEER_MSPCONFIGPATH=/opt/gopath/src/github.com/hyperledger/fabric/peer/crypto/peerOrganizations/insurer.hibc.com/users/Admin@insurer.hibc.com/msp" -e "CORE_PEER_ADDRESS=peer0.insurer.hibc.com:7051" cli peer chaincode instantiate -o orderer.hibc.com:7050 -C hibcchannel -n hibccc -l golang -v 1.2 -c '{"Args":["init"]}' -P "OR ('BankMSP.member','BuyerMSP.member','SellerMSP.member')"

docker exec -e "CORE_PEER_LOCALMSPID=insurerMSP" -e "CORE_PEER_MSPCONFIGPATH=/opt/gopath/src/github.com/hyperledger/fabric/peer/crypto/peerOrganizations/insurer.hibc.com/users/Admin@insurer.hibc.com/msp" -e "CORE_PEER_ADDRESS=peer0.insurer.hibc.com:7051" cli peer chaincode instantiate -o orderer.hibc.com:7050 -C hibcchannel -n hibccc -l golang -v 1.2 -c '{"Args":["init"]}'

echo "Instantiated hibc chaincode."

echo "Following is the docker network....."

docker ps
