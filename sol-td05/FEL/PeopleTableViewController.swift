//
//  PeopleTableViewController.swift
//  sol-td05
//
//  Created by admin on 2023-02-24.
//

import UIKit

class PeopleTableViewController: UITableViewController {
    var people:[Person] = []
    var address:Address?
    override func viewDidLoad() {
        super.viewDidLoad()
        if let adr = address{
            self.people = PersonDAO.shared.getPeopleByAddress(addresss: adr)
        }
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return self.people.count
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "personCell", for: indexPath)

        // Configure the cell...
        cell.textLabel?.text = self.people[indexPath.row].name
        cell.detailTextLabel?.text = "\(self.people[indexPath.row].age) ans"

        return cell
    }
    
    @IBAction func clickAjouter(_ sender: Any) {
        let alert = UIAlertController(title: "Ajout d'un habitant", message: "", preferredStyle: .alert)
        //champs
        alert.addTextField{(textfield) in
            textfield.placeholder = "Nom"
            textfield.textColor = UIColor.purple
        }
        
        alert.addTextField{(textfield) in
            textfield.placeholder = "Age"
            textfield.textColor = UIColor.purple
        }
        
        //actions
        let saveAction = UIAlertAction(title: "Ajouter", style: .default, handler: {_ in
            if let name = alert.textFields?[0].text, let age = Int(alert.textFields?[1].text ?? "0") {
                //ajout à la BD CoreDate
                let person = PersonDAO.shared.addNewPerson(name: name, age: age)
                PersonDAO.shared.addPersonToAddress(person: person, address:self.address!)
                //mise à jour de l'affichage tableView
                self.people.append(person)
                self.tableView.reloadData()
            }
        })
        
        let cancelAction = UIAlertAction(title: "Annuler", style: .default, handler: {_ in
            
        })
        
        //ajouter les actions à l'alerte
        alert.addAction(saveAction)
        alert.addAction(cancelAction)
        
        //presenter l'alerte
        present(alert, animated: true)
        
    }
    
    override func tableView(_ tableView: UITableView, trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        let delete = UIContextualAction(style: .destructive, title: "Supprimer", handler: {(action, view, handler)  in
            let name = self.people[indexPath.row].name
            //suppression de CoreData
            PersonDAO.shared.deletePerson(name: name!)
            //suppression de l'affichage dans tableView
            self.people.remove(at: indexPath.row)
            self.tableView.reloadData()
            
        })
        
        let edit = UIContextualAction(style: .normal, title: "Éditer", handler: {(action, view, handler)  in
            let oldName = self.people[indexPath.row].name!
            let oldAge = self.people[indexPath.row].age
            
            let alert = UIAlertController(title: "Mise à jour d'un habitant", message: "", preferredStyle: .alert)
            //champs
            alert.addTextField{(textfield) in
                textfield.text = oldName
                textfield.textColor = UIColor.purple
            }
            
            alert.addTextField{(textfield) in
                textfield.text = String(oldAge)
                textfield.textColor = UIColor.purple
            }
            
            //actions
            let saveAction = UIAlertAction(title: "Éditer", style: .default, handler: {_ in
                if let name = alert.textFields?[0].text, let age = Int(alert.textFields?[1].text ?? "0") {
                    //ajout à la BD CoreDate
                    PersonDAO.shared.updatePerson(oldName: oldName, newName: name, newAge: age)
                    //mise à jour de l'affichage tableView
                    self.people[indexPath.row].name = name
                    self.people[indexPath.row].age  = Int16(age)
                    self.tableView.reloadRows(at: [indexPath], with: .fade)
                }
            })
            
            let cancelAction = UIAlertAction(title: "Annuler", style: .default, handler: {_ in
                
            })
            
            //ajouter les actions à l'alerte
            alert.addAction(saveAction)
            alert.addAction(cancelAction)
            
            //presenter l'alerte
            self.present(alert, animated: true)
        })
        edit.backgroundColor = UIColor.systemBlue
        
        let actions = UISwipeActionsConfiguration(actions: [delete, edit])
        return actions
    }
    

    /*
    // Override to support conditional editing of the table view.
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    */

    /*
    // Override to support editing the table view.
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            // Delete the row from the data source
            tableView.deleteRows(at: [indexPath], with: .fade)
        } else if editingStyle == .insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }    
    }
    */

    /*
    // Override to support rearranging the table view.
    override func tableView(_ tableView: UITableView, moveRowAt fromIndexPath: IndexPath, to: IndexPath) {

    }
    */

    /*
    // Override to support conditional rearranging of the table view.
    override func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the item to be re-orderable.
        return true
    }
    */

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
