//
//  User.swift
//  Progresso
//
//  Created by Roberto Luiz Veiga Junior on 01/07/16.
//  Copyright © 2016 robertoluizveigajunior. All rights reserved.
//

import UIKit
import RealmSwift
import Alamofire

extension User {
    func singUp(_username:String, _password:String, _email:String, _emailVerified:String, _nickname:String, _vc:UIViewController){
        let finalEmail = _emailVerified.stringByTrimmingCharactersInSet(NSCharacterSet.whitespaceCharacterSet())
        
        let params = ["username":_username,
                      "password":_password,
                      "email":finalEmail,
                      "emailVerified":_emailVerified,
                      "nickname":_nickname]
        
        let headers = ["X-Parse-Application-Id": Keys.APPID,
                       "X-Parse-REST-API-Key": Keys.RESTAPIKEY,
                       "Content-Type": "application/json"]
        Alamofire.request(.POST, Keys.USERS, parameters: params, headers: headers)
            .responseJSON { response in
                print(response.response) // URL response
                print(response.data)     // server data
                print(response.result)   // result of response serialization
                
                if let JSON = response.result.value {
                    print("JSON: \(JSON)")
                }
                let viewController:UIViewController = UIStoryboard(name: "Main", bundle: nil).instantiateViewControllerWithIdentifier("Home") as! DayTableViewController
                _vc.presentViewController(viewController, animated: true, completion: nil)
        }
    }
    
    func logInWithUsername(_username:String, _password:String,onCompletion:Bool -> ()){
        
        let params = ["username":_username,
                      "password":_password]
        
        let headers = ["X-Parse-Application-Id": Keys.APPID,
            "X-Parse-REST-API-Key": Keys.RESTAPIKEY]
        
        Alamofire.request(.GET, Keys.LOGIN, parameters: params, headers: headers)
            .responseJSON { response in
                print(response.result)
                if let JSON = response.result.value {
                    print("JSON: \(JSON)")
                }
                onCompletion(true)
        }
    }
}

class User: Object {
    
    dynamic var username: String?
    dynamic var password: String?
    dynamic var nickname: String?
    dynamic var email: String?
    dynamic var emailVerified: String?
    
}
