//
//  ScreenShareAppApp.swift
//  ScreenShareApp
//
//  Created by Rajesab N Y on 07/08/24.
//

import SwiftUI
import UserNotifications

@main
struct ScreenShareAppApp: App {
    @UIApplicationDelegateAdaptor(AppDelegate.self) var appDelegate
    
    var body: some Scene {
        WindowGroup {
            ContentView()
        }
    }
}

class AppDelegate: NSObject, UIApplicationDelegate, UNUserNotificationCenterDelegate {
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey : Any]? = nil) -> Bool {
        UNUserNotificationCenter.current().delegate = self
        return true
    }
    
    func application(_ application: UIApplication, didRegisterForRemoteNotificationsWithDeviceToken deviceToken: Data) {
        let tokenParts = deviceToken.map { data in String(format: "%02.2hhx", data) }
        let token = tokenParts.joined()
        print("Device Token: \(token)")
    }
    
    func application(_ application: UIApplication, didFailToRegisterForRemoteNotificationsWithError error: Error) {
        print("Failed to register for remote notifications: \(error)")
    }
    
    func userNotificationCenter(_ center: UNUserNotificationCenter, willPresent notification: UNNotification, withCompletionHandler completionHandler: @escaping (UNNotificationPresentationOptions) -> Void) {
        completionHandler([.alert, .sound])
    }
    
    func userNotificationCenter(_ center: UNUserNotificationCenter, didReceive response: UNNotificationResponse, withCompletionHandler completionHandler: @escaping () -> Void) {
        let userInfo = response.notification.request.content.userInfo
        
        if let roomCode = userInfo["room_code"] as? String,
           let aps = userInfo["aps"] as? [String: Any],
           let alert = aps["alert"] as? [String: String],
           let title = alert["title"],
           let subtitle = alert["subtitle"],
           let body = alert["body"] {
            
            DispatchQueue.main.async {
                if let windowScene = UIApplication.shared.connectedScenes.first as? UIWindowScene,
                   let window = windowScene.windows.first,
                   let rootViewController = window.rootViewController,
                   let contentView = rootViewController.view.subviews.first(where: { $0 is ContentView }) as? ContentView {
                    contentView.handlePushNotification(roomCode: roomCode, title: title, subtitle: subtitle, body: body)
                }
            }
        }
        
        completionHandler()
    }
}
