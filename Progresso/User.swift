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
    var currentUser: User? {
        if let user = Utils.getObject(Keys.CURRENTUSER) {
            return user as? User
        } else {
            return nil
        }
    }
}



class User: Object {
    
    dynamic var username: String?
    dynamic var password: String?
    dynamic var nickname: String?
    dynamic var email: String?
    dynamic var emailVerified: String?
    
    private func singUpMakeParams(username: String!,password: String!,email: String!,emailVerified: String!,nickname: String!) -> [String : AnyObject]! {
        return ["username":username,
                "password":password,
                "email":email,
                "emailVerified":emailVerified,
                "nickname":nickname]
    }
    
    private func singUpMakeHeaders() -> [String : String]! {
        return ["X-Parse-Application-Id": Keys.APPID,
                "X-Parse-REST-API-Key": Keys.RESTAPIKEY,
                "Content-Type": "application/json"]
    }
    
    private func logInMakeParams(username: String!,password: String!) -> [String : AnyObject]! {
        return ["username":username,
                "password":password]
    }
    
    private func logInMakeHeaders() -> [String:String]{
        return ["X-Parse-Application-Id": Keys.APPID,
                "X-Parse-REST-API-Key": Keys.RESTAPIKEY]
    }
    
    func singUp(_username: String, _password: String, _email: String, _emailVerified: String, _nickname: String, _vc: UIViewController){
        let finalEmail = _email.stringByTrimmingCharactersInSet(NSCharacterSet.whitespaceCharacterSet())
        let params = self.singUpMakeParams(_username, password: _password, email: finalEmail, emailVerified: _emailVerified, nickname: _nickname)!
        let headers = self.singUpMakeHeaders()
        
        Alamofire.request(.POST, Keys.USERS, parameters: params, headers: headers)
            .responseJSON {
                if let JSON = $0.result.value {
                    print("JSON: \(JSON)")
                }
                let viewController:UIViewController = UIStoryboard(name: "Main", bundle: nil).instantiateViewControllerWithIdentifier("Home") as! DayTableViewController
                _vc.presentViewController(viewController, animated: true, completion: nil)
        }
    }
    
    
    
    func singIn(_username: String, _password: String, onCompletion: Bool -> ()){
        let post = "username=\(username)&password=\(password)"
        let url = NSURL(string: Keys.SERVERURL)
        
        let postData = post.dataUsingEncoding(NSASCIIStringEncoding)!
        
        let request = NSMutableURLRequest(URL: url!)
        let session = NSURLSession.sharedSession()
        let postLength = String( postData.length )
        
        request.HTTPMethod = "POST"
        request.HTTPBody = postData
        request.setValue(postLength, forHTTPHeaderField: "Content-Length")
        request.setValue("X-Parse-Application-Id", forHTTPHeaderField: Keys.APPID)
        request.setValue("X-Parse-REST-API-Key", forHTTPHeaderField: Keys.RESTAPIKEY)

        request.cachePolicy = NSURLRequestCachePolicy.ReloadIgnoringCacheData
        
        let task = session.dataTaskWithRequest(request) {
            
            guard let _:NSData = $0, let _:NSURLResponse = $1  where $2 == nil else {
                print("error")
                onCompletion(false)
                return
            }
            
            let dataString = NSString(data: $0!, encoding: NSUTF8StringEncoding)
            print(dataString.debugDescription)
            
            
            //onCompletion(true)
        }
        
        task.resume()
    
    }
    
    func logIn(_username: String, _password: String, onCompletion: Bool -> ()){
        let params = self.logInMakeParams(_username, password: _password)
        let headers = self.logInMakeHeaders()
        
        Alamofire.request(.GET, Keys.LOGIN, parameters: params, headers: headers)
            .authenticate(user: _username, password: _password)
            .responseJSON { response in
                switch response.result {
                case .Failure:
                    print("error: \(response.result.error?.description) code: \(response.result.error?.code)")
                    onCompletion(false)
                case .Success:
                    print(response.result.debugDescription)
                    onCompletion(false)
                }
        }
    }
}
