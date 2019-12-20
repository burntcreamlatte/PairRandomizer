//
//  PersonDetailViewController.swift
//  PairRandomizer
//
//  Created by Aaron Shackelford on 12/20/19.
//  Copyright © 2019 Aaron Shackelford. All rights reserved.
//

import UIKit

class PersonDetailViewController: UIViewController {

    // MARK: - Properties
    var person: Person?
    
    // MARK: - Outlets
    @IBOutlet weak var nameTextField: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        if let person = person {
            nameTextField.text = person.name
        }
    }
    
    // MARK: - Actions
    @IBAction func saveButtonTapped(_ sender: UIBarButtonItem) {
        //need to guard against name AND Person since we will default to update method
        guard let name = nameTextField.text, !name.isEmpty, let person = person else { return }
        PersonController.shared.update(person: person, name: name)
    }
    @IBAction func cancelButtonTapped(_ sender: UIBarButtonItem) {
        navigationController?.popViewController(animated: true)
    }
    
    
}
