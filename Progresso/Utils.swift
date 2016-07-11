//
//  Utils.swift
//  Progresso
//
//  Created by Roberto Luiz Veiga Junior on 04/07/16.
//  Copyright © 2016 robertoluizveigajunior. All rights reserved.
//

import UIKit

class Utils {
    
    static func saveObjectTemporarily(object: AnyObject, forKey key: String) {
        NSUserDefaults.standardUserDefaults().setObject(object, forKey: key)
    }
    
    static func saveObject(object: AnyObject, forKey key: String) {
        let userDefaults = NSUserDefaults.standardUserDefaults()
        userDefaults.setObject(object, forKey: key)
        userDefaults.synchronize()
    }
    
    static func getObject(key: String) -> AnyObject? {
        return NSUserDefaults.standardUserDefaults().objectForKey(key)
    }

}
