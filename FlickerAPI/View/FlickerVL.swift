//
//  FlickerVL.swift
//  FlickerAPI
//
//  Created by Soma Sharma on 17/06/21.
//

import UIKit

class FlickerVL: UIView {
    @IBOutlet weak var collectionView: UICollectionView! {
        didSet {
            collectionView.keyboardDismissMode = .onDrag
            collectionView.register(LoaderCollectionViewCell.self, forCellWithReuseIdentifier: "LoaderCollectionViewCell")
        }
    }
    
  
}
