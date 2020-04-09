//
//  ViewController.swift
//  LocalNotificationsTreino
//
//  Created by Victor Falcetta do Nascimento on 09/04/20.
//  Copyright © 2020 Victor Falcetta do Nascimento. All rights reserved.
//

import UIKit
import UserNotifications

class ViewController: UIViewController {
    let userNotificationCenter = UNUserNotificationCenter.current()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.requestNotificationAuthorization()
        self.sendNotification()
        // Do any additional setup after loading the view.
    }
    
    func requestNotificationAuthorization() {
        let authOptions = UNAuthorizationOptions.init(arrayLiteral: .alert, .badge, .sound)
        self.userNotificationCenter.requestAuthorization(options: authOptions) { (success, error) in
            if let error = error {
                print("Error: ", error)
            }
        }
    }
    
    func sendNotification() {
        let notificationContent = UNMutableNotificationContent()
        
        notificationContent.title = "Gordon Freeman..."
        notificationContent.body = "Rise and shine, Mr. Freeman, Rise and shine..."
        notificationContent.badge = NSNumber(value: 3)
        
        if let url = Bundle.main.url(forResource: "hl2", withExtension: "png") {
            if let attachment = try? UNNotificationAttachment(identifier: "hl2", url: url, options: nil) {
                notificationContent.attachments = [attachment]
            }
        }
        
        let trigger = UNTimeIntervalNotificationTrigger(timeInterval: 10, repeats: false)
        
        let request = UNNotificationRequest(identifier: "gordonNotification", content: notificationContent, trigger: trigger)
        
        userNotificationCenter.add(request) { (error) in
            if let error = error {
                print("Notification Error: ", error)
            }
        }
    }


}

