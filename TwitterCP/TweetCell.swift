//
//  TweetCell.swift
//  TwitterCP
//
//  Created by Eric Suarez on 2/14/17.
//  Copyright © 2017 Eric Suarez. All rights reserved.
//

import UIKit

class TweetCell: UITableViewCell {
    
    
    @IBOutlet weak var userProfilePic: UIImageView!
    @IBOutlet weak var usernameLabel: UILabel!
    @IBOutlet weak var timestampLabel: UILabel!
    @IBOutlet weak var tweetTextLabel: UILabel!
    @IBOutlet weak var retweetCountLabel: UILabel!
    @IBOutlet weak var favoriteCountLabel: UILabel!
    @IBOutlet weak var retweetButton: UIButton!
    @IBOutlet weak var favoriteButton: UIButton!

    var tweet: Tweet! {
        didSet {
            usernameLabel.text = tweet.username
            tweetTextLabel.text = tweet.text
            userProfilePic.setImageWith(URL(string: tweet.profilePicUrl!)!)
            timestampLabel.text = "\(tweet.timestampString!)"
            retweetCountLabel.text = "\(tweet.retweetCount)"
            favoriteCountLabel.text = "\(tweet.favoriteCount)"
        }
    }

    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        
        userProfilePic.layer.cornerRadius = 3
        userProfilePic.clipsToBounds = true
        
        tweetTextLabel.preferredMaxLayoutWidth = tweetTextLabel.frame.size.width
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        tweetTextLabel.preferredMaxLayoutWidth = tweetTextLabel.frame.size.width
    }


    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

    @IBAction func retweetPressed(_ sender: Any) {
        
        if tweet.didRetweet == 0 {
            retweetButton.setImage(UIImage(named: "retweet-action-on-pressed"), for: .normal)
            tweet.retweetCount += 1
            tweet.didRetweet = 1
            retweetCountLabel.text = "\(tweet.retweetCount)"
            return
        }
        
        if tweet.didRetweet == 1 {
            retweetButton.setImage(UIImage(named: "retweet-action"), for: .normal)
            tweet.retweetCount -= 1
            tweet.didRetweet = 0
            retweetCountLabel.text = "\(tweet.retweetCount)"
            return
        }
        
    }
    
    
    @IBAction func favoritePressed(_ sender: Any) {
    
        if tweet.didFavorite == 0 {
            favoriteButton.setImage(UIImage(named: "like-action-on-pressed"), for: .normal)
            tweet.favoriteCount += 1
            tweet.didFavorite = 1
            favoriteCountLabel.text = "\(tweet.favoriteCount)"
            return
        }
        
        if tweet.didFavorite == 1 {
            favoriteButton.setImage(UIImage(named: "like-action"), for: .normal)
            tweet.favoriteCount -= 1
            tweet.didFavorite = 0
            favoriteCountLabel.text = "\(tweet.favoriteCount)"
            return
        }

    
    }
}
