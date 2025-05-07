#!/bin/bash

# Prompt user for region and function name
read -p "Enter the deployment region (e.g., us-central1): " REGION
read -p "Enter the Cloud Function name: " FUNCTION_NAME

# Set project ID
export PROJECT_ID=$(gcloud config get-value project)

# Create function directory
mkdir -p cloud-function

# Create the index.js file
cat > cloud-function/index.js <<EOF
exports.helloWorld = (req, res) => {
  res.send('Hello from Cloud Function!');
};
EOF

# Create the package.json file
cat > cloud-function/package.json <<EOF
{
  "name": "cf-nodejs",
  "version": "1.0.0",
  "main": "index.js"
}
EOF

# Deploy the Cloud Function
gcloud functions deploy ${FUNCTION_NAME} \
  --gen2 \
  --runtime=nodejs20 \
  --region=${REGION} \
  --source=cloud-function \
  --entry-point=helloWorld \
  --trigger-http \
  --max-instances=5 \
  --allow-unauthenticated

# Clean up temporary files in home directory
cd ~
for file in *; do
  if [[ "$file" == gsp* || "$file" == arc* || "$file" == shell* ]]; then
    if [[ -f "$file" ]]; then
      rm "$file"
    fi
  fi
done
