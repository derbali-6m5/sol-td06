//
//  PersonDAO.swift
//  sol-td05
//
//  Created by admin on 2023-02-24.
//

import Foundation

protocol IPersonDAO {
    func getPeople() -> [Person]
    func getPeopleByAddress(addresss:Address) -> [Person]
    func addNewPerson(name:String, age:Int)->Person
    func updatePerson(oldName:String, newName:String, newAge:Int)
    func deletePerson(name:String)
    func addPersonToAddress(person:Person, address:Address)
}

class PersonDAO : IPersonDAO{
    
    func addPersonToAddress(person: Person, address: Address) {
        DataManager.shared.addPersonToAddress(person: person, address: address)
    }
    
   
    //définir un singleton
    static let shared = PersonDAO()
    
    func getPeople() -> [Person] {
        return DataManager.shared.people()
    }
    func getPeopleByAddress(addresss: Address) -> [Person] {
        return DataManager.shared.getPeopleByAddress(address: addresss)
    }
    
    func addNewPerson(name: String, age: Int) -> Person{
        return DataManager.shared.addNewPerson(name: name, age: age)
    }
    
    func updatePerson(oldName: String, newName: String, newAge: Int) {
        DataManager.shared.updatePerson(oldName: oldName, newName: newName, newAge: newAge)
    }
    
    func deletePerson(name: String) {
        DataManager.shared.deletePerson(name: name)
    }
    
    
    
}
