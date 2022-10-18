//
//  DetailViewModel.swift
//  MVVM
//
//  Created by MRGS on 18.10.2022.
//

import Foundation
class DetailViewModel: DetailViewModelType{
    
    private var profile: Profile
    var description: String {
        return profile.name + " " + profile.secondName + " " + profile.age.description
    }
    
    init(profile:Profile){
        self.profile = profile
    }
}
