//
//  TweetsViewController.swift
//  TwitterCP
//
//  Created by Eric Suarez on 2/14/17.
//  Copyright © 2017 Eric Suarez. All rights reserved.
//

import UIKit

class TweetsViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {

    var tweets: [Tweet]!
    var refreshControl: UIRefreshControl!
    
    @IBOutlet weak var tableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        var iconView = UIImageView()
        iconView.image = UIImage(named: "Twitter_Logo_Blue-1.png")
        iconView.frame = CGRect(x: 0, y: 0, width: 40, height: 40)
        iconView.contentMode = .scaleAspectFit
        self.navigationItem.titleView = iconView
        
        tableView.delegate = self
        tableView.dataSource = self
        tableView.rowHeight = UITableViewAutomaticDimension
        tableView.estimatedRowHeight = 80
        
        refreshControl = UIRefreshControl()
        refreshControl.addTarget(self, action: "onRefresh", for: UIControlEvents.valueChanged)
        tableView.insertSubview(refreshControl, at: 0)
        
        self.automaticallyAdjustsScrollViewInsets = false

        fetchTweets()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func onLogoutButton(_ sender: Any) {
        TwitterClient.sharedInstance?.logout()
    }
    
    func fetchTweets() {
        TwitterClient.sharedInstance?.homeTimeline(success: { (tweets: [Tweet])-> () in
            self.tweets = tweets
            
            for tweet in tweets {
                print(tweet.text)
            }
            
            self.tableView.reloadData()
        }, failure: { (error: Error) -> () in
            print(error.localizedDescription)
        })
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if tweets != nil {
            return tweets!.count
        } else {
            return 0
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "TweetCell", for: indexPath) as! TweetCell
        
        cell.tweet = tweets![indexPath.row]
        
        return cell
        
    }
    
    func onRefresh() {
        
        fetchTweets()
        
        self.refreshControl?.endRefreshing()
    }
    
        
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
        
        if let cell = sender as? TweetCell {
            let indexPath = tableView.indexPath(for: cell)
            let tweet = tweets![indexPath!.row]
            
            let detailViewController = segue.destination as! TweetDetailsViewController
            detailViewController.selectedTweet = tweet
        }
        
        if let profilePic = sender as? UIButton {
            if let superview = profilePic.superview {
                if let cell = superview.superview as? TweetCell {
                    let indexPath = tableView.indexPath(for: cell)
                    
                    let tweet = tweets![indexPath!.row]
                    
                    let profileViewController = segue.destination as! ProfileViewController
                    profileViewController.owningUser = tweet.user
                }
            }
        }

        if let composeButton = sender as? UIBarButtonItem {
            let currentUser = User.currentUser
            
            let composeViewController = segue.destination as! ComposeViewController
            composeViewController.loggedInUser = currentUser
        }

        
    }


}
