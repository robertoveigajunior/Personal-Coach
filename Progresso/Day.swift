//
//  Day.swift
//  Progresso
//
//  Created by Roberto Luiz Veiga Junior on 30/06/16.
//  Copyright © 2016 robertoluizveigajunior. All rights reserved.
//

import UIKit
import RealmSwift
import Alamofire

extension Day {
    func saveDay(score:Int,message:String) {
        self.score = score
        self.message = message
        self.save()
    }
    func checkDayAvailable(onCompletion:[Day] -> ()) {
        let headers =  ["X-Parse-Application-Id": Keys.APPID,
                        "X-Parse-REST-API-Key": Keys.RESTAPIKEY]
        
        Alamofire.request(.GET, Keys.DAY, headers: headers)
            .responseJSON { response in
                let realm = try! Realm()
                try! realm.write {
                    let json = try! NSJSONSerialization.JSONObjectWithData(response.data!, options: NSJSONReadingOptions())
                    realm.create(Day.self, value: json, update: true)
                }
        }
    }
}

class Day: Object {
    
    @NSManaged var score: Int
    @NSManaged var message: String?
    
    private func save() {
        
    }
}

