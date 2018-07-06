//
//  MenuBar.swift
//  GSScrollingTabbar
//
//  Created by Gagandeep Singh on 24/6/18.
//  Copyright © 2018 Gagandeep Singh. All rights reserved.
//

import UIKit

class MenuBar: UIView, UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout {
    
    enum Action {
        case didSelect(indexPath: IndexPath)
    }
    
    var layout: UICollectionViewFlowLayout {
        return MenuBarLayout()
    }
    
    @IBOutlet var collectionView: UICollectionView!
    @IBOutlet var collectionViewHeightAnchor: NSLayoutConstraint!
    @IBOutlet var scrollBar: UIView!
    @IBOutlet var scrollBarWidthAnchor: NSLayoutConstraint!
    @IBOutlet var scrollBarLeadingAnchor: NSLayoutConstraint!
    @IBOutlet var scrollBarHeightAnchor: NSLayoutConstraint!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        let selectedIndexPath = IndexPath(item: 0, section: 0)
        collectionView.scrollToItem(at: selectedIndexPath, at: .centeredHorizontally, animated: true)
        collectionView.collectionViewLayout = layout
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        collectionViewHeightAnchor.constant = style.barHeight
        scrollBarWidthAnchor.constant = itemWidth
        scrollBarHeightAnchor.constant = style.scrollbarHeight
        scrollBar.backgroundColor = style.scrollbarColor
    }
    
    private var itemWidth: CGFloat {
        return collectionView.bounds.width / CGFloat(_dataSource.numberOfItemsInTabbar)
    }
    
    internal weak var dataSource: ScrollingTabbarDataSource?
    private var _dataSource: ScrollingTabbarDataSource {
        return dataSource ?? DefaultDataSource()
    }
    
    var state: ScrollingTabbar.State = .init() {
        didSet {
            collectionView.reloadData()
        }
    }
    
    var actionHandler: ((Action) -> ())?
    
    var style: MenuBarStyle = .init()
    
    func selectItem(at index: Int) {
        let indexPath = IndexPath(item: index, section: 0)
        collectionView.scrollToItem(at: indexPath, at: .centeredHorizontally, animated: true)
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return _dataSource.numberOfItemsInTabbar
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: MenuBarCell.identifier, for: indexPath as IndexPath) as! MenuBarCell
        if indexPath == state.selectedIndex {
            cell.setView(dataSource?.viewForSelectedMenuBarItem(at: indexPath.item))
        } else {
            cell.setView(dataSource?.viewForMenuBarItem(at: indexPath.item))
        }
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 0
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        actionHandler?(.didSelect(indexPath: indexPath))
    }
}

extension MenuBar {
    func updatesScrollBar() {
        let offset = CGFloat(state.selectedIndex.item) * itemWidth
        scrollBarLeadingAnchor.constant = offset
        
        UIView.animate(withDuration: 0.3, delay: 0, usingSpringWithDamping: 1, initialSpringVelocity: 0.7, options: .curveEaseInOut, animations: {
            self.layoutIfNeeded()
        }, completion: nil)
    }
    
    func handleScroll(to position: CGFloat) {
        scrollBarLeadingAnchor.constant = position / CGFloat(collectionView.numberOfItems(inSection: 0))
    }
}
