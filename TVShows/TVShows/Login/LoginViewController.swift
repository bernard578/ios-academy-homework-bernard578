//
//  LoginViewController.swift
//  TVShows
//
//  Created by Bernard Ibrovic on 14.07.2021..
//

import UIKit
import Alamofire
import SVProgressHUD

final class LoginViewController: UIViewController {
    
    // MARK: - Outlets
    
    @IBOutlet private weak var emailTextField: AuthTextField!
    @IBOutlet private weak var passwordTextField: AuthTextField!
    
    // MARK: - Properties
    private var currentUser: User?
    private var configuration = URLSessionConfiguration.af.default
    private lazy var session = Session(configuration: configuration)
    
    
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
        if emailTextField.text!.isEmpty || passwordTextField.text!.isEmpty {
            print("Please fill in all of the required fields")
            return
        }
        
        SVProgressHUD.show()
        session.request(UserRouter.login(email: emailTextField.text!, password: passwordTextField.text!)).validate().responseDecodable(of: UserResponse.self) {
            [weak self] dataResponse in
            SVProgressHUD.dismiss()
            switch dataResponse.result {
            case .success(let user):
                self?.currentUser = user.user
                self?.pushHomeViewController()
            case .failure(let error):
                print(error)
            }
        }
    }
    
    @IBAction private func touchRegisterButtonActionHandler(_ sender: UIButton) {
        
        if emailTextField.text!.isEmpty || passwordTextField.text!.isEmpty {
            print("Please fill in all of the required fields")
            return
        }
        
        SVProgressHUD.show()
        session.request(UserRouter.register(email: emailTextField.text!, password: passwordTextField.text!)).validate().responseDecodable(of: UserResponse.self) {
            [weak self] dataResponse in
            SVProgressHUD.dismiss()
            switch dataResponse.result {
            case .success(let user):
                self?.currentUser = user.user
                self?.pushHomeViewController()
            case .failure(let error):
                print(error)
            }
        }
        
    }
        
        
    
    private func pushHomeViewController() {
        let storyboard = UIStoryboard(name: "Home", bundle: .main)
        let homeViewController = storyboard.instantiateViewController(withIdentifier: "HomeViewController") as! HomeViewController
        
        navigationController?.pushViewController(homeViewController, animated: true
        )
    }
    
}
