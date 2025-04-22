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

# Welcome message with branding
echo "${CYAN_TEXT}${BOLD_TEXT}=======================================================${RESET_FORMAT}"
echo "${CYAN_TEXT}${BOLD_TEXT}      🌟 Welcome to EduTechBarsha 🌟                  ${RESET_FORMAT}"
echo "${CYAN_TEXT}${BOLD_TEXT}=======================================================${RESET_FORMAT}"
echo
echo "${BLUE_TEXT}${BOLD_TEXT}=======================================${RESET_FORMAT}"
echo "${BLUE_TEXT}${BOLD_TEXT}         STARTING EXECUTION...         ${RESET_FORMAT}"
echo "${BLUE_TEXT}${BOLD_TEXT}=======================================${RESET_FORMAT}"
echo

# Instruction for REGION
echo "${YELLOW_TEXT}${BOLD_TEXT}Please Enter REGION:${RESET_FORMAT}"
read -r REGION
echo "${GREEN_TEXT}${BOLD_TEXT}You entered: $REGION${RESET_FORMAT}"
export REGION=$REGION

gcloud services enable datacatalog.googleapis.com

# Instruction for ecommerce dataset
echo "${YELLOW_TEXT}${BOLD_TEXT}Creating 'ecommerce' dataset in BigQuery...${RESET_FORMAT}"
bq mk ecommerce
echo "${GREEN_TEXT}${BOLD_TEXT}'ecommerce' dataset created successfully.${RESET_FORMAT}"

gcloud services enable bigqueryconnection.googleapis.com

# Instruction for connection creation
echo "${YELLOW_TEXT}${BOLD_TEXT}Creating BigQuery connection 'customer_data_connection'...${RESET_FORMAT}"
bq mk --connection --location=$REGION --project_id=$DEVSHELL_PROJECT_ID \
    --connection_type=CLOUD_RESOURCE customer_data_connection
echo "${GREEN_TEXT}${BOLD_TEXT}'customer_data_connection' created successfully.${RESET_FORMAT}"

CLOUD=$(bq show --connection $DEVSHELL_PROJECT_ID.$REGION.customer_data_connection | grep "serviceAccountId" | awk '{gsub(/"/, "", $8); print $8}')
NEWs="${CLOUD%?}"

# IAM policy binding
echo "${YELLOW_TEXT}${BOLD_TEXT}Adding IAM policy binding for service account: $NEWs ...${RESET_FORMAT}"
gcloud projects add-iam-policy-binding $DEVSHELL_PROJECT_ID \
    --member="serviceAccount:$NEWs" \
    --role="roles/storage.objectViewer"
echo "${GREEN_TEXT}${BOLD_TEXT}IAM policy binding added successfully.${RESET_FORMAT}"

# External table creation
echo "${YELLOW_TEXT}${BOLD_TEXT}Creating external table 'customer_online_sessions'...${RESET_FORMAT}"
bq mk --external_table_definition=gs://$DEVSHELL_PROJECT_ID-bucket/customer-online-sessions.csv \
ecommerce.customer_online_sessions
echo "${GREEN_TEXT}${BOLD_TEXT}'customer_online_sessions' external table created successfully.${RESET_FORMAT}"

# Tag template creation
echo "${YELLOW_TEXT}${BOLD_TEXT}Creating Data Catalog tag template 'sensitive_data_template'...${RESET_FORMAT}"
gcloud data-catalog tag-templates create sensitive_data_template \
    --location=$REGION \
    --display-name="Sensitive Data Template" \
    --field=id=has_sensitive_data,display-name="Has Sensitive Data",type=bool \
    --field=id=sensitive_data_type,display-name="Sensitive Data Type",type='enum(Location Info|Contact Info|None)'
echo "${GREEN_TEXT}${BOLD_TEXT}'sensitive_data_template' tag template created successfully.${RESET_FORMAT}"

# Tag file creation
cat > tag_file.json << EOF
  {
    "has_sensitive_data": TRUE,
    "sensitive_data_type": "Location Info"
  }
EOF

ENTRY_NAME=$(gcloud data-catalog entries lookup '//bigquery.googleapis.com/projects/'$DEVSHELL_PROJECT_ID'/datasets/ecommerce/tables/customer_online_sessions' --format="value(name)")

# Tag creation
echo "${YELLOW_TEXT}${BOLD_TEXT}Creating Data Catalog tag for 'customer_online_sessions'...${RESET_FORMAT}"
gcloud data-catalog tags create --entry=${ENTRY_NAME} \
    --tag-template=sensitive_data_template --tag-template-location=$REGION --tag-file=tag_file.json
echo "${GREEN_TEXT}${BOLD_TEXT}Tag created successfully.${RESET_FORMAT}"

# Completion message with branding
echo
echo "${GREEN_TEXT}${BOLD_TEXT}=======================================================${RESET_FORMAT}"
echo "${GREEN_TEXT}${BOLD_TEXT}              🎉 LAB COMPLETED SUCCESSFULLY! 🎉         ${RESET_FORMAT}"
echo "${GREEN_TEXT}${BOLD_TEXT}=======================================================${RESET_FORMAT}"
echo
echo -e "${MAGENTA_TEXT}${BOLD_TEXT}Thanks for learning with EduTechBarsha!${RESET_FORMAT}"
echo -e "${RED_TEXT}${BOLD_TEXT}Subscribe to our Channel:${RESET_FORMAT} ${BLUE_TEXT}${BOLD_TEXT}https://www.youtube.com/@edutechbarsha${RESET_FORMAT}"
