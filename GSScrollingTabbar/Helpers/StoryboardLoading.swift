//
//  StoryboardLoading.swift
//  GSScrollingTabbar
//
//  Created by Gagandeep Singh on 2/7/18.
//  Copyright © 2018 Gagandeep Singh. All rights reserved.
//

import Foundation

public protocol StoryboardLoading: class {}

extension StoryboardLoading {
    public static var fromStoryboard: Self {
        let storyboard = UIStoryboard(name: "Main", bundle: Bundle(for: Self.self))
        let viewController = storyboard.instantiateViewController(withIdentifier: String(describing: self))
        return viewController as! Self
    }
}
