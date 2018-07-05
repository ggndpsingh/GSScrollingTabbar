//
//  MenuBarLayout.swift
//  GSScrollingTabbar
//
//  Created by Gagandeep Singh on 2/7/18.
//  Copyright © 2018 Gagandeep Singh. All rights reserved.
//

class MenuBarLayout: UICollectionViewFlowLayout {
    override func prepare() {
        super.prepare()
        
        minimumLineSpacing = 0
        minimumInteritemSpacing = 0
        itemSize = {
            guard let collectionView = collectionView else { return .zero }
            let items = CGFloat(collectionView.numberOfItems(inSection: 0))
            let cvSize = collectionView.bounds.size
            return CGSize(width: cvSize.width / items, height: cvSize.height)
        }()
        scrollDirection = .horizontal
        
        if #available(iOS 11.0, *) {
            collectionView?.contentInsetAdjustmentBehavior = .never
        }
    }
}
