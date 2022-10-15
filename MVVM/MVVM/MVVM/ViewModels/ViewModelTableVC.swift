//
//  ViewModelTableVC.swift
//  MVVM
//
//  Created by MRGS on 16.10.2022.
//

import Foundation


class ViewModelTableVC: TableViewModelType {
    var numberOfRows: Int {
        return profiles.count
    }
   var profiles = [
        Profile(name: "John", secondName: "Smith", age: 33),
        Profile(name: "Kira", secondName: "Ivanova", age: 27),
        Profile(name: "Misha", secondName: "Petrov", age: 33),
    ]
}
