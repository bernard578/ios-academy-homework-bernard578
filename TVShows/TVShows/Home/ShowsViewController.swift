//
//  HomeViewController.swift
//  TVShows
//
//  Created by Bernard Ibrovic on 21.07.2021..
//

import UIKit
import SVProgressHUD

class ShowsViewController: UIViewController {
    
    // MARK: - Outlets
    
    @IBOutlet private weak var tableView: UITableView!
    
    // MARK: - Properties
    
    private var shows: [Show] = []
    var userResponse: UserResponse?
    var authInfo = APIManager.shared.authInfo
    private var manager = APIManager()
    private var showReviews: [Review] = []
    
    // MARK: - Lifecycle methods
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        makeShowsRequest()
    }
}

// MARK: - Functions

private extension ShowsViewController {
    
    func setupTableView() {
        tableView.delegate = self
        tableView.dataSource = self
    }
    
    func makeShowsRequest() {
        SVProgressHUD.show()
        manager.makeShowsRequest() {
        [weak self] dataResponse in
            SVProgressHUD.dismiss()
            switch dataResponse {
            case .success(let shows):
                self?.shows = shows.shows
                DispatchQueue.main.async {
                    self?.tableView.reloadData()
                }
                //print(self?.shows)
            case .failure(let error):
                print(error)
            }
        }

    }
}

// MARK: - Private functions

private extension ShowsViewController {
    
    func setupUI() {
        tableView.delegate = self
        tableView.dataSource = self
    }
    
    func pushShowDetailsViewController(id: String) {
        let storyboard = UIStoryboard(name: "ShowDetails", bundle: nil)
        let showDetailsViewController = storyboard.instantiateViewController(withIdentifier: "ShowDetailsViewController") as! ShowDetailsViewController
        let currentShow = shows.first{$0.id == id}
        showDetailsViewController.showId = id
        print(showDetailsViewController.showId!)
        showDetailsViewController.show = currentShow
        manager.makeReviewsRequest(showId: id) {
            [weak self] dataResponse in
                SVProgressHUD.dismiss()
                switch dataResponse {
                case .success(let reviewsResponse):
                    self?.showReviews = reviewsResponse.reviews
                    showDetailsViewController.reviews = reviewsResponse.reviews
                case .failure(let error):
                    print(error)
                }
        }
        DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
            self.navigationController?.pushViewController(showDetailsViewController, animated: true)
        }
    }
}

// MARK: - TableView Delegate

extension ShowsViewController: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        let show = shows[indexPath.row]
        pushShowDetailsViewController(id: show.id)
        
    }
    
}

// MARK: - TableView DataSource

extension ShowsViewController: UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return shows.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: String(describing: ShowTableViewCell.self), for: indexPath) as! ShowTableViewCell
        cell.configure(with: shows[indexPath.row])
        return cell
    }
}