//
//  ServiceCollectionViewCell.swift
//  Service Master
//
//  Created by Swapnil Roy Chowdhury on 2022-12-11.
//

import UIKit

class ServiceCollectionViewCell: UICollectionViewCell {
    
    static let reuseIdentifier: String = "ServiceCollectionViewCell"
    
    var data: Service = Service()
    
    @IBOutlet var service: UIButton!
    
    @IBAction func gotoService(_ sender: UIButton){
        addButtonTapAction!()
    }
    
    var addButtonTapAction : (()->())?
}
