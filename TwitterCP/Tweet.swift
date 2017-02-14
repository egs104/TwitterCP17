//
//  Tweet.swift
//  TwitterCP
//
//  Created by Eric Suarez on 2/4/17.
//  Copyright © 2017 Eric Suarez. All rights reserved.
//

import UIKit

class Tweet: NSObject {

    var text: String?
    var timestamp: Date?
    var timestampString: String?
    var retweetCount: Int = 0
    var favoriteCount: Int = 0
    var user: User?
    var username: String?
    var handle: String?
    var profilePicUrl: String?
    var didRetweet: Int?
    var didFavorite: Int?
    
    init(dictionary: NSDictionary) {
        text = dictionary["text"] as? String
        
        retweetCount = (dictionary["retweet_count"] as? Int) ?? 0
        favoriteCount = (dictionary["favorite_count"] as? Int) ?? 0
        user = User(dictionary: dictionary["user"] as! NSDictionary) as? User
        username = (user?.name)! as String
        handle = (user?.screenname)! as String
        profilePicUrl = user?.dictionary?["profile_image_url_https"] as? String
        didRetweet = (dictionary["favorited"] as? Bool)! ? 1 : 0
        didFavorite = (dictionary["retweeted"] as? Bool)! ? 1 : 0

        
        timestampString = dictionary["created_at"] as? String
        
        let formatter = DateFormatter()
        formatter.dateFormat = "EEE MMM d HH:mm:ss Z y"
        timestamp = formatter.date(from: timestampString!)
        formatter.dateStyle = .short
        formatter.timeStyle = .short
        timestampString = formatter.string(from: timestamp!)
        
        
    }
    
    class func tweetsWithArray(dictionaries: [NSDictionary]) -> [Tweet] {
        var tweets = [Tweet]()
        
        for dictionary in dictionaries {
            let tweet = Tweet(dictionary: dictionary)
            
            tweets.append(tweet)
        }
        
        return tweets
    }
    
}
