//
//  BookChapterViewCell.swift
//  Project
//
//  Created by Kevin Sum on 11/7/2017.
//  Copyright © 2017 Kevin iShuHui. All rights reserved.
//

import UIKit

class BookChapterViewCell: UITableViewCell {
    
    @IBOutlet private weak var coverImageView: UIImageView!
    @IBOutlet private weak var titleLabel: UILabel!
    @IBOutlet private weak var explainLabel: UILabel!
    
    var title: String? {
        get {
            return titleLabel.text
        }
        set {
            titleLabel.text = newValue
        }
    }
    
    var explain: String? {
        get {
            return explainLabel.text
        }
        set {
            explainLabel.text = newValue
        }
    }
    
    var cover: String? {
        didSet {
            let placeHolder = UIImage.fontAwesomeIcon(name: .image, textColor: .black, size: CGSize(width: 30, height: 30))
            if let url = cover {
                coverImageView.sd_setImage(with: URL(string: url), placeholderImage: placeHolder)
            }
        }
    }

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        // Configure the view for the selected state
    }

}
