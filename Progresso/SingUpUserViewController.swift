//
//  SingInUserViewController.swift
//  Progresso
//
//  Created by Roberto Luiz Veiga Junior on 01/07/16.
//  Copyright © 2016 robertoluizveigajunior. All rights reserved.
//

import UIKit

class SingUpUserViewController: UIViewController {

    @IBOutlet weak var txtUsername: UITextField!
    @IBOutlet weak var txtPassword: UITextField!
    @IBOutlet weak var txtNickname: UITextField!
    @IBOutlet weak var txtEmail: UITextField!
    @IBOutlet weak var txtEmailVerified: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    @IBAction func singIn(sender: AnyObject) {
        User().singIn(self.txtUsername.text!, password: txtPassword.text!, email: self.txtEmail.text!, emailVerified: self.txtEmailVerified.text!, nickname: self.txtNickname.text!,vc: self)
    }
    @IBAction func cancel(sender: AnyObject) {
        self.dismissViewControllerAnimated(true, completion: nil)
    }
}
