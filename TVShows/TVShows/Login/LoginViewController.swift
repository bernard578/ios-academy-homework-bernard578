//
//  LoginViewController.swift
//  TVShows
//
//  Created by Bernard Ibrovic on 14.07.2021..
//

import UIKit
import SVProgressHUD

final class LoginViewController: UIViewController {
    
    // MARK: - Outlets
    
    @IBOutlet weak var rememberMeButton: UIButton!
    @IBOutlet private weak var emailTextField: BottomLinedTextField!
    @IBOutlet private weak var passwordTextField: BottomLinedTextField!
    
    // MARK: - Properties
    
    private var currentUser: User?
    private var manager = APIManager()
    
    // MARK: - Lifecycle methods
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setRememberMeButtonImages()
    }
    
    // MARK: - Actions
    
    @IBAction private func touchRememberMeButtonActionHandler(_ sender: UIButton) {
        
        sender.isSelected = !sender.isSelected
    }
        
    @IBAction private func touchLoginButtonActionHandler(_ sender: UIButton) {
        guard
            let email = emailTextField.text,
            let password = passwordTextField.text,
            !email.isEmpty,
            !password.isEmpty
        else {
            print("Login error")
            return
        }
        
        SVProgressHUD.show()
        manager.makeLoginRequest(email: email, password: password) {
        [weak self] dataResponse in
            SVProgressHUD.dismiss()
            switch dataResponse {
            case .success(let user):
                self?.currentUser = user.user
                self?.pushHomeViewController()
                print("ovo je ok iz login")
                print(self?.currentUser)
            case .failure(let error):
                print(error)
            }
        }
        
    }
    
    @IBAction private func touchRegisterButtonActionHandler(_ sender: UIButton) {
        guard
            let email = emailTextField.text,
            let password = passwordTextField.text,
            !email.isEmpty,
            !password.isEmpty
        else {
            print("Registration error")
            return
        }
        
        SVProgressHUD.show()
        manager.makeRegisterRequest(email: email, password: password) {
        [weak self] dataResponse in
            SVProgressHUD.dismiss()
            switch dataResponse {
            case .success(let user):
                self?.currentUser = user.user
                self?.pushHomeViewController()
                print("ovo je ok iz register")
                print(self?.currentUser)
            case .failure(let error):
                print(error)
            }
        }
    }
}

// MARK: - private functions

private extension LoginViewController {
    
    func setRememberMeButtonImages() {
        rememberMeButton.setImage(UIImage(named: "ic-checkbox-unselected"), for: .normal)
        rememberMeButton.setImage(UIImage(named: "ic-checkbox-selected"), for: . selected)
    }
        
    func pushHomeViewController() {
        let storyboard = UIStoryboard(name: "Home", bundle: .main)
        let homeViewController = storyboard.instantiateViewController(withIdentifier: "HomeViewController") as! HomeViewController
        
        navigationController?.pushViewController(homeViewController, animated: true
        )
    }
}
