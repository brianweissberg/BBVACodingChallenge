//
//  StateTableViewCell.swift
//  BBVABrianWeissberg
//
//  Created by Brian Weissberg on 8/26/18.
//  Copyright © 2018 Brian Weissberg. All rights reserved.
//

import Foundation
import UIKit
import BWCustomCell

class StateTableViewCell: UITableViewCell {
    
    //
    // MARK: - Variables
    //
    
    var state: State? {
        didSet {
            DispatchQueue.main.async {
                self.updateCell()
            }
        }
    }
    var width: CGFloat = 0
    
    //
    // MARK: - Outlets
    //
    
    @IBOutlet weak var cellContentView: UIView!
    
    //
    // MARK: - Methods
    //
    
    func updateCell() {
        
        guard let state = state else { return }
        
        let cellView = BWCustomCell(frame: CGRect(x: 0, y: 0, width: width, height: 60))
        cellContentView.addSubview(cellView)
        cellView.set(subheading: "\(state.name)")
    }
}
