//
//  ContactDetailViewModel.swift
//  tw-test
//
//  Created by Krisnandika Aji on 03/07/23.
//

import Foundation

class ContactDetailViewModel {
    
    var data: Contact?
    
    init(data: Contact? = nil) {
        self.data = data
    }
    
    func saveContact(firstName: String?, lastName: String?, email: String?, dob: String?) -> Contact? {
        var newValue = data ?? Contact()
        
        if firstName == "" {
            return nil
        }
        
        return newValue
    }
}
