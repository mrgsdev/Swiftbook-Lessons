//
//  UIImageView + Extension.swift
//  Chat
//
//  Created by MRGS on 07.12.2022.
//

import Foundation
import UIKit

extension UIImageView {
    
    convenience init(image: UIImage?, contentMode: UIView.ContentMode) {
        self.init()
        
        self.image = image
        self.contentMode = contentMode
    }
    
}
