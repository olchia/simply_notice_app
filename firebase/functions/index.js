const functions = require("firebase-functions");
const admin = require("firebase-admin");

admin.initializeApp();

exports.saveUserFcmToken = functions
  .region("us-central1")
  .https.onCall(async (data, context) => {
    if (!context.auth) {
      throw new functions.https.HttpsError(
        "unauthenticated",
        "User must be authenticated to save FCM token."
      );
    }

    const uid = context.auth.uid;
    const token = data && data.token;
    const platform = data && data.platform;
    const permissionStatus = data && data.permissionStatus;

    if (!token || typeof token !== "string") {
      throw new functions.https.HttpsError(
        "invalid-argument",
        "FCM token is required."
      );
    }

    const userRef = admin.firestore().collection("user_info").doc(uid);

    await userRef.set(
      {
        fcm_token: token,
        fcm_tokens: admin.firestore.FieldValue.arrayUnion(token),
        fcm_platform: platform || "unknown",
        notifications_permission_status: permissionStatus || "unknown",
        notifications_enabled: true,
        checkin_reminder_enabled: true,
        checkin_reminder_time: "19:00",
        push_setup_status: "ready",
        fcm_token_updated_at: admin.firestore.FieldValue.serverTimestamp(),
      },
      { merge: true }
    );

    return {
      ok: true,
      message: "FCM token saved.",
    };
  });
