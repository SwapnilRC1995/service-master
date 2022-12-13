//
//  SignInViewController.swift
//  Service Master
//
//  Created by Swapnil Roy Chowdhury on 2022-12-02.
//

import UIKit
import Firebase
import GoogleSignIn

class SignInViewController: UIViewController {

    @IBOutlet var emailField: UITextField!
    @IBOutlet var passwordField: UITextField!
    
    @IBOutlet var signinBtn: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()

    }
    
    @IBAction func signIn(_ sender: UIButton){
        
        let email: String = emailField.text!
        let password: String = passwordField.text!
        
        signinBtn.isEnabled = false
        
        if email.trimmingCharacters(in: .whitespacesAndNewlines) == ""{
            self.resetForm("Please enter an email and try again");
        }else{
            if password.trimmingCharacters(in: .whitespacesAndNewlines) != "" {
                
                Auth.auth().signIn(withEmail: email, password: password) { result, error in
                    if error != nil{
                        print(error!.localizedDescription)
                        self.resetForm("There has been as internal issue signing you up. Please try again.")
                    }else{
                        self.performSegue(withIdentifier: "gotoLoggedInDashboard", sender: self);
                    }
                }
            }else{
                self.resetForm("Please enter the password and try again");
            }
        }
        
    }
    
    @IBAction func signInWithGoogle(_ sender: UIButton!){
        
        guard let clientID = FirebaseApp.app()?.options.clientID else { return }
        
        let config = GIDConfiguration(clientID: clientID)
        
        GIDSignIn.sharedInstance.signIn(with: config, presenting: self){[unowned self] user, error in
            if let error = error{
                print(error.localizedDescription)
                self.resetForm("There has been as internal issue signing you up. Please try again.")
                return
            }
            
            guard
                let authentication = user?.authentication,
                let idToken = authentication.idToken
            else{
                self.resetForm("There has been as internal issue signing you up. Please try again.")
                return
            }
            
            let credential = GoogleAuthProvider.credential(withIDToken: idToken, accessToken: authentication.accessToken)
            
            Auth.auth().signIn(with: credential){ authResult, error in
                if error != nil{
                    print(error!.localizedDescription)
                    self.resetForm("There has been as internal issue signing you up. Please try again.")
                }else{
                    self.performSegue(withIdentifier: "gotoLoggedInDashboard", sender: self);
                }
            }
        }
    }

    @IBAction func signInWithFacebook(_ sender: UIButton!){
        
    }
    
    func resetForm(_ message: String){
        let alert = UIAlertController(title: "Oops! Signin failed", message: message, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "Ok", style: .default, handler: nil))
        self.present(alert, animated: true, completion: nil)
        
        signinBtn.isEnabled = true
    }
}
