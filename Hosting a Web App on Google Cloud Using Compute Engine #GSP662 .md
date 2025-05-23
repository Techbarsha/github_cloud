# Hosting a Web App on Google Cloud Using Compute Engine [GSP662](https://www.cloudskillsboost.google/focuses/11952?parent=catalog)
## follow the instructions

# If you consider that the video helped you to complete your lab, so please do like and subscribe. [EDUTECH BARSHA](https://www.youtube.com/@edutechbarsha)
* In the GCP Console open the Cloud Shell and run the following commands:

```cmd
export ZONE=
```
```cmd
gcloud config set compute/zone $ZONE
gcloud services enable compute.googleapis.com
gsutil mb gs://fancy-store-$DEVSHELL_PROJECT_ID
git clone https://github.com/googlecodelabs/monolith-to-microservices.git
cd ~/monolith-to-microservices
chmod +x setup.sh
./setup.sh
nvm install --lts
curl -O -L https://github.com/Qwicklab/Level-1-AppDev-and-Infrastructure/blob/main/sh%20files/startup-script.sh
gsutil cp ~/monolith-to-microservices/startup-script.sh gs://fancy-store-$DEVSHELL_PROJECT_ID
cd ~
rm -rf monolith-to-microservices/*/node_modules
gsutil -m cp -r monolith-to-microservices gs://fancy-store-$DEVSHELL_PROJECT_ID/
gcloud compute instances create backend \
    --machine-type=e2-medium \
    --tags=backend \
   --metadata=startup-script-url=https://storage.googleapis.com/fancy-store-$DEVSHELL_PROJECT_ID/startup-script.sh
gcloud compute instances list
export EXTERNAL_IP=$(gcloud compute instances describe backend --zone=$ZONE --format='get(networkInterfaces[0].accessConfigs[0].natIP)')
cd ~/monolith-to-microservices/react-app
rm -f .env
cat > .env << EOF
REACT_APP_ORDERS_URL=http://$EXTERNAL_IP:8081/api/orders
REACT_APP_PRODUCTS_URL=http://$EXTERNAL_IP:8082/api/products
EOF
cd ~/monolith-to-microservices/react-app
npm install && npm run-script build
cd ~
rm -rf monolith-to-microservices/*/node_modules
gsutil -m cp -r monolith-to-microservices gs://fancy-store-$DEVSHELL_PROJECT_ID/
gcloud compute instances create frontend \
    --machine-type=e2-medium \
    --tags=frontend \
    --metadata=startup-script-url=https://storage.googleapis.com/fancy-store-$DEVSHELL_PROJECT_ID/startup-script.sh
gcloud compute firewall-rules create fw-fe \
    --allow tcp:8080 \
    --target-tags=frontend
gcloud compute firewall-rules create fw-be \
    --allow tcp:8081-8082 \
    --target-tags=backend
gcloud compute instances list
```
## Check the progress till task 4
```cmd
gcloud compute instances stop frontend
gcloud compute instances stop backend
gcloud compute instance-templates create fancy-fe \
    --source-instance=frontend
gcloud compute instance-templates create fancy-be \
    --source-instance=backend
gcloud compute instance-templates list
gcloud compute instances delete --quiet  backend
gcloud compute instance-groups managed create fancy-fe-mig \
    --base-instance-name fancy-fe \
    --size 2 \
    --template fancy-fe
gcloud compute instance-groups managed create fancy-be-mig \
    --base-instance-name fancy-be \
    --size 2 \
    --template fancy-be
gcloud compute instance-groups set-named-ports fancy-fe-mig \
    --named-ports frontend:8080
gcloud compute instance-groups set-named-ports fancy-be-mig \
    --named-ports orders:8081,products:8082
gcloud compute health-checks create http fancy-fe-hc \
    --port 8080 \
    --check-interval 30s \
    --healthy-threshold 1 \
    --timeout 10s \
    --unhealthy-threshold 3
gcloud compute health-checks create http fancy-be-hc \
    --port 8081 \
    --request-path=/api/orders \
    --check-interval 30s \
    --healthy-threshold 1 \
    --timeout 10s \
    --unhealthy-threshold 3
gcloud compute firewall-rules create allow-health-check \
    --allow tcp:8080-8081 \
    --source-ranges 130.211.0.0/22,35.191.0.0/16 \
    --network default
gcloud compute instance-groups managed update fancy-fe-mig \
    --health-check fancy-fe-hc \
    --initial-delay 300
gcloud compute instance-groups managed update fancy-be-mig \
    --health-check fancy-be-hc \
    --initial-delay 300
```
## Check the progress of task 5
```cmd
gcloud compute http-health-checks create fancy-fe-frontend-hc \
  --request-path / \
  --port 8080
gcloud compute http-health-checks create fancy-be-orders-hc \
  --request-path /api/orders \
  --port 8081
gcloud compute http-health-checks create fancy-be-products-hc \
  --request-path /api/products \
  --port 8082
gcloud compute backend-services create fancy-fe-frontend \
  --http-health-checks fancy-fe-frontend-hc \
  --port-name frontend \
  --global
gcloud compute backend-services create fancy-be-orders \
  --http-health-checks fancy-be-orders-hc \
  --port-name orders \
  --global
gcloud compute backend-services create fancy-be-products \
  --http-health-checks fancy-be-products-hc \
  --port-name products \
  --global
gcloud compute backend-services add-backend fancy-fe-frontend \
  --instance-group fancy-fe-mig \
  --instance-group-zone $ZONE \
  --global
gcloud compute backend-services add-backend fancy-be-orders \
  --instance-group fancy-be-mig \
  --instance-group-zone $ZONE \
  --global
gcloud compute backend-services add-backend fancy-be-products \
  --instance-group fancy-be-mig \
  --instance-group-zone $ZONE \
  --global
gcloud compute url-maps create fancy-map \
  --default-service fancy-fe-frontend
gcloud compute url-maps add-path-matcher fancy-map \
   --default-service fancy-fe-frontend \
   --path-matcher-name orders \
   --path-rules "/api/orders=fancy-be-orders,/api/products=fancy-be-products"
gcloud compute target-http-proxies create fancy-proxy \
  --url-map fancy-map
gcloud compute forwarding-rules create fancy-http-rule \
  --global \
  --target-http-proxy fancy-proxy \
  --ports 80
cd ~/monolith-to-microservices/react-app/
gcloud compute forwarding-rules list --global
export IP1=$(gcloud compute forwarding-rules describe fancy-http-rule --global --format='get(IPAddress)')
cd ~/monolith-to-microservices/react-app
rm -f .env
cat > .env << EOF
REACT_APP_ORDERS_URL=http://$EXTERNAL_IP:8081/api/orders
REACT_APP_PRODUCTS_URL=http://$EXTERNAL_IP:8082/api/products
REACT_APP_ORDERS_URL=http://$IP1/api/orders
REACT_APP_PRODUCTS_URL=http://$IP1/api/products
EOF
cd ~/monolith-to-microservices/react-app
npm install && npm run-script build
cd ~
rm -rf monolith-to-microservices/*/node_modules
gsutil -m cp -r monolith-to-microservices gs://fancy-store-$DEVSHELL_PROJECT_ID/
gcloud compute instance-groups managed rolling-action replace fancy-fe-mig \
    --max-unavailable 100%
gcloud compute instance-groups managed set-autoscaling \
  fancy-fe-mig \
  --max-num-replicas 2 \
  --target-load-balancing-utilization 0.60
gcloud compute instance-groups managed set-autoscaling \
  fancy-be-mig \
  --max-num-replicas 2 \
  --target-load-balancing-utilization 0.60
gcloud compute backend-services update fancy-fe-frontend \
    --enable-cdn --global
gcloud compute instances set-machine-type frontend --machine-type e2-small
gcloud compute instance-templates create fancy-fe-new \
    --source-instance=frontend \
    --source-instance-zone=$ZONE
gcloud compute instance-groups managed rolling-action start-update fancy-fe-mig \
    --version template=fancy-fe-new
cd ~/monolith-to-microservices/react-app/src/pages/Home
mv index.js.new index.js
cat ~/monolith-to-microservices/react-app/src/pages/Home/index.js
cd ~/monolith-to-microservices/react-app
npm install && npm run-script build
cd ~
rm -rf monolith-to-microservices/*/node_modules
gsutil -m cp -r monolith-to-microservices gs://fancy-store-$DEVSHELL_PROJECT_ID/
gcloud compute instance-groups managed rolling-action replace fancy-fe-mig \
    --max-unavailable=100%
```
## Now check the progress of all left tasks

### Congratulations 🎉 for completing the Lab !😄

##### *You Have Successfully Demonstrated Your Skills And Determination.*

#### *Well done!*

# Thanks For Watching:)
