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
    @IBOutlet weak var activitySpinner: UIActivityIndicatorView!
    @IBOutlet weak var emptyStateView: UIView!
    
    //
    // MARK: - Actions
    //
    
    @IBAction func refreshButtonTapped(_ sender: Any) {
        showEmptyStateView()
        NetworkController.shared.fetchStates { (states) in
            DispatchQueue.main.async {
                self.states = states
                self.tableView.reloadData()
            }
        }
        showTableView()
    }
    
    //
    // MARK: - View Lifecycle
    //
    
    override func viewDidLoad() {
        super.viewDidLoad()
        showEmptyStateView()
        setUpTableView()
        fetchStates()
        showTableView()
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
    
    func showEmptyStateView() {
        self.tableView.isHidden = true
        self.emptyStateView.isHidden = false
        self.activitySpinner.isHidden = false
        self.activitySpinner.startAnimating()
    }
    
    func showTableView() {
        self.tableView.isHidden = false
        self.emptyStateView.isHidden = true
        self.activitySpinner.isHidden = true
        self.activitySpinner.stopAnimating()
    }
}

extension StatesViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return states.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let state = states[indexPath.row]
        let cellWidth = self.view.frame.width
        
        let cell = tableView.dequeueReusableCell(withIdentifier: Keys.stateCell, for: indexPath) as? StateTableViewCell ?? StateTableViewCell()
        cell.frameWidth = cellWidth
        cell.state = state
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
    }
}

