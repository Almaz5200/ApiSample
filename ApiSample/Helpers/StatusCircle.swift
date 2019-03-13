//
//  StatusCircle.swift
//  ApiSample
//
//  Created by Artem Trubacheev on 09/03/2019.
//  Copyright © 2019 Artem Trubacheev. All rights reserved.
//

import UIKit

class SatusCircle: UIView {
    
    public var enabledColor = #colorLiteral(red: 0.1294117647, green: 0.862745098, blue: 0.2470588235, alpha: 1)
    public var disabledColor = #colorLiteral(red: 0.831372549, green: 0, blue: 0.2274509804, alpha: 1)
    
    var isOn = false {
        didSet {
            self.backgroundColor = self.isOn ? enabledColor : disabledColor
        }
    }
    
    override func awakeFromNib() {
        self.layer.cornerRadius = self.bounds.height/2
        isOn = false
    }
}
