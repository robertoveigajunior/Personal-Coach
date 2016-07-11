//
//  LogInViewController.swift
//  Progresso
//
//  Created by Roberto Luiz Veiga Junior on 01/07/16.
//  Copyright © 2016 robertoluizveigajunior. All rights reserved.
//

import UIKit

class LogInViewController: UIViewController {
    
    @IBOutlet weak var txtUsername: UITextField!
    @IBOutlet weak var txtPassword: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    @IBAction func logInAction(sender: AnyObject) {
        User().logIn(self.txtUsername.text!, _password: self.txtPassword.text!) {
            print("name: \(self.txtUsername.text!)")
            print("password: \(self.txtPassword.text!)")
            print($0)
            if $0 {
                self.performSegueWithIdentifier("sgMainViewController", sender: nil)
            }
        }
        
        
    }
    
    @IBAction func singUpAction(sender: AnyObject) {
        self.performSegueWithIdentifier("sgSingUpViewController", sender: nil)
    }
    
    
}
