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
    

    // MARK: - Lifecycle methods
        
    override func prepareForReuse() {
        super.prepareForReuse()
        
        descriptionLabel.text = ""
        averageRating.text = ""
    }
}


// MARK: - Functions

extension ShowDetailsTableViewCell {
    
    func configure(with show: Show) {
        descriptionLabel.text = show.description
        averageRating.text = "\(show.noOfReviews) REVIEWS, \(show.averageRating) AVERAGE"
        ratingView.rating = show.averageRating
        ratingView.setRoundedRating(Double(show.averageRating))
        ratingView.isUserInteractionEnabled = false
    }
}

