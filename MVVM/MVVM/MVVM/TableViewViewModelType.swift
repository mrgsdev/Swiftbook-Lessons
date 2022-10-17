//
//  TableViewModelType.swift
//  MVVM
//
//  Created by MRGS on 16.10.2022.
//

import Foundation
protocol TableViewViewModelType {
    func numberOfRows() -> Int
 
    func cellForViewModel(forIndexPath indexPath: IndexPath) -> TableViewCellViewModelType?   
}
