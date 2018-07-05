//
//  MenuBarStyle.swift
//  GSScrollingTabbar
//
//  Created by Gagandeep Singh on 2/7/18.
//  Copyright © 2018 Gagandeep Singh. All rights reserved.
//

public struct MenuBarStyle {
    var barHeight: CGFloat
    var scrollbarHeight: CGFloat
    var scrollbarColor: UIColor
    
    public init(height: CGFloat = 54, scrollbarHeight: CGFloat = 1, scrollbarColor: UIColor = .blue) {
        barHeight = height
        self.scrollbarHeight = scrollbarHeight
        self.scrollbarColor = scrollbarColor
    }
}
