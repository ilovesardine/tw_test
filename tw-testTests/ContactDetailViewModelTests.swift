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
        sut = ContactDetailViewModel()
    }
    
    override func tearDownWithError() throws {
        sut = nil
        try super.tearDownWithError()
    }
    
    // MARK: method tests
    
    func testSaveContact() {}
}
