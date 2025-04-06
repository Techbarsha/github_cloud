# Google Chat Bot - Apps Script || [GSP250](https://www.cloudskillsboost.google/focuses/32756?parent=catalog) ||
---
### ⚠️ Disclaimer
- **This script and guide are provided for  the educational purposes to help you understand the lab services and boost your career. Before using the script, please open and review it to familiarize yourself with Google Cloud services. Ensure that you follow 'Qwiklabs' terms of service and YouTube’s community guidelines. The goal is to enhance your learning experience, not to bypass it.**

<div align="center" style="padding: 5px;">
  <h3>📱 Join the EduTech Barsha Community</h3>
  
  <a href="https://whatsapp.com/channel/0029Va5J2r5Jf05cKT1pZh31">
    <img src="https://img.shields.io/badge/Join_WhatsApp-25D366?style=for-the-badge&logo=whatsapp&logoColor=white" alt="Join WhatsApp">
  </a>
  &nbsp;
  <a href="https://t.me/edutechbarsha">
    <img src="https://img.shields.io/badge/Join_Telegram-229ED9?style=for-the-badge&logo=telegram&logoColor=white" alt="Join Telegram">
  </a>
  &nbsp;
  <a href="https://www.youtube.com/@edutechbarsha?sub_confirmation=1">
    <img src="https://img.shields.io/badge/Subscribe-EduTech%20Barsha-FF0000?style=for-the-badge&logo=youtube&logoColor=white" alt="YouTube Channel">
  </a>
</div>

# Follow the instructions:
### Solution [here](https://youtu.be/qmEAyQ4pluI)

## 📝 Task 1: Create a chat app from a template

