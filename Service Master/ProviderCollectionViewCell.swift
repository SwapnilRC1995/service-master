//
//  ProviderCollectionViewCell.swift
//  Service Master
//
//  Created by Swapnil Roy Chowdhury on 2022-12-12.
//

import UIKit

class ProviderCollectionViewCell: UICollectionViewCell {
    
    static let reuseIdentifier: String = "ProviderCollectionViewCell"
    
    @IBOutlet var providerImage: UIImageView!
    @IBOutlet var providerName: UILabel!
}
