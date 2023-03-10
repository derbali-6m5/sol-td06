//
//  DataManager.swift
//  sol-td05
//
//  Created by admin on 2023-02-22.
//

import Foundation
import CoreData

class DataManager {
    //définir un singleton
    static let shared = DataManager()
    
    lazy var persistentContainer: NSPersistentContainer = {
        
        let container = NSPersistentContainer(name: "sol_td05")
        container.loadPersistentStores(completionHandler: { (storeDescription, error) in
            if let error = error as NSError? {
                fatalError("Unresolved error \(error), \(error.userInfo)")
            }
        })
        return container
    }()
    
    //MARK: find people

    func people() -> [Person] {
        let request : NSFetchRequest<Person> = Person.fetchRequest()
        
        let context = persistentContainer.viewContext
        do {
               return try context.fetch(request)
        } catch {
                let nserror = error as NSError
                fatalError("Unresolved error \(nserror), \(nserror.userInfo)")
            }
    }
    
    func getPeopleByAddress(address:Address) -> [Person] {
        let request : NSFetchRequest<Person> = Person.fetchRequest()
        let prediate = NSPredicate(format: "address = %@", address)
        request.predicate = prediate
        
        let context = persistentContainer.viewContext
        do {
               return try context.fetch(request)
        } catch {
                let nserror = error as NSError
                fatalError("Unresolved error \(nserror), \(nserror.userInfo)")
        }
    }
    
    //MARK: find addresses

    func getAddresses() -> [Address] {
        let request : NSFetchRequest<Address> = Address.fetchRequest()
        
        let context = persistentContainer.viewContext
        do {
               return try context.fetch(request)
        } catch {
                let nserror = error as NSError
                fatalError("Unresolved error \(nserror), \(nserror.userInfo)")
            }
    }
    
    //MARK: init some people
    func initPeople() {
        let context = persistentContainer.viewContext
        let sam = Person(context: context)
        sam.name = "Samuel Legeault"
        sam.age = 45
        
        let alex = Person(context: context)
        alex.name = "Alex Lajoie"
        alex.age = 34
        
        do{
            try context.save()
        }catch{
            let nserror = error as NSError
            fatalError("Unresolved error \(nserror), \(nserror.userInfo)")
        }
    }
    
    //MARK: init some addresses for people
    func initAddresses() {
        let context = persistentContainer.viewContext
        let valley = Address(context: context)
        valley.city = "Valleyfield"
        valley.postalCode = "J5G 6G9"
        
        let people = people()
        
        people.forEach { person in
            person.address = valley
        }
        
        do{
            try context.save()
        }catch{
            let nserror = error as NSError
            fatalError("Unresolved error \(nserror), \(nserror.userInfo)")
        }
        
    }
    
    //MARK: add new person
    func addNewPerson(name: String, age: Int) -> Person{
        let context = persistentContainer.viewContext
        let person = Person(context: context)
        person.name = name
        person.age = Int16(age)
        
        do{
            try context.save()
        }catch{
            let nserror = error as NSError
            fatalError("Unresolved error \(nserror), \(nserror.userInfo)")
        }
        
        return person
    }
    
    //MARK: add person to address
    func addPersonToAddress(person: Person, address: Address) {
        let context = persistentContainer.viewContext
        
        do {
            person.address = address
            address.people?.adding(person)
            try context.save()
        } catch {
                let nserror = error as NSError
                fatalError("Unresolved error \(nserror), \(nserror.userInfo)")
        }
    }
    
    //MARK: update a person
    func updatePerson(oldName: String, newName: String, newAge: Int) {
        let context = persistentContainer.viewContext
        let people = people()
        for person in people{
            if person.name == oldName {
                person.name = newName
                person.age = Int16(newAge)
                break
            }
        }
        
        do{
            try context.save()
        }catch{
            let nserror = error as NSError
            fatalError("Unresolved error \(nserror), \(nserror.userInfo)")
        }
    }
    
    //MARK: delete a person
    func deletePerson(name: String) {
        let context = persistentContainer.viewContext
        let people = people()
        for person in people{
            if person.name == name {
                context.delete(person)
                break
            }
        }
        
        do{
            try context.save()
        }catch{
            let nserror = error as NSError
            fatalError("Unresolved error \(nserror), \(nserror.userInfo)")
        }
    }
    
    //MARK: new address to person
    func newAddressToPerson(city: String, postalCode: String, personeName: String) {
        let context = persistentContainer.viewContext
        let address = Address(context: context)
        address.city = city
        address.postalCode = postalCode
        
        let people = people()
        for person in people{
            if person.name == personeName {
                person.address = address
                break
            }
        }
        
        do{
            try context.save()
        }catch{
            let nserror = error as NSError
            fatalError("Unresolved error \(nserror), \(nserror.userInfo)")
        }
        
        
    }
        
        
    
    
}















