//
//  PictureCollectionViewCell.swift
//  GridWithUnsplashAPI
//
//  Created by Erem Karalar on 20.04.2021.
//

import UIKit

class PictureCollectionViewCell: UICollectionViewCell {

    @IBOutlet var imageView: UIImageView!
    var representedIdentifier: String = ""
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    var image: UIImage? {
       didSet {
         imageView.image = image
       }
     }
    
    static func nib() -> UINib {
        return UINib(nibName: "PictureCollectionViewCell", bundle: nil)
    }
}
