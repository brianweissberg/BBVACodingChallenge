//
//  ViewController.swift
//  BBVABrianWeissberg
//
//  Created by Brian Weissberg on 8/25/18.
//  Copyright © 2018 Brian Weissberg. All rights reserved.
//

import UIKit

class StatesViewController: UIViewController {
    
    //
    // MARK: - Variables
    //
    
    var states = [State]()
    
    //
    // MARK: - Outlets
    //
    
    @IBOutlet weak var tableView: UITableView!
    
    //
    // MARK: - View Lifecycle
    //
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.tableView.delegate = self
        self.tableView.dataSource = self
        setUpTableView()
    }
    
    func setUpTableView() {
        StateController.shared.fetchSchools { (states) in
            DispatchQueue.main.async {
                self.states = StateController.shared.states
                self.tableView.reloadData()
            }
        }
    }
}

extension StatesViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return states.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "stateCell", for: indexPath)
        let state = states[indexPath.row]
        cell.textLabel?.text = state.name
        cell.detailTextLabel?.text = state.capital
        return cell
    }
}

