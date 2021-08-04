//
//  ShowDetailsTableViewCell.swift
//  TVShows
//
//  Created by Bernard Ibrovic on 28.07.2021..
//

import UIKit
import Kingfisher

final class ShowDetailsTableViewCell: UITableViewCell {
    
    // MARK: - Outlets
    
    @IBOutlet private weak var showImage: UIImageView!
    @IBOutlet private weak var descriptionLabel: UILabel!
    @IBOutlet private weak var averageRating: UILabel!
    @IBOutlet private weak var ratingView: RatingView!
    
    // MARK: - Properties
    
    var reviews: [Review] = []
    private var averageRatingNumber: Double?

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
        ratingView.setRoundedRating(Double(show.averageRating))
        ratingView.rating = Int(show.averageRating)
        //averageRatingNumber = calculateAverageRating(reviews: reviews)
        ratingView.isUserInteractionEnabled = false
        showImage.kf.setImage(
            with: URL(string: show.imageUrl),
            placeholder: UIImage(named: "ic-show-placeholder-rectangle"))
    }
    
//    func calculateAverageRating(reviews: [Review]) -> Double {
//        var totalNumber = 0
//        reviews.forEach { totalNumber = totalNumber + $0.rating }
//        print("total number \(totalNumber)")
//        return Double(totalNumber / reviews.count)
//    }
}

