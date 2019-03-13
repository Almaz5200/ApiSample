//
//  SavedCheckCell.swift
//  ApiSample
//
//  Created by Artem Trubacheev on 12/03/2019.
//  Copyright © 2019 Artem Trubacheev. All rights reserved.
//

import UIKit

class SavedCheckCell: UITableViewCell {

    @IBOutlet weak var emailLabel: UILabel!
    @IBOutlet weak var validFormatCircle: SatusCircle!
    @IBOutlet weak var smtpCircle: SatusCircle!
    @IBOutlet weak var mxcircle: SatusCircle!
    @IBOutlet weak var catchAllCircle: SatusCircle!
    @IBOutlet weak var roleCircle: SatusCircle!
    @IBOutlet weak var disposableCircle: SatusCircle!
    @IBOutlet weak var freeCircle: SatusCircle!
    @IBOutlet weak var scoreLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    func setup(check: Check) {
        emailLabel.text = check.email
        validFormatCircle.isOn = check.formatValid
        smtpCircle.isOn = check.smtpCheck
        mxcircle.isOn = check.mxFound
        catchAllCircle.isOn = check.catchAll
        roleCircle.isOn = check.role
        disposableCircle.isOn = check.disposable
        freeCircle.isOn = check.free
        scoreLabel.text = check.score.description
        
        switch check.score {
        case 0..<0.45:
            self.scoreLabel.textColor = scoreColors.bad
        case 0.45..<0.8:
            self.scoreLabel.textColor = scoreColors.middle
        case 0.8...1:
            self.scoreLabel.textColor = scoreColors.good
        default:
            self.scoreLabel.textColor = scoreColors.middle
        }
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
