//
//  ContactListViewModel.swift
//  tw-test
//
//  Created by Krisnandika Aji on 03/07/23.
//

import Foundation

class ContactListViewModel {
    let dataSource = Box(ContactListCollectionDataSource(data: [], selectionHandler: nil))
    
    var data: [Contact] = []
    var filteredData: [Contact] = []
    var keyword: String = ""
    var selectionHandler: ((Contact) -> Void)?
    
    init() {
        data = []
        filteredData = []
        
        commonInit()
    }
    
    private func commonInit() {
        fetchLocalJsonFile()
        updateDataSource()
    }
    
    func refreshData() {
        fetchLocalJsonFile()
        updateDataSource()
    }
    
    func updateDataSource() {
        dataSource.value = ContactListCollectionDataSource(data: filteredData, searchKeyword: keyword, selectionHandler: selectContact(_:))
    }
    
    func fetchLocalJsonFile() {
        let bundle = Bundle(for: type(of: self))

        guard let url = bundle.url(forResource: "data", withExtension: "json") else {
            print("Missing json file")
            return
        }
        
        do {
            let data = try Data(contentsOf: url)
            let decoder = JSONDecoder()
            
            let contacts = try decoder.decode([Contact].self, from: data)
            
            self.data = contacts
            self.filteredData = contacts
        } catch {
            print("Exception in parsing data")
        }
    }
    
    func searchContacts(keyword: String) {
        self.keyword = keyword
        
        let filtered = data.filter({ $0.firstName!.lowercased().contains(keyword.lowercased()) || $0.lastName!.lowercased().contains(keyword.lowercased()) })
        
        self.filteredData = filtered
        self.updateDataSource()
    }
    
    func saveContact(_ contact: Contact) {
        if let _ = self.data.firstIndex(where: { $0.id == contact.id }) {
            // update contact
            updateContact(contact)
        } else {
            // save contact
            addContact(contact)
        }
    }
    
    func addContact(_ contact: Contact) {
        self.data.insert(contact, at: 0)
        self.filteredData = data
        self.updateDataSource()
    }
    
    func updateContact(_ contact: Contact) {
        guard let index = self.data.firstIndex(where: { $0.id == contact.id }) else { return }
        
        self.data[index] = contact
        self.filteredData = data
        self.updateDataSource()
    }
    
    func selectContact(_ contact: Contact) {
        self.selectionHandler?(contact)
    }
}
