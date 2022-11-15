//
//  MainViewCollectionViewCell.swift
//  Interesnee-iOS
//
//  Created by Артем on 10.11.2022.
//

import UIKit
import Kingfisher

class MainViewCollectionViewCell: UICollectionViewCell {

    static let identifier = "PhotoCell"

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

    override func prepareForReuse() {
        super.prepareForReuse()
        imageView.image = nil
    }

    func configure(with viewModel: ImageViewModel?) {
        guard let viewModel = viewModel else { return }
        imageView.kf.setImage(with: viewModel.thumbnail, options: [.transition(.fade(0.3))])
    }
    
}
