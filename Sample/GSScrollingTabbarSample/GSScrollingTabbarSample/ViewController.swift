//
//  ViewController.swift
//  GSScrollingTabbarSample
//
//  Created by Gagandeep Singh on 5/7/18.
//  Copyright © 2018 Gagandeep Singh. All rights reserved.
//

import UIKit
import GSScrollingTabbar

class ViewController: UIViewController {

    lazy var sections = ScrollingTabbar(dataSource: self)
    
    let green = SampleTableViewController.loadFromStoryboard()
    let red = SampleTableViewController.loadFromStoryboard()
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        sections.menuBarStyle = MenuBarStyle(height: 32, scrollbarHeight: 2, scrollbarColor: .red)
        present(sections.tabbar, animated: true)
        green.rowCount = 10
        red.rowCount = 40
    }
}

extension ViewController: ScrollingTabbarDataSource {
    var numberOfItemsInTabbar: Int {
        return 2
    }
    
    func viewForMenuBarItem(at index: Int) -> UIView {
        let cell = menubarCell(at: index)
        cell.titleLabel.textColor = .lightGray
        return cell
    }
    
    func viewForSelectedMenuBarItem(at index: Int) -> UIView {
        let cell = menubarCell(at: index)
        cell.titleLabel.textColor = .red
        return cell
    }
    
    func viewControllerForItem(at index: Int) -> UIViewController {
        return index % 2 == 0 ? green : red
    }
    
    private func menubarCell(at index: Int) -> MenuBarCell {
        guard let cell = MenuBarCell.view else {
            return MenuBarCell()
        }
        
        let title: String = {
            switch index {
            case 0:
                return "Templates"
            case 1:
                return "Audits"
            case 2:
                return "Actions"
            default:
                return "Schedule"
            }
        }()
        
        cell.titleLabel.text = title
        return cell
    }
}

protocol StoryboardLoading {}
extension StoryboardLoading {
    static func loadFromStoryboard() -> Self {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let viewController = storyboard.instantiateViewController(withIdentifier: String(describing: self))
        return viewController as! Self
    }
}
