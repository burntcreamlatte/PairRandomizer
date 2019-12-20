//
//  PairsListTableViewController.swift
//  PairRandomizer
//
//  Created by Aaron Shackelford on 12/20/19.
//  Copyright © 2019 Aaron Shackelford. All rights reserved.
//

import UIKit

class PairsListTableViewController: UITableViewController {

    // MARK: - Properties
    
    var pairs: [[Person]]?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        loadViewIfNeeded()

        randomizePairs()
    }
    
    //will be called when we pop the stack while viewDidLoad will not
    //if we don't call this method we won't see the added person before hitting randomize
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        
        randomizePairs()
        tableView.reloadData()
    }
    
    // MARK: - Actions
    @IBAction func randomizeButtonTapped(_ sender: UIBarButtonItem) {
        randomizePairs()
    }
    

    // MARK: - Table view data source
    override func numberOfSections(in tableView: UITableView) -> Int {
        //CCI
        return pairs?.count ?? 0
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        //if pairs?[section].count
        return pairs?[section].count ?? 0
    }
    
    override func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        //cleans up the titles for sections
        if self.tableView(tableView, numberOfRowsInSection: section) > 0 {
            return "Pair \(section + 1)"
        } else {
            //will delete section header if empty
            return nil
        }
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "personCell", for: indexPath)

        //CCI
        //goes both levels for each section and row to correctly find the person
        let person = pairs?[indexPath.section][indexPath.row]
        cell.textLabel?.text = person?.name

        return cell
    }

    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            guard let person = pairs?[indexPath.section][indexPath.row] else { return }
            //remove from BOTH our pairs arrays, then CD
            pairs?[indexPath.section].remove(at: indexPath.row)
            PersonController.shared.delete(person: person)
            
            tableView.deleteRows(at: [indexPath], with: .fade)
            tableView.reloadData()
            //randomizePairs()
            //tableView.deleteSections(indexPath.section, with: .fade)
        }
    }
    
    // MARK: - Helper Methods
    func randomizePairs() {
        pairs = PersonController.shared.createPairs()
        tableView.reloadData()
    }

    // MARK: - Navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        //iidoo
        if segue.identifier == "toPersonDetailVC" {
            guard let indexPath = tableView.indexPathForSelectedRow, let destinationVC = segue.destination as? PersonDetailViewController else { return }
            destinationVC.person = pairs?[indexPath.section][indexPath.row]
        }
    }
}
