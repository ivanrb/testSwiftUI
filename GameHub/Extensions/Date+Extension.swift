//
//  Date+Extension.swift
//  GameHub
//
//  Created by Ivan Rodriguez on 11/9/23.
//

import Foundation

extension Date {
    
    var requestFormatted: String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "YYYY-MM-dd"

        return dateFormatter.string(from: self)
    }
    
}
