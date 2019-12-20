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
        setupView()

        if let person = person {
            nameTextField.text = person.name
        }
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        nameTextField.becomeFirstResponder()
    }
    
    // MARK: - Actions
    @IBAction func saveButtonTapped(_ sender: UIBarButtonItem) {
        //need to guard against name AND Person since we will default to update method
        
        guard let name = nameTextField.text, !name.isEmpty else { return }
        if let person = person {
            PersonController.shared.update(person: person, name: name)
        } else {
            PersonController.shared.add(name: name)
        }
        navigationController?.popViewController(animated: true)
    }
    @IBAction func cancelButtonTapped(_ sender: UIBarButtonItem) {
        navigationController?.popViewController(animated: true)
    }
    
    // MARK: - Helper Methods
    func setupView() {
        nameTextField.layer.cornerRadius = nameTextField.frame.height / 2
    }
    
}
