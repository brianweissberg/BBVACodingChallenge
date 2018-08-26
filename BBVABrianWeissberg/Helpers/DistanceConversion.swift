//
//  DistanceConversion.swift
//  BBVABrianWeissberg
//
//  Created by Brian Weissberg on 8/25/18.
//  Copyright © 2018 Brian Weissberg. All rights reserved.
//

import Foundation

class DistanceConversion: NSString {
    
    static func convertSquareKilometersToSquareMiles(squareKilometers sqm: String) -> String {
        
        var finalResult = ""
        
        if let filteredKilometers = Double(sqm.filterToDigits) {
            
            let result = Int(filteredKilometers * 0.38610)
            if let formattedNumber = formatIntegerWithDecimals(number: result) {
                finalResult = formattedNumber
            }
        } else {
            finalResult = sqm
            print("There was an error converting Square Kilometers to Square Miles")
        }
        return "\(finalResult) Square Miles"
    }
    
    /// This function takes and integer and converts that integer to a string with commas
    static func formatIntegerWithDecimals(number: Int) -> String? {
        let formatter = NumberFormatter()
        formatter.numberStyle = .decimal
        formatter.maximumFractionDigits = 0
        return formatter.string(from: NSNumber(value: number))
    }
}
