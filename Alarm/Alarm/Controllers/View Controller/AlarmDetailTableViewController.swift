//
//  AlarmDetailTableViewController.swift
//  Alarm
//
//  Created by Kaleb  Carrizoza on 9/14/20.
//  Copyright © 2020 Kaleb  Carrizoza. All rights reserved.
//

import UIKit

class AlarmDetailTableViewController: UITableViewController {
    //MARK: - Outlets
    @IBOutlet weak var alarmDatePicker: UIDatePicker!
    @IBOutlet weak var nameTextField: UITextField!
    @IBOutlet weak var enableButton: UIButton!
    
    //MARK: - Properties
    var alarm: Alarm? {
        didSet {
            loadViewIfNeeded()
            updateViews()
        }
    }
    
       
       var alarmIsOn: Bool = true
    
    //MARK: - lifeCycle
    override func viewDidLoad() {
        super.viewDidLoad()
        updateViews()

    }
    
    //MARK: - Actions
    @IBAction func enableButtonTapped(_ sender: Any) {
        alarmIsOn.toggle()
        
        if alarmIsOn {
            enableButton.setTitle("On", for: .normal)
            enableButton.backgroundColor = .cyan
        }else {
            enableButton.setTitle("Off", for: .normal)
            enableButton.backgroundColor = .red
        }
        
        if let alarm = alarm {
            AlarmController.shared.toggleEnable(for: alarm)
        }
    }
    
    @IBAction func saveButtonTapped(_ sender: Any) {
        guard let name = nameTextField.text, !name.isEmpty else {return}
        if let alarm = alarm {
            AlarmController.shared.update(alarm: alarm, fireDate: alarmDatePicker.date, name: name, enabled: alarmIsOn)
        } else {
            let alarm = AlarmController.shared.addAlarm(fireDate: alarmDatePicker.date, name: name, enabled: alarmIsOn)
            print(alarm)
            
        }
        navigationController?.popViewController(animated: true)
    }
    
  private func updateViews() {
    guard let alarm = alarm else {return}
        alarmDatePicker.date = alarm.fireDate
        nameTextField.text = alarm.name
    if alarm.enabled == true {
        alarmIsOn = true
        enableButton.setTitle("On", for: .normal)
        enableButton.backgroundColor = .green
    }else {
        alarmIsOn = false
        enableButton.setTitle("Off", for: .normal)
        enableButton.backgroundColor = .gray
    }
}
   
    
    
 


}//end of class
