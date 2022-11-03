//
//  Label + Extension.swift
//  Chat
//
//  Created by MRGS on 07.12.2022.
//

import UIKit
extension UILabel {
    
    convenience init(text: String, font: UIFont? = .avenir20()) {
        self.init()
        
        self.text = text
        self.font = font
    }
    
}

