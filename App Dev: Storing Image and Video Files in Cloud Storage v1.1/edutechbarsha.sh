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

# Display EDUTECH BARSHA header
echo
echo "${CYAN_TEXT}${BOLD_TEXT}╔════════════════════════════════════════════════════════╗${RESET_FORMAT}"
echo "${CYAN_TEXT}${BOLD_TEXT}                  WELCOME TO EDUTECH BARSHA              ${RESET_FORMAT}"
echo "${CYAN_TEXT}${BOLD_TEXT}                  Starting the process...                ${RESET_FORMAT}"
echo "${CYAN_TEXT}${BOLD_TEXT}╚════════════════════════════════════════════════════════╝${RESET_FORMAT}"
echo

# Function to display colored messages
print_message() {
  echo -e "${BOLD_TEXT}${2}${1}${RESET_FORMAT}"
}

# Function to check command status
check_status() {
  if [ $? -eq 0 ]; then
    print_message "✅ $1" "${GREEN_TEXT}"
  else
    print_message "❌ $1" "${RED_TEXT}"
  fi
}

# Task 1: Reviewing the case study application
print_message "\n📋 TASK 1: REVIEWING THE CASE STUDY APPLICATION" "${YELLOW_TEXT}"

# Clone the repository
print_message "\n📦 Cloning the repository..." "${CYAN_TEXT}"
git clone https://github.com/GoogleCloudPlatform/training-data-analyst
check_status "Repository cloned successfully"

# Configure and run the case study application
print_message "\n🔧 Configuring the application..." "${CYAN_TEXT}"
cd ~/training-data-analyst/courses/developingapps/nodejs/cloudstorage/start
check_status "Changed directory successfully"

print_message "\n🚀 Running preparation script..." "${CYAN_TEXT}"
. prepare_environment.sh
check_status "Environment preparation completed"

# Task 3: Creating a Cloud Storage bucket
print_message "\n📋 TASK 3: CREATING A CLOUD STORAGE BUCKET" "${YELLOW_TEXT}"

print_message "\n🔧 Creating Cloud Storage bucket..." "${CYAN_TEXT}"
gsutil mb gs://$DEVSHELL_PROJECT_ID-media
check_status "Cloud Storage bucket created"

print_message "\n🔧 Setting environment variables..." "${CYAN_TEXT}"
export GCLOUD_BUCKET=$DEVSHELL_PROJECT_ID-media
check_status "Environment variable set"

# Start the application
print_message "\n🚀 Starting the application..." "${CYAN_TEXT}"
npm start

# EDUTECH BARSHA Completion Banner
echo
echo "${GREEN_TEXT}${BOLD_TEXT}╔════════════════════════════════════════════════════════╗${RESET_FORMAT}"
echo "${GREEN_TEXT}${BOLD_TEXT}              🎉 CONGRATULATIONS! 🎉                     ${RESET_FORMAT}"
echo "${GREEN_TEXT}${BOLD_TEXT}          YOUR COMMAND EXECUTED SUCCESSFULLY!           ${RESET_FORMAT}"
echo "${GREEN_TEXT}${BOLD_TEXT}            THANK YOU FOR USING EDUTECH BARSHA!          ${RESET_FORMAT}"
echo "${GREEN_TEXT}${BOLD_TEXT}╚════════════════════════════════════════════════════════╝${RESET_FORMAT}"
echo
echo -e "${RED_TEXT}${BOLD_TEXT}📢 Subscribe to EDUTECH BARSHA:${RESET_FORMAT} ${BLUE_TEXT}${BOLD_TEXT}https://www.youtube.com/@edutechbarsha${RESET_FORMAT}"
