//
//  TableViewModelType.swift
//  MVVM
//
//  Created by MRGS on 16.10.2022.
//

import Foundation
protocol TableViewViewModelType {
    var numberOfRows: Int { get }
 
    func cellForViewModel(forIndexPath indexPath: IndexPath) -> TableViewCellViewModelType?   
}
