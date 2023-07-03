//
//  DateStringHelper.swift
//  tw-test
//
//  Created by Krisnandika Aji on 03/07/23.
//

import Foundation

extension DateFormatter {
    
    static let date: DateFormatter = {
        let formatter = DateFormatter()
        formatter.dateFormat = "d/M/yyyy"
        return formatter
    }()
    
    static let datePretty: DateFormatter = {
        let formatter = DateFormatter()
        formatter.dateFormat = "dd MMMM yyyy"
        return formatter
    }()
}

extension Date {
    
    func string(with formatter: DateFormatter) -> String {
        return formatter.string(from: self)
    }
}

extension String {
    
    func date(with formatter: DateFormatter) -> Date? {
        return formatter.date(from: self)
    }
}
