//
//  Reminder.swift
//  Reminders
//
//  Created by scr1ptk1ddy on 2020-02-05.
//  Copyright © 2020 gbc. All rights reserved.
//

import Foundation
import UIKit

class Reminder: NSObject, NSCoding {
    func encode(with coder: NSCoder) {
        return
    }
    

    
    // Properties
    var notification: UNUserNotificationCenter;
    var name: String = ""
    var time: NSDate
    
    // Archive Paths for Persistent Data
     static let DocumentsDirectory = FileManager().urls(for: .documentDirectory, in: .userDomainMask).first!
    static let ArchiveURL = DocumentsDirectory.appendingPathComponent("reminders")

    // enum for property types
    struct PropertyKey {
        static let nameKey = "name"
        static let timeKey = "time"
        static let notificationKey = "notification"
    }
    
    // Initializer
    init(name: String, time: NSDate, notification: UNUserNotificationCenter) {
        // set properties
        self.name = name
        self.time = time
        self.notification = notification
        
        super.init()
    }
    
    // Destructor
    deinit {
        // cancel notification
        UIApplication.shared.cancelLocalNotification(UILocalNotification(notification))
        
        
    }
    
    // NSCoding
    
    func encodeWithCoder(aCoder: NSCoder) {
        aCoder.encodeObject(name, forKey: PropertyKey.nameKey)
        aCoder.encodeObject(time, forKey: PropertyKey.timeKey)
        aCoder.encodeObject(notification, forKey: PropertyKey.notificationKey)
    }
    
    required convenience init(coder aDecoder: NSCoder) {
        let name = aDecoder.decodeObjectForKey(PropertyKey.nameKey) as! String
        
        // Because photo is an optional property of Meal, use conditional cast.
        let time = aDecoder.decodeObjectForKey(PropertyKey.timeKey) as! NSDate
        
        let notification = aDecoder.decodeObjectForKey(PropertyKey.notificationKey) as! UILocalNotification
        
        // Must call designated initializer.
        self.init(name: name, time: time, notification: notification)
    }
}
