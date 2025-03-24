#!/bin/bash

# Define color codes for changing colors
COLORS=('\033[0;31m' '\033[0;32m' '\033[0;33m' '\033[0;34m' '\033[0;35m' '\033[0;36m')
NC='\033[0m' 

# Function to print text with changing colors
print_with_changing_colors() {
    local text=("$@")
    local color_index=0
    for line in "${text[@]}"
    do
        echo -e "${COLORS[color_index]}${line}${NC}"
        ((color_index=(color_index+1) % ${#COLORS[@]}))
        sleep 0.5  
    done
}

welcome_pattern=(
"**********************************************************"
"**               WELCOME TO                             **" 
"**                EDUTECH BARSHA                        **" 
"**                                                      **"
"**********************************************************"
)

print_with_changing_colors "${welcome_pattern[@]}"

# Google Cloud Project & Bucket Deletion
PROJECT_ID=$(gcloud config get-value project)
BUCKET=${PROJECT_ID}-bucket
gsutil rm -rf gs://${BUCKET}/* 
gsutil rb gs://${BUCKET}


subscribe_pattern=(
"**********************************************************"
"**                 S U B S C R I B E  TO                **"
"**                 EDUTECH BARSHA                       **"
"**                                                      **"
"**********************************************************"
)

print_with_changing_colors "${subscribe_pattern[@]}"


congrats_pattern=(
"**********************************************************"
"**         🎉🎉 CONGRATULATIONS 🎉🎉                  **"
"**       SUCCESSFULLY DELETED BUCKET DATA               **"
"**              THANK YOU FOR SUPPORTING                **"
"**                EDUTECH BARSHA                        **"
"**********************************************************"
)

print_with_changing_colors "${congrats_pattern[@]}"
