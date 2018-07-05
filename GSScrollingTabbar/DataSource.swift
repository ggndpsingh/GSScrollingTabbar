//
//  DataSource.swift
//  GSScrollingTabbar
//
//  Created by Gagandeep Singh on 24/6/18.
//  Copyright © 2018 Gagandeep Singh. All rights reserved.
//

import Foundation

public protocol ScrollingTabbarDataSource: class {
    var numberOfItemsInTabbar: Int { get }
    func viewForMenuBarItem(at index: Int) -> UIView
    func viewForSelectedMenuBarItem(at index: Int) -> UIView
    func viewControllerForItem(at index: Int) -> UIViewController
}

internal class DefaultDataSource: ScrollingTabbarDataSource {
    var numberOfItemsInTabbar: Int {
        return 2
    }
    
    func titleForItem(at index: Int) -> String {
        return "Cell \(index)"
    }
    
    func viewForMenuBarItem(at index: Int) -> UIView {
        let view = UIView()
        return view
    }
    
    func viewForSelectedMenuBarItem(at index: Int) -> UIView {
        let view = UIView()
        return view
    }
    
    func viewControllerForItem(at index: Int) -> UIViewController {
        let view = UIViewController()
        view.view.backgroundColor = index % 2 == 0 ? .blue : .green
        return view
    }
}
