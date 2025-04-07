#!/bin/bash

# Bright Foreground Colors
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

# Pick random colors
RANDOM_TEXT_COLOR=${TEXT_COLORS[$RANDOM % ${#TEXT_COLORS[@]}]}
RANDOM_BG_COLOR=${BG_COLORS[$RANDOM % ${#BG_COLORS[@]}]}

# Display Welcome Banner
echo "${RANDOM_BG_COLOR}${RANDOM_TEXT_COLOR}${BOLD}######################################################################${RESET}"
echo "${RANDOM_BG_COLOR}${RANDOM_TEXT_COLOR}${BOLD}#                                                                    #${RESET}"
echo "${RANDOM_BG_COLOR}${RANDOM_TEXT_COLOR}${BOLD}#             WELCOME TO EDUTECH BARSHA                              #${RESET}"
echo "${RANDOM_BG_COLOR}${RANDOM_TEXT_COLOR}${BOLD}#                                                                    #${RESET}"
echo "${RANDOM_BG_COLOR}${RANDOM_TEXT_COLOR}${BOLD}######################################################################${RESET}"

# Clear the screen
clear

# Start Execution
echo "${BLUE_TEXT}${BOLD_TEXT}=======================================${RESET_FORMAT}"
echo "${BLUE_TEXT}${BOLD_TEXT}         Starting Execution...         ${RESET_FORMAT}"
echo "${BLUE_TEXT}${BOLD_TEXT}=======================================${RESET_FORMAT}"
echo

echo
echo "${YELLOW_TEXT}${BOLD_TEXT} Enter REGION:  ${RESET_FORMAT}"
read REGION
echo

if [ -z "$REGION" ]; then
    echo "${CYAN_TEXT}${BOLD_TEXT}Using Default region : us-central1 ${RESET_FORMAT}"
   export REGION=us-central1
else
  echo "${CYAN_TEXT}${BOLD_TEXT}Using region : $REGION ${RESET_FORMAT}"
    export REGION=$REGION
fi

gcloud config set project $DEVSHELL_PROJECT_ID

gcloud config set run/region $REGION

gcloud config set run/platform managed

gcloud config set eventarc/location $REGION

echo
echo "${GREEN_TEXT}${BOLD_TEXT} ========================== Getting project number ========================== ${RESET_FORMAT}"
echo

export PROJECT_NUMBER="$(gcloud projects list \
  --filter=$(gcloud config get-value project) \
  --format='value(PROJECT_NUMBER)')"

echo
echo "${GREEN_TEXT}${BOLD_TEXT} ========================== Adding IAM policy binding ========================== ${RESET_FORMAT}"
echo

gcloud projects add-iam-policy-binding $(gcloud config get-value project) \
  --member=serviceAccount:${PROJECT_NUMBER}-compute@developer.gserviceaccount.com \
  --role='roles/eventarc.admin'
echo
echo "${GREEN_TEXT}${BOLD_TEXT} ========================== Listing Eventarc providers ========================== ${RESET_FORMAT}"
echo

gcloud eventarc providers list
echo
echo "${GREEN_TEXT}${BOLD_TEXT} ========================== Describing pubsub Eventarc providers ========================== ${RESET_FORMAT}"
echo

gcloud eventarc providers describe \
  pubsub.googleapis.com

export SERVICE_NAME=event-display

export IMAGE_NAME="gcr.io/cloudrun/hello"
echo
echo "${GREEN_TEXT}${BOLD_TEXT} ========================== Deploying cloud run service  ========================== ${RESET_FORMAT}"
echo

gcloud run deploy ${SERVICE_NAME} \
  --image ${IMAGE_NAME} \
  --allow-unauthenticated \
  --max-instances=3
echo
echo "${GREEN_TEXT}${BOLD_TEXT} ========================== Describing pubsub Eventarc providers again ========================== ${RESET_FORMAT}"
echo

gcloud eventarc providers describe \
  pubsub.googleapis.com
echo
echo "${GREEN_TEXT}${BOLD_TEXT} ========================== Creating trigger pubsub ========================== ${RESET_FORMAT}"
echo

gcloud eventarc triggers create trigger-pubsub \
  --destination-run-service=${SERVICE_NAME} \
  --event-filters="type=google.cloud.pubsub.topic.v1.messagePublished"

export TOPIC_ID=$(gcloud eventarc triggers describe trigger-pubsub \
  --format='value(transport.pubsub.topic)')

echo ${TOPIC_ID}
echo
echo "${GREEN_TEXT}${BOLD_TEXT} ========================== Listing Eventarc triggers ========================== ${RESET_FORMAT}"
echo

gcloud eventarc triggers list
echo
echo "${GREEN_TEXT}${BOLD_TEXT} ========================== Publishing message in pubsub topic ========================== ${RESET_FORMAT}"
echo

gcloud pubsub topics publish ${TOPIC_ID} --message="Hello there"

export BUCKET_NAME=$(gcloud config get-value project)-cr-bucket
echo
echo "${GREEN_TEXT}${BOLD_TEXT} ========================== Creating storage bucket ========================== ${RESET_FORMAT}"
echo

gsutil mb -p $(gcloud config get-value project) \
  -l $(gcloud config get-value run/region) \
  gs://${BUCKET_NAME}/
echo
echo "${GREEN_TEXT}${BOLD_TEXT} ========================== getting iam policy of project and modifying it ========================== ${RESET_FORMAT}"
echo

gcloud projects get-iam-policy $DEVSHELL_PROJECT_ID > policy.yaml

cat <<EOF >> policy.yaml
auditConfigs:
- auditLogConfigs:
  - logType: ADMIN_READ
  - logType: DATA_READ
  - logType: DATA_WRITE
  service: storage.googleapis.com
EOF
echo
echo "${GREEN_TEXT}${BOLD_TEXT} ========================== setting iam policy of project ========================== ${RESET_FORMAT}"
echo
gcloud projects set-iam-policy $DEVSHELL_PROJECT_ID policy.yaml
echo
echo "${GREEN_TEXT}${BOLD_TEXT} ========================== Creating a dummy file ========================== ${RESET_FORMAT}"
echo

echo "Hello World" > random.txt
echo
echo "${GREEN_TEXT}${BOLD_TEXT} ========================== Copying dummy file into bucket ========================== ${RESET_FORMAT}"
echo

gsutil cp random.txt gs://${BUCKET_NAME}/random.txt

sleep 30
echo
echo "${GREEN_TEXT}${BOLD_TEXT} ========================== Describing cloudaudit Eventarc providers ========================== ${RESET_FORMAT}"
echo

gcloud eventarc providers describe cloudaudit.googleapis.com
echo
echo "${GREEN_TEXT}${BOLD_TEXT} ========================== creating trigger audit log ========================== ${RESET_FORMAT}"
echo
gcloud eventarc triggers create trigger-auditlog \
  --destination-run-service=${SERVICE_NAME} \
  --event-filters="type=google.cloud.audit.log.v1.written" \
  --event-filters="serviceName=storage.googleapis.com" \
  --event-filters="methodName=storage.objects.create" \
  --service-account=${PROJECT_NUMBER}-compute@developer.gserviceaccount.com
echo
echo "${GREEN_TEXT}${BOLD_TEXT} ========================== listing all triggers  ========================== ${RESET_FORMAT}"
echo
gcloud eventarc triggers list
echo
echo "${GREEN_TEXT}${BOLD_TEXT} ==========================  again Copying dummy file into bucket ========================== ${RESET_FORMAT}"
echo

gsutil cp random.txt gs://${BUCKET_NAME}/random.txt
echo

# Pick another random color for the final message
FINAL_TEXT_COLOR=${TEXT_COLORS[$RANDOM % ${#TEXT_COLORS[@]}]}
FINAL_BG_COLOR=${BG_COLORS[$RANDOM % ${#BG_COLORS[@]}]}

# Display Congratulations Message
echo "${FINAL_BG_COLOR}${FINAL_TEXT_COLOR}${BOLD}######################################################################${RESET}"
echo "${FINAL_BG_COLOR}${FINAL_TEXT_COLOR}${BOLD}#                                                                    #${RESET}"
echo "${FINAL_BG_COLOR}${FINAL_TEXT_COLOR}${BOLD}#       🎉🎉 CONGRATULATIONS FOR COMPLETING THE LAB! 🎉🎉        #${RESET}"
echo "${FINAL_BG_COLOR}${FINAL_TEXT_COLOR}${BOLD}#                                                                    #${RESET}"
echo "${FINAL_BG_COLOR}${FINAL_TEXT_COLOR}${BOLD}######################################################################${RESET}"

# Subscribe message with random colors
SUBSCRIBE_TEXT_COLOR=${TEXT_COLORS[$RANDOM % ${#TEXT_COLORS[@]}]}
SUBSCRIBE_BG_COLOR=${BG_COLORS[$RANDOM % ${#BG_COLORS[@]}]}

echo "${SUBSCRIBE_BG_COLOR}${SUBSCRIBE_TEXT_COLOR}${BOLD}📢 SUBSCRIBE TO OUR CHANNEL: https://www.youtube.com/@edutechbarsha ${RESET}"
