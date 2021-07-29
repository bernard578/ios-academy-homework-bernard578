//
//  ShowDetailsViewController.swift
//  TVShows
//
//  Created by Bernard Ibrovic on 28.07.2021..
//

import UIKit
import SVProgressHUD

class ShowDetailsViewController: UIViewController {
    
    // MARK: - Outlets
    
    @IBOutlet private weak var tableView: UITableView!
    @IBOutlet private weak var writeAReviewButton: UIButton!
    
    // MARK: - Properties
    
    var showId: String!
    var show: Show?
    var authInfo = APIManager.shared.authInfo
    private var manager = APIManager()
    var reviews: [Review] = []
    
    // MARK: - Lifecycle methods

    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        
    }
    
    // MARK: - Actions
    
    @IBAction func touchWriteAReviewButtonActionHandler(_ sender: UIButton) {
        pushWriteAReviewViewController()
    }
}

// MARK: - Private functions

private extension ShowDetailsViewController {
    
    func setupUI() {
        tableView.delegate = self
        tableView.dataSource = self
        navigationItem.title = show?.title
    }
    
    func pushWriteAReviewViewController() {
        let storyboard = UIStoryboard(name: "Review", bundle: .main)
        let writeAReviewViewController = storyboard.instantiateViewController(withIdentifier: "WriteAReviewViewController") as! WriteAReviewViewController
        let navigationController = UINavigationController(rootViewController: writeAReviewViewController)
        writeAReviewViewController.showId = showId
        present(navigationController, animated: true)
    }
    
}

// MARK: - TableViewDelegate

extension ShowDetailsViewController: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
    }
    
    func tableView(_ tableView: UITableView, estimatedHeightForRowAt indexPath: IndexPath) -> CGFloat {
        if indexPath.row == 0 {
            return 550
        } else {
            return 100
        }
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if indexPath.row == 0 {
            return 550
        } else {
            return 100
        }
    }
    
    
}

// MARK: - TableView DataSource

extension ShowDetailsViewController: UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return reviews.count + 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if indexPath.row == 0 {
            let cell = tableView.dequeueReusableCell(withIdentifier: String(describing: ShowDetailsTableViewCell.self), for: indexPath) as! ShowDetailsTableViewCell
            cell.rating = Double((show?.averageRating)!)
            cell.configure(with: show!)
            return cell
        } else {
            let cell = tableView.dequeueReusableCell(withIdentifier: String(describing: ReviewTableViewCell.self), for: indexPath) as! ReviewTableViewCell
            cell.configure(with: reviews[indexPath.row - 1])
            return cell
        }
    }
}

