//
//  HomeViewController.swift
//  TVShows
//
//  Created by Bernard Ibrovic on 21.07.2021..
//

import UIKit
import SVProgressHUD

class HomeViewController: UIViewController {
    
    // MARK: - Outlets
    
    @IBOutlet private weak var tableView: UITableView!
    
    // MARK: - Properties
    
    private var shows: [Show] = []
    public var user: User?
    public var authInfo = APIManager.shared.authInfo
    private var manager = APIManager()
    
    
//    init(user: User, authInfo: AuthInfo) {
//        self.user = user
//        self.authInfo = authInfo
//        super.init(nibName: nil, bundle: nil)
//    }
//
//    required init?(coder: NSCoder) {
//        fatalError("init(coder:) has not been implemented")
//    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.delegate = self
        tableView.dataSource = self
        makeShowsRequest()
        //print("Iz home \(authInfo)")
    }
}


// MARK: - Functions

private extension HomeViewController {
    
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

extension HomeViewController: UITableViewDelegate {
    
}

extension HomeViewController: UITableViewDataSource {
    
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
