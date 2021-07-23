//
//  AuthTextField.swift
//  TVShows
//
//  Created by Bernard Ibrovic on 19.07.2021..
//

import Foundation
import UIKit

final class BottomLinedTextField: UITextField {

    
    // MARK: - Private functions
    
    override func draw(_ rect: CGRect) {
        super.draw(rect)
        underlineTextField()
    }
    
    private func underlineTextField() {
        let bottomLine = CALayer()
        textColor = .white
        bottomLine.frame = CGRect(x: -10.0, y: frame.size.height + 3, width: frame.size.width + 20.0, height: 1.0)
        bottomLine.backgroundColor = UIColor.white.cgColor
        borderStyle = .none
        layer.addSublayer(bottomLine)
    }
}
