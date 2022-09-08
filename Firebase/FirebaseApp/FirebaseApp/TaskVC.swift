//
//  TableViewController.swift
//  FirebaseApp
//
//  Created by MRGS on 05.09.2022.
// lilay38440@vasqa.com

import UIKit
import FirebaseAuth
import FirebaseDatabase
class TaskVC: UITableViewController {
    var user:User!
    var ref:DatabaseReference!
    var tasksArray = [Tasks]()
    override func viewDidLoad() {
        super.viewDidLoad()
        
        guard let currentUser = Auth.auth().currentUser else { return } 
        user = User(user: currentUser)
        ref = Database.database().reference(withPath: "users").child(user.uid).child("tasks")
        
        self.navigationItem.leftBarButtonItem = UIBarButtonItem(title: "SignOut", style: .plain, target: self, action: #selector(signOut))
        self.navigationItem.rightBarButtonItem = UIBarButtonItem(title: "+", style: .plain, target: self, action: #selector(addTapped))
        self.tableView.register(UITableViewCell.self, forCellReuseIdentifier: "cell")
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        ref.observe(.value) { snapshot in
            var junkArray = [Tasks]()
            for item in snapshot.children{
                let task = Tasks(snapshot: item as! DataSnapshot)
                junkArray.append(task)
            }
            self.tasksArray = junkArray
            self.tableView.reloadData()
        }
    }
    @objc func addTapped(){
        
        let alertController = UIAlertController(title: "New task", message: "Add new task", preferredStyle: .alert)
        alertController.addTextField()
        let save = UIAlertAction(title: "Save", style: .default) { [weak self] _ in
            guard let txtfld = alertController.textFields?.first,txtfld.text != "" else{
                return
            }
            let task = Tasks(title: txtfld.text!)
            let taskRef = self?.ref.child(task.title.lowercased())
            taskRef?.setValue(["title":task.title,"completed":task.completed])
            
        }
        let cancel = UIAlertAction(title: "cancel", style: .default)
        alertController.addAction(save)
        alertController.addAction(cancel)
        present(alertController, animated: true)
        
    }
    @objc func signOut(){
        let firebaseAuth = Auth.auth()
        do {
            try firebaseAuth.signOut()
        } catch let signOutError as NSError {
            print("Error signing out: %@", signOutError)
        }
       dismiss(animated: true)
        
    }
    // MARK: - Table view data source
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return tasksArray.count
    }
    
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        
        cell.backgroundColor = .clear
        cell.textLabel?.text = tasksArray[indexPath.row].title
        return cell
    }
    
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        return true
    }
    
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            let task = tasksArray[indexPath.row]
            task.ref?.removeValue()
        }
    }
    
    /*
     // Override to support conditional editing of the table view.
     override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
     // Return false if you do not want the specified item to be editable.
     return true
     }
     */
    
    /*
     // Override to support editing the table view.
     override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
     if editingStyle == .delete {
     // Delete the row from the data source
     tableView.deleteRows(at: [indexPath], with: .fade)
     } else if editingStyle == .insert {
     // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
     }    
     }
     */
    
    /*
     // Override to support rearranging the table view.
     override func tableView(_ tableView: UITableView, moveRowAt fromIndexPath: IndexPath, to: IndexPath) {
     
     }
     */
    
    /*
     // Override to support conditional rearranging of the table view.
     override func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
     // Return false if you do not want the item to be re-orderable.
     return true
     }
     */
    
    /*
     // MARK: - Navigation
     
     // In a storyboard-based application, you will often want to do a little preparation before navigation
     override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
     // Get the new view controller using segue.destination.
     // Pass the selected object to the new view controller.
     }
     */
    
}
