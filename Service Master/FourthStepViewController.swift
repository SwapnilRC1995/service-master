//
//  FourthStepViewController.swift
//  Service Master
//
//  Created by Swapnil Roy Chowdhury on 2022-12-02.
//

import UIKit
import Firebase

class FourthStepViewController: UIViewController, UICollectionViewDelegate, UICollectionViewDataSource {
    
    var customerServiceRequestDetails: CustomerServiceRequestDetails!
    
    @IBOutlet var collectionView: UICollectionView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.collectionView.delegate = self
        self.collectionView.dataSource = self
        
        self.writeData()
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        customerServiceRequestDetails.selectedService.option.provider.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: ProviderCollectionViewCell.reuseIdentifier, for: indexPath) as! ProviderCollectionViewCell
        cell.providerName!.text = customerServiceRequestDetails.selectedService.option.provider[indexPath.row].serviceProvider
        return cell;
        
    }
    
    func writeData(){
        
        
        var providers: [Any] = []
        for provider in customerServiceRequestDetails.selectedService.option.provider{
            providers.append([
                "serviceProvider": provider.serviceProvider
            ])
        }
        
        let ref = Firestore.firestore().collection("reservationrequest").document()
        ref.setData([
            "postalCode": customerServiceRequestDetails.postalCode!,
            "urgency": customerServiceRequestDetails.urgency!,
            "customerName": customerServiceRequestDetails.customerName!,
            "customerAddress": customerServiceRequestDetails.customerAddress!,
            "serviceDescription": customerServiceRequestDetails.serviceDescription!,
            "customerCity": customerServiceRequestDetails.customerCity!,
            "customerProvince": customerServiceRequestDetails.customerProvince!,
            "customerContactNumber": customerServiceRequestDetails.customerContactNumber!,
            "customerEmail": customerServiceRequestDetails.customerEmail!,
            "customerContactPreference": customerServiceRequestDetails.customerContactPreference!,
            
            "selectedService": [
                "mainService": customerServiceRequestDetails.selectedService.mainService!,
                "description": customerServiceRequestDetails.selectedService.description!,
                "option": [
                    "name": customerServiceRequestDetails.selectedService.option.name,
                    "jobDescription": customerServiceRequestDetails.selectedService.option.jobDescription,
                    "provider":providers
                ]
            ]
            
        ])
    }

}
