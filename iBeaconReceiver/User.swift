//
//  User.swift
//  iBeaconReceiver
//
//  Created by Andrea Antonioni on 14/10/17.
//  Copyright © 2017 Andrea Antonioni. All rights reserved.
//

import UIKit

struct User {
    var fullname: String
    var avatar: UIImage
    
    init(fullname: String, avatar: UIImage) {
        self.fullname = fullname
        self.avatar = avatar
    }
}
