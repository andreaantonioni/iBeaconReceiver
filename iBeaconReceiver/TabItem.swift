//
//  TabItem.swift
//  iBeaconReceiver
//
//  Created by Andrea Antonioni on 15/10/17.
//  Copyright © 2017 Andrea Antonioni. All rights reserved.
//

import UIKit

enum TabItem: String {
    case beacon
    case profile
    
    private static let tabs = [
        "beacon": (title: "iBeacon", image: #imageLiteral(resourceName: "radio_waves"), tag: 1),
        "profile": (title: "Profile", image: #imageLiteral(resourceName: "user"), tag: 2)
    ]
    
    static func tabBarItem(for tabItem: TabItem) -> UITabBarItem {
        let item = tabs[tabItem.rawValue]!
        
        return UITabBarItem(title: item.title, image: item.image, tag: item.tag)
    }
}
