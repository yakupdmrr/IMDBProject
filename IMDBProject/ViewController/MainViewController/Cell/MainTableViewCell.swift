//
//  MainTableViewCell.swift
//  IMDBProject
//
//  Created by Yakup Demir on 15.04.2022.
//

import UIKit

class MainTableViewCell: UITableViewCell {

    
    @IBOutlet weak var dateLabel: UILabel!
    @IBOutlet weak var descriptionLabel: UILabel!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var xDimage: UIImageView!
    override func awakeFromNib() {
        super.awakeFromNib()
        xDimage.contentMode = .scaleToFill
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

     
    }
    
}
