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
        setupAlertController()
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
                self?.pushShowsViewController(userResponse: user)
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
                self?.pushShowsViewController(userResponse: user)
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
        
    func pushShowsViewController(userResponse: UserResponse) {
        let storyboard = UIStoryboard(name: "Shows", bundle: .main)
        let showsViewController = storyboard.instantiateViewController(withIdentifier: "ShowsViewController") as! ShowsViewController
        showsViewController.userResponse = userResponse
        
        navigationController?.setViewControllers([showsViewController], animated: true)
    }
    
    func setupAlertController() {
        let okAction = UIAlertAction(title: "OK", style: .default, handler: {
            _ in NSLog("An error occured")
        })
        alertController.addAction(okAction)
    }
}
