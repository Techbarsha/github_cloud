# Monitor an Apache Web Server using Ops Agent || [GSP1108](https://www.cloudskillsboost.google/focuses/56596?parent=catalog) ||

---
### ⚠️ Disclaimer
- **This script and guide are provided for  the educational purposes to help you understand the lab services and boost your career. Before using the script, please open and review it to familiarize yourself with Google Cloud services. Ensure that you follow 'Qwiklabs' terms of service and YouTube’s community guidelines. The goal is to enhance your learning experience, not to bypass it.**
---

# Follow the instructions

# If you consider that the video helped you to complete your lab, so please do like and subscribe [Edutech Barsha](https://www.youtube.com/@edutechbarsha)
## Solution [here](https://youtu.be/B_yaZVAnMSA)

### Run the following Commands in CloudShell
```

gcloud auth list

export PROJECT_ID=$(gcloud config get-value project)

export PROJECT_ID=$DEVSHELL_PROJECT_ID

export ZONE=us-central1-a

gcloud config set compute/zone $ZONE

gcloud compute instances create quickstart-vm --project=$DEVSHELL_PROJECT_ID --zone=$ZONE --machine-type=e2-small --image-family=debian-11 --image-project=debian-cloud --tags=http-server,https-server && gcloud compute firewall-rules create default-allow-http --target-tags=http-server --allow tcp:80 --description="Allow HTTP traffic" && gcloud compute firewall-rules create default-allow-https --target-tags=https-server --allow tcp:443 --description="Allow HTTPS traffic"


cat > cp_disk.sh <<'EOF_CP'

sudo apt-get update && sudo apt-get install apache2 php7.0 -y

curl -sSO https://dl.google.com/cloudagents/add-google-cloud-ops-agent-repo.sh
sudo bash add-google-cloud-ops-agent-repo.sh --also-install

# Configures Ops Agent to collect telemetry from the app and restart Ops Agent.

set -e

# Create a back up of the existing file so existing configurations are not lost.
sudo cp /etc/google-cloud-ops-agent/config.yaml /etc/google-cloud-ops-agent/config.yaml.bak

# Configure the Ops Agent.
sudo tee /etc/google-cloud-ops-agent/config.yaml > /dev/null << EOF
metrics:
  receivers:
    apache:
      type: apache
  service:
    pipelines:
      apache:
        receivers:
          - apache
logging:
  receivers:
    apache_access:
      type: apache_access
    apache_error:
      type: apache_error
  service:
    pipelines:
      apache:
        receivers:
          - apache_access
          - apache_error
EOF

sudo service google-cloud-ops-agent restart
sleep 60

EOF_CP

export ZONE=us-central1-a

gcloud compute scp cp_disk.sh quickstart-vm:/tmp --project=$DEVSHELL_PROJECT_ID --zone=$ZONE --quiet

gcloud compute ssh quickstart-vm --project=$DEVSHELL_PROJECT_ID --zone=$ZONE --quiet --command="bash /tmp/cp_disk.sh"



cat > cp-channel.json <<EOF_CP
{
  "type": "pubsub",
  "displayName": "techcps",
  "description": "subscribe to techcps",
  "labels": {
    "topic": "projects/$DEVSHELL_PROJECT_ID/topics/notificationTopic"
  }
}
EOF_CP


gcloud beta monitoring channels create --channel-content-from-file=cp-channel.json


email_channel=$(gcloud beta monitoring channels list)
channel_id=$(echo "$email_channel" | grep -oP 'name: \K[^ ]+' | head -n 1)


cat > stopped-vm-alert-policy.json <<EOF_CP
{
  "displayName": "Apache traffic above threshold",
  "userLabels": {},
  "conditions": [
    {
      "displayName": "VM Instance - workload/apache.traffic",
      "conditionThreshold": {
        "filter": "resource.type = \"gce_instance\" AND metric.type = \"workload.googleapis.com/apache.traffic\"",
        "aggregations": [
          {
            "alignmentPeriod": "60s",
            "crossSeriesReducer": "REDUCE_NONE",
            "perSeriesAligner": "ALIGN_RATE"
          }
        ],
        "comparison": "COMPARISON_GT",
        "duration": "0s",
        "trigger": {
          "count": 1
        },
        "thresholdValue": 4000
      }
    }
  ],
  "alertStrategy": {
    "autoClose": "1800s"
  },
  "combiner": "OR",
  "enabled": true,
  "notificationChannels": [
    "$channel_id"
  ],
  "severity": "SEVERITY_UNSPECIFIED"
}
EOF_CP


gcloud alpha monitoring policies create --policy-from-file=stopped-vm-alert-policy.json


```

### Congratulations 🎉 for completing the Lab !😄

##### *You Have Successfully Demonstrated Your Skills And Determination.*

#### *Well done!*