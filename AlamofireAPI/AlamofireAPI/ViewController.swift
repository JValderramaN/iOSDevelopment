//
//  ViewController.swift
//  AlamofireAPI
//
//  Created by uppersky04 on 3/27/15.
//  Copyright (c) 2015 uppersky. All rights reserved.
//

import UIKit
import OAuth2

class ViewController: UIViewController {
    
    let settings = [
        "client_id": "my_swift_app",
        "client_secret": "C7447242-A0CF-47C5-BAC7-B38BA91970A9",
        "authorize_uri": "https://authorize.smartplatforms.org/authorize",
        "token_uri": "https://authorize.smartplatforms.org/token",
        "scope": "profile email",
        "redirect_uris": ["myapp://oauth/callback"],   // don't forget to register this scheme
        ] as OAuth2JSON      // the "as" part may or may not be needed


    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }

    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    
    override func viewDidAppear(animated: Bool) {
        
        	
    }
}