1.  🖱️ Click this [Google Apps Script](https://script.google.com/home/projects/create?template=hangoutsChat) link to open the Google Apps Script online editor.

2.  🖱️ Click **Untitled project** (the current name).

3.  ✏️ In the **Edit project name** dialog, rename the project to **`Attendance Bot`**, and then click **Rename**.

4.  📄 Copy and replace the *entire content* of the `Code.gs` file with the following JavaScript code:

    ```javascript
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
      console.log('Attendance Bot added in ', event.space.name);
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

5.  💾 Click **Save** (the floppy disk icon) to save the changes to the `Code.gs` file.

---

## 🚀 Task 2: Publish the bot

➡️ **Navigate to OAuth Consent Screen:**

*   Go to the **OAuth consent screen** configuration page using this link: [OAuth Consent Screen](https://console.cloud.google.com/apis/credentials/consent?)

1.  👤 Set **User Type** to **`Internal`**, and click **Create**.

2.  ⚙️ On the next page (the **OAuth consent** screen), configure the following settings:

    | Field                         | Value                                  |
    | :---------------------------- | :------------------------------------- |
    | **App name**                  | `Attendance Bot`                       |
    | **User support email**        | Select your email ID from the dropdown |
    | **Developer contact information** | Enter your user email address          |

➡️ **Navigate to Google Chat API Configuration:**

*   Go to the **Google Chat API Configuration Page** using this link: [Google Chat API Config](https://console.cloud.google.com/apis/api/chat.googleapis.com/hangouts-chat?)

3.  ⚙️ In the **Configuration** dialog, set the fields with the following values:

    | Field                     | Value                                                              |
    | :------------------------ | :----------------------------------------------------------------- |
    | **App name**              | `Attendance Bot`                                                   |
    | **Avatar URL**            | `https://goo.gl/kv2ENA`                                            |
    | **Description**           | `Apps Script lab bot`                                              |
    | **Functionality**         | Select **Receive 1:1 messages** *and* **Join spaces and group conversations** |
    | **Connection settings**   | Check **Apps Script project** and paste the *Head Deployment ID* into the **Deployment ID** field |
    | **Visibility**            | Enter your user email address                                      |

4.  ✅ After the changes are saved, scroll to the top of the **Configuration** dialog and update the **App Status** to `LIVE – available to users`.

5.  💬 Click the [Google Chat](https://chat.google.com/) link to open Google Chat in a new tab.

6.  ➕ In the **Chat** section on the left, select **Start a chat** (or the `+` icon).

7.  🔍 Search for **`Attendance bot`**.

8.  🖱️ From the search results, select the **Attendance Bot** (Apps Script lab bot) that you just configured, and click **Start chat**.

---

## 🃏 Task 3: Define a card-formatted response

1.  📄 Return to the Apps Script editor containing your `Code.gs` file. Copy and replace the *entire content* with the following updated code:

    ```javascript
    var DEFAULT_IMAGE_URL = 'https://goo.gl/bMqzYS';
    var HEADER = {
      header: {
        title : 'Attendance Bot',
        subtitle : 'Log your vacation time',
        imageUrl : DEFAULT_IMAGE_URL
      }
    };

    /**
     * Creates a card-formatted response.
     * @param {object} widgets the UI components to send
     * @return {object} JSON-formatted response
     */
    function createCardResponse(widgets) {
      return {
        cards: [HEADER, {
          sections: [{
            widgets: widgets
          }]
        }]
      };
    }

    /**
     * Responds to a MESSAGE event triggered
     * in Google Chat.
     *
     * @param event the event object from Google Chat
     * @return JSON-formatted response
     */
    function onMessage(event) {
      var userMessage = event.message.text;

      var widgets = [{
        "textParagraph": {
          "text": "You said: " + userMessage
        }
      }];

      console.log('You said:', userMessage);

      return createCardResponse(widgets);
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
      console.log('Attendance Bot added in ', event.space.name);
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

2.  💾 Click **Save** to save the updated `Code.gs` file.

3.  💬 Go back to your Google Chat DM with the **Attendance Bot**. Type any message, for example: **`Hello`** and press Enter. You should see a card response now.

---

## 🖱️ Task 4: React to button clicks in cards

1.  📄 Return to the Apps Script editor again. Copy and replace the *entire content* of `Code.gs` one more time with the following final version of the code:

    ```javascript
    var DEFAULT_IMAGE_URL = 'https://goo.gl/bMqzYS';
    var HEADER = {
      header: {
        title : 'Attendance Bot',
        subtitle : 'Log your vacation time',
        imageUrl : DEFAULT_IMAGE_URL
      }
    };

    /**
     * Creates a card-formatted response.
     * @param {object} widgets the UI components to send
     * @return {object} JSON-formatted response
     */
    function createCardResponse(widgets) {
      return {
        cards: [HEADER, {
          sections: [{
            widgets: widgets
          }]
        }]
      };
    }

    var REASON = {
      SICK: 'Out sick',
      OTHER: 'Out of office'
    };
    /**
     * Responds to a MESSAGE event triggered in Google Chat.
     * @param {object} event the event object from Google Chat
     * @return {object} JSON-formatted response
     */
    function onMessage(event) {
      console.info(event);
      var reason = REASON.OTHER;
      var name = event.user.displayName;
      var userMessage = event.message.text;

      // If the user said that they were 'sick', adjust the image in the
      // header sent in response.
      if (userMessage.toLowerCase().indexOf('sick') > -1) {
        // Hospital material icon
        HEADER.header.imageUrl = 'https://goo.gl/mnZ37b';
        reason = REASON.SICK;
      } else if (userMessage.toLowerCase().indexOf('vacation') > -1) {
        // Spa material icon
        HEADER.header.imageUrl = 'https://goo.gl/EbgHuc';
      } else {
         // Reset to default image if keywords not found
         HEADER.header.imageUrl = DEFAULT_IMAGE_URL;
      }


      var widgets = [{
        textParagraph: {
          text: 'Hello, ' + name + '.<br>Are you taking time off today?'
        }
      }, {
        buttons: [{
          textButton: {
            text: 'Set vacation in Gmail',
            onClick: {
              action: {
                actionMethodName: 'turnOnAutoResponder',
                parameters: [{
                  key: 'reason',
                  value: reason
                }]
              }
            }
          }
        }, {
          textButton: {
            text: 'Block out day in Calendar',
            onClick: {
              action: {
                actionMethodName: 'blockOutCalendar',
                parameters: [{
                  key: 'reason',
                  value: reason
                }]
              }
            }
          }
        }]
      }];
      return createCardResponse(widgets);
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
      console.log('Attendance Bot added in ', event.space.name);
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

    /**
     * Responds to a CARD_CLICKED event triggered in Google Chat.
     * @param {object} event the event object from Google Chat
     * @return {object} JSON-formatted response
     * @see https://developers.google.com/chat/reference/message-formats/events
     */
    function onCardClick(event) {
      console.info(event);
      var message = '';
      var reason = event.action.parameters[0].value;
      if (event.action.actionMethodName == 'turnOnAutoResponder') {
        turnOnAutoResponder(reason);
        message = 'Turned on vacation settings in Gmail.';
      } else if (event.action.actionMethodName == 'blockOutCalendar') {
        blockOutCalendar(reason);
        message = 'Blocked out your calendar for the day.';
      } else {
        message = "I'm sorry; I'm not sure which button you clicked.";
      }
      return { text: message };
    }

    var ONE_DAY_MILLIS = 24 * 60 * 60 * 1000;
    /**
     * Turns on the user's vacation response for today in Gmail.
     * Requires the Gmail API advanced service.
     * @param {string} reason the reason for vacation, either REASON.SICK or REASON.OTHER
     */
    function turnOnAutoResponder(reason) {
      var currentTime = (new Date()).getTime();
      // Ensure Gmail API service is enabled in Apps Script
      try {
        Gmail.Users.Settings.updateVacation({
          enableAutoReply: true,
          responseSubject: reason,
          responseBodyHtml: "I'm out of the office today; will be back on the next business day.<br><br><i>Created by Attendance Bot!</i>",
          restrictToContacts: true,
          restrictToDomain: true,
          startTime: currentTime,
          endTime: currentTime + ONE_DAY_MILLIS
        }, 'me');
         console.log('Gmail vacation responder activated for:', reason);
      } catch (e) {
        console.error('Error activating Gmail vacation responder:', e);
        // Potentially return an error message to the user via Chat?
      }
    }

    /**
     * Places an all-day event on the user's primary Calendar.
     * Uses the default CalendarApp service.
     * @param {string} reason the reason for vacation, either REASON.SICK or REASON.OTHER
     */
    function blockOutCalendar(reason) {
       try {
        CalendarApp.createAllDayEvent(reason, new Date(), new Date(Date.now() + ONE_DAY_MILLIS));
        console.log('Calendar blocked out for:', reason);
      } catch (e) {
        console.error('Error blocking out calendar:', e);
         // Potentially return an error message to the user via Chat?
      }
    }
    ```

2.  💾 Click **Save** to save the final `Code.gs` file.

3.  ⚙️ **Add Gmail API Service:**
    *   In the Apps Script editor's left-side menu, locate the **Services** section.
    *   Click the **`+`** icon next to **Services** to **Add a service**.
    *   Scroll or search for **`Gmail API`** in the list, select it.
    *   Click the **Add** button. *(This grants the script permission to interact with Gmail)*.

4.  💬 Go back to your Google Chat DM with the **Attendance Bot**. Type the message: **`I'm sick`** and press Enter.
    *   You should see a card with buttons. Click one of the buttons.
    *   You might be prompted to authorize the script the first time you click a button that interacts with Gmail or Calendar. Review the permissions and click **Allow**.

---

### Congratulations 🎉 for completing the Lab !😄

##### *You Have Successfully Demonstrated Your Skills And Determination.*

#### *Well done!*

# Thanks For Watching:)
