//
//  ViewController.swift
//  FirebaseApp
//
//  Created by MRGS on 31.08.2022.
//

import UIKit
import FirebaseAuth
import FirebaseDatabase
class LoginVC: UIViewController {
    var ref:DatabaseReference!
    @IBOutlet weak var warnLabel: UILabel!
    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        ref = Database.database().reference(withPath: "users")
        warnLabel.text = ""
        Auth.auth().addStateDidChangeListener { auth, user in // 
            if user == nil{
                print("123")
            } else{
                let vc =  TaskVC()
                let nav = UINavigationController.init(rootViewController: vc)
                nav.modalPresentationStyle = .fullScreen
                self.present(nav, animated: true, completion: nil)
            }
        }
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        emailTextField.text = ""
        warnLabel.text = ""
        passwordTextField.text = ""
    }
  
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func loginTapped(_ sender: UIButton) {
        // Validate the input
        guard let emailAddress = emailTextField.text, emailAddress != "",
              let password = passwordTextField.text, password != "" else {
            let alert = UIAlertController(title: "Error", message: "Both fields must not be blank.", preferredStyle: UIAlertController.Style.alert)

            // add an action (button)
            alert.addAction(UIAlertAction(title: "OK", style: UIAlertAction.Style.default, handler: nil))

            // show the alert
            self.present(alert, animated: true, completion: nil)

            return
        }

        // Perform login by calling Firebase APIs
        Auth.auth().signIn(withEmail: emailAddress, password: password, completion: { (result, error) in

            if let error = error {
                // create the alert
                let alert = UIAlertController(title: "Error", message: error.localizedDescription, preferredStyle: UIAlertController.Style.alert)

                // add an action (button)
                alert.addAction(UIAlertAction(title: "OK", style: UIAlertAction.Style.default, handler: nil))

                // show the alert
                self.present(alert, animated: true, completion: nil)

                return
            }

            // Email verification
            guard let result = result, result.user.isEmailVerified else {
                let alert = UIAlertController(title: "Error", message: "You haven't confirmed your email address yet. We sent you a confirmation email when you sign up. Please click the verification link in that email. If you need us to send the confirmation email again, please tap Resend Email.", preferredStyle: UIAlertController.Style.alert)

                // add an action (button)
                alert.addAction(UIAlertAction(title: "OK", style: UIAlertAction.Style.default, handler: nil))

                // show the alert
                self.present(alert, animated: true, completion: nil)
                return
            }


            // Dismiss keyboard
            self.view.endEditing(true)
            // Present the main view
//            let navVc = TaskVC()
////            UserDefaults.standard.set(true, forKey: "true")
//            self.warnLabel.text = "SUCCESS"
//            self.navigationController?.viewControllers = [navVc]

        })

    }
    
    @IBAction func registerTapped(_ sender: UIButton) {
        // Validate the input
        guard
              let emailAddress = emailTextField.text, emailAddress != "",
              let password = passwordTextField.text, password != "" else {
            
            // create the alert
            let alert = UIAlertController(title: "Error", message: "EMPTY EMAIL/PASS", preferredStyle: UIAlertController.Style.alert)

            // add an action (button)
            alert.addAction(UIAlertAction(title: "OK", style: UIAlertAction.Style.default, handler: nil))

            // show the alert
            self.present(alert, animated: true, completion: nil)
            return
        }
         
        
        // Register the user account on Firebase
        Auth.auth().createUser(withEmail: emailAddress, password: password, completion: { [weak self] (user, error) in
            
            if let error = error {
                // create the alert
                let alert = UIAlertController(title: "Password ", message: error.localizedDescription, preferredStyle: UIAlertController.Style.alert)

                // add an action (button)
                alert.addAction(UIAlertAction(title: "OK", style: UIAlertAction.Style.default, handler: nil))

                // show the alert
                self?.present(alert, animated: true, completion: nil)
                return
            }
            
       
            
            // Save the name of the user
            if let changeRequest = Auth.auth().currentUser?.createProfileChangeRequest() {
                changeRequest.displayName = emailAddress
                changeRequest.commitChanges(completion: { (error) in
                    if let error = error {
                        print("Failed to change the display name: \(error.localizedDescription)")
                    }
                })
            }
            // Save userDB
            let userRef = self?.ref.child((user?.user.uid)!)
            userRef?.setValue(["email":user!.user.email!])
            // Dismiss keyboard
            self?.view.endEditing(true)
            
            // Send verification email
            Auth.auth().currentUser?.sendEmailVerification()
            // create the alert
            let alert = UIAlertController(title: "Email Verification", message: "We've just sent a confirmation email to your email address. Please check your inbox and click the verification link in that email to complete the sign up.", preferredStyle: UIAlertController.Style.alert)

            // add an action (button)
            alert.addAction(UIAlertAction(title: "OK", style: UIAlertAction.Style.default, handler: nil))

            // show the alert
            self?.present(alert, animated: true, completion: nil)
            
        })
    }

}

