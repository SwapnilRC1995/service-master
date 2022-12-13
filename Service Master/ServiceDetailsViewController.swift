//
//  ServiceDetailsViewController.swift
//  Service Master
//
//  Created by Swapnil Roy Chowdhury on 2022-12-02.
//

import UIKit
import Firebase
import SwiftyJSON

class ServiceDetailsViewController: UIViewController, UICollectionViewDelegate, UICollectionViewDataSource {

    @IBOutlet var collectionView: UICollectionView!
    @IBOutlet var serviceTitle: UILabel!
    @IBOutlet var serviceDescription: UILabel!
    var service: Service = Service()
    private var options: [Option] = []
    
    var selectedService: SelectedService!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        self.collectionView.delegate = self
        self.collectionView.dataSource = self
        
        serviceTitle.text = service.mainService
        serviceDescription.text = service.description
        options = service.options
    
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return options.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: ServiceDetailsCollectionViewCell.reuseIdentifier, for: indexPath) as! ServiceDetailsCollectionViewCell
        
        if(!options.isEmpty){
            if(cell.optionTitle != nil && cell.optionDescription != nil){
                cell.optionTitle!.text = options[indexPath.row].name
                cell.optionDescription!.text = options[indexPath.row].jobDescription
                
                cell.addBookNowButtonTapAction = { [self] in
                    selectedService = SelectedService()
                    selectedService.mainService = service.mainService
                    selectedService.description = service.description
                    selectedService.option = options[indexPath.row]
                    performSegue(withIdentifier: "gotoFirstStepPage", sender: selectedService)
                }
            }
        }
        return cell;
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if(segue.identifier == "gotoFirstStepPage"){
            let destination = segue.destination as! FirstStepViewController
            destination.selectedService = sender as? SelectedService
        }
    }
    
    @IBAction func signOut(_ sender: UIButton){
        try? Auth.auth().signOut()
        performSegue(withIdentifier: "logOutSuccess", sender: self)
    }
    
}
