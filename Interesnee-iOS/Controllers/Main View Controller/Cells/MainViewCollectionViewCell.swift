//
//  MainViewCollectionViewCell.swift
//  Interesnee-iOS
//
//  Created by Артем on 10.11.2022.
//

import UIKit

class MainViewCollectionViewCell: UICollectionViewCell {

    @IBOutlet weak var imageView: UIImageView!
    
    private var cornerRadius: CGFloat = 10.0

    override func awakeFromNib() {
        super.awakeFromNib()

        contentView.layer.cornerRadius = cornerRadius
        contentView.layer.masksToBounds = true

        layer.cornerRadius = cornerRadius
        layer.masksToBounds = false

        layer.shadowRadius = 6.0
        layer.shadowOpacity = 0.15
        layer.shadowColor = UIColor.black.cgColor
        layer.shadowOffset = CGSize(width: 0, height: 5)
    }

    override func layoutSubviews() {
        super.layoutSubviews()

        layer.shadowPath = UIBezierPath(
            roundedRect: bounds,
            cornerRadius: cornerRadius
        ).cgPath
    }
    
}
