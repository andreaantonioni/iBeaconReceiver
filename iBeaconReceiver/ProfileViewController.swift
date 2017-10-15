//
//  ProfileViewController.swift
//  iBeaconReceiver
//
//  Created by Andrea Antonioni on 14/10/17.
//  Copyright © 2017 Andrea Antonioni. All rights reserved.
//

import UIKit

class ProfileViewController: UITableViewController {

    @IBOutlet weak var fullnameLabel: UILabel!
    @IBOutlet weak var imageView: UIImageView!
    
    var user: User!
    
    // MARK: - Instantiate
    
    static func instantiate(withUser user: User) -> ProfileViewController {
        let viewController = Storyboard.Main.instantiate(ProfileViewController.self)
        viewController.user = user
        return viewController
    }
    
    // MARK: - View cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()

        self.title = "Profile"
    
        styleConfiguration()
        
        fullnameLabel.text = user.fullname
        imageView.image = user.avatar
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    private func styleConfiguration() {
        imageView.layer.cornerRadius = imageView.frame.width/2
        imageView.clipsToBounds = true
    }

}
