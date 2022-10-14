//
//  ViewModel.swift
//  MVVM
//
//  Created by MRGS on 14.10.2022.
//

import Foundation
class ViewModel {
    private var profile = Profile(name: "John", secondName: "Smith", age: 33)
    
    var name: String {
        return profile.name
    }
    
    var secondName: String {
        return profile.secondName
    }
    
    var age: String {
        return profile.age.description
    }
}
