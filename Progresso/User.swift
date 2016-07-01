//
//  User.swift
//  Progresso
//
//  Created by Roberto Luiz Veiga Junior on 01/07/16.
//  Copyright © 2016 robertoluizveigajunior. All rights reserved.
//

import UIKit
import Parse

extension User {
    func singIn(username:String, password:String, email:String, emailVerified:String, nickname:String, vc:UIViewController){
        let finalEmail = emailVerified.stringByTrimmingCharactersInSet(NSCharacterSet.whitespaceCharacterSet())
        
        // Validate the text fields
//        if countString(username) < 5 {
//            var alert = UIAlertView(title: "Invalid", message: "Username must be greater than 5 characters", delegate: self, cancelButtonTitle: "OK")
//            alert.show()
//            
//        } else if count(password) < 8 {
//            var alert = UIAlertView(title: "Invalid", message: "Password must be greater than 8 characters", delegate: self, cancelButtonTitle: "OK")
//            alert.show()
//            
//        } else if count(email) < 8 {
//            var alert = UIAlertView(title: "Invalid", message: "Please enter a valid email address", delegate: self, cancelButtonTitle: "OK")
//            alert.show()
//            
//        } else {
            // Run a spinner to show a task in progress
            let spinner: UIActivityIndicatorView = UIActivityIndicatorView(frame: CGRectMake(0, 0, 150, 150)) as UIActivityIndicatorView
            spinner.startAnimating()
            
            let newUser = PFUser()
            
            newUser.username = username
            newUser.password = password
            newUser.email = finalEmail
            
            // Sign up the user asynchronously
            newUser.signUpInBackgroundWithBlock({ (succeed, error) -> Void in
                
                // Stop the spinner
                spinner.stopAnimating()
                if ((error) != nil) {
                    let alert = UIAlertController(title: "Error", message: "\(error)", preferredStyle: UIAlertControllerStyle.Alert)
                    alert.showViewController(vc, sender: nil)
                    
                } else {
                    let alert = UIAlertController(title: "Success", message: "Signed Up", preferredStyle: UIAlertControllerStyle.Alert)
                    alert.showViewController(vc, sender: nil)
                    dispatch_async(dispatch_get_main_queue(), { () -> Void in
                        let viewController:UIViewController = UIStoryboard(name: "Main", bundle: nil).instantiateViewControllerWithIdentifier("Home") as! DayTableViewController
                        vc.presentViewController(viewController, animated: true, completion: nil)
                    })
                }
            })
        }
    //}
}

class User: PFUser {
    
    @NSManaged var days: [Day]!
    @NSManaged var nickname: String?
    @NSManaged var emailVerified: String?
    
    override class func initialize() {
        struct Static {
            static var onceToken : dispatch_once_t = 0;
        }
        dispatch_once(&Static.onceToken) {
            self.registerSubclass()
        }
    }

}
