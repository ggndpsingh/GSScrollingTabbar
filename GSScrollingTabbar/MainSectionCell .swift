//
//  MainSectionCell .swift
//  GSScrollingTabbar
//
//  Created by Gagandeep Singh on 24/6/18.
//  Copyright © 2018 Gagandeep Singh. All rights reserved.
//

import UIKit

class MainSectionCell: UICollectionViewCell {
    
    @IBOutlet var container: UIView!
    private weak var viewController: UIViewController?
    
    func setViewController(_ viewController: UIViewController, in container: UIViewController) {
        guard self.viewController == nil || self.viewController != viewController else { return }
        self.viewController = viewController
        
        container.addChild(viewController)
        viewController.didMove(toParent: container)
        addSubview(viewController.view)
        viewController.view.translatesAutoresizingMaskIntoConstraints =  false
        viewController.view.leadingAnchor.constraint(equalTo: leadingAnchor).isActive = true
        viewController.view.trailingAnchor.constraint(equalTo: trailingAnchor).isActive = true
        viewController.view.topAnchor.constraint(equalTo: topAnchor).isActive = true
        viewController.view.bottomAnchor.constraint(equalTo: bottomAnchor).isActive = true
        viewController.view.frame = frame
        viewController.view.autoresizingMask = [.flexibleWidth, .flexibleHeight]
    }
}
