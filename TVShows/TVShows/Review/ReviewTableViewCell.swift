//
//  ReviewTableViewCell.swift
//  TVShows
//
//  Created by Bernard Ibrovic on 29.07.2021..
//

import UIKit

final class ReviewTableViewCell: UITableViewCell {
    
    // MARK: - Outlets
    
    @IBOutlet private weak var emailLabel: UILabel!
    @IBOutlet private weak var reviewDescriptionLabel: UILabel!
    @IBOutlet private weak var userImage: UIImageView!
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
        
        ratingStars
            .enumerated()
            .forEach { (index, item) in
                item.tag = index
            }
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        
        emailLabel.text = ""
        reviewDescriptionLabel.text = ""
        userImage?.image = UIImage(named: "splash-top-left")
        
        ratingStars
            .forEach {
                $0.image = UIImage(named: "ic-star-deselected")
            }
    }
}

// MARK: - Functions

extension ReviewTableViewCell {
    
    func configure(with review: Review) {
        emailLabel.text = review.user.email
        reviewDescriptionLabel.text = review.comment
        setRating(stars:review.rating,ratingStars: ratingStars)
        guard let userImageUrl = review.user.imageUrl else { return }
        userImage.kf.setImage(
            with: URL(string: userImageUrl),
            placeholder: UIImage(named: "ic-profile-placeholder"))
    }
    
    func setRating(stars: Int, ratingStars: [UIImageView]) {
        ratingStars
            .enumerated()
            .forEach { (index, item) in
                if stars >  index {
                    item.image = UIImage(named: "ic-star-selected")
                }
            }
    }
}
