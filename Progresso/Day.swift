//
//  Day.swift
//  Progresso
//
//  Created by Roberto Luiz Veiga Junior on 30/06/16.
//  Copyright © 2016 robertoluizveigajunior. All rights reserved.
//

import UIKit
import Parse

extension Day {
    func saveDay(score:Int,message:String) {
        self.score = score
        self.message = message
        self.saveInBackground()
    }
}

class Day: PFObject,  PFSubclassing {
    
    @NSManaged var score: Int
    @NSManaged var message: String?
    
    static func parseClassName() -> String {
        return "Day"
    }
}

