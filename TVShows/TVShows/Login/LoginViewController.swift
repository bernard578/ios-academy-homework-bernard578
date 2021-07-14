//
//  LoginViewController.swift
//  TVShows
//
//  Created by Bernard Ibrovic on 14.07.2021..
//

import UIKit

class LoginViewController: UIViewController {
    @IBOutlet var textLabel: UILabel!
    private var counter = 0
    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!
    private var flag = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        activityIndicator.startAnimating()
        DispatchQueue.main.asyncAfter(deadline: .now() + .seconds(3)) {
            self.activityIndicator.stopAnimating()
            self.activityIndicator.isHidden = true
        }
    }

    @IBAction func buttonClicked(_ sender: Any) {
        counter += 1
        textLabel.text = counter == 1 ?
            "The button has been clicked \(counter) time." :
            "The button has been clicked \(counter) times."
    }
    
    @IBAction func activityIndicatorButtonClicked(_ sender: Any) {
        if flag == 0 {
            activityIndicator.startAnimating()
            activityIndicator.isHidden = false
            flag = 1
        } else {
            activityIndicator.stopAnimating()
            activityIndicator.isHidden = true
            flag = 0
        }
    }
    
}
