//
//  TweetDetailsViewController.swift
//  TwitterCP
//
//  Created by Eric Suarez on 2/15/17.
//  Copyright © 2017 Eric Suarez. All rights reserved.
//

import UIKit

class TweetDetailsViewController: UIViewController {
    
    var selectedTweet: Tweet?
    
    @IBOutlet weak var profilePicImageView: UIImageView!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var handleLabel: UILabel!
    @IBOutlet weak var tweetContentLabel: UILabel!
    @IBOutlet weak var retweetsLabel: UILabel!
    @IBOutlet weak var favoritesLabel: UILabel!
    @IBOutlet weak var timestampLabel: UILabel!
    

    override func viewDidLoad() {
        super.viewDidLoad()

        profilePicImageView.setImageWith(NSURL(string: (selectedTweet?.profilePicUrl)!)! as URL)
        nameLabel.text = selectedTweet?.username
        handleLabel.text = "@\(selectedTweet!.handle!)"
        tweetContentLabel.text = selectedTweet?.text
        retweetsLabel.text = "\(selectedTweet!.retweetCount)"
        favoritesLabel.text = "\(selectedTweet!.favoriteCount)"
        timestampLabel.text = "\(selectedTweet!.timestampString!)"
        
        profilePicImageView.layer.cornerRadius = 3
        profilePicImageView.clipsToBounds = true

    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
        
        favoritesLabel.sizeToFit()
        retweetsLabel.sizeToFit()
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
