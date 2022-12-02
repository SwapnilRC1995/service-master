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
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */
    
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
        sender.backgroundColor = UIColor.red
        urgency = sender.titleLabel!.text!;
        print(urgency);
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if(segue.identifier == "ToStepThree"){
            let destination = segue.destination as! ThirdStepViewController
            destination.urgency = urgency
            destination.desc = desc.text!
        }
    }

}
