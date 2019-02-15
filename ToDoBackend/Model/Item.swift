//
//  Item.swift
//  ToDoBackend
//
//  Created by siddharth on 15/02/19.
//  Copyright © 2019 clarionTechnologies. All rights reserved.
//

import Foundation
import Firebase

class Item {
    
    var ref: DatabaseReference?
    var title: String?
    
    init (snapshot: DataSnapshot) {
        ref = snapshot.ref
        
        let data = snapshot.value as! Dictionary<String, String>
        title = data["title"]! as String
    }

}
