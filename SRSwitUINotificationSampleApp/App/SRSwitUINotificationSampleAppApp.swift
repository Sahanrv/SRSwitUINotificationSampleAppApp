//
//  SRSwitUINotificationSampleAppApp.swift
//  SRSwitUINotificationSampleApp
//
//  Created by Sahan Ravindu on 04/03/2024.
//

import SwiftUI
import Firebase

class AppDelegate: NSObject, UIApplicationDelegate {
    func application(_ application: UIApplication,
                     didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey : Any]? = nil) -> Bool {
        
        application.registerForRemoteNotifications()
        FirebaseApp.configure()
        Messaging.messaging().delegate = self
        UNUserNotificationCenter.current().delegate = self
        
        return true
    }
}

extension AppDelegate: notificationDelegates {
    func application(_ application: UIApplication, didRegisterForRemoteNotificationsWithDeviceToken deviceToken: Data) {
        Messaging.messaging().apnsToken = deviceToken
    }
    
    
    func messaging(_ messaging: Messaging, didReceiveRegistrationToken fcmToken: String?) {
        if let fcm = Messaging.messaging().fcmToken {
            #if DEBUG
            print("fcm", fcm)
            #endif
        }
    }
    
    func application(_ application: UIApplication, didFailToRegisterForRemoteNotificationsWithError error: Error) {
        print("Failed to register for remote notifications: \\(error.localizedDescription)")
    }
    
    func userNotificationCenter(_ center: UNUserNotificationCenter, willPresent notification: UNNotification, withCompletionHandler completionHandler: @escaping (UNNotificationPresentationOptions) -> Void) {
        // Handle the notification presentation here
        completionHandler([.banner, .sound, .badge])
    }
    
    func application(_ application: UIApplication, didReceiveRemoteNotification userInfo: [AnyHashable: Any], fetchCompletionHandler completionHandler: @escaping (UIBackgroundFetchResult) -> Void) {
        // Handle the received remote notification here
        
        // Print the notification payload
        print("Received remote notification: \\(userInfo)")
        
        // Process the notification content
        if let aps = userInfo["aps"] as? [String: Any], let _ = aps["alert"] as? String {
            // Extract information from the notification payload
            print("Notification message: \\(alert)")
        }
        
        // Indicate the result of the background fetch to the system
        completionHandler(UIBackgroundFetchResult.newData)
    }
}

@main
struct SRSwitUINotificationSampleAppApp: App {
    
    @UIApplicationDelegateAdaptor(AppDelegate.self) var delegate
    
    var body: some Scene {
        WindowGroup {
            ContentView()
        }
    }
}
