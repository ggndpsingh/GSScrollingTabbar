//
//  MenuBarCell.swift
//  GSScrollingTabbar
//
//  Created by Gagandeep Singh on 24/6/18.
//  Copyright © 2018 Gagandeep Singh. All rights reserved.
//

import UIKit

class MenuBarCell: UICollectionViewCell {
    
    static let identifier = "MenuBarCell"
    
    private var _contentView: UIView?
    
    func setView(_ view: UIView?) {
        _contentView = view
        layoutSubviews()
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        _contentView?.removeFromSuperview()
        
        guard let view = _contentView else { return }
        view.frame = contentView.frame
        view.autoresizingMask = [.flexibleHeight, .flexibleHeight]
        contentView.addSubview(view)
    }
}
