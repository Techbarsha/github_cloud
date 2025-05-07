#!/bin/bash

# Prompt user for input
read -p "Enter region for HTTP function (e.g., us-central1): " REGION1
read -p "Enter name for HTTP function (e.g., cf-http-go): " FUNCTION_NAME1
read -p "Enter region for Pub/Sub function (e.g., us-central1): " REGION2
read -p "Enter name for Pub/Sub function (e.g., cf-pubsub-go): " FUNCTION_NAME2

export PROJECT_ID=$(gcloud config get-value project)

# HTTP Cloud Function
mkdir -p cloud-function-http-go
cat > cloud-function-http-go/main.go <<EOF
package p

import (
	"net/http"
)

func HelloHTTP(w http.ResponseWriter, r *http.Request) {
	w.Write([]byte("Hello from Go HTTP Cloud Function!"))
}
EOF

cat > cloud-function-http-go/go.mod <<EOF
module cloudfunction

go 1.21
EOF

gcloud functions deploy ${FUNCTION_NAME1} \
  --gen2 \
  --runtime=go121 \
  --region=${REGION1} \
  --source=cloud-function-http-go \
  --entry-point=HelloHTTP \
  --trigger-http \
  --max-instances=5 \
  --allow-unauthenticated

# Pub/Sub Cloud Function
mkdir -p cloud-function-pubsub-go
cat > cloud-function-pubsub-go/main.go <<EOF
package p

import (
	"context"
	"log"
)

type PubSubMessage struct {
	Data []byte \`json:"data"\`
}

func HelloPubSub(ctx context.Context, m PubSubMessage) error {
	log.Printf("Hello, %s!", string(m.Data))
	return nil
}
EOF

cat > cloud-function-pubsub-go/go.mod <<EOF
module cloudfunction

go 1.21
EOF

gcloud functions deploy ${FUNCTION_NAME2} \
  --gen2 \
  --runtime=go121 \
  --region=${REGION2} \
  --source=cloud-function-pubsub-go \
  --entry-point=HelloPubSub \
  --trigger-topic=cf-pubsub \
  --max-instances=5

# Clean up certain files
cd ~
for file in *; do
  if [[ "$file" == gsp* || "$file" == arc* || "$file" == shell* ]]; then
    if [[ -f "$file" ]]; then
      rm "$file"
    fi
  fi
done
