//
//  Tasks.swift
//  FirebaseApp
//
//  Created by MRGS on 06.09.2022.
//

import Foundation
import FirebaseAuth
import FirebaseDatabase

struct Tasks {
    let title:String 
    var ref:DatabaseReference?
    var completed = false
    
    init(title:String) {
        self.title = title
        self.ref = nil
    }
    init(snapshot: DataSnapshot) {
        let snapshotValue = snapshot.value as! [String:AnyObject]
        title = snapshotValue["title"] as! String
        completed = snapshotValue["completed"] as! Bool
        ref = snapshot.ref
    }
}
