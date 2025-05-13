#!/bin/bash
BLACK_TEXT=$'\033[0;90m'
RED_TEXT=$'\033[0;91m'
GREEN_TEXT=$'\033[0;92m'
YELLOW_TEXT=$'\033[0;93m'
BLUE_TEXT=$'\033[0;94m'
MAGENTA_TEXT=$'\033[0;95m'
CYAN_TEXT=$'\033[0;96m'
WHITE_TEXT=$'\033[0;97m'
RESET_FORMAT=$'\033[0m'
BOLD_TEXT=$'\033[1m'
UNDERLINE_TEXT=$'\033[4m'

echo
clear

echo
echo "${CYAN_TEXT}${BOLD_TEXT}===================================${RESET_FORMAT}"
echo "${CYAN_TEXT}${BOLD_TEXT}     STARTING EXECUTION!!          ${RESET_FORMAT}"
echo "${CYAN_TEXT}${BOLD_TEXT}===================================${RESET_FORMAT}"
echo

echo "${GREEN_TEXT}${BOLD_TEXT}🔍  Fetching the default compute zone for your project... ${RESET_FORMAT}"
ZONE=$(gcloud compute project-info describe \
  --format="value(commonInstanceMetadata.items[google-compute-default-zone])")

echo "${GREEN_TEXT}${BOLD_TEXT}🌍  Fetching the default compute region for your project... ${RESET_FORMAT}"
REGION=$(gcloud compute project-info describe \
  --format="value(commonInstanceMetadata.items[google-compute-default-region])")

echo "${GREEN_TEXT}${BOLD_TEXT}🆔  Retrieving the current GCP Project ID... ${RESET_FORMAT}"
PROJECT_ID=$(gcloud config get-value project)

echo
echo "${YELLOW_TEXT}${BOLD_TEXT}📊  Now, let's set up some Cloud Logging Metrics. ${RESET_FORMAT}"
echo

msg=$(echo "U3Vic2NyaWJlIHRvIEVkdXRlY2ggQmFyc2hh" | base64 --decode)

echo "${CYAN_TEXT}${BOLD_TEXT}📈  Creating a logging metric named '200responses' to count successful App Engine responses... ${RESET_FORMAT}"
gcloud logging metrics create 200responses \
  --description="Counts 200 OK responses from the default App Engine service" \
  --log-filter='resource.type="gae_app" AND resource.labels.module_id="default" AND (protoPayload.status=200 OR httpRequest.status=200)'

echo
echo "${BLUE_TEXT}${BOLD_TEXT}📝  Generating the configuration file 'latency_metric.yaml' for a latency distribution metric... ${RESET_FORMAT}"
cat > latency_metric.yaml <<EOF
name: projects/\$DEVSHELL_PROJECT_ID/metrics/latency_metric
description: "latency distribution"
filter: >
  resource.type="gae_app"
  resource.labels.module_id="default"
  (protoPayload.status=200 OR httpRequest.status=200)
  logName=("projects/\$DEVSHELL_PROJECT_ID/logs/cloudbuild" OR
           "projects/\$DEVSHELL_PROJECT_ID/logs/stderr" OR
           "projects/\$DEVSHELL_PROJECT_ID/logs/%2Fvar%2Flog%2Fgoogle_init.log" OR
           "projects/\$DEVSHELL_PROJECT_ID/logs/appengine.googleapis.com%2Frequest_log" OR
           "projects/\$DEVSHELL_PROJECT_ID/logs/cloudaudit.googleapis.com%2Factivity")
  severity>=DEFAULT
valueExtractor: EXTRACT(protoPayload.latency)
metricDescriptor:
  metricKind: DELTA
  valueType: DISTRIBUTION
  unit: "s"
  displayName: "Latency distribution"
bucketOptions:
  exponentialBuckets:
    numFiniteBuckets: 10
    growthFactor: 2.0
    scale: 0.01
EOF

echo
echo "${GREEN_TEXT}${BOLD_TEXT}🆔  Exporting your Project ID to the DEVSHELL_PROJECT_ID environment variable for use in the next step... ${RESET_FORMAT}"
export DEVSHELL_PROJECT_ID=$(gcloud config get-value project)

