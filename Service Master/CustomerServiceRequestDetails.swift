//
//  CustomerServiceRequestDetails.swift
//  Service Master
//
//  Created by Swapnil Roy Chowdhury on 2022-12-12.
//

import Foundation

class CustomerServiceRequestDetails{
    
    var postalCode: String!
    var customerName: String!
    var urgency: String!
    var serviceDescription: String!
    var customerAddress: String!
    var customerCity: String!
    var customerProvince: String!
    var customerContactNumber: String!
    var customerEmail: String!
    var customerContactPreference: [String]!
    
    var selectedService: SelectedService!
}
