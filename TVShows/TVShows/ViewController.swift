//
//  ViewController.swift
//  TVShows
//
//  Created by Bernard Ibrovic on 08.07.2021..
//

import UIKit
import SVProgressHUD

class LoginViewController: UIViewController {
    
    @IBOutlet weak var titleLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        print("Test")
        self.titleLabel.text = "This is my second app"
        SVProgressHUD.show()
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 5) {
            SVProgressHUD.dismiss()
        }
        
    }


}

