//
//  ProfileDetailsViewController.swift
//  TVShows
//
//  Created by Bernard Ibrovic on 02.08.2021..
//

import UIKit
import SVProgressHUD
import Kingfisher

class ProfileDetailsViewController: UIViewController {

    @IBOutlet weak var emailLabel: UILabel!
    @IBOutlet weak var userImage: UIImageView!
    @IBOutlet weak var changeProfilePhotoButton: UIButton!
    
//    var authInfo = APIManager.shared.authInfo
    private var manager = APIManager()
    private var user: User?

    override func viewDidLoad() {
        super.viewDidLoad()
        addNavigationLeftBarButtonItem()
        makeUserRequest()
    }

}

private extension ProfileDetailsViewController {
    
    func addNavigationLeftBarButtonItem() {
        navigationItem.leftBarButtonItem = UIBarButtonItem(
            title: "Close",
            style: .plain,
            target: self,
            action: #selector(didSelectClose)
          )
    }
    
    @objc func didSelectClose() {
            dismiss(animated: true, completion: nil) // push <-> pop; present <->
        }
    
    func makeUserRequest() {
        SVProgressHUD.show()
        manager.makeUserRequest() { [weak self] dataResponse in
            SVProgressHUD.dismiss()
            switch dataResponse {
            case .success(let user):
                self?.user = user.user
                self?.showUserDetails(user: (self?.user)!)
            case .failure(let error):
                print(error)
            }
        }
    }
    
    func showUserDetails(user: User) {
        emailLabel.text = user.email
        guard let userImageUrl = user.imageUrl else {
            userImage.image = UIImage(named: "ic-profile-placeholder")
            return
        }
        userImage.kf.setImage(
            with: URL(string: userImageUrl),
            placeholder: UIImage(named: "ic-profile-placeholder"))
    }
}
