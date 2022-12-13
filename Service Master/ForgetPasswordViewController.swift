//
//  ForgetPasswordViewController.swift
//  Service Master
//
//  Created by Swapnil Roy Chowdhury on 2022-12-02.
//

import UIKit
import Firebase
import GoogleSignIn

class ForgetPasswordViewController: UIViewController {

    @IBOutlet var emailField: UITextField!
    @IBOutlet var confirmEmailField: UITextField!
    
    @IBOutlet var resetPasswordBtn: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()

    }
    
    @IBAction func resetPassword(_ sender: UIButton){
        
        let email: String = emailField.text!
        let confirmEmail: String = confirmEmailField.text!
        
        resetPasswordBtn.isEnabled = false
        
        if email.trimmingCharacters(in: .whitespacesAndNewlines) == ""{
            self.resetForm("Oops! Password Reset failed", "Please enter an email and try again");
        }else{
            if confirmEmail.trimmingCharacters(in: .whitespacesAndNewlines) != "" && email == confirmEmail{
                Auth.auth().sendPasswordReset(withEmail: email) { error in
                    if error != nil{
                        print(error!.localizedDescription)
                        self.resetForm("Oops! Password Reset failed", "There has been as internal issue resetting your password. Please try again.")
                    }else{
                        self.resetPasswordSuccessful("Reset Password?", "We've sent you an email to reset your password. Please follow and link and do as instructed. Hope to see you back soon!");
                    }
                }
            }else{
                self.resetForm("Oops! Password Reset failed", "Emails do not match. Please try again");
            }
        }
    }
    
    @IBAction func signInWithGoogle(_ sender: UIButton!){
        
        guard let clientID = FirebaseApp.app()?.options.clientID else { return }
        
        let config = GIDConfiguration(clientID: clientID)
        
        GIDSignIn.sharedInstance.signIn(with: config, presenting: self){[unowned self] user, error in
            if let error = error{
                print(error.localizedDescription)
                self.resetForm("Oops! Signin failed", "There has been as internal issue signing you in. Please try again.")
                return
            }
            
            guard
                let authentication = user?.authentication,
                let idToken = authentication.idToken
            else{
                self.resetForm("Oops! Signin failed", "There has been as internal issue signing you in. Please try again.")
                return
            }
            
            let credential = GoogleAuthProvider.credential(withIDToken: idToken, accessToken: authentication.accessToken)
            
            Auth.auth().signIn(with: credential){ authResult, error in
                if error != nil{
                    print(error!.localizedDescription)
                    self.resetForm("Oops! Signin failed", "There has been as internal issue signing you in. Please try again.")
                }else{
                    self.performSegue(withIdentifier: "gotoLoggedInDashboard", sender: self);
                }
            }
        }
    }

    @IBAction func signInWithFacebook(_ sender: UIButton!){
        
    }
    
    func resetPasswordSuccessful(_ title: String, _ message: String){
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "Ok", style: .default, handler: {(action) in
            self.performSegue(withIdentifier: "gotoSignIn", sender: self)
        }))
        self.present(alert, animated: true, completion: nil)
        
        resetPasswordBtn.isEnabled = true
    }
    
    func resetForm(_ title: String, _ message: String){
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "Ok", style: .default, handler: nil))
        self.present(alert, animated: true, completion: nil)
        
        resetPasswordBtn.isEnabled = true
    }

}
