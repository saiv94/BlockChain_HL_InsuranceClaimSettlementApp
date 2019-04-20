echo "Starting network..."

docker-compose -f docker-compose.yml -p hibcnetwork up 

sleep 30

echo "Network started"

echo "Following is the docker network....."

docker ps
