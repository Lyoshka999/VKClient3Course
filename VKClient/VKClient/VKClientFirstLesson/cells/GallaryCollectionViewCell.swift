//
//  GallaryCollectionViewCell.swift
//  VKClientFirstLesson
//
//  Created by Алексей on 16.05.2022.
//

import UIKit


class GallaryCollectionViewCell: UICollectionViewCell {


    @IBOutlet weak var photoImageView: UIImageView!
   
    
    
    
    override func prepareForReuse() {
        super.prepareForReuse()
        self.photoImageView.image = nil
        
    }
    
    func configure(image: UIImage) {
        photoImageView.image = image
    }
    

    override func awakeFromNib() {
        super.awakeFromNib()
        
    }

}

