//
//  ViewController.swift
//  BBVABrianWeissberg
//
//  Created by Brian Weissberg on 8/25/18.
//  Copyright © 2018 Brian Weissberg. All rights reserved.
//

import UIKit
import BWCustomCell

class StatesViewController: UIViewController {
    
    //
    // MARK: - Variable
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
        setUpTableView()
        fetchStates()
    }
    
    //
    // MARK: - Methods
    //
    
    func fetchStates() {
        
        NetworkController.shared.fetchStates { (states) in
            DispatchQueue.main.async {
                self.states = states
                self.tableView.reloadData()
            }
        }
    }
    
    func setUpTableView() {
        self.tableView.rowHeight = 155
        self.tableView.separatorStyle = UITableViewCellSeparatorStyle.none
        self.tableView.delegate = self
        self.tableView.dataSource = self
    }
}

extension StatesViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return states.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let state = states[indexPath.row]
        let cellWidth = self.view.frame.width
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "stateCell", for: indexPath) as? StateTableViewCell ?? StateTableViewCell()
        cell.width = cellWidth
        cell.state = state
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
    }
}

