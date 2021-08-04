//
//  ShowTableViewCell.swift
//  TVShows
//
//  Created by Bernard Ibrovic on 27.07.2021..
//

import UIKit

final class ShowTableViewCell: UITableViewCell {
    
    // MARK: - Outlets
    
    @IBOutlet private weak var showImage: UIImageView!
    @IBOutlet private weak var titleLabel: UILabel!
    
    // MARK: - Lifecycle methods
    
    override func prepareForReuse() {
        super.prepareForReuse()
        
        titleLabel.text = ""
    }
}

// MARK: - Functions

extension ShowTableViewCell {
    
    func configure(with show: Show) {
        titleLabel.text = show.title
        showImage.kf.setImage(
            with: URL(string: show.imageUrl),
            placeholder: UIImage(named: "ic-show-placeholder-vertical"))
    }
}
