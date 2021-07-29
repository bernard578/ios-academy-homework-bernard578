//
//  ReviewTableViewCell.swift
//  TVShows
//
//  Created by Bernard Ibrovic on 29.07.2021..
//

import UIKit

class ReviewTableViewCell: UITableViewCell {
    
    // MARK: - Outlets
    
    @IBOutlet private weak var emailLabel: UILabel!
    @IBOutlet private weak var reviewDescriptionLabel: UILabel!
    @IBOutlet private weak var imageUrl: UIImageView?
    @IBOutlet private weak var ratingStar1: UIImageView!
    @IBOutlet private weak var ratingStar2: UIImageView!
    @IBOutlet private weak var ratingStar3: UIImageView!
    @IBOutlet private weak var ratingStar4: UIImageView!
    @IBOutlet private weak var ratingStar5: UIImageView!
    
    // MARK: - Properties
    private var ratingStars: [UIImageView] = []

    // MARK: - Lifecycle methods

    override func awakeFromNib() {
        super.awakeFromNib()
        ratingStars = [ratingStar1, ratingStar2, ratingStar3, ratingStar4, ratingStar5]
        
        var i = 0
        for ratingStar in ratingStars {
            ratingStar.tag = i
            i = i + 1
        }
    }
    
    override func prepareForReuse() {
        emailLabel.text = ""
        reviewDescriptionLabel.text = ""
        imageUrl?.image = UIImage(named: "splash-top-left")
        
        ratingStars
            .forEach({
            (item) in
                item.image = UIImage(named: "ic-star-deselected")
                })
    }
}

// MARK: - Functions
extension ReviewTableViewCell {
    func configure(with review: Review) {
        emailLabel.text = review.user.email
        reviewDescriptionLabel.text = review.comment
        imageUrl?.image = UIImage(named: "splash-top-left")
        setRating(stars:review.rating,ratingStars: ratingStars)
    }
    
    func setRating(stars: Int, ratingStars: [UIImageView]) {
        ratingStars
            .enumerated()
            .forEach({
            (index, item) in
                if stars >  index {
                    item.image = UIImage(named: "ic-star-selected")
                }
            })
    }
}
