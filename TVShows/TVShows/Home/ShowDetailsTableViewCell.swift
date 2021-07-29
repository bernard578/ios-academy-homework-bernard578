//
//  ShowDetailsTableViewCell.swift
//  TVShows
//
//  Created by Bernard Ibrovic on 28.07.2021..
//

import UIKit

class ShowDetailsTableViewCell: UITableViewCell {
    
    // MARK: - Outlets
    
    @IBOutlet private weak var descriptionLabel: UILabel!
    @IBOutlet private weak var averageRating: UILabel!
    @IBOutlet private weak var ratingView: RatingView!
    
    // MARK: - Properties
    
    var authInfo = APIManager.shared.authInfo
    var rating: Double!
    private var manager = APIManager()
    private var reviews: [Review] = []

    // MARK: - Lifecycle methods
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
    }
        
    override func prepareForReuse() {
        descriptionLabel.text = ""
        averageRating.text = ""
    }
}


// MARK: - Functions

extension ShowDetailsTableViewCell {
    
    func configure(with show: Show) {
        descriptionLabel.text = show.description
        averageRating.text = "\(show.noOfReviews) REVIEWS, \(Double(show.averageRating!)) AVERAGE"
        ratingView.setRoundedRating(rating)
        ratingView.isUserInteractionEnabled = false
    }
}

