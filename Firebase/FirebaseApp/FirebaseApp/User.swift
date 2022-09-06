//
//  User.swift
//  FirebaseApp
//
//  Created by MRGS on 06.09.2022.
//

import Foundation
import FirebaseAuth
struct User {
    let uid:String
    let email:String 
    init(user: FirebaseAuth.User) {
        self.uid = user.uid
        self.email = user.email!
    }
}
