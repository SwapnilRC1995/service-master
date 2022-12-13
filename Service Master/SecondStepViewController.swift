//
//  SecondStepViewController.swift
//  Service Master
//
//  Created by Swapnil Roy Chowdhury on 2022-12-02.
//

import UIKit

class SecondStepViewController: UIViewController {

    @IBOutlet var desc: UILabel!
    @IBOutlet var asap: UIButton!
    @IBOutlet var week: UIButton!
    @IBOutlet var anytime: UIButton!
    
    
    var urgency: String = ""
    var isFromNextStep: Bool = false;
    
    var customerServiceRequestDetails: CustomerServiceRequestDetails!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        asap.layer.cornerRadius = 5
        week.layer.cornerRadius = 5
        anytime.layer.cornerRadius = 5
        
        if(isFromNextStep){
            desc.text = customerServiceRequestDetails.serviceDescription
            urgency = customerServiceRequestDetails.urgency
            if(customerServiceRequestDetails.urgency == "ASAP"){
                asap.backgroundColor = UIColor.black
                week.backgroundColor = UIColor(red: 231/255, green: 168/255, blue: 17/255, alpha: 1)
                anytime.backgroundColor = UIColor(red: 231/255, green: 168/255, blue: 17/255, alpha: 1)
            } else if (customerServiceRequestDetails.urgency == "1 week"){
                asap.backgroundColor = UIColor(red: 231/255, green: 168/255, blue: 17/255, alpha: 1)
                week.backgroundColor = UIColor.black
                anytime.backgroundColor = UIColor(red: 231/255, green: 168/255, blue: 17/255, alpha: 1)
            } else if (customerServiceRequestDetails.urgency == "Anytime"){
                asap.backgroundColor = UIColor(red: 231/255, green: 168/255, blue: 17/255, alpha: 1)
                week.backgroundColor = UIColor(red: 231/255, green: 168/255, blue: 17/255, alpha: 1)
                anytime.backgroundColor = UIColor.black
            }
        }
        
    }
    
    @IBAction func selectButtonBehaviour(_ sender: UIButton){
        if(sender == asap){
            week.backgroundColor = UIColor(red: 231/255, green: 168/255, blue: 17/255, alpha: 1)
            anytime.backgroundColor = UIColor(red: 231/255, green: 168/255, blue: 17/255, alpha: 1)
        } else if (sender == week){
            asap.backgroundColor = UIColor(red: 231/255, green: 168/255, blue: 17/255, alpha: 1)
            anytime.backgroundColor = UIColor(red: 231/255, green: 168/255, blue: 17/255, alpha: 1)
        } else if (sender == anytime){
            asap.backgroundColor = UIColor(red: 231/255, green: 168/255, blue: 17/255, alpha: 1)
            week.backgroundColor = UIColor(red: 231/255, green: 168/255, blue: 17/255, alpha: 1)
        }
        sender.backgroundColor = UIColor.black
        urgency = sender.titleLabel!.text!;
    }
    
    @IBAction func nextStepButtonPressed(_ sender: UIButton){
        if(urgency == ""){
            showAlertWithMessage("Sorry, please select how urgent it is")
        }else if(desc.text == ""){
            showAlertWithMessage("Sorry, please describe your situation for us to deliver better")
        }else{
            customerServiceRequestDetails.urgency = urgency
            customerServiceRequestDetails.serviceDescription = desc.text!
            performSegue(withIdentifier: "ToStepThree", sender: self)
        }
    }
    
    @IBAction func previousStepButtomPressed(_ sender: UIButton){
        performSegue(withIdentifier: "ToStepOne", sender: self)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if(segue.identifier == "ToStepThree"){
            let destination = segue.destination as! ThirdStepViewController
            destination.customerServiceRequestDetails = customerServiceRequestDetails
        }
        if(segue.identifier == "ToStepOne"){
            let destination = segue.destination as! FirstStepViewController
            destination.customerServiceRequestDetails = customerServiceRequestDetails
            destination.isFromNextStep = true
        }
    }
    
    func showAlertWithMessage(_ message: String){
        let alert = UIAlertController(title: "Oops! Our service providers need it", message: message, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "Ok", style: .default, handler: nil))
        self.present(alert, animated: true, completion: nil)
    }

}
