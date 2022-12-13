//
//  SelectedService.swift
//  Service Master
//
//  Created by Swapnil Roy Chowdhury on 2022-12-12.
//

import Foundation

class SelectedService{
    var mainService: String!
    var description: String!
    var option: Option!
    
    func toString(){
        print("---------------------------------------")
        print("Main service = ", self.mainService!)
        print("Description = ", self.description!)
        print("Options = ", self.option.toString())
    }
}

