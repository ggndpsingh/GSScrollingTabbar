//
//  ScrollingTabbar.swift
//  GSScrollingTabbar
//
//  Created by Gagandeep Singh on 2/7/18.
//  Copyright © 2018 Gagandeep Singh. All rights reserved.
//

import Foundation

public class ScrollingTabbar {
    public var tabbar: UIViewController {
        return _tabbar
    }
    
    private var _tabbar: Tabbar
    
    public init(dataSource: ScrollingTabbarDataSource) {
        _tabbar = Tabbar.fromStoryboard
        _tabbar.dataSource = dataSource
    }
    
    public var menuBarStyle: MenuBarStyle = .init() {
        didSet {
            _tabbar.menuBarStyle = menuBarStyle
        }
    }
}

class Tabbar: UIViewController, StoryboardLoading {
    
    //MARK:- Public
    
    public weak var dataSource: ScrollingTabbarDataSource?
    
    public var isScrollEnabled: Bool = true {
        didSet {
            collectionView?.isScrollEnabled = isScrollEnabled
        }
    }
    
    //MARK:- Internal
    
    @IBOutlet weak var menuBar: MenuBar! {
        didSet {
            menuBar.actionHandler = menuBarActionHandler(_:)
        }
    }
    
    @IBOutlet var collectionView: UICollectionView! {
        didSet {
            collectionView.collectionViewLayout = FullScreenLayout()
            collectionView.isPagingEnabled = true
        }
    }
    
    //MARK:- State
    
    private var state: ScrollingTabbar.State = .init() {
        didSet {
            menuBar.state = state
            collectionView.selectItem(at: state.selectedIndex, animated: true, scrollPosition: .centeredHorizontally)
        }
    }
    
    private var _dataSource: ScrollingTabbarDataSource {
        return dataSource ?? DefaultDataSource()
    }
    
    override public func viewDidLoad() {
        super.viewDidLoad()
        menuBar.dataSource = dataSource
        menuBar.style = menuBarStyle
        collectionView.isScrollEnabled = isScrollEnabled
    }
    
    // MARK:- Menu Bar Handler
    
    public var menuBarStyle: MenuBarStyle = .init()
    
    private func menuBarActionHandler(_ action: MenuBar.Action) {
        switch action {
        case .didSelect(let indexPath):
            state = .init(indexPath: indexPath)
        }
    }
}

extension Tabbar {
    public override func willTransition(to newCollection: UITraitCollection, with coordinator: UIViewControllerTransitionCoordinator) {
        super.willTransition(to: newCollection, with: coordinator)
    }
    
    public override func didRotate(from fromInterfaceOrientation: UIInterfaceOrientation) {
        collectionView.collectionViewLayout.invalidateLayout()
        menuBar.collectionView.collectionViewLayout.invalidateLayout()
    }
    
    public override func traitCollectionDidChange(_ previousTraitCollection: UITraitCollection?) {
        collectionView.collectionViewLayout.invalidateLayout()
        menuBar.collectionView.collectionViewLayout.invalidateLayout()
    }
    
    public func collectionView(_ collectionView: UICollectionView, targetContentOffsetForProposedContentOffset proposedContentOffset: CGPoint) -> CGPoint {
        let offset = CGFloat(state.selectedIndex.item) * collectionView.bounds.width
        return CGPoint(x: offset, y: 0)
    }
}

extension Tabbar: UICollectionViewDataSource {
    public func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    public func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return _dataSource.numberOfItemsInTabbar
    }
    
    public func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath) as! MainSectionCell
        let viewController = _dataSource.viewControllerForItem(at: indexPath.item)
        cell.setViewController(viewController, in: self)
        return cell
    }
}

extension Tabbar: UIScrollViewDelegate {
    public func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
        let index = scrollView.contentOffset.x / collectionView.bounds.width
        let indexPath = IndexPath(item: Int(max(0, floor(index))), section: 0)
        state = .init(indexPath: indexPath)
    }
    
    public func scrollViewDidScroll(_ scrollView: UIScrollView) {
        menuBar.handleScroll(to: scrollView.contentOffset.x)
    }
    
    public func scrollViewDidEndScrollingAnimation(_ scrollView: UIScrollView) {
        let index = scrollView.contentOffset.x / collectionView.bounds.width
        let indexPath = IndexPath(item: Int(floor(index)), section: 0)
        state = .init(indexPath: indexPath)
    }
}

extension ScrollingTabbar {
    struct State {
        var selectedIndex: IndexPath
        init(indexPath: IndexPath = IndexPath(item: 0, section: 0)) {
            selectedIndex = indexPath
        }
    }
}
