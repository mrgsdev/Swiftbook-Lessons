//
//  ViewModelTableVC.swift
//  MVVM
//
//  Created by MRGS on 16.10.2022.
//

import Foundation


class ViewModelTableVC: TableViewViewModelType {
    
    
    private var selectedIndexPath: IndexPath?
    func cellForViewModel(forIndexPath indexPath : IndexPath) -> TableViewCellViewModelType? {
        let profile = profiles[indexPath.row]
        return TableViewCellViewModel(profile:profile)
    }
    
    func numberOfRows() -> Int {
        return profiles.count
    }
    
   var profiles = [
        Profile(name: "John", secondName: "Smith", age: 33),
        Profile(name: "Kira", secondName: "Ivanova", age: 27),
        Profile(name: "Misha", secondName: "Petrov", age: 33),
    ]
    
     
    
    func viewModelForSelectedRow() -> DetailViewModelType? {
        guard let selectedIndexPath = selectedIndexPath else { return nil }
        return DetailViewModel(profile: profiles[selectedIndexPath.row])
    }
    
    func selectRow(atIndexPath indexPath: IndexPath) {
        self.selectedIndexPath = indexPath
    }
}
