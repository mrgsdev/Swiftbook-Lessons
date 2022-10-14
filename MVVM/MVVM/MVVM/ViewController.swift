//
//  ViewController.swift
//  MVVM
//
//  Created by MRGS on 13.10.2022.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var secondNameLabel: UILabel!
    @IBOutlet weak var ageLabel: UILabel!
    
    var profile:Profile?{
        didSet{
            guard let profile = profile else { return }
            self.nameLabel.text = profile.name
            self.secondNameLabel.text = profile.secondName
            self.ageLabel.text = profile.age.description
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        profile = Profile(name: "John", secondName: "Smith", age: 33)
    }


}

