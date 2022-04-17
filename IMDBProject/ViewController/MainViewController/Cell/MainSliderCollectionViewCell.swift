//
//  MainSliderCollectionViewCell.swift
//  IMDBProject
//
//  Created by Yakup Demir on 17.04.2022.
//

import UIKit

class MainSliderCollectionViewCell: UICollectionViewCell {

    @IBOutlet weak var containerView: UIView!
    @IBOutlet weak var slideOwerViewLabel: UILabel!
    @IBOutlet weak var slideTitleLabel: UILabel!
    @IBOutlet weak var imageView: UIImageView!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        
        imageView.contentMode = .scaleAspectFill
    }

}
