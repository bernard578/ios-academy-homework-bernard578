//
//  AuthTextField.swift
//  TVShows
//
//  Created by Bernard Ibrovic on 19.07.2021..
//

import Foundation
import UIKit

class AuthTextField: UITextField {

    override func draw(_ rect: CGRect) {
        super.draw(rect)
        let bottomLine = CALayer()
        self.textColor = .white
        bottomLine.frame = CGRect(x: -10.0, y: self.frame.size.height + 3, width: self.frame.size.width + 20.0, height: 1.0)
        bottomLine.backgroundColor = UIColor.white.cgColor
        self.borderStyle = .none
        self.layer.addSublayer(bottomLine)
    }
}
