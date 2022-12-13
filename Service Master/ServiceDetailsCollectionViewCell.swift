//
//  ServiceDetailsCollectionViewCell.swift
//  Service Master
//
//  Created by Swapnil Roy Chowdhury on 2022-12-12.
//

import UIKit

class ServiceDetailsCollectionViewCell: UICollectionViewCell {
    
    static let reuseIdentifier: String = "ServiceDetailsCollectionViewCell"
    
    @IBOutlet var optionTitle: UILabel!
    @IBOutlet var optionDescription: UILabel!
    
    @IBOutlet var optionBookNowBtn: UIButton!
    
    @IBAction func bookNow(_ sender: UIButton){
        addBookNowButtonTapAction!()
    }
    
    var addBookNowButtonTapAction : (()->())?
    
}
