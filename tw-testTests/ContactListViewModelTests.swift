//
//  ContactListViewModelTests.swift
//  tw-testTests
//
//  Created by Krisnandika Aji on 03/07/23.
//

import XCTest
@testable import tw_test

final class ContactListViewModelTests: XCTestCase {
    
    var sut: ContactListViewModel!
    
    override func setUpWithError() throws {
        try super.setUpWithError()
        sut = ContactListViewModel()
    }
    
    override func tearDownWithError() throws {
        sut = nil
        try super.tearDownWithError()
    }
    
    // MARK: method tests
    
    func testFetchLocalJsonFile() {
        sut.fetchLocalJsonFile()
        
        XCTAssertFalse(sut.data.isEmpty)
    }
    
    func testSearchContacts() {
        let keyword = "Monroe"
        
        sut.searchContacts(keyword: keyword)
        
        XCTAssertEqual(sut.filteredData.count, 1)
    }
    
    func testAddContact() {
        let curCount = sut.data.count
        
        let contact = Contact(id: "12", firstName: "Marylin", lastName: "Manson", email: "marylin@manson.com", dob: "2/3/1963")
        
        sut.addContact(contact)
        
        XCTAssertEqual(sut.data.count, curCount + 1)
    }
    
    func testUpdateContact() {
        var randomContact = sut.data[5]
        
        randomContact.lastName = "Evelyn"
        sut.updateContact(randomContact)
        
        XCTAssertEqual(sut.data[5].lastName, "Evelyn")
    }
}
