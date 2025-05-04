BLACK=`tput setaf 0`
RED=`tput setaf 1`
GREEN=`tput setaf 2`
YELLOW=`tput setaf 3`
BLUE=`tput setaf 4`
MAGENTA=`tput setaf 5`
CYAN=`tput setaf 6`
WHITE=`tput setaf 7`

BG_BLACK=`tput setab 0`
BG_RED=`tput setab 1`
BG_GREEN=`tput setab 2`
BG_YELLOW=`tput setab 3`
BG_BLUE=`tput setab 4`
BG_MAGENTA=`tput setab 5`
BG_CYAN=`tput setab 6`
BG_WHITE=`tput setab 7`

BOLD=`tput bold`
RESET=`tput sgr0`

# Pick random colors
RANDOM_TEXT_COLOR=${TEXT_COLORS[$RANDOM % ${#TEXT_COLORS[@]}]}
RANDOM_BG_COLOR=${BG_COLORS[$RANDOM % ${#BG_COLORS[@]}]}

# Display Welcome Banner
echo "${RANDOM_BG_COLOR}${RANDOM_TEXT_COLOR}${BOLD}######################################################################${RESET}"
echo "${RANDOM_BG_COLOR}${RANDOM_TEXT_COLOR}${BOLD}#                                                                    #${RESET}"
echo "${RANDOM_BG_COLOR}${RANDOM_TEXT_COLOR}${BOLD}#             WELCOME TO EDUTECH BARSHA                              #${RESET}"
echo "${RANDOM_BG_COLOR}${RANDOM_TEXT_COLOR}${BOLD}#                                                                    #${RESET}"
echo "${RANDOM_BG_COLOR}${RANDOM_TEXT_COLOR}${BOLD}######################################################################${RESET}"

#----------------------------------------------------start--------------------------------------------------#

echo "${YELLOW}${BOLD}Starting${RESET}" "${GREEN}${BOLD}Execution!!${RESET}"

gsutil mb gs://$DEVSHELL_PROJECT_ID

gsutil cp gs://sureskills-ql/challenge-labs/ch01-startup-script/install-web.sh gs://$DEVSHELL_PROJECT_ID

gcloud compute instances create quickgcplab --project=$DEVSHELL_PROJECT_ID --zone=$ZONE --machine-type=n1-standard-1 --tags=http-server --metadata startup-script-url=gs://$DEVSHELL_PROJECT_ID/install-web.sh

gcloud compute firewall-rules create allow-http \
    --allow=tcp:80 \
    --description="awesome lab" \
    --direction=INGRESS \
    --target-tags=http-server

echo "${RED}${BOLD}Congratulations🤩${RESET}" "${WHITE}${BOLD}for${RESET}" "${GREEN}${BOLD}Completing the Lab🥳 !!!${RESET}"

#-----------------------------------------------------end----------------------------------------------------------#
