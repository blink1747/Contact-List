//
//  ViewController.swift
//  Contact List
//
//  Created by IMCS on 8/13/19.
//  Copyright © 2019 IMCS. All rights reserved.
//

import UIKit
import Contacts

class ViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
   
    
    var contactStore = CNContactStore()
    var contacts = [ContactStruct]()
    
    @IBOutlet weak var tableView: UITableView!
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return contacts.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = UITableViewCell(style: .subtitle, reuseIdentifier: nil)
        let contactToDisplay = contacts[indexPath.row]
        cell.textLabel?.text = contactToDisplay.givenName + " " + contactToDisplay.familyName
        cell.detailTextLabel?.text = contactToDisplay.number
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        // Segue to the second view controller
        self.performSegue(withIdentifier: "segueBack", sender: self)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        // get a reference to the second view controller
        let viewController = segue.destination as! ImageViewController
        
        if let indexPath = tableView.indexPathForSelectedRow{
            let selectedRow = indexPath.row
            viewController.receiveContact = contacts[selectedRow]
           
        }
    
    }
//
//    func numberOfSections(in tableView: UITableView) -> Int {
//        return contacts.count
//    }
    
    

    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        tableView.delegate = self
        tableView.dataSource = self
        
        contactStore.requestAccess(for: .contacts) { (success, error) in
            if success {
                print("Authorization Successful")
            }
            
        }
        self.fetchContacts()
    }
    
    

    func fetchContacts() {
        let key = [CNContactGivenNameKey, CNContactFamilyNameKey, CNContactPhoneNumbersKey] as [CNKeyDescriptor]
        
        let request = CNContactFetchRequest(keysToFetch: key)
        try! contactStore.enumerateContacts(with: request) { (contact, stoppingPointer) in
            let name = contact.givenName
            let familyName = contact.familyName
            let number = contact.phoneNumbers.first?.value.stringValue
            
            let contactToAppend = ContactStruct(givenName: name, familyName: familyName, number: number!)
            
            self.contacts.append(contactToAppend)
        
        }
        tableView.reloadData()
        print(contacts.first?.givenName)
    }

}

