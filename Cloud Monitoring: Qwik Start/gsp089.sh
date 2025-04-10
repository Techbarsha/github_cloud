#!/bin/bash

clear

#=========================#
#   Color Configuration   #
#=========================#

BLACK=`tput setaf 0`; RED=`tput setaf 1`; GREEN=`tput setaf 2`
YELLOW=`tput setaf 3`; BLUE=`tput setaf 4`; MAGENTA=`tput setaf 5`
CYAN=`tput setaf 6`; WHITE=`tput setaf 7`
BG_BLACK=`tput setab 0`; BG_RED=`tput setab 1`; BG_GREEN=`tput setab 2`
BG_YELLOW=`tput setab 3`; BG_BLUE=`tput setab 4`; BG_MAGENTA=`tput setab 5`
BG_CYAN=`tput setab 6`; BG_WHITE=`tput setab 7`
BOLD=`tput bold`; RESET=`tput sgr0`

TEXT_COLORS=($RED $GREEN $YELLOW $BLUE $MAGENTA $CYAN)
BG_COLORS=($BG_RED $BG_GREEN $BG_YELLOW $BG_BLUE $BG_MAGENTA $BG_CYAN)

RANDOM_TEXT_COLOR=${TEXT_COLORS[$RANDOM % ${#TEXT_COLORS[@]}]}
RANDOM_BG_COLOR=${BG_COLORS[$RANDOM % ${#BG_COLORS[@]}]}

#=========================#
#     Utility Function    #
#=========================#

section_title() {
  echo -e "\n${BOLD}${1}${RESET}"
}

success_message() {
  echo -e "${RANDOM_BG_COLOR}${RANDOM_TEXT_COLOR}${BOLD}✔ ${1}${RESET}"
}

#=========================#
#       Execution         #
#=========================#

success_message "Starting Execution"

section_title "${BLUE}Step 1: Set Environment Variables"
export PROJECT_ID=$(gcloud config get-value project)
export PROJECT_NUMBER=$(gcloud projects describe ${PROJECT_ID} --format="value(projectNumber)")
export ZONE=$(gcloud compute project-info describe --format="value(commonInstanceMetadata.items[google-compute-default-zone])")
export REGION=$(gcloud compute project-info describe --format="value(commonInstanceMetadata.items[google-compute-default-region])")

section_title "${GREEN}Step 2: Enable OS Config Service"
gcloud services enable osconfig.googleapis.com

section_title "${YELLOW}Step 3: Configure gcloud Settings"
gcloud config set compute/zone $ZONE
gcloud config set compute/region $REGION

section_title "${MAGENTA}Step 4: Create Compute Instance"
gcloud compute instances create lamp-1-vm \
  --project=$DEVSHELL_PROJECT_ID \
  --zone=$ZONE \
  --machine-type=e2-medium \
  --network-interface=network-tier=PREMIUM,stack-type=IPV4_ONLY,subnet=default \
  --metadata=enable-osconfig=TRUE,enable-oslogin=true \
  --maintenance-policy=MIGRATE \
  --provisioning-model=STANDARD \
  --service-account=$PROJECT_NUMBER-compute@developer.gserviceaccount.com \
  --scopes=https://www.googleapis.com/auth/devstorage.read_only,\
https://www.googleapis.com/auth/logging.write,\
https://www.googleapis.com/auth/monitoring.write,\
https://www.googleapis.com/auth/service.management.readonly,\
https://www.googleapis.com/auth/servicecontrol,\
https://www.googleapis.com/auth/trace.append \
  --tags=http-server \
  --create-disk=auto-delete=yes,boot=yes,device-name=lamp-1-vm,\
image=projects/debian-cloud/global/images/debian-12-bookworm-v20250311,\
mode=rw,size=10,type=pd-balanced \
  --no-shielded-secure-boot --shielded-vtpm --shielded-integrity-monitoring \
  --labels=goog-ops-agent-policy=v2-x86-template-1-4-0,goog-ec-src=vm_add-gcloud \
  --reservation-affinity=any

# Create policy config file
cat > config.yaml <<EOF
agentsRule:
  packageState: installed
  version: latest
instanceFilter:
  inclusionLabels:
  - labels:
      goog-ops-agent-policy: v2-x86-template-1-4-0
EOF

gcloud compute instances ops-agents policies create goog-ops-agent-v2-x86-template-1-4-0-$ZONE \
  --project=$DEVSHELL_PROJECT_ID --zone=$ZONE --file=config.yaml

gcloud compute resource-policies create snapshot-schedule default-schedule-1 \
  --project=$DEVSHELL_PROJECT_ID --region=$REGION \
  --max-retention-days=14 --on-source-disk-delete=keep-auto-snapshots \
  --daily-schedule --start-time=22:00

gcloud compute disks add-resource-policies lamp-1-vm \
  --project=$DEVSHELL_PROJECT_ID --zone=$ZONE \
  --resource-policies=projects/$DEVSHELL_PROJECT_ID/regions/$REGION/resourcePolicies/default-schedule-1

section_title "${RED}Step 5: Create HTTP Firewall Rule"
gcloud compute firewall-rules create allow-http \
  --project=$DEVSHELL_PROJECT_ID \
  --direction=INGRESS --priority=1000 \
  --network=default --action=ALLOW \
  --rules=tcp:80 --source-ranges=0.0.0.0/0 \
  --target-tags=http-server

sleep 45

section_title "${CYAN}Step 6: Create & Transfer Startup Script"
cat > prepare_disk.sh <<'EOF'
sudo apt-get update
sudo apt-get install -y apache2 php7.0
sudo service apache2 restart
EOF

gcloud compute scp prepare_disk.sh lamp-1-vm:/tmp --project=$DEVSHELL_PROJECT_ID --zone=$ZONE --quiet
gcloud compute ssh lamp-1-vm --project=$DEVSHELL_PROJECT_ID --zone=$ZONE --quiet --command="bash /tmp/prepare_disk.sh"

section_title "${GREEN}Step 7: Retrieve Instance ID"
export INSTANCE_ID=$(gcloud compute instances list --filter=lamp-1-vm --zones $ZONE --format="value(id)")

section_title "${YELLOW}Step 8: Setup Uptime Check"
# Uptime config JSON creation
curl -X POST -H "Authorization: Bearer $(gcloud auth print-access-token)" -H "Content-Type: application/json" \
"https://monitoring.googleapis.com/v3/projects/$DEVSHELL_PROJECT_ID/uptimeCheckConfigs" \
-d @<(cat <<EOF
{
  "displayName": "Lamp Uptime Check",
  "httpCheck": {
    "path": "/",
    "port": 80,
    "requestMethod": "GET"
  },
  "monitoredResource": {
    "labels": {
      "instance_id": "$INSTANCE_ID",
      "project_id": "$DEVSHELL_PROJECT_ID",
      "zone": "$ZONE"
    },
    "type": "gce_instance"
  }
}
EOF
)

section_title "${MAGENTA}Step 9: Create Email Notification Channel"
cat > email-channel.json <<EOF
{
  "type": "email",
  "displayName": "quickgcplab",
  "description": "Awesome",
  "labels": {
    "email_address": "$USER_EMAIL"
  }
}
EOF

gcloud beta monitoring channels create --channel-content-from-file="email-channel.json"

section_title "${RED}Step 10: Get Notification Channel ID"
email_channel_info=$(gcloud beta monitoring channels list)
email_channel_id=$(echo "$email_channel_info" | grep -oP 'name: \K[^ ]+' | head -n 1)

section_title "${CYAN}Step 11: Create Alerting Policy"
cat > awesome.json <<EOF
{
  "displayName": "Inbound Traffic Alert",
  "conditions": [
    {
      "displayName": "VM Instance - Network traffic",
      "conditionThreshold": {
        "filter": "resource.type = \\"gce_instance\\" AND metric.type = \\"agent.googleapis.com/interface/traffic\\"",
        "aggregations": [
          {
            "alignmentPeriod": "300s",
            "crossSeriesReducer": "REDUCE_NONE",
            "perSeriesAligner": "ALIGN_RATE"
          }
        ],
        "comparison": "COMPARISON_GT",
        "duration": "60s",
        "trigger": {
          "count": 1
        },
        "thresholdValue": 500
      }
    }
  ],
  "combiner": "OR",
  "enabled": true,
  "notificationChannels": ["$email_channel_id"]
}
EOF

gcloud alpha monitoring policies create --policy-from-file="awesome.json"

# ─────────────────────────────────────────────
#              COMPLETION MESSAGE
# ─────────────────────────────────────────────
echo
echo "${GREEN_TEXT}${BOLD_TEXT}"
echo "╔═══════════════════════════════════════════════════════╗"
echo "║              LAB COMPLETED SUCCESSFULLY!!😊           ║"
echo "╚═══════════════════════════════════════════════════════╝"
echo "${RESET_FORMAT}"
echo
echo -e "${RED_TEXT}${BOLD_TEXT}Subscribe to Edutech Barsha:${RESET_FORMAT} ${BLUE_TEXT}${BOLD_TEXT}https://www.youtube.com/@edutechbarsha${RESET_FORMAT}"
