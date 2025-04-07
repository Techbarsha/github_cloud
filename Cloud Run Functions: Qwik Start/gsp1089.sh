#!/bin/bash

# Define color variables
BLACK_TEXT=$'\033[0;90m'
RED_TEXT=$'\033[0;91m'
GREEN_TEXT=$'\033[0;92m'
YELLOW_TEXT=$'\033[0;93m'
BLUE_TEXT=$'\033[0;94m'
MAGENTA_TEXT=$'\033[0;95m'
CYAN_TEXT=$'\033[0;96m'
WHITE_TEXT=$'\033[0;97m'

NO_COLOR=$'\033[0m'
RESET_FORMAT=$'\033[0m'
BOLD_TEXT=$'\033[1m'
UNDERLINE_TEXT=$'\033[4m'

clear

# Welcome message
echo "${BLUE_TEXT}${BOLD_TEXT}=======================================${RESET_FORMAT}"
echo "${BLUE_TEXT}${BOLD_TEXT}         INITIATING EXECUTION...  ${RESET_FORMAT}"
echo "${BLUE_TEXT}${BOLD_TEXT}=======================================${RESET_FORMAT}"
echo

gcloud services enable \
  artifactregistry.googleapis.com \
  cloudfunctions.googleapis.com \
  cloudbuild.googleapis.com \
  eventarc.googleapis.com \
  run.googleapis.com \
  logging.googleapis.com \
  osconfig.googleapis.com \
  pubsub.googleapis.com

export PROJECT_ID=$(gcloud config get-value project)
PROJECT_NUMBER=$(gcloud projects list --filter="project_id:$PROJECT_ID" --format='value(project_number)')
export ZONE=$(gcloud compute project-info describe \
--format="value(commonInstanceMetadata.items[google-compute-default-zone])")
export REGION=$(gcloud compute project-info describe \
--format="value(commonInstanceMetadata.items[google-compute-default-region])")


gcloud config set compute/region $REGION


SERVICE_ACCOUNT=$(gsutil kms serviceaccount -p $PROJECT_NUMBER)


gcloud projects add-iam-policy-binding $PROJECT_ID \
  --member serviceAccount:$SERVICE_ACCOUNT \
  --role roles/pubsub.publisher


gcloud projects add-iam-policy-binding $PROJECT_ID \
  --member serviceAccount:$PROJECT_NUMBER-compute@developer.gserviceaccount.com \
  --role roles/eventarc.eventReceiver


gcloud projects get-iam-policy $DEVSHELL_PROJECT_ID > policy.yaml


cat <<EOF >> policy.yaml
auditConfigs:
- auditLogConfigs:
  - logType: ADMIN_READ
  - logType: DATA_READ
  - logType: DATA_WRITE
  service: compute.googleapis.com
EOF


gcloud projects set-iam-policy $DEVSHELL_PROJECT_ID policy.yaml


mkdir ~/hello-http && cd $_


cat > index.js <<EOF
const functions = require('@google-cloud/functions-framework');

functions.http('helloWorld', (req, res) => {
  res.status(200).send('HTTP with Node.js in GCF 2nd gen!');
});
EOF


cat > package.json <<EOF
{
  "name": "nodejs-functions-gen2-codelab",
  "version": "0.0.1",
  "main": "index.js",
  "dependencies": {
    "@google-cloud/functions-framework": "^2.0.0"
  }
}
EOF


deploy_function() {
  while true; do
    echo "Attempting to deploy the Cloud Function..."
    
    gcloud functions deploy nodejs-http-function \
      --gen2 \
      --runtime nodejs22 \
      --entry-point helloWorld \
      --source . \
      --region $REGION \
      --trigger-http \
      --timeout 600s \
      --max-instances 1 \
      --allow-unauthenticated
    
    if [ $? -eq 0 ]; then
      echo "Cloud Function deployed successfully!"
      break
    else
      echo "Deployment failed. Retrying in 30 seconds..."
      sleep 30
    fi
  done
}

# Call the function
deploy_function


gcloud functions call nodejs-http-function \
  --gen2 --region $REGION


mkdir ~/hello-storage && cd $_


cat > index.js <<EOF
const functions = require('@google-cloud/functions-framework');

functions.cloudEvent('helloStorage', (cloudevent) => {
  console.log('Cloud Storage event with Node.js in GCF 2nd gen!');
  console.log(cloudevent);
});
EOF


cat > package.json <<EOF
{
  "name": "nodejs-functions-gen2-codelab",
  "version": "0.0.1",
  "main": "index.js",
  "dependencies": {
    "@google-cloud/functions-framework": "^2.0.0"
  }
}
EOF


BUCKET="gs://gcf-gen2-storage-$PROJECT_ID"
gsutil mb -l $REGION $BUCKET


deploy_function() {
  while true; do
    echo "Attempting to deploy the Cloud Function..."
    
gcloud functions deploy nodejs-storage-function \
  --gen2 \
  --runtime nodejs22 \
  --entry-point helloStorage \
  --source . \
  --region $REGION \
  --trigger-bucket $BUCKET \
  --trigger-location $REGION \
  --max-instances 1
    
    if [ $? -eq 0 ]; then
      echo "Cloud Function deployed successfully!"
      break
    else
      echo "Deployment failed. Retrying in 30 seconds..."
      sleep 30
    fi
  done
}

