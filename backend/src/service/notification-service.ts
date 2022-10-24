import * as OneSignal from "onesignal-node";
import { CreateNotificationBody } from "onesignal-node/lib/types";

export type Notification = {
  title: string;
  body: string;
  userIds: number[];
};

const NotificationClient = new OneSignal.Client(
  process.env.ONE_SIGNAL_APP_ID,
  process.env.ONE_SIGNAL_KEY
);

const sendNotification = async (notification: Notification) => {
  try {
    const body: CreateNotificationBody = {
      headings: {
        en: notification.title,
      },
      include_external_user_ids: notification.userIds.map((id) =>
        id.toString()
      ),
    };

    if (notification.body) body.contents = { en: notification.body };

    const response = await NotificationClient.createNotification(body);

    if (response.body?.errors) {
      console.log(response.body.errors);
      throw new Error("There was an error while creating notification");
    }

    return response.body;
  } catch (e) {
    console.error(e);
  }
};

export default sendNotification;
