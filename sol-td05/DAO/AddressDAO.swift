//
//  AddressDAO.swift
//  sol-td05
//
//  Created by admin on 2023-02-24.
//

import Foundation
protocol IAddressDAO{
    func getAddresses() -> [Address]
    func newAddressToPerson(city:String, postalCode:String,personeName:String)
}

class AddressDAO:IAddressDAO {
    func getAddresses() -> [Address] {
       return DataManager.shared.getAddresses()
    }
    
  
    static let shared = AddressDAO()
    
    func newAddressToPerson(city: String, postalCode: String, personeName: String) {
        DataManager.shared.newAddressToPerson(city: city, postalCode: postalCode, personeName: personeName)
    }
    
}
