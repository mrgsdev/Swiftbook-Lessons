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
    let userId:String
    var ref:DatabaseReference?
    var completed = false
    
    init(title:String,userId:String) {
        self.title = title
        self.userId = userId
        self.ref = nil
    }
    init(snapshot: DataSnapshot) {
        let snapshotValue = snapshot.value as! [String:AnyObject]
        title = snapshotValue["title"] as! String
        userId = snapshotValue["userId"] as! String
        completed = snapshotValue["completed"] as! Bool
        ref = snapshot.ref
    }
}
