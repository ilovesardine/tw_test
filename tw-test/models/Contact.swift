//
//  Contact.swift
//  tw-test
//
//  Created by Krisnandika Aji on 03/07/23.
//

import Foundation

struct Contact: Codable {
    var id, firstName, lastName, email, dob: String?
    
    var fullname: String { return "\(firstName ?? "-") \(lastName ?? "-")" }
}
