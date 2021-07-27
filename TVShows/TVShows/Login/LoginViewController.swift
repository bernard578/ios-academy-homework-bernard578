//
//  LoginViewController.swift
//  TVShows
//
//  Created by Bernard Ibrovic on 14.07.2021..
//

import UIKit

final class LoginViewController: UIViewController {
    
    // MARK: - Outlets
    
    @IBOutlet weak var rememberMeButton: UIButton!
    
    // MARK: - Lifecycle methods
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setRememberMeButtonImages()
    }
    
    // MARK: - Actions
    
    @IBAction func touchRememberMeButtonActionHandler(_ sender: UIButton) {
        sender.isSelected = !sender.isSelected
    }
    
    // MARK: - Private functions
    
    private func setRememberMeButtonImages() {
        rememberMeButton.setImage(UIImage(named: "ic-checkbox-unselected"), for: .normal)
        rememberMeButton.setImage(UIImage(named: "ic-checkbox-selected"), for: .selected)
    }
}