# Call the function
deploy_function


echo "Hello World" > random.txt
gsutil cp random.txt $BUCKET/random.txt


gcloud functions logs read nodejs-storage-function \
  --region $REGION --gen2 --limit=100 --format "value(log)"


cd ~
git clone https://github.com/GoogleCloudPlatform/eventarc-samples.git


cd ~/eventarc-samples/gce-vm-labeler/gcf/nodejs


deploy_function() {
  while true; do
    echo "Attempting to deploy the Cloud Function..."
    
gcloud functions deploy gce-vm-labeler \
  --gen2 \
  --runtime nodejs22 \
  --entry-point labelVmCreation \
  --source . \
  --region $REGION \
  --trigger-event-filters="type=google.cloud.audit.log.v1.written,serviceName=compute.googleapis.com,methodName=beta.compute.instances.insert" \
  --trigger-location $REGION \
  --max-instances 1
    
    if [ $? -eq 0 ]; then
      echo "Cloud Function deployed successfully!"
      break
    else
      echo "Deployment failed. Retrying in 30 seconds..."
      sleep 30
    fi
  done
}

# Call the function
deploy_function


gcloud compute instances create instance-1 --project=$PROJECT_ID --zone=$ZONE --machine-type=e2-medium --network-interface=network-tier=PREMIUM,stack-type=IPV4_ONLY,subnet=default --metadata=enable-osconfig=TRUE,enable-oslogin=true --maintenance-policy=MIGRATE --provisioning-model=STANDARD --service-account=$PROJECT_NUMBER-compute@developer.gserviceaccount.com --scopes=https://www.googleapis.com/auth/devstorage.read_only,https://www.googleapis.com/auth/logging.write,https://www.googleapis.com/auth/monitoring.write,https://www.googleapis.com/auth/service.management.readonly,https://www.googleapis.com/auth/servicecontrol,https://www.googleapis.com/auth/trace.append --create-disk=auto-delete=yes,boot=yes,device-name=instance-1,image=projects/debian-cloud/global/images/debian-12-bookworm-v20250311,mode=rw,size=10,type=pd-balanced --no-shielded-secure-boot --shielded-vtpm --shielded-integrity-monitoring --labels=goog-ops-agent-policy=v2-x86-template-1-4-0,goog-ec-src=vm_add-gcloud --reservation-affinity=any && printf 'agentsRule:\n  packageState: installed\n  version: latest\ninstanceFilter:\n  inclusionLabels:\n  - labels:\n      goog-ops-agent-policy: v2-x86-template-1-4-0\n' > config.yaml && gcloud compute instances ops-agents policies create goog-ops-agent-v2-x86-template-1-4-0-$ZONE --project=$PROJECT_ID --zone=$ZONE --file=config.yaml && gcloud compute resource-policies create snapshot-schedule default-schedule-1 --project=$PROJECT_ID --region=$REGION --max-retention-days=14 --on-source-disk-delete=keep-auto-snapshots --daily-schedule --start-time=08:00 && gcloud compute disks add-resource-policies instance-1 --project=$PROJECT_ID --zone=$ZONE --resource-policies=projects/$PROJECT_ID/regions/$REGION/resourcePolicies/default-schedule-1


gcloud compute instances describe instance-1 --zone $ZONE


mkdir ~/hello-world-colored && cd $_


touch requirements.txt
cat > main.py <<EOF
import os

color = os.environ.get('COLOR')

def hello_world(request):
    return f'<body style="background-color:{color}"><h1>Hello World!</h1></body>'
EOF


deploy_function() {
  while true; do
    echo "Attempting to deploy the Cloud Function..."
    
COLOR=yellow
gcloud functions deploy hello-world-colored \
  --gen2 \
  --runtime python39 \
  --entry-point hello_world \
  --source . \
  --region $REGION \
  --trigger-http \
  --allow-unauthenticated \
  --update-env-vars COLOR=$COLOR \
  --max-instances 1 \
  --quiet
    
    if [ $? -eq 0 ]; then
      echo "Cloud Function deployed successfully!"
      break
    else
      echo "Deployment failed. Retrying in 30 seconds..."
      sleep 30
    fi
  done
}

# Call the function
deploy_function


mkdir ~/min-instances && cd $_
touch main.go


cat > main.go <<EOF_END
package p

import (
        "fmt"
        "net/http"
        "time"
)

func init() {
        time.Sleep(10 * time.Second)
}

func HelloWorld(w http.ResponseWriter, r *http.Request) {
        fmt.Fprint(w, "Slow HTTP Go in GCF 2nd gen!")
}
EOF_END


echo "module example.com/mod" > go.mod