echo "${CYAN_TEXT}${BOLD_TEXT}📉  Creating the 'latency_metric' using the configuration from 'latency_metric.yaml'... ${RESET_FORMAT}"
gcloud logging metrics create latency_metric --config-from-file=latency_metric.yaml

echo
echo "${YELLOW_TEXT}${BOLD_TEXT}⚙️  Next, we'll create a Compute Engine instance and configure an audit log sink. ${RESET_FORMAT}"
echo

echo
echo "${CYAN_TEXT}${BOLD_TEXT} $msg ${RESET_FORMAT}"
echo

echo "${MAGENTA_TEXT}${BOLD_TEXT}🖥️  Creating a new Compute Engine VM instance named 'audit-log-vm'. This may take a few moments... ${RESET_FORMAT}"
gcloud compute instances create audit-log-vm \
  --zone=$ZONE \
  --machine-type=e2-micro \
  --image-family=debian-11 \
  --image-project=debian-cloud \
  --tags=http-server \
  --metadata=startup-script='#!/bin/bash
    sudo apt update && sudo apt install -y apache2
    sudo systemctl start apache2' \
  --scopes=https://www.googleapis.com/auth/cloud-platform \
  --labels=env=lab \
  --quiet

echo
echo "${YELLOW_TEXT}${BOLD_TEXT}🔍  Setting up an Audit Log Sink to export logs to BigQuery. ${RESET_FORMAT}"
echo

echo "${GREEN_TEXT}${BOLD_TEXT}🆔  Confirming the current GCP Project ID for sink configuration... ${RESET_FORMAT}"
PROJECT_ID=$(gcloud config get-value project)
SINK_NAME="AuditLogs"
BQ_DATASET="AuditLogs"
BQ_LOCATION="US"

echo "${BLUE_TEXT}${BOLD_TEXT}🗃️  Ensuring the BigQuery dataset '$BQ_DATASET' exists in location '$BQ_LOCATION'... ${RESET_FORMAT}"
bq --location=$BQ_LOCATION mk --dataset $PROJECT_ID:$BQ_DATASET

echo "${CYAN_TEXT}${BOLD_TEXT}📤  Creating the logging sink '$SINK_NAME' to channel GCE audit logs to the '$BQ_DATASET' BigQuery dataset... ${RESET_FORMAT}"
gcloud logging sinks create $SINK_NAME \
  bigquery.googleapis.com/projects/$PROJECT_ID/datasets/$BQ_DATASET \
  --log-filter='resource.type="gce_instance"
logName="projects/'$PROJECT_ID'/logs/cloudaudit.googleapis.com%2Factivity"' \
  --description="Export GCE audit logs to BigQuery" \
  --project=$PROJECT_ID

echo
echo "${BLUE_TEXT}${BOLD_TEXT}~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~${RESET_FORMAT}"
echo "${CYAN_TEXT}${BOLD_TEXT}         NOW FOLLOW VIDEO STEPS👨‍💻            ${RESET_FORMAT}"
echo "${BLUE_TEXT}${BOLD_TEXT}~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~${RESET_FORMAT}"
echo

echo "${CYAN_TEXT}${BOLD_TEXT}🔗 OPEN THIS LINK:${RESET_FORMAT} ${BLUE_TEXT}https://console.cloud.google.com/appengine?project=${PROJECT_ID}${RESET_FORMAT}"
echo
echo "${YELLOW_TEXT}${BOLD_TEXT}📖 Book Details (Test Log Entry):${RESET_FORMAT}"
echo "${GREEN_TEXT}   Title:${RESET_FORMAT} Test Book"
echo "${GREEN_TEXT}   Author:${RESET_FORMAT} Jane Doe"
echo "${GREEN_TEXT}   Date Published:${RESET_FORMAT} 1/2/2003"
echo "${GREEN_TEXT}   Description:${RESET_FORMAT} Log test."

echo
echo "${MAGENTA_TEXT}${BOLD_TEXT}💖 IF YOU FOUND THIS HELPFUL, SUBSCRIBE EDUTECH BARSHA! 👇${RESET_FORMAT}"
echo "${BLUE_TEXT}${BOLD_TEXT}${UNDERLINE_TEXT}https://www.youtube.com/@edutechbarsha${RESET_FORMAT}"
echo
