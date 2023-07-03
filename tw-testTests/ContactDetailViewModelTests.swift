//
//  ContactDetailViewModelTests.swift
//  tw-testTests
//
//  Created by Krisnandika Aji on 03/07/23.
//

import XCTest
@testable import tw_test

final class ContactDetailViewModelTests: XCTestCase {
    
    var sut: ContactDetailViewModel!
    
    override func setUpWithError() throws {
        try super.setUpWithError()
        sut = ContactDetailViewModel(data: Contact(id: "12", firstName: "Marylin", lastName: "Manson", email: "marylin@manson.com", dob: "2/3/1963"))
    }
    
    override func tearDownWithError() throws {
        sut = nil
        try super.tearDownWithError()
    }
    
    // MARK: method tests
    
    func testSaveContact() {
        let newContact = sut.saveContact(firstName: "Edward", lastName: "Kennedy", email: nil, dob: nil)
        
        XCTAssertEqual(newContact?.id, "12")
        XCTAssertEqual(newContact?.lastName, "Kennedy")
        XCTAssertEqual(newContact?.dob, "2/3/1963")
    }
}
