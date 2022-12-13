//
//  ThirdStepViewController.swift
//  Service Master
//
//  Created by Swapnil Roy Chowdhury on 2022-12-02.
//

import UIKit

class ThirdStepViewController: UIViewController {
    
    @IBOutlet var text: UIButton!
    @IBOutlet var phone: UIButton!
    @IBOutlet var email: UIButton!
    
    @IBOutlet var nameField: UITextField!
    @IBOutlet var addressField: UITextField!
    @IBOutlet var cityField: UITextField!
    @IBOutlet var provinceField: UITextField!
    @IBOutlet var contactField: UITextField!
    @IBOutlet var emailAddrField: UITextField!
    
    var contactMedium = Array<String>();
    
    var customerServiceRequestDetails: CustomerServiceRequestDetails!
    
    var isText: Bool = false
    var isPhone: Bool = false
    var isEmail: Bool = false
    
    override func viewDidLoad() {
        super.viewDidLoad()
        text.layer.cornerRadius = 5
        phone.layer.cornerRadius = 5
        email.layer.cornerRadius = 5
        
    }

    @IBAction func selectEmail(_ sender: UIButton){
        isEmail = !isEmail;
        if(isEmail){
            sender.backgroundColor = UIColor.black
            contactMedium.append(sender.titleLabel!.text!)
        }else{
            sender.backgroundColor = UIColor(red: 231/255, green: 168/255, blue: 17/255, alpha: 1)
            if let index = contactMedium.firstIndex(of: sender.titleLabel!.text!){
                contactMedium.remove(at: index)
            }
        }
    }
    @IBAction func selectText(_ sender: UIButton){
        isText = !isText;
        if(isText){
            sender.backgroundColor = UIColor.black
            contactMedium.append(sender.titleLabel!.text!)
        }else{
            sender.backgroundColor = UIColor(red: 231/255, green: 168/255, blue: 17/255, alpha: 1)
            if let index = contactMedium.firstIndex(of: sender.titleLabel!.text!){
                contactMedium.remove(at: index)
            }
        }
    }
    @IBAction func selectPhone(_ sender: UIButton){
        isPhone = !isPhone;
        if(isPhone){
            sender.backgroundColor = UIColor.black
            contactMedium.append(sender.titleLabel!.text!)
        }else{
            sender.backgroundColor = UIColor(red: 231/255, green: 168/255, blue: 17/255, alpha: 1)
            if let index = contactMedium.firstIndex(of: sender.titleLabel!.text!){
                contactMedium.remove(at: index)
            }
        }
    }
    
    @IBAction func nextStepButtonPressed(_ sender: UIButton){
        if(nameField.text?.trimmingCharacters(in: .whitespacesAndNewlines) == ""){
            showAlertWithMessage("Sorry, please enter your name")
        }else if(addressField.text?.trimmingCharacters(in: .whitespacesAndNewlines) == ""){
            showAlertWithMessage("Sorry, please enter your full address")
        }else if(cityField.text?.trimmingCharacters(in: .whitespacesAndNewlines) == ""){
            showAlertWithMessage("Sorry, please enter the city you live in")
        }else if(provinceField.text?.trimmingCharacters(in: .whitespacesAndNewlines) == ""){
            showAlertWithMessage("Sorry, please enter the province your city belongs to")
        }else if(contactField.text?.trimmingCharacters(in: .whitespacesAndNewlines) == ""){
            showAlertWithMessage("Sorry, please enter your contact number")
        }else if(emailAddrField.text?.trimmingCharacters(in: .whitespacesAndNewlines) == ""){
            showAlertWithMessage("Sorry, please enter your email")
        }else{
            customerServiceRequestDetails.customerName = nameField.text!
            customerServiceRequestDetails.customerAddress = addressField.text!
            customerServiceRequestDetails.customerCity = cityField.text!
            customerServiceRequestDetails.customerProvince = provinceField.text!
            customerServiceRequestDetails.customerContactNumber = contactField.text!
            customerServiceRequestDetails.customerEmail = emailAddrField.text!
            customerServiceRequestDetails.customerContactPreference = contactMedium
            performSegue(withIdentifier: "ToStepFour", sender: self)
        }
    }
    
    @IBAction func previousStepButtomPressed(_ sender: UIButton){
        performSegue(withIdentifier: "ToStepTwo", sender: self)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if(segue.identifier == "ToStepFour"){
            let destination = segue.destination as! FourthStepViewController
            destination.customerServiceRequestDetails = customerServiceRequestDetails
        }
        
        if(segue.identifier == "ToStepTwo"){
            let destination = segue.destination as! SecondStepViewController
            destination.customerServiceRequestDetails = customerServiceRequestDetails
            destination.isFromNextStep = true;
        }
    }
    
    func showAlertWithMessage(_ message: String){
        let alert = UIAlertController(title: "Oops! Our service providers need it", message: message, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "Ok", style: .default, handler: nil))
        self.present(alert, animated: true, completion: nil)
    }
    
}
