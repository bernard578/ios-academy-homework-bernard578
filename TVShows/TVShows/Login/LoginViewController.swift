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
    
    @IBOutlet private weak var loginButton: UIButton!
    @IBOutlet weak var rememberMeButton: UIButton!
    @IBOutlet private weak var emailTextField: BottomLinedTextField!
    @IBOutlet private weak var passwordTextField: BottomLinedTextField!
    
    @IBOutlet weak var passwordVisibilityButton: UIButton!
    // MARK: - Properties
    
    private var currentUser: User?
    private var manager = APIManager()
    private let alertController = UIAlertController(title: "Alert Controller", message: "", preferredStyle: .alert)
    
    // MARK: - Lifecycle methods
    
    override func viewDidLoad() {
        super.viewDidLoad()
        emailTextField.text = "NoviKorisnik@hotmail.com"
        passwordTextField.text = "Korisnik123"
        setRememberMeButtonImages()
        setPasswordVisibilityButtonImages()
    }
    
    // MARK: - Actions
    
    @IBAction private func touchRememberMeButtonActionHandler(_ sender: UIButton) {
        sender.isSelected = !sender.isSelected
    }
        
    @IBAction func touchPasswordVisibilityActionHandler(_ sender: UIButton) {
        sender.isSelected = !sender.isSelected
        if sender.isSelected {
            passwordTextField.isSecureTextEntry = false
        } else {
            passwordTextField.isSecureTextEntry = true
        }
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
                if self!.rememberMeButton.isSelected {
                    KeychainAccess.shared.store(authInfo: APIManager.shared.authInfo!)
                }
                self?.pushShowsViewController(userResponse: user)
            case .failure(let error):
                self?.startWrongCredentialsAnimation()
                self?.alert(title: "Login error", message: "Login error occurred")
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
                self?.alert(title: "Registration error", message: "Registration error occured")
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
    
    func setPasswordVisibilityButtonImages() {
        passwordVisibilityButton.setImage(UIImage(named: "ic-invisible"), for: .normal)
        passwordVisibilityButton.setImage(UIImage(named: "ic-visible"), for: .selected)
    }
        
    func pushShowsViewController(userResponse: UserResponse) {
        let storyboard = UIStoryboard(name: "Shows", bundle: .main)
        let showsViewController = storyboard.instantiateViewController(withIdentifier: "ShowsViewController") as! ShowsViewController
        showsViewController.userResponse = userResponse
        
        navigationController?.setViewControllers([showsViewController], animated: true)
    }
    
    func alert(title: String, message: String) {
        let alertController = UIAlertController(title: title, message: message, preferredStyle: .alert)
        addAlertAction(alertController: alertController)
        present(alertController, animated: true, completion: nil)
    }
    
    func addAlertAction(alertController: UIAlertController) {
        let okAction = UIAlertAction(title: "OK", style: .default, handler: {
            _ in NSLog("An error occured")
        })
        alertController.addAction(okAction)
    }
    
    func startWrongCredentialsAnimation() {
        shakeTextField(textField: emailTextField)
        shakeTextField(textField: passwordTextField)
        animateLoginButtonColor(button: loginButton)
    }
    
    func shakeTextField(textField: UITextField) {
        let shakeAnimation = CABasicAnimation(keyPath: "position")
        shakeAnimation.duration = 0.1
        shakeAnimation.repeatCount = 4
        shakeAnimation.autoreverses = true
        shakeAnimation.fromValue = NSValue(cgPoint: CGPoint(x: textField.center.x - 5, y: textField.center.y))
        shakeAnimation.toValue = NSValue(cgPoint: CGPoint(x: textField.center.x + 5, y: textField.center.y))
        textField.layer.add(shakeAnimation, forKey: "position")
    }
    
    func animateLoginButtonColor(button: UIButton) {
        UIView.animate(
            withDuration: 1.0,
            delay: 0.0,
            options: [.autoreverse],
            animations: {
            button.layer.backgroundColor = UIColor.red.cgColor
        }, completion: { (finished) in
            button.layer.backgroundColor = UIColor.white.cgColor
        })
    }
    
}
