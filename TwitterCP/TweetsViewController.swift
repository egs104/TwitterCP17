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
    
//    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
//        // Get the new view controller using segue.destinationViewController.
//        // Pass the selected object to the new view controller.
//        
//    }


}
