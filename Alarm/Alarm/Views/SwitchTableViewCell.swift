//
//  SwitchTableViewCell.swift
//  Alarm
//
//  Created by Kaleb  Carrizoza on 9/14/20.
//  Copyright © 2020 Kaleb  Carrizoza. All rights reserved.
//

import UIKit

protocol SwitchTableViewCellDelegate: AnyObject {
    func switchCellSwitchValueChanged(cell: SwitchTableViewCell)
}

class SwitchTableViewCell: UITableViewCell {
    //MARK: - Outlets
    @IBOutlet weak var timeLabel: UILabel!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var alarmSwitch: UISwitch!
    
    var alarm: Alarm? {
        didSet {
            updateViews()
        }
    }
    //MARK: - Properties
    weak var delegate: SwitchTableViewCellDelegate?
    
    
    
    //MARK: - Actions
    @IBAction func switchValueChanged(_ sender: Any) {
        delegate?.switchCellSwitchValueChanged(cell: self)
    }
    
    
    func updateViews() {
        guard let alarm = alarm else {return}
        timeLabel.text = alarm.fireTimeAsString
        nameLabel.text = alarm.name
        alarmSwitch.isOn = alarm.enabled
}
    
    
    
    
    
    
    
    
    
   // override func awakeFromNib() {
    //   super.awakeFromNib()
        // Initialization code
    //}
    //override func setSelected(_ selected: Bool, animated: Bool) {
    //  super.setSelected(selected, animated: animated)
        // Configure the view for the selected state
   // }

}
