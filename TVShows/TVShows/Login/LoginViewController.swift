//
//  LoginViewController.swift
//  TVShows
//
//  Created by Bernard Ibrovic on 14.07.2021..
//

import UIKit

class LoginViewController: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()

    }
    
    @IBAction func touchRememberMeButtonClicked(_ sender: UIButton) {
        if sender.isSelected {
            sender.setImage(UIImage(named: "ic-checkbox-unselected"), for: .normal)
        } else {
            sender.setImage(UIImage(named: "ic-checkbox-selected"), for: . normal)
        }
        sender.isSelected = !sender.isSelected
    }
}
