#!/bin/bash
# Wait for the container to fully initialize
sleep 1

# Switch to the container's working directory
cd /home/container || exit 1

# Auto update
if [ -z "${AUTO_UPDATE}" ] || [ "${AUTO_UPDATE}" == "1" ]; then
    # Update if DepotDownloader exists
    cd /home/container/.DepotDownloader || exit 1
    
    echo "Updating SCP: Secret Laboratory..."
    if [ "${BRANCH_TAG}" == "" ]; then
        echo "Using public branch."
        ./DepotDownloader -app 996560 -depot 996562 -dir /home/container -validate > /dev/null 2>&1
    else
        echo "Using branch: ${BRANCH_TAG}"
        ./DepotDownloader -app 996560 -depot 996562 -branch "${BRANCH_TAG}" -dir /home/container -validate > /dev/null 2>&1
    fi
    echo "SCP:SL update finished."
else
    echo "Not updating game server as auto update was set to 0."
fi

cd /home/container || exit 1

MODIFIED_STARTUP="eval $(echo ${STARTUP} | sed -e 's/{{/${/g' -e 's/}}/}/g')"
echo ":/home/container$ ${MODIFIED_STARTUP}"

${MODIFIED_STARTUP}