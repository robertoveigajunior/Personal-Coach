//
//  LogInViewController.swift
//  Progresso
//
//  Created by Roberto Luiz Veiga Junior on 01/07/16.
//  Copyright © 2016 robertoluizveigajunior. All rights reserved.
//

import UIKit
import Parse

class LogInViewController: UIViewController {

    @IBOutlet weak var txtUsername: UITextField!
    @IBOutlet weak var txtPassword: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    @IBAction func logInAction(sender: AnyObject) {
        PFUser.logInWithUsernameInBackground(txtUsername.text!, password: txtPassword.text!) { (user, err) in
            if err == nil {
                self.performSegueWithIdentifier("sgMainViewController", sender: nil)
            }
        }
    }
   
    @IBAction func singUpAction(sender: AnyObject) {
        self.performSegueWithIdentifier("sgSingUpViewController", sender: nil)
    }
    

}
