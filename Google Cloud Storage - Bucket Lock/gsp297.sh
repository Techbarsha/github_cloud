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
# Array of color codes excluding black and white
TEXT_COLORS=($RED $GREEN $YELLOW $BLUE $MAGENTA $CYAN)
BG_COLORS=($BG_RED $BG_GREEN $BG_YELLOW $BG_BLUE $BG_MAGENTA $BG_CYAN)

# Pick random colors
RANDOM_TEXT_COLOR=${TEXT_COLORS[$RANDOM % ${#TEXT_COLORS[@]}]}
RANDOM_BG_COLOR=${BG_COLORS[$RANDOM % ${#BG_COLORS[@]}]}

# Display Welcome Banner
echo "${RANDOM_BG_COLOR}${RANDOM_TEXT_COLOR}${BOLD}######################################################################${RESET}"
echo "${RANDOM_BG_COLOR}${RANDOM_TEXT_COLOR}${BOLD}#                                                                    #${RESET}"
echo "${RANDOM_BG_COLOR}${RANDOM_TEXT_COLOR}${BOLD}#             WELCOME TO EDUTECH BARSHA                              #${RESET}"
echo "${RANDOM_BG_COLOR}${RANDOM_TEXT_COLOR}${BOLD}#                                                                    #${RESET}"
echo "${RANDOM_BG_COLOR}${RANDOM_TEXT_COLOR}${BOLD}######################################################################${RESET}"
echo

# Welcome message
echo "${BLUE_TEXT}${BOLD_TEXT}=======================================${RESET_FORMAT}"
echo "${BLUE_TEXT}${BOLD_TEXT}         INITIATING EXECUTION...  ${RESET_FORMAT}"
echo "${BLUE_TEXT}${BOLD_TEXT}=======================================${RESET_FORMAT}"
echo

# Prompt for region if not set
if [ -z "$region" ]; then
  read -p "${MAGENTA_TEXT}${BOLD_TEXT}Enter REGION: ${RESET_FORMAT}" region
  export region
  echo "${GREEN_TEXT}${BOLD_TEXT}Region set to: $region${RESET_FORMAT}"
fi

export BUCKET=$(gcloud config get-value project)

# Instructions before creating bucket
echo
echo "${YELLOW_TEXT}${BOLD_TEXT}INSTRUCTIONS:${RESET_FORMAT}"
echo "${CYAN_TEXT}${BOLD_TEXT}Creating a bucket named 'gs://$BUCKET'.${RESET_FORMAT}"
echo
gsutil mb -l $region "gs://$BUCKET"
sleep 10

echo "${MAGENTA_TEXT}${BOLD_TEXT}Setting retention policy...${RESET_FORMAT}"
gsutil retention set 10s "gs://$BUCKET"
gsutil retention get "gs://$BUCKET"


echo "${MAGENTA_TEXT}${BOLD_TEXT}Copying dummy_transactions...${RESET_FORMAT}"
gsutil cp gs://spls/gsp297/dummy_transactions "gs://$BUCKET/"
gsutil ls -L "gs://$BUCKET/dummy_transactions"
sleep 10

echo "${MAGENTA_TEXT}${BOLD_TEXT}Locking retention policy...${RESET_FORMAT}"
gsutil retention lock "gs://$BUCKET/"


echo "${MAGENTA_TEXT}${BOLD_TEXT}Setting temporary hold...${RESET_FORMAT}"
gsutil retention temp set "gs://$BUCKET/dummy_transactions"


echo "${MAGENTA_TEXT}${BOLD_TEXT}Removing dummy_transactions...${RESET_FORMAT}"
gsutil rm "gs://$BUCKET/dummy_transactions"


echo "${MAGENTA_TEXT}${BOLD_TEXT}Releasing temporary hold...${RESET_FORMAT}"
gsutil retention temp release "gs://$BUCKET/dummy_transactions"


echo "${MAGENTA_TEXT}${BOLD_TEXT}Setting event-based hold as default...${RESET_FORMAT}"
gsutil retention event-default set "gs://$BUCKET/"


echo "${MAGENTA_TEXT}${BOLD_TEXT}Copying dummy_loan...${RESET_FORMAT}"
gsutil cp gs://spls/gsp297/dummy_loan "gs://$BUCKET/"
gsutil ls -L "gs://$BUCKET/dummy_loan"


echo "${MAGENTA_TEXT}${BOLD_TEXT}Releasing event-based hold...${RESET_FORMAT}"
gsutil retention event release "gs://$BUCKET/dummy_loan"
gsutil ls -L "gs://$BUCKET/dummy_loan"

# Pick another random color for the final message
FINAL_TEXT_COLOR=${TEXT_COLORS[$RANDOM % ${#TEXT_COLORS[@]}]}
FINAL_BG_COLOR=${BG_COLORS[$RANDOM % ${#BG_COLORS[@]}]}

# Display Congratulations Message
echo "${FINAL_BG_COLOR}${FINAL_TEXT_COLOR}${BOLD}######################################################################${RESET}"
echo "${FINAL_BG_COLOR}${FINAL_TEXT_COLOR}${BOLD}#                                                                    #${RESET}"
echo "${FINAL_BG_COLOR}${FINAL_TEXT_COLOR}${BOLD}#       🎉🎉 CONGRATULATIONS FOR COMPLETING THE LAB! 🎉🎉        #${RESET}"
echo "${FINAL_BG_COLOR}${FINAL_TEXT_COLOR}${BOLD}#                                                                    #${RESET}"
echo "${FINAL_BG_COLOR}${FINAL_TEXT_COLOR}${BOLD}######################################################################${RESET}"

# Subscribe message with random colors
SUBSCRIBE_TEXT_COLOR=${TEXT_COLORS[$RANDOM % ${#TEXT_COLORS[@]}]}
SUBSCRIBE_BG_COLOR=${BG_COLORS[$RANDOM % ${#BG_COLORS[@]}]}

echo "${SUBSCRIBE_BG_COLOR}${SUBSCRIBE_TEXT_COLOR}${BOLD}📢 SUBSCRIBE TO OUR CHANNEL: https://www.youtube.com/@edutechbarsha ${RESET}"
