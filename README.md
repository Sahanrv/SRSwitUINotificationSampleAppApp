# SRSwitUINotificationSampleAppApp
This is a sample of integrating Cloud Messaging/Push Notifications into your SwiftUI application

# This application target for iOS 15 upward versions
- If you are targeting iOS 15 replace the notification permission process with the below.

```
// Request notification authorization
        UNUserNotificationCenter.current().requestAuthorization(options: [.alert, .sound, .badge]) { granted, error in
            if granted {
                print("Notification authorization granted")
                // Register for remote notifications
                DispatchQueue.main.async {
                    application.registerForRemoteNotifications()
										UNUserNotificationCenter.current().delegate = self
                }
            } else {
                print("Notification authorization denied")
                // Handle the case where the user denied notification permissions
            }
        }
```
