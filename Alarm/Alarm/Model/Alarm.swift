//
//  Alarm.swift
//  Alarm
//
//  Created by Kaleb  Carrizoza on 9/14/20.
//  Copyright © 2020 Kaleb  Carrizoza. All rights reserved.
//

import Foundation

class Alarm: Codable {
    var fireDate: Date
    var name: String
    var enabled: Bool
    var uuid: String
    // to return a string value
    var fireTimeAsString: String {
        let dateFormatter = DateFormatter()
        dateFormatter.timeStyle = .short
        
        return dateFormatter.string(from: fireDate)
    }
    
    init(fireDate: Date, name: String, enabled: Bool, uuid: String = UUID().uuidString) {
        self.fireDate = fireDate
        self.name = name
        self.enabled = enabled
        self.uuid = uuid
      
    }
    
}// end of class

extension Alarm: Equatable {
      static func == (lhs: Alarm, rhs: Alarm)  -> Bool {
          return lhs.uuid == rhs.uuid
      }
      
  }


