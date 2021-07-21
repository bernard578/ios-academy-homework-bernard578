//
//  LoginViewController.swift
//  TVShows
//
//  Created by Bernard Ibrovic on 14.07.2021..
//

import UIKit

final class LoginViewController: UIViewController {
    
    
    // MARK: - Lifecycle methods
    override func viewDidLoad() {
        super.viewDidLoad()

    }
    
    // MARK: - Actions
    
    @IBAction private func touchRememberMeButtonActionHandler(_ sender: UIButton) {
        if sender.isSelected {
            sender.setImage(UIImage(named: "ic-checkbox-unselected"), for: .normal)
        } else {
            sender.setImage(UIImage(named: "ic-checkbox-selected"), for: . normal)
        }
        sender.isSelected = !sender.isSelected
    }
    
    // MARK: - private functions
    
    @IBAction private func touchLoginButtonActionHandler(_ sender: UIButton) {
        pushHomeViewController()
    }
    
    @IBAction private func touchRegisterButtonActionHandler(_ sender: UIButton) {
        pushHomeViewController()
    }
    
    private func pushHomeViewController() {
        let storyboard = UIStoryboard(name: "Home", bundle: .main)
        let homeViewController = storyboard.instantiateViewController(withIdentifier: "HomeViewController") as! HomeViewController
        
        navigationController?.pushViewController(homeViewController, animated: true
        )
    }
    
}
