//
//  ModelTests.swift
//  tw-testTests
//
//  Created by Krisnandika Aji on 03/07/23.
//

import XCTest
@testable import tw_test

final class ModelTests: XCTestCase {
    func testContactModelCanCreateInstance() {
        let instance = Contact(id: "5c8a80f52dfee238898d64cf", firstName: "Phoebe", lastName: "Monroe", email: "phoebemonroe@furnafix.com", dob: "3/2/1982");
        XCTAssertNotNil(instance)
    }
    
    func testContactModelCreatedFromLocalJson() throws {
        let bundle = Bundle(for: type(of: self))

        guard let url = bundle.url(forResource: "data", withExtension: "json") else {
            XCTFail("Missing file: data.json")
            return
        }
        
        let json = try Data(contentsOf: url)
        let decoder = JSONDecoder()
        
        let contacts = try decoder.decode([Contact].self, from: json)
        
        XCTAssertNotNil(contacts)
        
        let firstContact = contacts.first
        XCTAssertEqual(firstContact?.firstName, "Phoebe")
    }
}
