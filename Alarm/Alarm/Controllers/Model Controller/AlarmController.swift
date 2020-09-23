//
//  AlarmController.swift
//  Alarm
//
//  Created by Kaleb  Carrizoza on 9/14/20.
//  Copyright © 2020 Kaleb  Carrizoza. All rights reserved.
//

import Foundation
import UserNotifications

protocol AlarmScheduler: AnyObject {
    func schedulerUserNotifications(for alarm: Alarm)
    func cancelUserNotifications(for alarm: Alarm)
}

extension AlarmScheduler {
    func schedulerUserNotifications(for alarm: Alarm) {
        let content = UNMutableNotificationContent()
        content.title = alarm.name
        content.body = "Body"
        content.badge  = 1
        content.sound = UNNotificationSound.default
        
        let calendar = Calendar.current
        var dateComponents = DateComponents()
        dateComponents.hour = calendar.component(.hour, from: alarm.fireDate)
        dateComponents.minute = calendar.component(.minute, from: alarm.fireDate)
        dateComponents.second = 0
        
        let trigger = UNCalendarNotificationTrigger(dateMatching: dateComponents, repeats: true)
     
        let request = UNNotificationRequest.init(identifier: alarm.uuid, content: content, trigger: trigger)
        UNUserNotificationCenter.current().add(request) { (_) in
            print("user ask to get local notification")
        }
        
    }//end of extension
    
    func cancelUserNotifications(for alarm: Alarm) {
        UNUserNotificationCenter.current().removePendingNotificationRequests(withIdentifiers: [alarm.uuid])
    }
    
}

class AlarmController {
    
    static let shared = AlarmController ()
    
     var alarms: [Alarm] = []
    
  
    
    func addAlarm(fireDate: Date, name: String, enabled: Bool) -> Alarm {
        let newAlarm = Alarm(fireDate: Date(), name: name, enabled: enabled)
        alarms.append(newAlarm)
        saveToPersistence()
        
     
    
        return newAlarm
    }
    
    func update(alarm: Alarm, fireDate: Date, name: String, enabled: Bool) {
        alarm.fireDate = fireDate
        alarm.name = name
        alarm.enabled = enabled
        saveToPersistence()
       
    }
    
    func delete(alarm: Alarm) {
        guard let index = alarms.firstIndex(of: alarm) else {return}
        alarms.remove(at: index)
        saveToPersistence()
    }
    
    func toggleEnable(for alarm: Alarm) {
        alarm.enabled = !alarm.enabled
        
        if alarm.enabled {
           schedulerUserNotifications(for: alarm)
        }else {
            cancelUserNotifications(for: alarm)
        }
        saveToPersistence()
    }
    
    //MARK: - private functions
    private  func fileURl() -> URL{
        let urls = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)
        let fileURl = urls[0].appendingPathComponent("alarm.Json")
        return fileURl
    }
    
    func saveToPersistence() {
        let jsonEncoder = JSONEncoder()
        do {
            let jsonNotes = try jsonEncoder.encode(alarms)
            try jsonNotes.write(to: fileURl())
        } catch {
            print(error.localizedDescription)
        }
        
    }
    
    func loadFromPersistence() {
        let jsonDecoder = JSONDecoder()
        do {
            let jsonData = try Data(contentsOf: fileURl())
            let decodedNotes = try jsonDecoder.decode([Alarm].self, from: jsonData)
            alarms = decodedNotes
        }catch{
            print(error.localizedDescription)
        }
    }
    
}//end of class

extension AlarmController: AlarmScheduler {
    
}






