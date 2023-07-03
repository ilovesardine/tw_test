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
    
    func testFetchLocalJsonFile() {}
    
    func testSearchContacts() {}
    
    func testAddContact() {}
    
    func testUpdateContact() {}
}
