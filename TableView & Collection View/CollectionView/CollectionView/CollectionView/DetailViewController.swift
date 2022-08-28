//
//  DetailViewController.swift
//  CollectionView
//
//  Created by MRGS on 28.08.2022.
//

import UIKit

class DetailViewController: UIViewController {
    var image: UIImage?
    @IBOutlet weak var photoImageView: UIImageView!
    override func viewDidLoad() {
        super.viewDidLoad()
        photoImageView.image = image
        // Do any additional setup after loading the view.
    }
    
 

}
