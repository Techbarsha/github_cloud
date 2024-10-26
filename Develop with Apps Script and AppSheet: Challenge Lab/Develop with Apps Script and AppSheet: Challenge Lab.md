# Develop with Apps Script and AppSheet: Challenge Lab || [ARC126](https://www.cloudskillsboost.google/focuses/66584?parent=catalog) ||

---
### ⚠️ Disclaimer
- **This script and guide are provided for  the educational purposes to help you understand the lab services and boost your career. Before using the script, please open and review it to familiarize yourself with Google Cloud services. Ensure that you follow 'Qwiklabs' terms of service and YouTube’s community guidelines. The goal is to enhance your learning experience, not to bypass it.**
---
# Follow the instructions

# If you consider that the video helped you to complete your lab, so please do like and subscribe [Edutech Barsha](https://www.youtube.com/@edutechbarsha)
## Solution [here](https://youtu.be/Fg3N5NcWKuU)

### Task 1. Create and customize an app

1. After you've logged into **AppSheet**, open the [ATM Maintenance app](https://www.appsheet.com/template/AppDef?appName=ATMMaintenance-925818016) in same Incognito tab.

2. In the left navigation menu, click **Copy app**.

3. In the **Copy app** form, for **App name**, type or paste the following and leave the remaining settings as their defaults. ```ATM Maintenance Tracker```

4. Click **Copy app**.

### Task 2. Add an automation to an AppSheet app

- * Go to **My Drive** from [here](https://drive.google.com/drive/my-drive)

- * Download **File** from [here](https://docs.google.com/spreadsheets/d/1lP_jWnn5TsZoNcWY9JdSBTdI1a4MisaM/export?gid=1359178156&format=xlsx)

### Task 3. Create and publish an Apps Script chat bot

1. Create a new **Apps Script Chat App** from [here](https://script.google.com/home/projects/create?template=hangoutsChat)

- * Now replace the following in **Code.gs** file:

```
/**
 * Responds to a MESSAGE event in Google Chat.
 *
 * @param {Object} event the event object from Google Chat
 */
function onMessage(event) {
  var name = "";

  if (event.space.type == "DM") {
    name = "You";
  } else {
    name = event.user.displayName;
  }
  var message = name + " said \"" + event.message.text + "\"";

  return { "text": message };
}

/**
 * Responds to an ADDED_TO_SPACE event in Google Chat.
 *
 * @param {Object} event the event object from Google Chat
 */
function onAddToSpace(event) {
  var message = "";

  if (event.space.singleUserBotDm) {
    message = "Thank you for adding me to a DM, " + event.user.displayName + "!";
  } else {
    message = "Thank you for adding me to " +
        (event.space.displayName ? event.space.displayName : "this chat");
  }

  if (event.message) {
    // Bot added through @mention.
    message = message + " and you said: \"" + event.message.text + "\"";
  }
  console.log('Helper Bot added in ', event.space.name);
  return { "text": message };
}

/**
 * Responds to a REMOVED_FROM_SPACE event in Google Chat.
 *
 * @param {Object} event the event object from Google Chat
 */
function onRemoveFromSpace(event) {
  console.info("Bot removed from ",
      (event.space.name ? event.space.name : "this chat"));
}
```

* Go to **OAuth consent screen** from [here](https://console.cloud.google.com/apis/credentials/consent?)

* Now Paste The Following

|Field  | Value |
|   :---:   | :----: |
| **App name**  | Helper Bot|
| **User support email** | Select the email ID **username** from the drop-down. |
| **Developer contact information**	| **username** |

* Go to **Google Chat API Configuration** from [here](https://console.cloud.google.com/apis/api/chat.googleapis.com/hangouts-chat?)

|Field  | Value |
|   :---:   | :----: |
| App name | Helper Bot |
| Avatar URL | https://goo.gl/kv2ENA |
| Description |	Helper chat bot |
| Functionality | Select **Receive 1:1 messages and Join spaces and group conversations** |
| Connection settings | Check **Apps Script project**, and then paste the **Head Deployment ID** for the test deployment into the Deployment ID field**
| Visibility | **username** |
| App Status | LIVE – available to users |

* Go and Test Your **Helper Bot** [here](https://mail.google.com/chat/u/0/#chat/home)

## *NOW FOLLOW VIDEO'S INSTRUCTIONS*

## *Create a bar chart of the `top 3 event types based on the highest number of users`*

## *Save your bar chart to a new dashboard named `User Events`*


### Congratulations 🎉 for completing the Lab !😄

##### *You Have Successfully Demonstrated Your Skills And Determination.*

#### *Well done!*
