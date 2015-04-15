//
//  ViewController.swift
//  TwitterAuth
//
//  Created by uppersky04 on 3/24/15.
//  Copyright (c) 2015 uppersky. All rights reserved.
//

import UIKit
import Fabric
import TwitterKit
import Alamofire

class ViewController: UIViewController,TWTRTweetViewDelegate{
    
    @IBOutlet weak var tableView: UITableView!
    
    
    //TWTRTweetView?
    
    var tweets: [TWTRTweet] = [] {
        didSet {
            tableView.reloadData()
        }
    }
    
    var tweetIDs = ["356855095494840320",
        "415538817731690496"]
    

    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        
        
        
        
        Twitter.sharedInstance().startWithConsumerKey("kafEUW9iZNrFMi090P15Oc1lH",
        consumerSecret: "K6mEAfaf4lGh6nS6MEpiU7ktfYkRRjXqq1Cafvez5zvWmlkb3w")
        
    Fabric.with([Twitter.sharedInstance()])
        
        Twitter.sharedInstance().APIClient.loadUserWithID(Twitter.sharedInstance().session().userID, completion: {
            (user: TWTRUser!, error: NSError!) in
            
            
            if (user != nil) {
                println("signed in as \(user.userID)");
                
            } else {
                println("error: \(error.localizedDescription)");
            }
            
        })
        



        
        Alamofire.request(.GET, "https://api.twitter.com/1.1/search/tweets.json?q=javn92&count=100").responseJSON() {
            (_, _, data, _) in
            println(data)
        }
        
       /* let logInButton = TWTRLogInButton(logInCompletion: {
            (session: TWTRSession!, error: NSError!) in
            
            
            if (session != nil) {
                println("signed in as \(session.userName)");
            } else {
                println("error: \(error.localizedDescription)");
            }
            
            
        })
        logInButton.center = self.view.center
        self.view.addSubview(logInButton)
*/
        
        // Do any additional setup after loading the view, typically from a nib.
        
        
     /*
        Twitter.sharedInstance().logInGuestWithCompletion { (session: TWTRGuestSession!, error: NSError!) in
            Twitter.sharedInstance().APIClient.loadTweetWithID("415538817731690496") { (tweet: TWTRTweet!, error: NSError!) in
                self.tweet2.configureWithTweet(tweet)
            }
        }
*/
        
        
        loadTweets()
        
        
        Twitter.sharedInstance().logInGuestWithCompletion { session, error in
            if let validSession = session {
                Twitter.sharedInstance().APIClient.loadTweetWithID("20") { tweet, error in
                    if let t = tweet {
                        //self.tweetView?.configureWithTweet(t)
                    } else {
                        println("Failed to load Tweet: \(error.localizedDescription)")
                    }
                }
            } else {
                println("Unable to login as guest: \(error.localizedDescription)")
            }
        }
    
        
        
    }
    
    
    func loadTweets(){
            // Load Tweets
            Twitter.sharedInstance().APIClient.loadTweetsWithIDs(tweetIDs) { tweets, error in
                if let ts = tweets as? [TWTRTweet] {
                    self.tweets = ts
                } else {
                    println("Failed to load tweets: \(error.localizedDescription)")
                }
            }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func logInButtonTapped(sender: UIButton) {
        Twitter.sharedInstance().logInWithCompletion {
            (session : TWTRSession!, error : NSError!) -> Void in
            if (session != nil) {
                println("signed in as \(session.userName)");
                //self.ses = session
            } else {
                println("error: \(error.localizedDescription)");
            }
        }
    }
    
    @IBAction func logOutButtonTapped(sender: UIButton) {
        println("deslogeo")
        Twitter.sharedInstance().logOut()
    }

    @IBAction func sendTweetButtonTapped(sender: UIButton) {
        let composer = TWTRComposer()
        
        composer.setText("just setting up my Fabric")
        composer.setImage(UIImage(named: "apple_logo.jpg"))

        
        
        composer.showWithCompletion { (result) -> Void in

            if (result == TWTRComposerResult.Cancelled) {
                println("Tweet composition cancelled")
            }
            else {
                println("Sending tweet!")
            }
        }
    }
    
    
    

// MARK: UITableViewDelegate Methods
 func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    return self.tweets.count
}

 func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
    let tweet = tweets[indexPath.row]
    let cell = tableView.dequeueReusableCellWithIdentifier("tweetCell", forIndexPath: indexPath) as TWTRTweetTableViewCell
    
   // cell.tweetView = T
    //let cell = tableView.dequeueReusableCellWithIdentifier("tweetCell", forIndexPath: indexPath) as UITableViewCell
    //cell.textLabel?.text = "aca"
    
    cell.configureWithTweet(tweet)
    
    
    return cell
}

    /*
 func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
    let tweet = tweets[indexPath.row]
    return TWTRTweetTableViewCell.heightForTweet(tweet, width: CGRectGetWidth(self.view.bounds))
}*/

    @IBAction func loadTweetsButtonTapped(sender: UIButton) {
        tweetIDs.append("580488625080672257")
        loadTweets()
    }
    
    func tweetView(tweetView: TWTRTweetView!, didSelectTweet tweet: TWTRTweet!) {
        println("Tweet selected: \(tweet)")
    }

    
}

