//
//  Service.swift
//  Service Master
//
//  Created by Swapnil Roy Chowdhury on 2022-12-11.
//

import Foundation
import SwiftyJSON
import Firebase

class Service{
    var mainService: String = ""
    var description: String = ""
    var options: [Option] = [Option]()
    
    func parseJSON(_ json: JSON) -> Service{
        let service = Service()
        
        if let mainService = json["mainServices"].string{
            service.mainService = mainService
        }
        
        if let description = json["description"].string{
            service.description = description
        }
        for opt in json["options"]{
            let o = Option()
            service.options.append(o.parseJSON(JSON(opt.1)))
        }
        
        return service
    }
    
    func toString(){
        print("++++++++++++++++++++++++++++++++++++++++++++++++")
        print("Service name = ", self.mainService)
        print("Service description = ", self.description)
        for o in self.options{
            o.toString()
        }
        print("++++++++++++++++++++++++++++++++++++++++++++++++")
    }
}

class Option{
    var name: String = ""
    var jobDescription: String = ""
    var provider: [Provider] = [Provider]()
    
    func parseJSON(_ json: JSON) -> Option{
        let option = Option()
        
        if let name = json["name"].string{
            option.name = name
        }
        
        if let jobDescription = json["jobDescription"].string{
            option.jobDescription = jobDescription
        }
        
        for p in json["provider"]{
            option.provider.append(Provider().parseJSON(JSON(p.1)))
        }
        return option
    }
    
    func toString(){
        print("----------------------------------------------")
        print("Option name = ", self.name)
        print("Option description = ", self.jobDescription)
        for p in provider{
            p.toString()
        }
        print("----------------------------------------------")
        
    }
}

class Provider{
    var serviceProvider: String = ""
    
    func parseJSON(_ json: JSON) -> Provider{
        let provider = Provider()
        
        if let serviceProvider = json["serviceProvider"].string{
            provider.serviceProvider = serviceProvider
        }
        
        return provider
    }
    
    func toString(){
        print("***********************************************")
        print(self.serviceProvider)
        print("***********************************************")
    }
}

extension Dictionary{
    var JSON: Data {
            do {
                return try JSONSerialization.data(withJSONObject: self, options: .prettyPrinted)
            } catch {
                return Data()
            }
        }
}

extension DataSnapshot {
  var valueToJSON: Data {
      guard let dictionary = value as? [String: Any] else {
          return Data()
      }
      return dictionary.JSON
  }

  var listToJSON: Data {
      guard let object = children.allObjects as? [DataSnapshot] else {
          return Data()
      }

      let dictionary: [NSDictionary] = object.compactMap { $0.value as? NSDictionary }

      do {
          return try JSONSerialization.data(withJSONObject: dictionary, options: .prettyPrinted)
      } catch {
          return Data()
      }
  }
}
