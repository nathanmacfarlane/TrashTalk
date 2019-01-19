const functions = require('firebase-functions');
const admin = require('firebase-admin');
admin.initializeApp(functions.config().firebase);

exports.userNotification = functions.firestore.document('notifications/{id}').onCreate((snap, context) => {

  const notification = snap.data();

  const payload = {
    notification: {
      title: notification.title
    }
  };

  admin.messaging().sendToTopic("trashFeed", payload).then((response) => {
    console.log('Notification sent successfully:', response);
  }).catch((error) => {
    console.log('Notification sent failed:', error);
  });

  return 0;
});
