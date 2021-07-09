import * as functions from "firebase-functions";
import * as admin from "firebase-admin";

admin.initializeApp();

export const newMessageNotification = functions.firestore
    .document("chat/{message}")
    .onCreate((change, _) => {
      if (!change.data().username || !change.data().text) {
        console.log("Username or text empty");
        return;
      }
      const message: admin.messaging.MessagingPayload = {
        notification: {
          title: change.data().username,
          body: change.data().text,
        },
      };
      return admin.messaging().sendToTopic("chat", message);
    });
