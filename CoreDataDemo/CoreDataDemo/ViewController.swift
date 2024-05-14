//
//  ViewController.swift
//  CoreDataDemo
//
//  Created by admin on 5/13/24.
//

import UIKit

class ViewController: UIViewController {
    
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var navigationBar: UINavigationBar!
    
    let managedObjContext = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    
    // Data for the table
    var items: [Person]?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationBar.topItem?.title = "Person List"
        // Do any additional setup after loading the view.
        tableView.dataSource = self
        tableView.delegate = self
        
        // Get items from Core Data
        fetchPeople()
        
    }
    
    func fetchPeople () {
        // fetch data from Core Data
        do {
            self.items = try managedObjContext.fetch(Person.fetchRequest())
            DispatchQueue.main.async {
                self.tableView.reloadData()
            }
        } catch {
            print(error)
        }
    }
    
    @IBAction func addTapped (_ sender: Any) {
        // Create alert
        let alert = UIAlertController(title:"Add Person", message: "What is their name?",preferredStyle: .alert)
        alert.addTextField()
        
        // Configure button handler
        let submitButton = UIAlertAction(title: "Add", style: .default) { (action) in
            // Get the textfield for the alert
            let textfield = alert.textFields![0]
            // Create a person object
            let newPerson = Person(context: self.managedObjContext)
            newPerson.name = textfield.text
            newPerson.age = 20
            newPerson.gender = "male"
            // Save the data
            do {
                try self.managedObjContext.save()
            } catch {
                print(error)
            }
            // Re-fetch the data
            self.fetchPeople()
            
        }
        // Add button
        alert.addAction (submitButton)
        // Show alert
        self.present(alert, animated: true, completion: nil)
    }
}

extension ViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return items?.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "PersonCell", for: indexPath)
        
        // get person from array and set label text
        let person = self.items![indexPath.row]
        cell.textLabel?.text = person.name
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        // Selected Person
        let person = self.items![indexPath.row]
        // Create alert
        let alert = UIAlertController(title: "Edit Person", message:"Edit name:", preferredStyle: .alert)
        alert.addTextField()
        let textfield = alert.textFields![0]
        textfield.text = person.name
        // Configure button handler
        let saveButton = UIAlertAction(title: "Save", style: .default) { (action) in
            // Get the textfield for the alert
            let textfield = alert.textFields![0]
            // Edit name property of person object\
            person.name = textfield.text
            // Save the data
            do {
                try self.managedObjContext.save()
            } catch {
                print(error)
            }
            
            // Re-fetch the data
            self.fetchPeople()
        }
        // Add button
        alert.addAction(saveButton)
        // Show alert
        self.present(alert, animated: true, completion: nil)
    }
    
    func tableView(_ tableView: UITableView, trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        // Create swipe action
        let action = UIContextualAction(style: .destructive, title: "Delete") { (action, view, completionHandler) in
            // Which person to remove
            let personToRemove = self.items![indexPath.row]
            // Remove the person
            self.managedObjContext.delete(personToRemove)
            // Save the data
            do {
                try self.managedObjContext.save()
            } catch {
                print(error)
            }
            // Re-fetch the data
            self.fetchPeople()
        }
        // Return swipe actions
        return UISwipeActionsConfiguration (actions: [action])
    }
}
