//
//  FirstStepViewController.swift
//  Service Master
//
//  Created by Swapnil Roy Chowdhury on 2022-12-02.
//

import UIKit

class FirstStepViewController: UIViewController {

    @IBOutlet var postalCodeField: UITextField!
    @IBOutlet var gotoStepTwo: UIButton!
    
    var selectedService: SelectedService!
    
    var customerServiceRequestDetails: CustomerServiceRequestDetails!
    
    var isFromNextStep: Bool = false
    
    override func viewDidLoad() {
        super.viewDidLoad()
        if(isFromNextStep){
            postalCodeField.text = customerServiceRequestDetails.postalCode
        }else{
            customerServiceRequestDetails = CustomerServiceRequestDetails()
            customerServiceRequestDetails.selectedService = selectedService
        }
        
    }
    
    @IBAction func nextStepButtonPressed(_ sender: UIButton){
        if(postalCodeField.text?.trimmingCharacters(in: .whitespacesAndNewlines) != ""){
            customerServiceRequestDetails.postalCode = postalCodeField!.text
            performSegue(withIdentifier: "ToStepTwo", sender: self)
        }else{
            showAlertWithMessage("Sorry, Postal Code cannot be empty")
        }
        
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if(segue.identifier == "ToStepTwo"){
            let destination = segue.destination as! SecondStepViewController
            destination.customerServiceRequestDetails = customerServiceRequestDetails
        }
    }

    func showAlertWithMessage(_ message: String){
        let alert = UIAlertController(title: "Oops! Our service providers need it", message: message, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "Ok", style: .default, handler: nil))
        self.present(alert, animated: true, completion: nil)
    }

}
