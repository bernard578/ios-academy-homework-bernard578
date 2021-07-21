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
    
    @IBAction func touchRememberMeButtonActionHandler(_ sender: UIButton) {
        if sender.isSelected {
            sender.setImage(UIImage(named: "ic-checkbox-unselected"), for: .normal)
        } else {
            sender.setImage(UIImage(named: "ic-checkbox-selected"), for: . normal)
        }
        sender.isSelected = !sender.isSelected
    }
    
    
    @IBAction func touchLoginButtonActionHandler(_ sender: UIButton) {
        pushHomeViewController()
    }
    
    @IBAction func touchRegisterButtonActionHandler(_ sender: UIButton) {
        pushHomeViewController()
    }
    
    // MARK: - private functions
    
    private func pushHomeViewController() {
        let storyboard = UIStoryboard(name: "Home", bundle: .main)
        let homeViewController = storyboard.instantiateViewController(withIdentifier: "Home") as! HomeViewController
        
        navigationController?.pushViewController(homeViewController, animated: true)
    }
}
