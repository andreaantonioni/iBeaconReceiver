//
//  Storyboard.swift
//  iBeaconReceiver
//
//  Created by Andrea Antonioni on 14/10/17.
//  Copyright © 2017 Andrea Antonioni. All rights reserved.
//

import UIKit

enum Storyboard: String {
    case Main
    
    func instantiate<VC: UIViewController>(_ viewController: VC.Type) -> VC {
        guard
            let vc = UIStoryboard(name: self.rawValue, bundle: nil)
                .instantiateViewController(withIdentifier: VC.storyboardIdentifier) as? VC
            else { fatalError("Couldn't instantiate \(VC.storyboardIdentifier) from \(self.rawValue)") }
        return vc
    }
    
}

extension UIViewController {
    public static var storyboardIdentifier: String {
        return self.description().components(separatedBy: ".").dropFirst().joined(separator: ".")
    }
}
