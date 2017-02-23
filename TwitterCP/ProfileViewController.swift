//
//  ProfileViewController.swift
//  TwitterCP
//
//  Created by Eric Suarez on 2/23/17.
//  Copyright © 2017 Eric Suarez. All rights reserved.
//

import UIKit

class ProfileViewController: UIViewController {
    
    var owningUser: User?

    @IBOutlet weak var profilePicImageView: UIImageView!
    @IBOutlet weak var coverPhotoImageView: UIImageView!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var handleLabel: UILabel!
    @IBOutlet weak var tweetCountLabel: UILabel!
    @IBOutlet weak var followingCountLabel: UILabel!
    @IBOutlet weak var followersCountLabel: UILabel!
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        profilePicImageView.setImageWith(owningUser?.profileUrl as! URL)
        
        var coverPhotoUrl = owningUser?.coverPhotoUrl
        
        if let coverPhotoUrl = coverPhotoUrl {
            coverPhotoImageView.setImageWith(URL(string: owningUser!.coverPhotoUrl!)!)
        }
        
        tweetCountLabel.text = "\(owningUser!.tweetCount!)"
        followersCountLabel.text = "\(owningUser!.followersCount!)"
        followingCountLabel.text = "\(owningUser!.followingCount!)"
        nameLabel.text = owningUser?.name!
        handleLabel.text = "@\(owningUser!.screenname!)"
        
        profilePicImageView.layer.cornerRadius = 3
        profilePicImageView.clipsToBounds = true
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