deploy_function() {
  while true; do
    echo "Attempting to deploy the Cloud Function..."
    
gcloud functions deploy slow-function \
  --gen2 \
  --runtime go121 \
  --entry-point HelloWorld \
  --source . \
  --region $REGION \
  --trigger-http \
  --allow-unauthenticated \
  --max-instances 4
    
    if [ $? -eq 0 ]; then
      echo "Cloud Function deployed successfully!"
      break
    else
      echo "Deployment failed. Retrying in 30 seconds..."
      sleep 30
    fi
  done
}

# Call the function
deploy_function


gcloud functions call slow-function \
  --gen2 --region $REGION

# Transform DEVSHELL_PROJECT_ID and REGION
export spcl_project=$(echo "$DEVSHELL_PROJECT_ID" | sed 's/-/--/g; s/$/__/g')
export my_region=$(echo "$REGION" | sed 's/-/--/g; s/$/__/g')

# Build the final string
export full_path="$REGION-docker.pkg.dev/$DEVSHELL_PROJECT_ID/gcf-artifacts/$spcl_project$my_region"

# Append the static part
export full_path="${full_path}slow--function:version_1"


gcloud run deploy slow-function \
--image=$full_path \
--min-instances=1 \
--max-instances=4 \
--region=$REGION \
--project=$DEVSHELL_PROJECT_ID


gcloud functions call slow-function \
  --gen2 --region $REGION


SLOW_URL=$(gcloud functions describe slow-function --region $REGION --gen2 --format="value(serviceConfig.uri)")


hey -n 10 -c 10 $SLOW_URL

# Function to prompt user to check their progress
function check_progress {
    while true; do
        echo
        echo "${YELLOW_TEXT}${BOLD_TEXT}PLEASE CHECK YOUR PROGRESS UPTO TASK 6. ${RESET_FORMAT}"
        echo
        echo -n "${BLUE_TEXT}${BOLD_TEXT}Have you checked your progress up to Task 6? (Y/N): ${RESET_FORMAT}"
        read -r user_input
        if [[ "$user_input" == "Y" || "$user_input" == "y" ]]; then
            echo
            echo "${GREEN_TEXT}${BOLD_TEXT}Great! Proceeding to the next steps...${RESET_FORMAT}"
            echo
            break
        elif [[ "$user_input" == "N" || "$user_input" == "n" ]]; then
            echo
            echo "${RED_TEXT}${BOLD_TEXT}Please check your progress up to Task 6.${RESET_FORMAT}"
        else
            echo
            echo "Invalid input. Please enter Y or N."
        fi
    done
}

# Call function to check progress before proceeding
check_progress


gcloud run services delete slow-function --region $REGION --quiet


deploy_function() {
  while true; do
    echo "Attempting to deploy the Cloud Function..."
    
gcloud functions deploy slow-concurrent-function \
  --gen2 \
  --runtime go121 \
  --entry-point HelloWorld \
  --source . \
  --region $REGION \
  --trigger-http \
  --allow-unauthenticated \
  --min-instances 1 \
  --max-instances 4 \
  --quiet
    
    if [ $? -eq 0 ]; then
      echo "Cloud Function deployed successfully!"
      break
    else
      echo "Deployment failed. Retrying in 30 seconds..."
      sleep 30
    fi
  done
}

# Call the function
deploy_function

# Transform DEVSHELL_PROJECT_ID and REGION
export spcl_project=$(echo "$DEVSHELL_PROJECT_ID" | sed 's/-/--/g; s/$/__/g')
export my_region=$(echo "$REGION" | sed 's/-/--/g; s/$/__/g')

# Build the final string
export full_path="$REGION-docker.pkg.dev/$DEVSHELL_PROJECT_ID/gcf-artifacts/$spcl_project$my_region"

# Append the static part
export full_path="${full_path}slow--concurrent--function:version_1"


gcloud run deploy slow-concurrent-function \
--image=$full_path \
--concurrency=100 \
--cpu=1 \
--max-instances=4 \
--set-env-vars=LOG_EXECUTION_ID=true \
--region=$REGION \
--project=$DEVSHELL_PROJECT_ID \
 && gcloud run services update-traffic slow-concurrent-function --to-latest --region=$REGION


SLOW_CONCURRENT_URL=$(gcloud functions describe slow-concurrent-function --region $REGION --gen2 --format="value(serviceConfig.uri)")


hey -n 10 -c 10 $SLOW_CONCURRENT_URL

echo

echo "${YELLOW_TEXT}${BOLD_TEXT}CLICK HERE: ${RESET_FORMAT}""https://console.cloud.google.com/run/deploy/$REGION/slow-concurrent-function?project=$DEVSHELL_PROJECT_ID"
echo

# Completion Message
echo
echo "${GREEN_TEXT}${BOLD_TEXT}=======================================================${RESET_FORMAT}"
echo "${GREEN_TEXT}${BOLD_TEXT}              LAB COMPLETED SUCCESSFULLY!              ${RESET_FORMAT}"
echo "${GREEN_TEXT}${BOLD_TEXT}=======================================================${RESET_FORMAT}"
echo ""
echo -e "${RED_TEXT}${BOLD_TEXT}Subscribe my Channel:${RESET_FORMAT} ${BLUE_TEXT}${BOLD_TEXT}https://www.youtube.com/@edutechbarsha${RESET_FORMAT}"
echo
