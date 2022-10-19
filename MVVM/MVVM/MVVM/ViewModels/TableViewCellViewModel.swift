//
//  File.swift
//  MVVM
//
//  Created by MRGS on 16.10.2022.
//

import Foundation
class TableViewCellViewModel:TableViewCellViewModelType {
    var fullName: String {
        return profile.name + " " + profile.secondName
    }
    
    var age: String {
        return profile.age.description
    }
    
    private var profile: Profile
    
    init(profile: Profile) {
        self.profile = profile
    }
}
