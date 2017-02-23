//
//  ComposeViewController.swift
//  TwitterCP
//
//  Created by Eric Suarez on 2/23/17.
//  Copyright © 2017 Eric Suarez. All rights reserved.
//

import UIKit

class ComposeViewController: UIViewController {
    
    var loggedInUser: User?
    
    @IBOutlet weak var currentUserImageView: UIImageView!
    @IBOutlet weak var currentUserName: UILabel!
    @IBOutlet weak var currentUserHandle: UILabel!
    @IBOutlet weak var tweetTextArea: UITextView!

    override func viewDidLoad() {
        super.viewDidLoad()
        
        let name = loggedInUser?.name
        let screenname = loggedInUser?.screenname!
        let profileUrl = loggedInUser?.profileUrl
        
        currentUserName.text = name
        currentUserHandle.text = "@\(screenname!)"
        currentUserImageView.setImageWith(profileUrl as! URL)
        
        tweetTextArea.becomeFirstResponder()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func displayAlert(_ title: String, message: String) {
        
        let alert = UIAlertController(title: title, message: message, preferredStyle: UIAlertControllerStyle.alert)
        alert.addAction((UIAlertAction(title: "OK", style: .default, handler: { (action) -> Void in
            self.dismiss(animated: true, completion: nil)
        })))
        
        self.present(alert, animated: true, completion: nil)
        
    }
    
    @IBAction func sendTweet(_ sender: Any) {
        
        if tweetTextArea.text != nil {
            var formattedTweet = tweetTextArea.text.replacingOccurrences(of: " ", with: "%20")
            
            TwitterClient.sharedInstance?.postTweet(tweetContent: formattedTweet)
            
            displayAlert("Tweet Posted!", message: "Your tweet successfully posted!")
            
            tweetTextArea.text = ""
        }
        
        self.dismiss(animated: true, completion: nil)
        
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
