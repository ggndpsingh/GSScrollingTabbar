//
//  NibLoading.swift
//  GSScrollingTabbarSample
//
//  Created by Gagandeep Singh on 1/7/18.
//  Copyright © 2018 Gagandeep Singh. All rights reserved.
//

import Foundation

protocol NibLoading {}
extension NibLoading {
    static var view: Self? {
        return Bundle.main.loadNibNamed(String(describing: self.self), owner: nil, options: nil)?.first as? Self
    }
}
