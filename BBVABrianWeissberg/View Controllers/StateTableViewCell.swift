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
    
    var frameWidth: CGFloat = 0
    var state: State? {
        didSet {
            DispatchQueue.main.async {
                self.updateCell()
            }
        }
    }
    
    //
    // MARK: - Outlets
    //
    
    @IBOutlet weak var cellContentView: UIView!
    
    //
    // MARK: - Methods
    //
    
    override func prepareForReuse() {
        for view in cellContentView.subviews {
            view.removeFromSuperview()
        }
    }
    
    func updateCell() {
        
        guard let state = state else { return }
        
        let cellView = BWCustomCell(frame: CGRect(x: 0, y: 0, width: frameWidth, height: 145))
        cellContentView.addSubview(cellView)
        let area = DistanceConversion.convertSquareKilometersToSquareMiles(squareKilometers: state.area)
        
        cellView.set(name: "\(state.name)")
        cellView.set(country: "Country: \(state.country)")
        cellView.set(abbreviation: "Abbreviation: \(state.abbreviation)")
        cellView.set(area: "Area: \(area)")
        cellView.set(captial: "Capital: \(state.capital)")
        
        if let city = state.largestCity {
            cellView.set(largestCity: "Largest City: \(city)")
        } else {
            cellView.set(largestCity: "Largest City: N/A")
        }
    }
}
