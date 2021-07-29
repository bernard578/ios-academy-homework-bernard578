//
//  WriteAReviewViewController.swift
//  TVShows
//
//  Created by Bernard Ibrovic on 29.07.2021..
//

import UIKit
import SVProgressHUD

class WriteAReviewViewController: UIViewController {
    
    // MARK: - Outlets

    @IBOutlet weak var ratingButton1: UIButton!
    @IBOutlet weak var ratingButton2: UIButton!
    @IBOutlet weak var ratingButton3: UIButton!
    @IBOutlet weak var ratingButton4: UIButton!
    @IBOutlet weak var ratingButton5: UIButton!
    @IBOutlet weak var commentTextField: UITextView!

    // MARK: - Properties
    
    private var ratingButtons: [UIButton] = []
    private var currentRating: Int = 0
    private var manager = APIManager()
    private let alertController = UIAlertController(title: "Alert Controller", message: "", preferredStyle: .alert)
    var showId: String!
    var authInfo = APIManager.shared.authInfo
    
    // MARK: - Lifecycle methods
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupAlertController()
        ratingButtons = [ratingButton1, ratingButton2, ratingButton3, ratingButton4, ratingButton5]
        var i = 1
        for ratingButton in ratingButtons {
            ratingButton.tag = i
            i = i + 1
        }
        addNavigationLeftBarButtonItem()
        navigationItem.title = "Write a Review"
        }
    
    
    @IBAction func touchSubmitButtonActionHandler(_ sender: UIButton) {
        if currentRating == 0 {
            alertController.title = "Submit error"
            alertController.message = "Select a rating"
            present(alertController, animated: true, completion: nil)
            return
        }
        guard
            let showId = showId,
            let comment = commentTextField.text
        else {
            print("not ok when posting review")
            return
        }
        makeAPostRequest(showId: showId, comment: comment)
    }
    
    @IBAction func touchStarClickedActionHandler(_ sender: UIButton) {
        let numberOfStars = sender.tag
        currentRating = numberOfStars
        ratingButtons
            .forEach({
            (item) in
                if item.tag <= numberOfStars {
                item.setImage(UIImage(named: "ic-star-selected"), for: .normal)
                } else {
                    item.setImage(UIImage(named:"ic-star-deselected"), for: .normal)
                }
                })
    }
}

// MARK: - Functions

private extension WriteAReviewViewController {
    
    @objc func didSelectClose() {
            dismiss(animated: true, completion: nil) // push <-> pop; present <->
        }
    
    func setupAlertController() {
        let okAction = UIAlertAction(title: "OK", style: .default, handler: {
            _ in NSLog("An error occured")
        })
        alertController.addAction(okAction)
    }
    
    func addNavigationLeftBarButtonItem() {
        navigationItem.leftBarButtonItem = UIBarButtonItem(
            title: "Close",
            style: .plain,
            target: self,
            action: #selector(didSelectClose)
          )
    }
    
    func makeAPostRequest(showId: String, comment: String) {
        SVProgressHUD.show()
        manager.makePostReviewRequest(showId: showId, comment: comment, rating: currentRating) {
        [weak self] dataResponse in
            SVProgressHUD.dismiss()
            switch dataResponse {
            case .success(let response):
//                print("ok je")
//                print(response)
                self?.didSelectClose()
            case .failure(let error):
                self?.alertController.title = "Review error"
                self?.alertController.message = "Error while writing a review"
                print(error)
            }
        }
    }
}
