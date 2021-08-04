//
//  ProfileDetailsViewController.swift
//  TVShows
//
//  Created by Bernard Ibrovic on 02.08.2021..
//

import UIKit
import SVProgressHUD
import Kingfisher
import Alamofire

final class ProfileDetailsViewController: UIViewController {
    
    // MARK: - Outlets

    @IBOutlet weak var emailLabel: UILabel!
    @IBOutlet weak var userImage: UIImageView!
    @IBOutlet weak var changeProfilePhotoButton: UIButton!
    
    // MARK: - Properties
    
    private var manager = APIManager()
    private var user: User?
    private let imagePicker = UIImagePickerController()
    
    // MARK: - Lifecycle methods

    override func viewDidLoad() {
        super.viewDidLoad()
        addNavigationLeftBarButtonItem()
        makeUserRequest()
        setupUI()
    }
    
    // MARK: - Actions
    
    @IBAction func touchChangeProfilePhotoButtonActionHandler(_ sender: Any) {
        imagePicker.allowsEditing = false
        imagePicker.sourceType = .photoLibrary
        present(imagePicker, animated: true, completion: nil)
    }
    
    @IBAction func touchLogoutButtonActionHandler(_ sender: Any) {
        dismiss(animated: true, completion: nil)
        KeychainAccess.shared.store(authInfo: nil)
        APIManager.shared.authInfo = nil
        NotificationCenter.default.post(Notification.init(name: Notification.Name(rawValue: "NotificationDidLogout")))
    }
}

// MARK: - Functions

private extension ProfileDetailsViewController {
    
    func setupUI() {
        imagePicker.delegate = self
        navigationItem.title = "My Account"
    }
    
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
    
    func storeImage(_ image: UIImage) {
        guard
            let imageData = image.jpegData(compressionQuality: 0.9)
        else { return }
        
        let requestData = MultipartFormData()
        requestData.append(
            imageData,
            withName: "image",
            fileName: "image.jpg",
            mimeType: "image/jpg"
        )
        
        print(APIManager.shared.authInfo!.headers)
        AF
            .upload(multipartFormData: requestData,
                    to: "https://tv-shows.infinum.academy/users",
                    method: .put,
                    headers: HTTPHeaders(APIManager.shared.authInfo!.headers))
            .validate()
            .responseDecodable(of: UserResponse.self) { dataResponse in
            print("Data response \(dataResponse)")
            switch dataResponse.result {
            case .success(let okJe):
                print("ok je ovako")
                print(okJe)
            case .failure(let nijeOK):
                print("nije ok")
                print(nijeOK)
            }
        }
    }

}

// MARK: - UIImagePickerControllerDelegate

extension ProfileDetailsViewController: UIImagePickerControllerDelegate {
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        if let pickedImage = info[UIImagePickerController.InfoKey.originalImage
        ] as? UIImage {
            userImage.contentMode = .scaleAspectFit
            userImage.image = pickedImage
            storeImage(pickedImage)
        }

//        if let pickedImage = info[.originalImage] as? UIImage {
//            storeImage(pickedImage)
//        }
        dismiss(animated: true, completion: nil)
    }
    
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        dismiss(animated: true, completion: nil)
    }
    
}

// MARK: - UINavigationControllerDelegate

extension ProfileDetailsViewController: UINavigationControllerDelegate {

}
