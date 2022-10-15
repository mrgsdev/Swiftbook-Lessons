//
//  TableViewModelType.swift
//  MVVM
//
//  Created by MRGS on 16.10.2022.
//

import Foundation
protocol TableViewModelType {
    var numberOfRows: Int { get }
    var profiles: [Profile] {get}
}
