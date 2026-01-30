#!/bin/bash


# # 1. Get a list of all container IDs
# container_list=$(docker ps -aq)

# # 2. Loop through each ID
# for id in $container_list; do
    
#     # Get the status (e.g., "running", "exited", "paused")
#     # Using inspect is better for 'if' conditions than 'ps'
#     status=$(docker inspect -f '{{.State.Status}}' "$id")
#     name=$(docker inspect -f '{{.Name}}' "$id")

#     echo "Checking Container: $name (ID: $id)"

#     # 3. If condition based on status
#     if [ "$status" == "exited" ]; then
#         echo  "Container is down ID= $id":
# 	echo ---

# 	echo "Starting container ID= $id"
# docker start $id
#         echo ---
#       	docker ps --format "table {{.ID}}\t{{.Names}}\t{{.Status}}"
   	
#     elif [ "$status" == "running" ]; then
# 	    echo " All containers are running"
#     else
#         echo "Status is: $status. Manual check required."
#     fi
# done
# */
echo "Hello I'm Dev Gupta"
echo ---------------------------------------------------------

./hello.sh
echo ""
echo ---------------------------------------------------------

date
#Resource Usage
echo "CPU Usage"
mpstat 1 1 
echo ---------------------------------------------------------
echo ""

#Threshold
mem_usage=$(free | awk '/Mem:/ {printf "%.0f", ($3/$2)*100}')
if [ $mem_usage -gt 80 ]; then
    echo "⚠️  WARNING: High memory usage: ${mem_usage}%"
else
    echo "Memory usage: ${mem_usage}%"
fi
echo ---------------------------------------------------------

echo "Memory available"
echo ----------------------------------------------------------
echo "Disk space"
echo ""
 free -h

# disk_usage=$(df -h | awk 'NR==2 {print $5}')

# if [ $disk_usage -gt 80 ]; then
#  echo "Empty disk now as it has reached 80%"
# else
#  echo "Disk Usage"
#  fi
# echo ""
# echo "Disk space"
echo ----------------------------------------------------------

df -h
echo ""
#Process status
echo Checking if docker is running or not
echo ----------------------------------------------------------

#!/bin/bash

# Check if docker command exists
if ! command -v docker &> /dev/null
then
    echo "Docker not found. Installing now..."
    
    # Official Ubuntu quick-install method
    sudo apt update
    sudo apt install -y docker.io
    
    # Optional: Start and enable the service
    sudo systemctl start docker
    sudo systemctl enable docker
    echo "Docker installed successfully!"
else
    echo "Docker is already installed."
    docker --version
fi


docker_status=$(systemctl is-active docker)
echo ""
if [ $docker_status == "inactive" ];then
    echo "Docker is inactive, starting in 3..2..1.."
    sudo systemctl start docker
    systemctl is-active docker
    else
    echo "Docker is active"
    echo ""
    fi
echo "Checking Running Containers"
echo ----------------------------------------------------------

docker ps

#Network
echo Network
echo ----------------------------------------------------------
nc -zv -w3 172.17.0.2 27017
nc -zv -w3 172.17.0.3 8080
echo ""
#Logs
echo System logs
echo ----------------------------------------------------------

tail -n 10 /var/log/syslog
echo ""
echo Systemd Logs
echo ----------------------------------------------------------

journalctl -n 10 --no-pager
echo ""

container_list=$(docker ps -qa)
for id in $container_list; do
    

#Get the status (e.g., "running", "exited", "paused")
    # Using inspect is better for 'if' conditions than 'ps'
    status=$(docker inspect -f '{{.State.Status}}' "$id")
    name=$(docker inspect -f '{{.Name}}' "$id")

    echo "Checking Container: $name (ID: $id)"

    # 3. If condition based on status
    if [ "$status" == "exited" ]; then
        echo  "Container is down ID= $id":
	echo ---

	echo "Starting container ID= $id"
docker start $id
        echo ---
      	docker ps --format "table {{.ID}}\t{{.Names}}\t{{.Status}}"
   	
    elif [ "$status" == "running" ]; then
	    echo " This container is running: $name & $id"
    else
        echo "   ⚠️  Status is: $status. Manual check required."
    fi

done
container_list=$(docker ps -qa)
for id in $container_list; do
   
echo "Logs for container: $(docker ps --filter id=$id --format '{{.Names}}')"
    docker logs --tail 10 $name
    done
#Uptime
echo ----------------------------------------------------------
echo ""
echo UPTIME
uptime
