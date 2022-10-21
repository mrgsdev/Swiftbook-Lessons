//
//  TableViewControllerMVVM3.swift
//  MVVM
//
//  Created by MRGS on 23.10.2022.
//

import UIKit

class TableViewControllerMVVM3: UITableViewController {

    @IBOutlet var viewModel: ViewModelMVVM3!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        viewModel.fetchMovies { [weak self] in
            DispatchQueue.main.async {
                self?.tableView.reloadData()
            }
        }
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.numberOfRowsInSection()
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        
        cell.textLabel?.text = viewModel.titleForCell(atIndexPath: indexPath)
        
        return cell
    }

}
