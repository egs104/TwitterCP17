//
//  TwitterClient.swift
//  TwitterCP
//
//  Created by Eric Suarez on 2/4/17.
//  Copyright © 2017 Eric Suarez. All rights reserved.
//

import UIKit
import BDBOAuth1Manager

class TwitterClient: BDBOAuth1SessionManager {

    static let sharedInstance =  TwitterClient(baseURL: NSURL(string: "https://api.twitter.com") as URL!, consumerKey: "P0w9xlvpJqS3oYL6aynKDViom", consumerSecret: "KxmThEncKNX6UWIgfk4cl2YBSulToHF1FhB1CRc7jRvQzHnATl")
    
    var loginSuccess: (() -> ())?
    var loginFailure: ((Error) -> ())?
    
    func login(success: @escaping ()->(), failure: @escaping (Error)->()) {
        loginSuccess = success
        loginFailure = failure
        
        TwitterClient.sharedInstance?.deauthorize()
        TwitterClient.sharedInstance?.fetchRequestToken(withPath: "oauth/request_token", method: "GET", callbackURL: NSURL(string: "mytwitterdemo://oauth") as URL!, scope: nil, success: { (requestToken: BDBOAuth1Credential?)  in
            
            let url = NSURL(string: "https://api.twitter.com/oauth/authorize?oauth_token=\((requestToken?.token)!)")!
            
            UIApplication.shared.openURL(url as URL)
            
        }, failure: { (error: Error?) in
            print("error: \(error!.localizedDescription)")
            self.loginFailure?((error)!)
        })

    }
    
    func logout() {
        User.currentUser = nil
        deauthorize()
        
        NotificationCenter.default.post(name: NSNotification.Name(rawValue: User.userDidLogoutNotification), object: nil)
    }
    
    func handleOpenUrl(url: URL) {
        let requestToken = BDBOAuth1Credential(queryString: url.query)
        fetchAccessToken(withPath: "oauth/access_token", method: "POST", requestToken: requestToken, success: { (accessToken: BDBOAuth1Credential?) in
            
            self.currentAccount(success: { (user: User) -> () in
                User.currentUser = user
                self.loginSuccess?()
            }, failure: { (error: Error) -> () in
                self.loginFailure?(error)
            })
            
        }, failure: { (error: Error?) in
            print("error: \(error?.localizedDescription)")
            self.loginFailure?(error!)
        })

    }
    
    func homeTimeline(success: @escaping ([Tweet]) -> (), failure: @escaping (Error) -> ()) {
        get("1.1/statuses/home_timeline.json", parameters: nil, progress: nil, success: { (task: URLSessionDataTask, response: Any?) in
            let dictionaries = response as? [NSDictionary]
            
            print(dictionaries)
            
            let tweets = Tweet.tweetsWithArray(dictionaries: dictionaries!)
            
            success(tweets)
            
        }, failure: { (task: URLSessionDataTask?, error: Error) in
            print("error")
            failure(error)
        })
    }
    
    func currentAccount(success: @escaping (User) -> (), failure: @escaping (Error) -> ()) {
        get("1.1/account/verify_credentials.json", parameters: nil, progress: nil, success: { (task: URLSessionDataTask, response: Any?) in
            let userDictionary = response as? NSDictionary
            
            let user = User(dictionary: userDictionary!)
            
            print("name: \(user.name)")
            
            success(user)
            
        }, failure: { (task: URLSessionDataTask?, error: Error) in
            print("error")
            failure(error)
        })
    }
    
}
