//
//  FullScreenLayout.swift
//  GSScrollingTabbar
//
//  Created by Gagandeep Singh on 2/7/18.
//  Copyright © 2018 Gagandeep Singh. All rights reserved.
//

import Foundation

class FullScreenLayout: UICollectionViewFlowLayout {
    
    override func prepare() {
        super.prepare()
        
        minimumLineSpacing = 0
        minimumInteritemSpacing = 0
        itemSize = {
            guard let collectionView = collectionView else { return .zero }
            return collectionView.bounds.size
        }()
        scrollDirection = .horizontal
        
        if #available(iOS 11.0, *) {
            collectionView?.contentInsetAdjustmentBehavior = .never
        }
    }
}
