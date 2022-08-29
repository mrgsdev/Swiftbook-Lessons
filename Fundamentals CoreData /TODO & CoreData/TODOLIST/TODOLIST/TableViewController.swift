//
//  TableViewController.swift
//  TODOLIST
//
//  Created by MRGS on 29.08.2022.
//

import UIKit
import CoreData

private var reuseIdentifier = "cell"
class TableViewController: UITableViewController {
    
    var task:[Task] = []
    
    @IBAction func saveTask(_ sender: UIBarButtonItem) {
        let alertController = UIAlertController(title: "New Task", message: "Add new task", preferredStyle: .alert)
        let saveAction = UIAlertAction(title: "Save", style: .default) { action in
            let textField = alertController.textFields?.first
            if let newTask = textField?.text{
                self.saveTaskCoreData(withTitle:newTask)
                self.tableView.reloadData()
            }
        }
        alertController.addTextField()
        let cancelAction = UIAlertAction(title: "Cancel", style: .default)
        alertController.addAction(saveAction)
        alertController.addAction(cancelAction)
        present(alertController, animated: true)
    }
    
    private func saveTaskCoreData(withTitle title: String){
        let context = getContext()
        
        guard let entity = NSEntityDescription.entity(forEntityName: "Task", in: context) else { return }
        
        let taskObject = Task(entity: entity, insertInto: context)
        taskObject.title = title
        
        do {
            try context.save()
            task.append(taskObject)
        } catch let error as NSError {
            print(error.localizedDescription)
        }
    }
    private func getContext() -> NSManagedObjectContext{
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        let context = appDelegate.persistentContainer.viewContext
        return context
    }
    private func deletesObject(){
        //        let context = getContext()
        //        let fetchRequest: NSFetchRequest<Task> = Task.fetchRequest()
        //        if let results = try? context.fetch(fetchRequest){
        //            for object in results {
        //                context.delete(object)
        //            }
        //        }
        //        do {
        //            try context.save()
        //        } catch let error as NSError {
        //            print(error.localizedDescription)
        //        }
    }
    override func viewDidLoad() {
        super.viewDidLoad()

    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        let context = getContext()
        let fetchRequest: NSFetchRequest<Task> = Task.fetchRequest()
        do {
            task =  try context.fetch(fetchRequest)
        } catch let error as NSError {
            print(error.localizedDescription)
        }
        
    }
    // MARK: - Table view data source
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return task.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: reuseIdentifier, for: indexPath)
        cell.textLabel?.text = task[indexPath.row].title
        return cell
    }
}
