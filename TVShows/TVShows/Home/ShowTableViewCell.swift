//
//  ShowTableViewCell.swift
//  TVShows
//
//  Created by Bernard Ibrovic on 27.07.2021..
//

import UIKit

class ShowTableViewCell: UITableViewCell {
    
    @IBOutlet private weak var titleLabel: UILabel!

    override func awakeFromNib() {
        super.awakeFromNib()
        titleLabel.textColor = .red
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        
        titleLabel.text = ""
    }

//    override func setSelected(_ selected: Bool, animated: Bool) {
//        super.setSelected(selected, animated: animated)
//
//    }

}

extension ShowTableViewCell {
    
    func configure(with show: Show) {
        titleLabel.text = show.title
    }
}
