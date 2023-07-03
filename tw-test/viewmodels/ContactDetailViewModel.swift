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
        
        newValue.firstName = firstName ?? data?.firstName
        newValue.lastName = lastName ?? data?.lastName
        newValue.email = email ?? data?.email
        newValue.dob = dob ?? data?.dob
        
        return newValue
    }
}
