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
    private let alertController = UIAlertController(title: "Alert Controller", message: "", preferredStyle: .alert)
    
    // MARK: - Lifecycle methods
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setRememberMeButtonImages()
        setUpAlertController()
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
            case .failure(let error):
                self?.alertController.title = "Login error"
                self?.alertController.message = "Login error occured"
                self?.present(self!.alertController, animated: true, completion: nil)
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
                self?.alertController.title = "Registration error"
                self?.alertController.message = "Registration error occured"
                self?.present(self!.alertController, animated: true, completion: nil)
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
    
    func handleSuccessfulLogin(for user: User, headers: [String: String]) {
        guard let authInfo = try? AuthInfo(headers: headers) else {
            SVProgressHUD.showError(withStatus: "Missing headers")
            return
        }
        SVProgressHUD.showSuccess(withStatus: "Success")
    }
    
    func setUpAlertController() {
        let okAction = UIAlertAction(title: "OK", style: .default, handler: {
            _ in NSLog("An error occured")
        })
        alertController.addAction(okAction)
    }
}
