//
//  FlickrCell.swift
//  FlickerAPI
//
//  Created by Soma Sharma on 17/06/21.
//

import UIKit

final class FlickrCell: UICollectionViewCell {
    @IBOutlet weak var imageV: UIImageView!
    
    var imageUrl : String? {
        didSet {
            imageV.imageDownloader(url: imageUrl ?? "")
        }
    }
}
