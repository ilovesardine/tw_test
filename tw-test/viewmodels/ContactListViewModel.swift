//
//  ContactListViewModel.swift
//  tw-test
//
//  Created by Krisnandika Aji on 03/07/23.
//

import Foundation

class ContactListViewModel {
    
    var data: [Contact] = []
    var filteredData: [Contact] = []
    var keyword: String = ""
    var selectionHandler: ((Contact) -> Void)?
    
    init() {
        data = []
        filteredData = []
    }
    
    func fetchLocalJsonFile() {}
    func searchContacts(keyword: String) {}
    func addContact(_ contact: Contact) {}
    func updateContact(_ contact: Contact) {}
    
    func selectContact(_ contact: Contact) {}
}
