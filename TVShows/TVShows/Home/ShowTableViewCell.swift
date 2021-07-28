//
//  ShowTableViewCell.swift
//  TVShows
//
//  Created by Bernard Ibrovic on 27.07.2021..
//

import UIKit

class ShowTableViewCell: UITableViewCell {
    
    // MARK: - Outlets
    
    @IBOutlet private weak var titleLabel: UILabel!
    
    // MARK: - Lifecycle methods

    override func awakeFromNib() {
        super.awakeFromNib()
        titleLabel.textColor = .red
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        
        titleLabel.text = ""
    }
}

// MARK: - Functions

extension ShowTableViewCell {
    
    func configure(with show: Show) {
        titleLabel.text = show.title
    }
}
