//
//  UpdateTableViewCell.swift
//  KSiShuHui
//
//  Created by Kevin Sum on 31/7/2017.
//  Copyright © 2017 Kevin iShuHui. All rights reserved.
//

import UIKit

class UpdateTableViewCell: UITableViewCell {
    
    @IBOutlet private weak var coverImageView: UIImageView!
    @IBOutlet private weak var titleLabel: UILabel!
    @IBOutlet private weak var descLabel: UILabel!
    @IBOutlet weak var updateLabel: UILabel!
    
    var title: String? {
        get {
            return titleLabel.text
        }
        set {
            titleLabel.text = newValue
        }
    }
    
    var desc: String? {
        get {
            return descLabel.text
        }
        set {
            descLabel.text = newValue
        }
    }
    
    var cover: String? {
        didSet {
            let placeHolder = UIImage.fontAwesomeIcon(name: .starO, textColor: .gray, size: CGSize(width: 30, height: 30))
            if let url = cover {
                coverImageView.sd_setImage(with: URL(string: url), placeholderImage: placeHolder)
            }
        }
    }
    
    var updateStr: String? {
        get {
            return updateLabel.text
        }
        set {
            updateLabel.text = newValue
        }
    }

    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
}
