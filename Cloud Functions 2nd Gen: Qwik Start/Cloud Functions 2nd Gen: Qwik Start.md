# Cloud Functions 2nd Gen: Qwik Start || [GSP1089](https://www.cloudskillsboost.google/focuses/49757?parent=catalog)
---
### ⚠️ Disclaimer
- **This script and guide are provided for  the educational purposes to help you understand the lab services and boost your career. Before using the script, please open and review it to familiarize yourself with Google Cloud services. Ensure that you follow 'Qwiklabs' terms of service and YouTube’s community guidelines. The goal is to enhance your learning experience, not to bypass it.**
---
# Follow the instructions:
### If you consider that the video helped you to complete your lab, so please do like and subscribe [Edutech Barsha](https://www.youtube.com/@edutechbarsha)
## Solution [here](https://youtu.be/T5vr5fS1awg)

* Go to `Audit Logs` from [here](https://console.cloud.google.com/iam-admin/audit?)

* Copy & Paste in filter

```
Compute Engine API
```

* Check the box next to `Compute Engine API`

* Now Check all `Admin Read` , `Data Read` & `Data Write`


### Run the following Commands in CloudShell

### Assign Variable

```
export ZONE=
```
```
export REGION="${ZONE%-*}"
gcloud config set compute/region $REGION
export PROJECT_ID=$(gcloud config get-value project)

gcloud services enable \
  artifactregistry.googleapis.com \
  cloudfunctions.googleapis.com \
  cloudbuild.googleapis.com \
  eventarc.googleapis.com \
  run.googleapis.com \
  logging.googleapis.com \
  pubsub.googleapis.com

mkdir ~/hello-http && cd $_
touch index.js && touch package.json

cat > index.js <<EOF_END
const functions = require('@google-cloud/functions-framework');

functions.http('helloWorld', (req, res) => {
  res.status(200).send('HTTP with Node.js in GCF 2nd gen!');
});
EOF_END

cat > package.json <<EOF_END
{
  "name": "nodejs-functions-gen2-codelab",
  "version": "0.0.1",
  "main": "index.js",
  "dependencies": {
    "@google-cloud/functions-framework": "^2.0.0"
  }
}
EOF_END

deploy_function() {
  gcloud functions deploy nodejs-http-function \
    --gen2 \
    --runtime nodejs18 \
    --entry-point helloWorld \
    --source . \
    --region $REGION \
    --trigger-http \
    --timeout 600s \
    --max-instances 1 \
    --quiet
}

SERVICE_NAME="nodejs-http-function"

# Loop until the Cloud Run service is created
while true; do
  # Run the deployment command
  deploy_function

  # Check if Cloud Run service is created
  if gcloud run services describe $SERVICE_NAME --region $REGION &> /dev/null; then
    echo "Cloud Run service is created. Exiting the loop."
    break
  else
    echo "Waiting for Cloud Run service to be created..."
    sleep 10
  fi
done

echo "Running the next code..."

PROJECT_NUMBER=$(gcloud projects list --filter="project_id:$PROJECT_ID" --format='value(project_number)')
SERVICE_ACCOUNT=$(gsutil kms serviceaccount -p $PROJECT_NUMBER)

gcloud projects add-iam-policy-binding $PROJECT_ID \
  --member serviceAccount:$SERVICE_ACCOUNT \
  --role roles/pubsub.publisher
  
mkdir ~/hello-storage && cd $_
touch index.js && touch package.json

cat > index.js <<EOF_END
const functions = require('@google-cloud/functions-framework');

functions.cloudEvent('helloStorage', (cloudevent) => {
  console.log('Cloud Storage event with Node.js in GCF 2nd gen!');
  console.log(cloudevent);
});
EOF_END


cat > package.json <<EOF_END
{
  "name": "nodejs-functions-gen2-codelab",
  "version": "0.0.1",
  "main": "index.js",
  "dependencies": {
    "@google-cloud/functions-framework": "^2.0.0"
  }
}
EOF_END


BUCKET="gs://gcf-gen2-storage-$PROJECT_ID"
gsutil mb -l $REGION $BUCKET

deploy_function () {
gcloud functions deploy nodejs-storage-function \
  --gen2 \
  --runtime nodejs18 \
  --entry-point helloStorage \
  --source . \
  --region $REGION \
  --trigger-bucket $BUCKET \
  --trigger-location $REGION \
  --max-instances 1 \
  --quiet
}

# Variables
SERVICE_NAME="nodejs-storage-function"

# Loop until the Cloud Run service is created
while true; do
  # Run the deployment command
  deploy_function

  # Check if Cloud Run service is created
  if gcloud run services describe $SERVICE_NAME --region $REGION &> /dev/null; then
    echo "Cloud Run service is created. Exiting the loop."
    break
  else
    echo "Waiting for Cloud Run service to be created..."
    sleep 10
  fi
done

# Your next code to run after the Cloud Run service is created
echo "Running the next code..."
# Add your next code here

### ``` If you facing error re-run the above command again and again... 
echo "Hello World" > random.txt
gsutil cp random.txt $BUCKET/random.txt

gcloud functions logs read nodejs-storage-function \
  --region $REGION --gen2 --limit=100 --format "value(log)"

gcloud projects add-iam-policy-binding $PROJECT_ID \
  --member serviceAccount:$PROJECT_NUMBER-compute@developer.gserviceaccount.com \
  --role roles/eventarc.eventReceiver

cd ~
git clone https://github.com/GoogleCloudPlatform/eventarc-samples.git

cd ~/eventarc-samples/gce-vm-labeler/gcf/nodejs

gcloud functions deploy gce-vm-labeler \
  --gen2 \
  --runtime nodejs18 \
  --entry-point labelVmCreation \
  --source . \
  --region $REGION \
  --trigger-event-filters="type=google.cloud.audit.log.v1.written,serviceName=compute.googleapis.com,methodName=beta.compute.instances.insert" \
  --trigger-location $REGION \
  --max-instances 1

gcloud compute instances create instance-1 --zone=$ZONE

mkdir ~/hello-world-colored && cd $_
touch main.py


cat > main.py <<EOF_END
import os

color = os.environ.get('COLOR')

def hello_world(request):
    return f'<body style="background-color:{color}"><h1>Hello World!</h1></body>'
EOF_END

echo > requirements.txt 

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

gcloud functions deploy slow-function \
  --gen2 \
  --runtime go116 \
  --entry-point HelloWorld \
  --source . \
  --region $REGION \
  --trigger-http \
  --allow-unauthenticated \
  --max-instances 4 \
  --quiet

gcloud run deploy slow-function \
--image=$REGION-docker.pkg.dev/$DEVSHELL_PROJECT_ID/gcf-artifacts/slow--function:version_1 \
--min-instances=1 \
--max-instances=4 \
--region=$REGION \
--project=$DEVSHELL_PROJECT_ID \
 && gcloud run services update-traffic slow-function --to-latest --region=$REGION

```
# *NOW FOLLOW VIDEO INSTRUCTON'S*


### Congratulations 🎉 for completing the Lab !😄

##### *You Have Successfully Demonstrated Your Skills And Determination.*

#### *Well done!*

# Thanks For Watching:)
